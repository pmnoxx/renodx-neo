# RenoDX for Azur Promilia

**Version:** 0.2.0

An experimental RenoDX addon for Azur Promilia. It upgrades the game's post-processing and UI resources for HDR output and provides tone mapping, color grading, display output, and optional UI ID hiding controls.

## Resource upgrades

The following resource upgrades are enabled by default at output size:

- `R8G8B8A8_TYPELESS`
- `R8G8B8A8_UNORM`
- `R8G8B8A8_UNORM_SRGB`

Other resource format upgrades default to Off. The resource upgrade controls are available in Advanced settings.

The addon version is also shown at the bottom of the settings UI under **Misc**.

## Build

Build the `azur-promilia` target. The expected artifact is `renodx-azur-promilia.addon64`.

## Manual verification

Load the addon through ReShade in Azur Promilia, confirm the RenoDX settings appear, and check that the three listed resource upgrades use Output size by default. Verify HDR output and tone mapping in game.

With RenoDRT enabled, check a bright scene that uses a `PostProcess2D` color LUT. Highlights should exceed Game Brightness while the LUT still affects the image. Switch to Vanilla to check the original SDR behavior.
