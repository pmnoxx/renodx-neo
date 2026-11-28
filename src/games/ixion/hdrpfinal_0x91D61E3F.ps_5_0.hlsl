#include "./common.hlsl"

Texture2DArray<float4> t3 : register(t3);
Texture2DArray<float4> t2 : register(t2);
Texture2DArray<float4> t1 : register(t1);
Texture2DArray<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1) {
  float4 cb1[79];
}
cbuffer cb0 : register(b0) {
  float4 cb0[6];
}

void main(
    float4 v0: SV_POSITION0,
    float2 v1: TEXCOORD0,
    out float4 o0: SV_Target0) {
  int4 coord;
  coord.xy = (uint2)(cb1[46].xy * v1.xy);
  coord.xy = (uint2)((float2)coord.xy * cb0[3].xy + cb0[3].zw * (cb1[46].xy - 1));
  coord.zw = 0;
  float3 color = t0.Load(coord).xyz;
  float alpha = t3.Load(coord).x;
  // vanilla clamps here; HDR output must not
  if (injectedData.toneMapType == 0.f) color = saturate(color);

  float2 uv = v1.xy * cb0[3].xy + cb0[3].zw;
  if (injectedData.fxNoise > 0.f) {
    color = renodx::color::srgb::EncodeSafe(color);
    float n = t2.SampleBias(s1_s, float3(cb0[2].xy * uv, cb0[2].z), cb1[78].y).w * 2 - 1;
    n = (n >= 0 ? 1 : -1) * (1 - sqrt(1 - abs(n)));
    color += n * (1.f / 255.f) * injectedData.fxNoise;
    color = renodx::color::srgb::DecodeSafe(color);
  }

  float4 after_post = t1.SampleLevel(s0_s, float3(cb1[48].xy * uv, 0), 0);
  o0.xyz = after_post.w * color + after_post.xyz;
  o0.rgb = PostToneMapScale(o0.rgb);
  o0.w = (cb0[5].x == 1.0) ? alpha : 1.f;
}
