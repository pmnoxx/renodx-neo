# NieR:Automata

Experimental D3D11/x64 development addon. The current baseline hides native HDR through `IDXGIOutput6::GetDesc1`. Successful queries originating inside the game executable receive SDR BT.709 color space and eight bits per color. Calls from RenoDX, DevKit and other modules retain the real descriptor. Windows HDR stays enabled independently of this game setting.

`[renodx-nier_automata] HideNativeHDR=1` in ReShade.ini enables the startup hook (default). Set it to `0` and restart to compare native detection. Use `[ADDON] LoadFromDllMain=renodx-nier_automata.addon64` to load before native display detection. Normal device-time addon loading is too late. The addon intercepts the executable's named `CreateDXGIFactory` import, preserving ReShade's current redirected entry point, and installs the output descriptor hook on the primary adapter/output implementation before returning the factory to the game. The actual hook hit and resulting SDR swapchain must be verified; multi-adapter implementations have not been tested.

The overlay shows the count of intercepted game queries. The addon fails to activate if the factory import cannot be patched; output-hook installation failures are logged. The real API handles failed/null queries unchanged. The game uses `DisplayConfigGetDeviceInfo` for display names, so hooking advanced-color packets there did not disable its HDR.

## Custom RenoDX HDR

`[renodx-nier_automata] EnableHDR=1` (default) upgrades the SDR rendering path to HDR10. `EnableHDR=0` plus a restart restores the verified SDR baseline with no addon resource upgrades or shader replacements. Keep `HideNativeHDR=1` in both modes. Do not enable the game's native HDR.

- `0x7FB4ADA1`: capture scene + bloom, vignette and exposure before the rational SDR curve. Preserve original strip-LUT addressing, LUT blend and brightness as a decoded SDR grade reference. Forward-map the real upstream scene with three-input `ToneMapPass`, using the rational curve as the neutral reference. Write extended sRGB-shaped values for later game composition.
- `0x644BD65C`: preserve the reconstructed SDR CAS algorithm, removing its final saturate. Above-white neighborhoods naturally disable its SDR sharpening weight; highlights pass through without clipping. This manually reconstructed shader compiles but is not binary-equivalent to the original.
- Alternate scene variants `0xA0D17E10`, `0x74B83FF7` and dual-output `0x83C6596C` also use scene-side HDR mapping. Keep packed LUT sampling and highlight masks, using a smooth rational LUT reference rather than clipping HDR into the lookup domain. Preserve the encoded primary and native linear secondary output conventions. The linear t3 domain is inferred from the dual-output LUT builder and still needs live consumer validation when those variants execute.
- `0x96F799BE`: remove the executed adaptive CAS upscaler's final RGB upper clamp while preserving weighting and interpolation. Alternate variants compile but their execution/appearance requires scene and scaling coverage beyond the currently observed no-upscale path.
- Clone output-sized RGBA8 render targets to FP16; retain existing scene/bloom float formats and leave asset textures/LUTs alone. Use an FP16 swapchain proxy, then a thin `SwapChainPass` to encode BT.2020/PQ into RGB10A2 HDR10.
- Default peak 1000 nits, scene/UI white 203 nits. The game addon overlay exposes peak/scene/UI brightness for the current session. These experimental sliders are not persisted yet.
- Every patched original shader has an unpatched `.hlsl.original` companion. Proxy shaders are new code and have no original game shader.

Build from the existing Clang x64 environment with `cmake --build --preset clang-x64-debug --target nier_automata`. Close the game first. Output: `build/Debug/renodx-nier_automata.addon64`; generated embeds are under `build/nier_automata.include/embed/`. No global build configuration changes are needed.

Verified in the title/menu and a loaded forest gameplay scene: native HDR query masked, SDR tonemap and CAS hashes active as addon replacements, native HDR dispatches absent, RGB10A2/PQ presentation, full-resolution FP16 compositor/proxy. Gameplay readback retained values above one through scene, tonemap, CAS and the presentation proxy. HUD and minimap rendered in the captured scene. This establishes a working experimental HDR pipeline; full SDR appearance matching, peak adjustment comparisons, other areas/effects, menus and video still need broader visual validation.

The original tonemap reconstruction was visually checked on the title screen but is not proven pixel-equivalent. The other offline reconstructed compute shaders are not registered. Multi-adapter native HDR detection remains untested.
