# NieR:Automata

The overlay displays the loaded addon's embedded file version and compile date/time.
Include both lines in bug-report screenshots to identify the installed build.
The file version is generated during CMake configuration in UTC; the compile time
uses the build machine's local timezone.

The `Native HDR override` control offers three startup modes:

| Mode | Game decision / output descriptor |
| --- | --- |
| Game default | Leave both unchanged; follow the game's display detection. |
| Force native HDR off (default) | Force the SDR game path and BT.709/8-bit descriptor. |
| Force native HDR on | Force the native HDR game path and HDR10/PQ/10-bit descriptor. |

The setting is saved as `NativeHDROverride` under `[renodx-nier_automata]`: 0 for
game default, 1 for force off, 2 for force on. Missing or invalid values use 1.
The overlay shows the active mode separately from a saved selection for the next
launch. Changing modes takes effect next launch because the game initializes
different shaders and buffers for each rendering path. This setting controls
the game's native HDR, independently of RenoDX's HDR10 output. The previous
validated custom RenoDX pipeline used native HDR off; forced native HDR on
remains experimental and needs separate visual/output validation.

Forced modes use a version-checked memory patch plus a game-caller
`IDXGIOutput6::GetDesc1` hook. On the supported Steam executable, both initialize
during D3D11 device initialization, before the game makes its native HDR decision.
No early-load configuration or first-launch restart is required. The addon no
longer writes `ADDON.LoadFromDllMain`, and the restart popup/countdown is removed.
Existing early-load entries are left untouched. The overlay reports memory-patch
and output-hook installation separately; errors are recorded in `ReShade.log`.

## Executable compatibility

Before installing executable hooks or patches, the addon computes CRC32 of all
bytes in the running executable's on-disk file. The supported Steam build has
CRC32 `6751080E` and SHA256
`09854c2d45d9a72e66357e72f50cee379bb2eafe35b3d64e5e88f4eddc8613fa`.
The result is cached for the addon lifetime before its first executable change.
Existing PE identity and instruction-anchor checks also apply at installation.

A CRC mismatch or failure to read the executable disables native HDR override
(including the factory import and output descriptor hooks), FPS unlock and its
FPS target, LOD distance, and save anywhere. Their controls are disabled. A warning
at the top of the addon overlay lists these features and shows the detected and
supported CRC32, or a read-failure message. ReShade.log records the disabled list.
RenoDX shader replacements, HDR output and shader-based effect controls remain
available. Compatibility is checked even when all executable features are off.

Verify the `nier-automata` target with `clang-x64-debug`. On the supported executable,
confirm normal startup and feature operation. With a different executable version,
confirm the top warning and four disabled feature entries, disabled controls, and
no factory IAT patch, native HDR decision patch, FPS hooks, LOD hooks/writes or save
hooks. Repeat with saved enabled settings and after creating another D3D11 device.
A failed executable read must produce the same disabled state. Existing instruction
anchor conflicts must continue to reject the affected patch on a matching CRC.

## Experimental FPS unlocker

Unlock FPS is enabled by default with a 60 FPS limit. Raise the gameplay FPS
target in the overlay to unlock higher frame rates; the overlay saves both
controls. Existing saved `UnlockFPS` and `FPSLimit` values take precedence. The FPS
target accepts 60–360. After installation, turning Unlock FPS off immediately
uses a 60 FPS safety cap; turning it on again uses the saved gameplay target.
Installing the unlocker pins the addon until process exit, so hot-unload requires
a restart.

The implementation was authored from the installed Steam executable's machine
code. It bypasses the engine's render wait and
paces the main game timer. For updates faster than 60 FPS, it replaces only the
main timer's minimum-one-tick clamp with its measured elapsed time multiplied
by its own tick rate per millisecond. Forced steps, paused updates, other timer objects and the
original slow-frame compensation remain intact.

Supported executable: PE timestamp `6AC89519`, image size `018BE000`, SHA256
`09854c2d45d9a72e66357e72f50cee379bb2eafe35b3d64e5e88f4eddc8613fa`.
The addon checks the PE identity and separate code/reference anchors and leaves
unrecognized or already patched versions untouched. Do not combine it with
another FPS unlocker. VSync, driver caps and GPU load can still limit FPS.

