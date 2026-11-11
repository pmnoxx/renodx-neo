# NieR:Automata

The overlay displays the loaded addon's embedded file version and compile date/time.
Include both lines in bug-report screenshots to identify the installed build.
The file version is generated during CMake configuration in UTC; the compile time
uses the build machine's local timezone.

On a fresh installation, configuring early loading before any native HDR query
was intercepted opens a restart popup automatically, even with the ReShade menu
closed. Its red warning explains the ReShade loading limitation and asks the user
to fully close and relaunch the game. `Understood` dismisses it for that process;
it does not restart the game. A red reminder remains in the addon overlay.
Verify with an empty INI: first launch shows the popup, dismissal does not repeat
it that session, and the next launch with working early loading shows no popup.

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

High FPS can affect frame-counted scripts and menus. Use the live 60 FPS switch
for affected sequences. Pause-state timer updates are capped at 60 automatically;
cutscene, hacking and menu detection is not otherwise implemented. Verify game
speed and progression before treating a high-FPS session as fully supported.

Validated on the supported executable: the title scene updates at 120 FPS with
a normalized simulation step near 0.5 (8.333 ms times 0.06 ticks/ms), and the
user confirmed unlocking worked after increasing the display refresh rate.
Full gameplay progression and every timing-sensitive sequence remain unverified.

Experimental D3D11/x64 development addon. The current baseline hides native HDR through `IDXGIOutput6::GetDesc1`. Successful queries originating inside the game executable receive SDR BT.709 color space and eight bits per color. Calls from RenoDX, DevKit and other modules retain the real descriptor. Windows HDR stays enabled independently of this game setting.

Native HDR suppression is always enabled. The addon automatically adds its actual filename to ReShade's `ADDON.LoadFromDllMain` list while preserving other entries. A fresh installation needs one full game restart after the first launch so the addon can load before native display detection. The overlay and log show a restart notice when no game HDR query was intercepted. No manual INI edit is required. Normal device-time addon loading is too late for that launch. The addon intercepts the executable's named `CreateDXGIFactory` import, preserving ReShade's current redirected entry point, and installs the output descriptor hook on the primary adapter/output implementation before returning the factory to the game. The actual hook hit must be verified; multi-adapter implementations have not been tested.

The overlay shows the count of intercepted game queries. The addon fails to activate if the factory import cannot be patched; output-hook installation failures are logged. The real API handles failed/null queries unchanged. The game uses `DisplayConfigGetDeviceInfo` for display names, so hooking advanced-color packets there did not disable its HDR.

## Custom RenoDX HDR

The addon always upgrades the SDR rendering path to HDR10 and suppresses the game's native HDR detection. There are no `HideNativeHDR` or `EnableHDR` config options; obsolete entries are ignored. Brightness, tone mapping, grading, FPS, and motion-blur controls remain configurable.

