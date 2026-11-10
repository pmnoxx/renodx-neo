// ---- Created with 3Dmigoto v1.3.16 on Tue Nov 10 02:45:25 2026

cbuffer _Unif_g_0 : register(b1)
{

  struct
  {
    float4 pos_g;
    float rate_g;
    float time_g;
    float alpha_g;
    float exposure_g;
    float brightness_g;
    float value_g;
    int loop_g;
    float power_g;
  } g : packoffset(c0);

}

SamplerState texture0_g_Sampler_s : register(s0);
SamplerState texture1_g_Sampler_s : register(s1);
SamplerState pattern_g_Sampler_s : register(s2);
Texture2D<float4> texture0_g_Texture : register(t0);
Texture2D<float4> texture1_g_Texture : register(t1);
Texture2D<float4> pattern_g_Texture : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : LOCATION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(1,1) + -v1.xy;
  r0.xyzw = pattern_g_Texture.Sample(pattern_g_Sampler_s, r0.xy).xyzw;
  r0.y = g.rate_g * 2 + -1;
  r0.x = r0.y + r0.x;
  r0.y = cmp(1 < r0.x);
  r0.x = r0.y ? 1 : r0.x;
  r0.y = cmp(r0.x < 0);
  r0.x = r0.y ? 0 : r0.x;
  r1.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, v1.xy).xyzw;
  // Added: sampled alpha was implicitly limited by the original UNORM source.
  r1.w = saturate(r1.w);
  r2.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: retain the same sampled-alpha range for the other scene input.
  r2.w = saturate(r2.w);
  r1.xyzw = -r2.xyzw + r1.xyzw;
  r0.xyzw = r0.xxxx * r1.xyzw + r2.xyzw;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  // Original: o0.w = g.alpha_g * r0.w;
  // Restore alpha clamping before float-target blending; preserve RGB exposure.
  o0.w = saturate(g.alpha_g * r0.w);
  return;
}