The WAX mod loader (`dinput8.dll`) applies its own 60 FPS limit unless
`"uncap_fps": true` is set in `<game>\wax\config.json`. When Unlock FPS is on
and that file exists, the addon sets the option at startup (only that value is
edited). WAX reads its config before add-ons load, so the overlay shows a red
warning and the change applies after one restart. To verify: set `uncap_fps` to
`false`, launch (log reports the write, game stays at 60), relaunch and check
that game updates reach the FPS target.

High FPS can affect frame-counted scripts and menus. Use the live 60 FPS switch
for affected sequences. Pause-state timer updates are capped at 60 automatically;
cutscene, hacking and menu detection is not otherwise implemented. Verify game
speed and progression before treating a high-FPS session as fully supported.

Validated on the supported executable: the title scene updates at 120 FPS with
a normalized simulation step near 0.5 (8.333 ms times 0.06 ticks/ms), and the
user confirmed unlocking worked after increasing the display refresh rate.
Full gameplay progression and every timing-sensitive sequence remain unverified.

Experimental D3D11/x64 development addon. Successful `IDXGIOutput6::GetDesc1` queries originating inside the game executable follow the selected startup override. Game default passes through unchanged. Force off reports SDR BT.709/eight bits; force on reports HDR10/PQ/ten bits. Calls from RenoDX, DevKit and other modules retain the real descriptor. The mod does not change Windows HDR settings.

For forced modes, the memory patch replaces the game's decision block at RVA `25E88E`, setting both its native HDR flag and saved output color space before buffer formats and rendering shaders are selected: 0/0 for force off, 1/12 for force on. Game default leaves the code unchanged. The patch checks PE timestamp `6AC89519`, image size `018BE000`, the entire original 25-byte decision block and the adjacent GetDesc1 call. Unknown or conflicting builds are left unpatched and reported as errors. The patch changes process memory only and remains until process exit; it contains no addon callback addresses. It also applies to later executions of the same display initialization path. Native HDR on requires the game's IDXGIOutput6 path and output support for HDR10 signaling.

The output hook remains separate from the memory patch. The addon intercepts the executable's named `CreateDXGIFactory` import while preserving ReShade's redirected entry point. Normal device-time loading also obtains a factory/output immediately, so installation does not depend on observing the game's earlier factory creation. The descriptor hook uses the primary adapter/output implementation; other implementations remain untested. The overlay shows the count of intercepted game queries, which alone does not establish the native HDR state. Factory/output-hook installation failures are logged independently of memory-patch status. Failed/null descriptor queries retain the real API result. The game's DisplayConfigGetDeviceInfo calls retrieve display names, rather than HDR enablement.

## Custom RenoDX HDR

RenoDX HDR10 output is always enabled. Native HDR detection follows `NativeHDROverride`; choose Force native HDR off for the previously validated custom SDR-to-HDR rendering path. There are no `HideNativeHDR` or `EnableHDR` config options; obsolete entries are ignored. Brightness, tone mapping, grading, FPS, and motion-blur controls remain configurable.