- `0x7FB4ADA1`: capture scene + bloom, vignette and exposure before the rational SDR curve. Preserve original strip-LUT addressing, LUT blend and brightness as a decoded SDR grade reference. Forward-map the real upstream scene with three-input `ToneMapPass`, using the rational curve as the neutral reference. Write extended sRGB-shaped values for later game composition.
- `0x644BD65C`: preserve the reconstructed SDR CAS algorithm, removing its final saturate. Above-white neighborhoods naturally disable its SDR sharpening weight; highlights pass through without clipping. This manually reconstructed shader compiles but is not binary-equivalent to the original.
- Alternate scene variants `0xA0D17E10`, `0x74B83FF7` and dual-output `0x83C6596C` also use scene-side HDR mapping. Keep packed LUT sampling and highlight masks, using a smooth rational LUT reference rather than clipping HDR into the lookup domain. Preserve the encoded primary and native linear secondary output conventions. The linear t3 domain is inferred from the dual-output LUT builder and still needs live consumer validation when those variants execute.
- `0x96F799BE`: remove the executed adaptive CAS upscaler's final RGB upper clamp while preserving weighting and interpolation. Alternate variants compile but their execution/appearance requires scene and scaling coverage beyond the currently observed no-upscale path.
- Clone output-sized RGBA8 render targets and MSAA resolve destinations to FP16; retain existing scene/bloom float formats and leave asset textures/LUTs alone. Use an FP16 swapchain proxy, then a thin `SwapChainPass` to encode BT.2020/PQ into RGB10A2 HDR10.
- The shared resource resolve handler preserves a caller-supplied typed format when it matches the effective resource format family. This avoids an unsupported-format assertion for native `R11G11B10_FLOAT` MSAA buffers while still selecting the upgraded format for cloned targets. To verify, enable MSAA in game settings, apply, and load gameplay without an assertion; check scene rendering and HDR output. MSAA resolve destinations can be shader-readable without render-target usage, so the game upgrade rule includes `resolve_dest` to keep both ends in FP16. After deploying both fixes, the user confirmed MSAA could be enabled without a crash; title rendering continued with HDR10/PQ output and the FPS unlock active. Broader gameplay and all sample-count combinations remain unverified.
- Default peak 1000 nits, scene/UI white 203 nits. The game addon overlay exposes peak/scene/UI brightness and persists these sliders.
- The overlay's Basic section now includes the tone mapper (`Vanilla`, `None`, `ACES`, or `RenoDRT`), peak/scene/UI white, 2.2 gamma correction, and exposure. Advanced color grading exposes highlights, shadows, contrast, and saturation. Settings are saved under `[renodx-nier_automata]`; defaults preserve the current RenoDRT mapping and neutral grading values.
- Every patched original shader has an unpatched `.hlsl.original` companion. Proxy shaders are new code and have no original game shader.

Build from the existing Clang x64 environment with `cmake --build --preset clang-x64-debug --target nier-automata`. Close the game first. Output: `build/Debug/renodx-nier-automata.addon64`; generated embeds are under `build/nier-automata.include/embed/`. No global build configuration changes are needed.

Verified in the title/menu and a loaded forest gameplay scene: native HDR query masked, SDR tonemap and CAS hashes active as addon replacements, native HDR dispatches absent, RGB10A2/PQ presentation, full-resolution FP16 compositor/proxy. Gameplay readback retained values above one through scene, tonemap, CAS and the presentation proxy. HUD and minimap rendered in the captured scene. This establishes a working experimental HDR pipeline; full SDR appearance matching, peak adjustment comparisons, other areas/effects, menus and video still need broader visual validation.

The original tonemap reconstruction was visually checked on the title screen but is not proven pixel-equivalent. The other offline reconstructed compute shaders are not registered. Multi-adapter native HDR detection remains untested.

### Startup verification

With no addon settings or early-load entry, launch once and verify the addon appends its filename to `ADDON.LoadFromDllMain`; restart and confirm the log reports output-hook installation and an intercepted native HDR query. Existing early-load entries must survive without duplicate NieR entries. Legacy zero-valued `HideNativeHDR`/`EnableHDR` keys must not disable either behavior. Without saved FPS settings, the overlay must show Unlock FPS enabled at 60; saved FPS choices must still apply. With Windows HDR enabled, verify native HDR dispatches are absent and analyzer luminance extends above SDR white. These runtime checks are required in addition to a successful build.

## Camera motion blur

The overlay's `Disable camera motion blur` option replaces pixel shader `0x83015F55` with a neutral (0.5, 0.5) velocity output while enabled; it is off by default and saved as `DisableCameraMotionBlur`. Disassembly confirms that this pass computes camera velocity from the depth texture, camera parameters, and previous view-projection matrix. Two vertex shaders also produce previous-frame geometry velocity (`0x4ABDF171` and `0xF96BB863`); they are not replaced yet, so object-motion blur may remain. The current option only suppresses the camera-derived component and still needs visual verification in gameplay.
