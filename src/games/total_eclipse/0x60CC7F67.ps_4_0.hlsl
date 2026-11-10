// Original assets: adv/sys/compositor_tears5.dx11.pso; CRC32 0x60CC7F67.
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
SamplerState pattern_g_Sampler_s : register(s2);
Texture2D<float4> texture0_g_Texture : register(t0);
Texture2D<float4> pattern_g_Texture : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : LOCATION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = pattern_g_Texture.Sample(pattern_g_Sampler_s, v1.xy).xyzw;
  r0.x = g.time_g * r0.w;
  r0.x = 6.28318548 * r0.x;
  r0.x = sin(r0.x);
  r0.yz = float2(0.5,0.5) + -v1.xy;
  r0.xy = r0.yz * r0.xx;
  r0.xy = g.rate_g * r0.xy;
  r0.xy = -r0.xy * float2(0.0299999993,0.0299999993) + v1.xy;
  r0.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r0.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r0.w = saturate(r0.w);
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = g.alpha_g * r0.w;
  // Original output above: o0.w = g.alpha_g * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}