- `0x7FB4ADA1`: capture scene + bloom, vignette and exposure before the rational SDR curve. Preserve original strip-LUT addressing, LUT blend and brightness as a decoded SDR grade reference. Forward-map the real upstream scene with three-input `ToneMapPass`, using the rational curve as the neutral reference. Write extended sRGB-shaped values for later game composition.
- `0x644BD65C`: preserve the reconstructed SDR CAS algorithm, removing its final saturate. Above-white neighborhoods naturally disable its SDR sharpening weight; highlights pass through without clipping. This manually reconstructed shader compiles but is not binary-equivalent to the original.
- Alternate scene variants `0xA0D17E10`, `0x74B83FF7` and dual-output `0x83C6596C` also use scene-side HDR mapping. Keep packed LUT sampling and highlight masks, using a smooth rational LUT reference rather than clipping HDR into the lookup domain. Preserve the encoded primary and native linear secondary output conventions. The linear t3 domain is inferred from the dual-output LUT builder and still needs live consumer validation when those variants execute.
- `0x96F799BE`: remove the executed adaptive CAS upscaler's final RGB upper clamp while preserving weighting and interpolation. Alternate variants compile but their execution/appearance requires scene and scaling coverage beyond the currently observed no-upscale path.
- Clone output-sized RGBA8 render targets and MSAA resolve destinations to FP16; retain existing scene/bloom float formats and leave asset textures/LUTs alone. Use an FP16 swapchain proxy, then a thin `SwapChainPass` to encode BT.2020/PQ into RGB10A2 HDR10.
- The shared resource resolve handler preserves a caller-supplied typed format when it matches the effective resource format family. This avoids an unsupported-format assertion for native `R11G11B10_FLOAT` MSAA buffers while still selecting the upgraded format for cloned targets. To verify, enable MSAA in game settings, apply, and load gameplay without an assertion; check scene rendering and HDR output. MSAA resolve destinations can be shader-readable without render-target usage, so the game upgrade rule includes `resolve_dest` to keep both ends in FP16. After deploying both fixes, the user confirmed MSAA could be enabled without a crash; title rendering continued with HDR10/PQ output and the FPS unlock active. Broader gameplay and all sample-count combinations remain unverified.
- Default peak 1000 nits, scene/UI white 203 nits. The game addon overlay exposes peak/scene/UI brightness and persists these sliders.
- The overlay's Basic section now includes the tone mapper (`Vanilla (SDR)`, `Off (upgrade only)`, `ACES`, or `RenoDRT`), peak/scene/UI white, 2.2 gamma correction, and exposure. Advanced color grading exposes highlights, shadows, contrast, and saturation. `Vanilla (SDR)` (`ToneMapType=0`) keeps the game's own SDR result in every replaced shader and caps it, including CAS sharpening and the final proxy, at SDR white. `Off (upgrade only)` (`ToneMapType=1`) keeps the FP16/HDR10 swap chain upgrade but runs the original math in every replaced shader. Settings are saved under `[renodx-nier_automata]`; defaults preserve the current RenoDRT mapping and neutral grading values.
- Every patched original shader has an unpatched `.hlsl.original` companion. Proxy shaders are new code and have no original game shader.

Build from the existing Clang x64 environment with `cmake --build --preset clang-x64-debug --target nier-automata`. Close the game first. Output: `build/Debug/renodx-nier-automata.addon64`; generated embeds are under `build/nier-automata.include/embed/`. No global build configuration changes are needed.

Verified in the title/menu and a loaded forest gameplay scene: native HDR query masked, SDR tonemap and CAS hashes active as addon replacements, native HDR dispatches absent, RGB10A2/PQ presentation, full-resolution FP16 compositor/proxy. Gameplay readback retained values above one through scene, tonemap, CAS and the presentation proxy. HUD and minimap rendered in the captured scene. This establishes a working experimental HDR pipeline; full SDR appearance matching, peak adjustment comparisons, other areas/effects, menus and video still need broader visual validation.

All replaced shaders are readable rewrites whose `.hlsl.original` files compile (`fxc /O3`) to the game's exact SHEX instruction chunk. Each patched shader compiled with `/D NIER_VERIFY_MODE=1` (constant Off) also reduces to that exact game code; the camera velocity shader is a deliberate replacement and is excluded. Verifier: `tmp/tasks/nier_automata_hdr/verify_rewrite.py` in the Display Commander task workspace, or per file with `.agents/skills/readable-shader-rewrite/scripts/compare_shader_code.py`. Previous sources are kept as `*.beforerewrite`. Other offline reconstructed compute shaders are not registered. Multi-adapter native HDR detection remains untested.

### Startup verification

