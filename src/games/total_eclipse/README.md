# Muv-Luv Alternative Total Eclipse

Experimental D3D11 HDR output and composite-resource preservation. Build with:

```powershell
cmake --build build --config Debug --target total_eclipse
```

Output: `build/Debug/renodx-total_eclipse.addon64`.

The addon explicitly discovers the real ReShade module. Display Commander's DXGI proxy also exports addon registration functions, but does not provide the full ReShade API.

The game draws artwork and video into an output-sized intermediate, then copies it to the swapchain. With HDR10 enabled, both original resources use RGB10A2. The intermediate must also have an RGBA16F clone; otherwise the swapchain's floating-point proxy has no valid image. The upgrade rule matches RGB10A2 render targets of any size and preserves the game's gamma-space compositing. The proxy decodes sRGB and encodes the result for HDR10. It does not inverse-tonemap the final SDR frame.

RGBA8 scene targets of any size are also cloned to RGBA16F. Save 1 proves the sprite pass produces RGB above 1 before its original UNORM write (observed maximum 1.71). The exposure/transition shader `0x5C733846` clamps sampled and output alpha to preserve the original UNORM alpha behavior. Without this fix, accumulated alpha exceeds 1 and causes unstable source-alpha blending in float targets. RGB exposure and transition math remain unchanged.

The scene remains in the game's gamma-shaped domain until final output conversion. This preserves actual upstream highlights without inverse-tonemapping. Other scenes, complete color calibration, and UI separation still need validation. Generic tone-mapping controls inherited from the scaffold are not wired to a game tonemapper.

## Verification

1. Start the game and verify the startup video and title artwork render.
2. In DevKit, capture a frame. Confirm the game composite target has an RGBA16F clone and the swapchain uses RGB10A2/HDR10.
3. Repeat after restarting without DevKit; no live clone override is required.
4. Before changing game shaders, capture a representative scene and compare original and cloned resources. Readbacks are live, not frozen snapshot contents.

Investigation captures, failed experiments, build logs, and rollback binaries are kept in the parent task directory, outside the game shader source folder.

The color-target rules now include RGBA8 and RGB10A2 render targets of any size, covering smaller effect buffers as well as output-sized composites. Single-channel masks and floating-point depth targets retain their original formats. This broad coverage still needs scene-by-scene validation.

Save 14 also exercises the final artwork/UI composite shader `0x1880F22A`. Float scene alpha can accumulate far above one (observed 695); this shader must clamp sampled alpha before vertex-alpha modulation and alpha testing. Clamping only its final output alpha is insufficient. The replacement preserves RGB and color-correction math. A live original/baseline/patched comparison reproduced corruption with original alpha handling and restored normal colors with sampled-alpha clamping.

Extracted transition shaders include timing, UV and trigonometric clamps. These must remain intact; removing every saturate/min/max is not an HDR fix. Source artwork may already be clipped, independently of render-target precision.


When adding or changing `custom_shaders`, keep each CRC32 entry mapped to its original in-game shader filename in an adjacent comment. Include every known filename alias for identical bytecode. For shaders embedded in a binary, record the binary name and extraction offset instead of inventing an asset path. The extracted `adv/sys` manifest is the naming reference for compositor shaders.
