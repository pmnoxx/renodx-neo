// Hidden/Lens Render Pipeline/Utils/Blit (_SRGB_TO_LINEAR_CONVERSION)
// Sign-preserving sRGB conversion so wide-gamut (negative) BT.709 values survive.
#include "./shared.h"

Texture2D<float4> t0 : register(t0);  // _BlitTexture
SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0) {
  float4 cb0[115];
}

void main(
    float4 v0: SV_POSITION0,
    float2 v1: TEXCOORD0,
    out float4 o0: SV_Target0) {
  float4 color = t0.Sample(s0_s, v1.xy);
  o0.rgb = renodx::color::srgb::DecodeSafe(color.rgb);
  o0.w = cb0[114].x ? (1.f - color.w) : color.w;
}