With an empty INI and no early-load entry, the overlay must show Force native HDR off active, and the log must report its force-off patch plus output-hook installation. Confirm native display state fields are 0/0, SDR game shaders, and no native HDR dispatches. Select Force native HDR on: the active mode must stay unchanged that session; after relaunch, verify fields 1/12 and native HDR shader selection. Select Game default and relaunch: verify original decision bytes remain unchanged, descriptor calls pass through without incrementing the override counter, and native HDR follows actual display detection. Test Windows HDR enabled/disabled and display/MSAA rebuilds in each mode. The forced-on path needs visual/output verification independently of the custom native-HDR-off path.

No first-launch restart popup should appear, and `ADDON.LoadFromDllMain` must remain unchanged. Repeat with unrelated early-load entries and invalid `NativeHDROverride` values (fallback: force off). Unsupported/conflicting executable anchors must report a forced-mode patch failure without writing those bytes. Legacy `HideNativeHDR`/`EnableHDR` keys remain ignored. FPS defaults remain enabled at 60, with saved FPS choices respected. Both replacement machine-code sequences and the original were executed in isolated buffers across six input color spaces, verifying the two state fields and surrounding guard bytes. In-game runtime validation of these startup modes remains pending; earlier visual evidence used native HDR off with the descriptor hook and early loading.

## Camera motion blur

The overlay's `Disable camera motion blur` option replaces pixel shader `0x83015F55` with a neutral (0.5, 0.5) velocity output while enabled; it is off by default and saved as `DisableCameraMotionBlur`. Disassembly confirms that this pass computes camera velocity from the depth texture, camera parameters, and previous view-projection matrix. Two vertex shaders also produce previous-frame geometry velocity (`0x4ABDF171` and `0xF96BB863`); they are not replaced yet, so object-motion blur may remain. The current option only suppresses the camera-derived component and still needs visual verification in gameplay.

## Effect toggles

The **Effects** section has five checkboxes. Disable bloom is on by default; the others are off. They apply in every tone mapper mode, including Off.

- **Disable bloom**: drops the bloom texture added before tone mapping.
- **Disable vignette**: removes the screen-edge darkening.
- **Disable auto exposure**: uses a fixed 1.0 multiplier instead of `g_AverageBrightnessBuffer[0]`.
- **Disable game tone mapping**: skips the game's rational curve, so the exposed scene clips at SDR white. This changes Vanilla and Off only, because ACES and RenoDRT already replace the curve.
- **Disable sharpening**: in `casshadersharpen` the output is the centre texel. In `casshaderupsampleandsharpen` the sharpening weights are zero, leaving an exactly normalized adaptive bilinear upscale.

Under `NIER_VERIFY_MODE` the toggles are compile-time `false`, so the Off-mode proof against the game bytecode covers the toggles-off path; with default settings Off differs from the game only by the dropped bloom.

## LOD distance

`LOD distance` (1x-20x, default 1x = vanilla) keeps full-detail models such as bushes and props out to a multiple of the game's LOD distance. Each model owns screen-size LOD thresholds (`objReadInfo.bxm` `DistRate0-3` or class defaults); the addon tracks model LOD setup/teardown (RVAs `1951B0`/`1948A0`) and divides those thresholds once per frame. Installed on first use; models loaded before then keep vanilla LODs until the area reloads. Verified in game by scaling live thresholds to 5%: bushes and a storage tank kept their full-detail meshes.

## Graphics tweaks

The overlay's **Graphics tweaks** section (graphics_tweaks.hpp) reimplements graphics and start-up tweaks of emoose's Automata-LodMod for the supported Steam build. Everything is off or at the game default until changed, and all of it is disabled when the executable CRC32 check fails. Each feature checks its own original bytes and disables only itself on a mismatch; failures are listed in red at the bottom of the section and in `ReShade.log`. All settings are stored in the ReShade config section `renodx-nier_automata`.

**Live**

