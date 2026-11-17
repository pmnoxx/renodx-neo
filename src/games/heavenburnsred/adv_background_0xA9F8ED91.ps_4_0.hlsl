// Lily/AdvBackgroundImage (story-scene background sprite)
#include "./shared.h"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);

void main(
    float4 v0 : SV_POSITION0,
    float4 v1 : COLOR0,
    float4 v2 : TEXCOORD0,
    float4 v3 : TEXCOORD1,
    out float4 o0 : SV_Target0) {
  float2 uv = v2.xy;

  // RenoDX: zoom out around the screen center, matching the story-character zoom in
  // adv_character_0xE209A12D. The sprite is an affine screen-aligned quad, so the UV derivatives
  // give the texel at the screen center. Past the image edge the background is black.
  bool outside = false;
  if (CUSTOM_BACKGROUND_ZOOM > 1.f && CUSTOM_SCREEN_WIDTH > 0.f) {
    float2 duv_dx = ddx(v2.xy);
    float2 duv_dy = ddy(v2.xy);
    float2 offset = 0.5f * float2(CUSTOM_SCREEN_WIDTH, CUSTOM_SCREEN_HEIGHT) - v0.xy;
    float2 uv_center = v2.xy + duv_dx * offset.x + duv_dy * offset.y;
    uv = uv_center + (v2.xy - uv_center) * CUSTOM_BACKGROUND_ZOOM;
    outside = any(uv < 0.f) || any(uv > 1.f);
  }

  float4 r0 = t0.Sample(s0_s, uv);
  if (outside) r0.xyz = 0.f;
  o0.xyz = v1.xyz * r0.xyz;
  o0.w = v1.w;
}
