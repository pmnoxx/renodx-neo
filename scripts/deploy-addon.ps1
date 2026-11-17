# deploy-addon.ps1
# Copy a built game addon into the game's folder for local testing.
#
#   pwsh scripts/deploy-addon.ps1 -Mod heavenburnsred [-Config Debug|Release] [-GameDir <folder>]
#
# The game folder is resolved from src/games/<mod>/metadata.json (deploy.steam_appid + deploy.game_exe)
# unless -GameDir is given. If the deployed addon is locked because the game has it loaded, the locked
# file is renamed to `<name>.old` (Windows allows renaming a loaded DLL) and the new build is copied
# next to it; ReShade only loads `*.addon64`/`*.addon32`, so the `.old` file is ignored on the next launch.

[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)][string]$Mod,
  [ValidateSet('Debug', 'Release')][string]$Config = 'Debug',
  [string]$GameDir
)

$ErrorActionPreference = 'Stop'
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..') | Select-Object -ExpandProperty Path
$metadataPath = Join-Path $repoRoot "src\games\$Mod\metadata.json"
$metadata = $null
if (Test-Path $metadataPath) { $metadata = Get-Content $metadataPath -Raw | ConvertFrom-Json }

$extension = 'addon64'
if ($metadata -and $metadata.deploy -and $metadata.deploy.architecture -eq 'x86') { $extension = 'addon32' }
$fileName = "renodx-$Mod.$extension"
$source = Join-Path $repoRoot "build\$Config\$fileName"
if (-not (Test-Path $source)) { throw "Build output not found: $source" }

function Get-SteamLibraries {
  $steamPath = (Get-ItemProperty -Path 'HKCU:\Software\Valve\Steam' -Name SteamPath -ErrorAction SilentlyContinue).SteamPath
  if (-not $steamPath) { return @() }
  $libraries = @($steamPath -replace '/', '\')
  $vdf = Join-Path $steamPath 'steamapps\libraryfolders.vdf'
  if (Test-Path $vdf) {
    foreach ($match in [regex]::Matches((Get-Content $vdf -Raw), '"path"\s+"([^"]+)"')) {
      $libraries += $match.Groups[1].Value -replace '\\\\', '\'
    }
  }
  return $libraries | Select-Object -Unique
}

function Resolve-GameDir {
  if (-not $metadata -or -not $metadata.deploy -or -not $metadata.deploy.steam_appid) {
    throw "No -GameDir given and $metadataPath has no deploy.steam_appid."
  }
  $appId = $metadata.deploy.steam_appid
  foreach ($library in Get-SteamLibraries) {
    $manifest = Join-Path $library "steamapps\appmanifest_$appId.acf"
    if (-not (Test-Path $manifest)) { continue }
    $installDir = [regex]::Match((Get-Content $manifest -Raw), '"installdir"\s+"([^"]+)"').Groups[1].Value
    $root = Join-Path $library "steamapps\common\$installDir"
    $exe = $metadata.deploy.game_exe
    if (-not $exe) { return $root }
    $found = Get-ChildItem -Path $root -Filter $exe -Recurse -File -Depth 4 -ErrorAction SilentlyContinue |
      Select-Object -First 1
    if (-not $found) { throw "Found Steam install $root but not $exe under it; pass -GameDir." }
    return $found.DirectoryName
  }
  throw "Steam app $appId is not installed in any Steam library; pass -GameDir."
}

if (-not $GameDir) { $GameDir = Resolve-GameDir }
if (-not (Test-Path $GameDir)) { throw "Game folder not found: $GameDir" }
$destination = Join-Path $GameDir $fileName

if ((Test-Path $destination) -and
    (Get-FileHash $destination).Hash -eq (Get-FileHash $source).Hash) {
  Write-Host "Already up to date: $destination" -ForegroundColor Green
  exit 0
}

try {
  Copy-Item -Path $source -Destination $destination -Force
  Write-Host "Deployed: $destination" -ForegroundColor Green
} catch [System.IO.IOException], [System.UnauthorizedAccessException] {
  # The running game has the addon loaded. Move it aside as .old, replacing an older .old if that one
  # is no longer loaded, else fall back to .old1, .old2, ...
  $aside = "$destination.old"
  $index = 0
  while (Test-Path $aside) {
    try {
      Remove-Item -Path $aside -Force
    } catch {
      $index++
      $aside = "$destination.old$index"
    }
  }
  Move-Item -Path $destination -Destination $aside
  Copy-Item -Path $source -Destination $destination -Force
  Write-Host "Deployed: $destination (locked copy moved to $(Split-Path $aside -Leaf); restart the game to load the new build)" -ForegroundColor Yellow
}

if ((Get-FileHash $destination).Hash -ne (Get-FileHash $source).Hash) {
  throw "Deployed file does not match $source"
}
