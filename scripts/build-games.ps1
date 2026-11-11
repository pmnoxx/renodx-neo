[CmdletBinding()]
param(
    [string]$BuildDirectory = 'build',
    [string]$Configuration = 'Release',
    [ValidateRange(1, 256)]
    [int]$Parallel = 18,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
$gameListJson = Get-Content (Join-Path $repoRoot 'games.json') -Raw
if (-not $gameListJson.TrimStart().StartsWith('[')) {
    throw 'games.json must be an array of game target names.'
}
$games = ConvertFrom-Json -InputObject $gameListJson
$games = @($games)
if ($games.Count -eq 0) {
    throw 'games.json must contain at least one game target.'
}
foreach ($game in $games) {
    if ($game -isnot [string] -or $game -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$' -or
        -not (Test-Path (Join-Path $repoRoot "src/games/$game/addon.cpp"))) {
        throw "Invalid game target in games.json: $game"
    }
}
if (($games | Select-Object -Unique).Count -ne $games.Count) {
    throw 'games.json contains duplicate game targets.'
}

Push-Location $repoRoot
try {
    $buildArgs = @('--build', $BuildDirectory, '--config', $Configuration, '--target') +
        $games + @('--parallel', "$Parallel")
    Write-Host "cmake $($buildArgs -join ' ')"
    if (-not $DryRun) {
        & cmake @buildArgs
        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }
    }
} finally {
    Pop-Location
}