- **LOD distance**: see above.
- **Shadow distance multiplier/minimum/maximum/PSS, filter strength bias/minimum/maximum**: the static shadow system object `F51540` starts with the current `cShadowParam` (split points +0x14..+0x20, blur strength +0x34). Each frame `797930` steps area transitions on those fields and then calls `7801E0` once per cascade, which reads them directly. A hook on `7801E0` (installed on first use) writes the adjusted values for the duration of the call and puts the game's values back, so nothing compounds and transitions stay exact. With PSS above 0 the second and third split points come from the PSS value alone, so multiplier/minimum/maximum then only move the first.
- **Disable manual culling**: hooks the cull query `7F4510` and update `846680` on first use. Real geometry is always shown; names that look like stand-ins (`low`, `lod`, `dummy`, `distant`, `far` without `nolow`) and the models in config key `ManualCullingKeepModels` (`name:area|name:area`, area 0 = every area, read at start-up, default written on first run) keep the game's answer. Hard filters are not implemented.
- **Real-time shadow models** (red, experimental): two code patches in the mesh shadow submit code (`848319`, `84822D`), written and restored by the checkbox.
- **Force shadows on all models** (red, experimental): patch at `8482FA`, plus a hook on model setup `84D180` that sets the shadow-caster bit on every mesh and remembers the game's bits. Unchecking restores them for models still loaded. Models loaded before the option was first enabled in a session are not tracked and change when their area reloads. The reference mod's model filter (`ENKEI`, `landscape`, `GROUND_g11118jimen`) is not implemented, so those models cast shadows too.

- **Ambient occlusion strength** (0-4, default 1) and **Disable ambient occlusion**: act on pixel shader `0x376F65B3` (`shader.dat/saoupsampling.pso`, the depth-aware upsample that writes the final AO term, 1 = unoccluded). The replacement runs the unmodified decompile of the game shader and returns `pow(ao, strength)`; the checkbox sends strength 0, which returns 1 without sampling. At strength 1 the game's own shader is left in place. The value reaches the shader as `shader_injection.ambient_occlusion_strength`, updated each present. The earlier AO passes still run. Saved as `AmbientOcclusionStrength` and `DisableAmbientOcclusion`. The checkbox is verified in game; the slider is not yet.

**Requires restart**

- **AO width/height multiplier** (0.1-2): scales `g_HiZMapTexture` and `g_SaoTexture_Half[0/1]` through a hook on the texture-create function `248160`, filtered by the three call sites in `774010`. Rebuilding these targets while the game runs was tried and crashes the game, so this stays restart-only.
- **Shadow resolution** (2048-16384): patches the size multiplier in `772750`, the cascade viewport shift/size in `77F860`/`77FA40` and the half shadow map size. On the first `cShadowParam` load the addon compares the game's multiplier `F513E0` with the patch and reverts the sites if the game initialised first.
- **Communication screen resolution** (256-2048): size immediates at `772998` and `77541C`.
- **Skip intro movies**, **Skip booting screens**, **Title screen opens Load Game**: small code patches at `7610B6`, `97CC99`/`97CCBC`/`97CCD1` and `990E4F`/`990E5F`/`990FD6`/`990FDB`.

Patches and hooks are applied in `init_device` or by the checkbox that owns them.

Verification so far is static: all expected bytes, hook entries and type-name strings were compared with the on-disk executable and match, and the hooked functions' argument counts were read from the game code. Nothing has been confirmed in game yet; in particular, the shadow hook's effect has not been observed in game. To verify: with all defaults the log must contain no `graphics tweaks:` hook or patch lines; move each live control and watch for the effect without reloading; set each restart option, relaunch and confirm its `applied`/`hook installed` line plus the visible effect (DevKit resource sizes for AO, shadow and communication targets).

## Save anywhere (testing)

Off by default. Hooks the game's save permission check (RVA `9CA540`) and the `@SAVE` scenario state test (RVA `38C8C0`, only for the `@SAVE` object) so pause menu Save stays enabled where the game greys it out, without changing stored script state. Saving during scripted events or bosses can create saves that resume in a broken state; use a spare slot and back up saves. Verified in game: Save enabled in a greyed-out area, save loaded correctly (state-memory variant).

## Movie mods

Replacement cutscene movies, such as AI-upscaled 4K packs, load without Automata-LodMod and without touching game files. Put the `.usm` files in a `movie` folder next to `NieRAutomata.exe`; each is played in place of `data\movie\<same name>.usm` (`movie_mods.hpp`).

