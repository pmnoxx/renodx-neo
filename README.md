[![Snapshot](https://github.com/pmnoxx/renodx-neo/actions/workflows/snapshot.yml/badge.svg?branch=main)](https://github.com/pmnoxx/renodx-neo/actions/workflows/snapshot.yml)

[![Discord](https://img.shields.io/discord/1408098019194310818?logo=discord&logoColor=%23fff&label=Discord&labelColor=%235865F2)](https://discord.gg/F6AUTeWJHM)

# renodx
RenoDX, short for "Renovation Engine for DirectX Games", is a toolset to mod games. Currently it can replace shaders, inject buffers, add overlays, upgrade swapchains, upgrade texture resources, and write user settings to disk. Because RenoDX uses Reshade's add-on system, compatibility is expected to be pretty wide. Using Reshade simplifies all the hooks necessary to tap into DirectX without worrying about patching version-specific exe files.


# Contributing

* See [CONTRIBUTING.md](./docs/CONTRIBUTING.md)
* For the live devkit and MCP workflow, see [DEVKIT_MCP.md](./docs/DEVKIT_MCP.md)

# Mods

The games maintained in this fork are listed in [games.json](./games.json). This list controls both `build.cmd` and the snapshot build. Entries use the CMake target/folder names under `src/games`.

| Game | Snapshot download | Latest source update |
| --- | --- | --- |
| Muv-Luv Alternative Total Eclipse | [renodx-total-eclipse.addon64](https://github.com/pmnoxx/renodx-neo/releases/download/snapshot/renodx-total-eclipse.addon64) | [![Snapshot](https://img.shields.io/github/last-commit/pmnoxx/renodx-neo/main?path=src%2Fgames%2Ftotal-eclipse&label=Snapshot)](https://github.com/pmnoxx/renodx-neo/commits/main/src/games/total-eclipse) |
| NieR:Automata | [renodx-nier-automata.addon64](https://github.com/pmnoxx/renodx-neo/releases/download/snapshot/renodx-nier-automata.addon64) | [![Snapshot](https://img.shields.io/github/last-commit/pmnoxx/renodx-neo/main?path=src%2Fgames%2Fnier-automata&label=Snapshot)](https://github.com/pmnoxx/renodx-neo/commits/main/src/games/nier-automata) |

Snapshot badges show the latest commit to each game's source folder on `main`.

Both mods are 64-bit. Download the latest builds from the [snapshot release](https://github.com/pmnoxx/renodx-neo/releases/tag/snapshot). Source code for other RenoDX mods is available under [src/games](./src/games); they are not included in this fork's snapshot.

# Building these mods

After configuring the Clang x64 build in a Visual Studio developer shell:

```bat
cmake --preset clang-x64
.\build.cmd
```

`build.cmd` builds only the targets in [games.json](./games.json), plus their required build dependencies. It defaults to Release with 18 parallel jobs, works from any current directory, and accepts PowerShell script options:

```bat
.\build.cmd -Configuration Debug -Parallel 8
.\build.cmd -DryRun
```

Add another game's existing target name to `games.json` to include it in local builds and snapshots. The snapshot currently builds and packages x64 addons and their debug symbols; games added to the list must support x64.

# Utilities

For building and using this fork's developer tools, see [DEVKIT_MCP.md](./docs/DEVKIT_MCP.md).
