#ifndef SRC_GAMES_AZUR_PROMILIA_UI_HLSL_
#define SRC_GAMES_AZUR_PROMILIA_UI_HLSL_

#include "./shared.h"

// The UID label ("UID:xxxxxxxxxxxx", bottom-left, right of the ping readout) is drawn into a
// vertically flipped UI target, so on screen x 0.068..0.158 / y 0.975..1.0 it sits at
// NDC x -0.864..-0.684 / y 0.95..1.0. Glyph quads fully inside collapse to a point.
float4 HideUidVertex(float4 position) {
  if (CUSTOM_HIDE_UID == 0.f || position.w == 0.f) return position;
  float2 ndc = position.xy / position.w;
  if (ndc.x > -0.864f && ndc.x < -0.684f && ndc.y > 0.95f && ndc.y < 1.02f) {
    return float4(-2.f, -2.f, 0.f, 1.f);
  }
  return position;
}

#endif  // SRC_GAMES_AZUR_PROMILIA_UI_HLSL_
