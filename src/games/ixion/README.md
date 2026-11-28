# RenoDX for IXION

**Version:** 1.0.0

A RenoDX addon for IXION (Unity HDRP, DirectX 11). It replaces the game's SDR tone mapping with HDR tone mapping, adds color grading and effect controls, and outputs HDR10.

## What it does

- Builds the color grading LUT from untonemapped color, then tone maps it with RenoDRT or the vanilla ACES fit.
- Adds bloom, vignette and dither strength sliders, plus a LUT shaper and tetrahedral LUT sampling option.
- Keeps the final pass from clamping highlights, and scales game and UI brightness separately.
- Outputs HDR10 (BT.2020 PQ, `R10G10B10A2`).

## Resource upgrades

All `R8G8B8A8_TYPELESS` and `R11G11B10_FLOAT` resources are upgraded to 16-bit float at any size.

The addon version is shown at the bottom of the settings UI under **Misc**.

## Build

Build the `ixion` target. The expected artifact is `renodx-ixion.addon64`.

## Manual verification

Load the addon through ReShade in IXION and confirm the RenoDX settings appear. Check that highlights exceed Game Brightness in gameplay and that menus and UI follow the UI Brightness slider. Switch the tone mapper to Vanilla to compare with the original SDR look.
