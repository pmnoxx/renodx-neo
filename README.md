[![Clang](https://github.com/clshortfuse/renodx/actions/workflows/clang-x64.yml/badge.svg)](https://github.com/clshortfuse/renodx/actions/workflows/clang-x64.yml) [![Ninja](https://github.com/clshortfuse/renodx/actions/workflows/ninja-x64.yml/badge.svg)](https://github.com/clshortfuse/renodx/actions/workflows/ninja-x64.yml) [![Visual Studio](https://github.com/clshortfuse/renodx/actions/workflows/visual-studio-x64.yml/badge.svg)](https://github.com/clshortfuse/renodx/actions/workflows/visual-studio-x64.yml) 

[![Discord](https://img.shields.io/discord/1408098019194310818?logo=discord&logoColor=%23fff&label=Discord&labelColor=%235865F2)](https://discord.gg/F6AUTeWJHM)

# renodx
RenoDX, short for "Renovation Engine for DirectX Games", is a toolset to mod games. Currently it can replace shaders, inject buffers, add overlays, upgrade swapchains, upgrade texture resources, and write user settings to disk. Because RenoDX uses Reshade's add-on system, compatibility is expected to be pretty wide. Using Reshade simplifies all the hooks necessary to tap into DirectX without worrying about patching version-specific exe files.


# Contributing

* See [CONTRIBUTING.md](./docs/CONTRIBUTING.md)
* For the live devkit and MCP workflow, see [DEVKIT_MCP.md](./docs/DEVKIT_MCP.md)

# Mods

The games maintained in this fork are listed in [games.json](./games.json). This list controls both `build.cmd` and the snapshot build. Entries use the CMake target/folder names under `src/games`.

| Game | Snapshot download |
| --- | --- |
| Muv-Luv Alternative Total Eclipse | [renodx-total-eclipse.addon64](https://github.com/pmnoxx/renodx-neo/releases/download/snapshot/renodx-total-eclipse.addon64) |
| NieR:Automata | [renodx-nier-automata.addon64](https://github.com/pmnoxx/renodx-neo/releases/download/snapshot/renodx-nier-automata.addon64) |

Both mods are 64-bit. Download the latest builds from the [snapshot release](https://github.com/pmnoxx/renodx-neo/releases/tag/snapshot). For other RenoDX mods, see the upstream [Mods page](https://github.com/clshortfuse/renodx/wiki/Mods).

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

Developer tools are available from the [upstream RenoDX snapshot](https://github.com/clshortfuse/renodx/releases/tag/snapshot).