- The addon redirects the executable's `CreateFileA`/`CreateFileW` imports for paths ending in `data\movie\<name>.usm`. If the replacement cannot be opened the game's file is used.
- The game sizes its movie heaps for 1920x1080. For larger replacements the addon multiplies `MOVIE FILE` (`86BE47`) and `MOVIE VRAM` (`86C0AF`) by `ceil(largest pixels / 2073600)` (4 for 3840x2160, at most 16) and grows their parents `FILE ROOT` (`86BA05`) and `TEXTURE ROOT` (`86BA2B`) by the same amount. This happens when the addon loads and needs the supported executable; it is skipped, with a red overlay message, if the game already created its heaps. Replacements are not loaded while the buffers are too small.
- Frame size is read from the MPEG sequence header of each file at start-up. H.264 movies are not supported (the game has no decoder for them).
- The **Movie mods** overlay section has the `Load replacement movies` checkbox (default on, saved as `ReplacementMovies`; unticking is live, ticking needs a restart when larger buffers are required), **Open movie folder**, the number of replacements found with the largest size, the buffer multiplier, and how many movies the game opened this session with how many were replaced. **Opened movies** lists each file with its open count.
- `ReShade.log` gets one `NieR:Automata movie mods:` line at start-up and one per movie on its first open.

Verified on the supported executable with 46 3840x2160 files: log reports `movie buffers 4x`; live heap ranges are `FF00000` and `7800000` bytes; the logo movies play and are logged as `game file`. Playback of a replaced cutscene is not yet confirmed in game. To verify: play a cutscene whose file exists in `movie` and check the overlay count and the `(replaced)` log line.

## Texture mods

Texture mods can be switched on and off while the game runs; no game file is modified. Each subfolder of `Mods` next to `NieRAutomata.exe` is one mod. Any `<HASH>.dds` inside it, at any depth, replaces the texture whose top mip level has that CRC32C. Texture mods published for FAR (Fix Automata Resolution) use the same file naming, so they can be extracted into a subfolder as they are, without FAR installed. Implemented independently on ReShade add-on events (`texture_mods.hpp`); no FAR or Special K code is used.

How it works: the game's own texture is left untouched. The addon hashes it at creation, creates the replacement texture beside it and binds the replacement's view whenever the game binds a shader resource view of the original. Enabling or disabling a mod therefore only changes which view gets bound. The original texture stays in video memory while it is replaced.

- Supported files: DXT1/3/5, ATI1/ATI2 (BC4/BC5), 32-bit RGBA/BGRA and DX10-header 2D textures, with any mip count. Replacements may differ in size and format from the original; sRGB or typeless storage follows the game's texture.
- The **Texture mods** overlay section lists every mod folder with a checkbox and its texture count. Ticking or unticking applies immediately to loaded textures and is remembered in `ReShade.ini` (`[renodx-nier_automata-texture-mods]`). Folders without `<HASH>.dds` files are listed greyed out.
- **Open Mods folder** opens the folder in Explorer, creating it if needed. **Rescan** picks up added, removed or changed folders and applies them at once.
- When two enabled mods replace the same texture, the folder whose name sorts first wins and the other is reported in `ReShade.log`.
- Replacements and rejected files are written to `ReShade.log` (`NieR:Automata texture mods:`).
- A mod made for an older game version does nothing for textures the game has since changed, because their hashes differ. Example: the menu grid, vignette and grain sheet was `013F2718` (2048x1024) and is `D93E5729` (4096x4096, `ui/ui_core.dtt`) in the supported Steam build; the loading-screen grid `713B879E` (`ui/ui_loading.dtt`) is unchanged.
- Mods that add game content (items, text, behaviours), such as mods made for the WAX framework, are not texture mods and are not handled here.

Manual check: put a transparent 4x4 DXT1 file at `Mods\None\D93E5729.dds`, start the game and open Options; the background grid is gone. Untick `None` in the overlay; the grid returns without a restart. Tick it again; the grid disappears.
