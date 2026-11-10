# Muv-Luv Alternative Total Eclipse

Experimental D3D11 HDR output and composite-resource preservation. Build with:

```powershell
cmake --build build --config Debug --target total-eclipse
```

Output: `build/Debug/renodx-total-eclipse.addon64`.

## Additional compositor alpha compatibility

All 99 extracted `adv/sys/compositor*.dx11.pso` asset names are covered by
93 unique CRC-addressed replacements, each paired with its untouched
`.hlsl.original`. Hash-identical aliases share a replacement and are listed
beside the registration. Scene samples restore bounded alpha before effect
math; output alpha is bounded without clipping RGB. Pattern samples and
existing UV, transition-mask and timing clamps retain their original math.
The radial-blur zoomout and tears10 shaders ignore sampled alpha and only
bound output alpha; tears12 preserves its pattern input and bounds output
alpha. Sprite shaders are outside this compositor set.

Original-bytecode D3D11 WARP comparisons pass at five rates (0, 0.25, 0.5,
0.75, 1): 465 SDR cases with a two-byte channel tolerance and 465 float-input
stress cases comparing alpha 1 against alpha 2048, with unchanged HDR RGB.
These use synthetic textures, disabled blending, fixed nonzero loop count and
fixed other effect parameters; full game-scene, blend-state and timing coverage
is still required. All 93 original-source baselines and replacements compile.

Those comparisons exposed decompiler constant swizzle errors in horizontal,
vertical and bottom stretch, sidewipe-from-right and zoomout. Their original
DXBC reads transition rate and exposure separately; replacements restore that
mapping instead of broadcasting rate into exposure. Raw `.original` files
retain the decompiler text, including these artifacts. Invalid `int6` casts
are repaired to scalar signed integer comparisons or float conversions as
appropriate.

The horizontal stretch transition `0xA5FA10A3`
(`compositor_stretch_horizontal.dx11.pso`) also bounds sampled scene alpha
before its blur/interpolation and bounds output alpha. Its RGB, UVs, filter
weights and rate/exposure math remain unchanged. Live original and unmodified
baseline reproduced severe color corruption; the alpha-only replacement
removed it, reverting reproduced it, and restoring removed it again. The user
confirmed that the resulting strong horizontal blur matches the intended
transition. Permanent addon verification after restart remains pending.

The look-down/left/right, horizontal/vertical convolution, and tears14/18/19
replacements restore bounded sampled scene alpha before filtering, opacity
modulation or alpha testing, and bound output alpha for the float color target.
RGB, UVs, transition timing and discard expressions retain the original math.
Tears14 is a direct RGBA copy and only needs output alpha bounded. Tears19
retains its original alpha doubling and discard threshold before the output
clamp. Depth and pattern inputs are not changed.

All eight replacements and their unchanged decompiled baselines compile as
`ps_4_0`. The look-left/right baselines repair the decompiler's invalid `int6`
cast to the scalar signed-int-to-float conversion in the original DXBC.
Compilation does not establish original/baseline runtime equivalence.

Runtime verification is pending: compare original bytecode, unchanged baseline
and replacement at matching intermediate transition frames and endpoints;
check artwork, subtitles, menus and new save thumbnails. Confirm all eight
CRC-addressed shader embeds are included by the `total-eclipse` build and active
as Add-on replacements without live disk overrides after restart. Shader alpha
clamps do not emulate UNORM quantization or destination clamping after blending.

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

The pattern wipe `0xA4BA7C88` (`compositor_pattern.dx11.pso`) also clamps sampled scene alpha and output alpha. An animated scene can switch from ordinary crossfade to this pass; fixing crossfade alone leaves pattern transitions unstable. The paused rainy scene reproduced the failure with the original and unmodified decompiled pattern shader. The alpha-only replacement restored artwork, subtitles and menu composition, without changing the pattern mask or RGB exposure math.

When patching shaders, comment each changed block and retain the original expression in a comment where it is replaced. Mark inserted operations as added, explain the lost UNORM behavior being restored, and leave unrelated original math visible.

## Scenario render resolution

The RenoDX settings include **Scene Resolution**: Native, 3840 x 2160, or the
current monitor size. The engine's scenario render target is recreated at the
selected size and rebound to the scene while its logical layout stays at the
game's original dimensions. Artwork and video keep their source resolution.
Native mode restores the detected scenario target. Engine hooks install only
for the validated 1.0.27 x64 executable; other builds remain at native
resolution.

Keep two files together in this mod folder for every patched game shader:
`0xHASH.ps_4_0.hlsl` contains the patched replacement, and
`0xHASH.ps_4_0.hlsl.original` preserves the unpatched decompiled source.
Create the `.original` copy before editing, retain it unchanged through later
patches, and do not register or compile it as a replacement. Preserve raw
decompiler artifacts in `.original`; any repairs belong in the editable shader
or a separate task-local compilation baseline. Embedded shaders follow the same
convention using their recovered unpatched source.

The look-up transition 0x5E79C239 (compositor_look_up.dx11.pso) filters multiple scene samples. Clamp sampled alpha before that filter and output alpha before float-target blending, retaining RGB and UV math. The initial live comparison removed psychedelic corruption but left only the sky, requiring a vanilla reference rather than inferring success from clean colors. A restart with the game addon disabled and save 19 loaded also settles on the sky, with no face; the actual game window and native tda_screen readback confirm blue sky. Thus the settled scene selection matches this reference. Both input textures remain populated (face in texture0, sky in texture1); a diagnostic measured rate_g=1, alpha_g=1, brightness_g=1. Full transition timing and permanent addon runtime verification remain pending. DC native SDR screenshots swap red and blue in this session; use resource readbacks/window capture for color comparisons.

### CPU-uploaded video and save previews

Keep CPU-updated scene textures on their original SDR resource. The game's
`update_texture_region` and writable map paths update the original texture, not
its RGBA16F clone. Sampling an empty clone hides video or save previews even
when the original contains valid pixels. The game-local callbacks disable scene
clone substitution on CPU writes, including existing resource views. GPU-rendered
scene targets retain their float clones and compositor alpha fixes.

Verified after deployment on 2026-11-10: startup movie renders, and the user
confirmed both video playback and save thumbnails. Existing saves were not
modified. New-save thumbnail capture remains a separate verification case.
