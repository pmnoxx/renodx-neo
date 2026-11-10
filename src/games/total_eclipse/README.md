# Muv-Luv Alternative Total Eclipse

Experimental D3D11 HDR output and composite-resource preservation. Build with:

```powershell
cmake --build build --config Debug --target total_eclipse
```

Output: `build/Debug/renodx-total_eclipse.addon64`.

The addon explicitly discovers the real ReShade module. Display Commander's DXGI proxy also exports addon registration functions, but does not provide the full ReShade API.

The game draws artwork and video into an output-sized intermediate, then copies it to the swapchain. With HDR10 enabled, both original resources use RGB10A2. The intermediate must also have an RGBA16F clone; otherwise the swapchain's floating-point proxy has no valid image. The upgrade rule matches output-sized RGB10A2 render targets and preserves the game's gamma-space compositing. The proxy decodes sRGB and encodes the result for HDR10. It does not inverse-tonemap the final SDR frame.

Output-sized RGBA8 scene targets are also cloned to RGBA16F. Save 1 proves the sprite pass produces RGB above 1 before its original UNORM write (observed maximum 1.71). The exposure/transition shader `0x5C733846` clamps sampled and output alpha to preserve the original UNORM alpha behavior. Without this fix, accumulated alpha exceeds 1 and causes unstable source-alpha blending in float targets. RGB exposure and transition math remain unchanged.

The scene remains in the game's gamma-shaped domain until final output conversion. This preserves actual upstream highlights without inverse-tonemapping. Other scenes, complete color calibration, and UI separation still need validation. Generic tone-mapping controls inherited from the scaffold are not wired to a game tonemapper.

## Verification

1. Start the game and verify the startup video and title artwork render.
2. In DevKit, capture a frame. Confirm the game composite target has an RGBA16F clone and the swapchain uses RGB10A2/HDR10.
3. Repeat after restarting without DevKit; no live clone override is required.
4. Before changing game shaders, capture a representative scene and compare original and cloned resources. Readbacks are live, not frozen snapshot contents.

Investigation captures, failed experiments, build logs, and rollback binaries are kept in the parent task directory, outside the game shader source folder.
