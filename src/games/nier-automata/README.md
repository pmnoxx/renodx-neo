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
