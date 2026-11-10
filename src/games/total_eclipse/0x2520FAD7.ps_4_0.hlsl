// Original assets: adv/sys/compositor_mosaicinout.dx11.pso; CRC32 0x2520FAD7.
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
Texture2D<float4> texture0_g_Texture : register(t0);
Texture2D<float4> texture1_g_Texture : register(t1);


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

  r0.x = 1 + -g.rate_g;
  r0.x = r0.x + r0.x;
  r0.y = cmp(g.rate_g < 0.5);
  r0.z = g.rate_g + g.rate_g;
  r0.x = r0.y ? r0.z : r0.x;
  r0.x = 32 * r0.x;
  r0.x = trunc(r0.x);
  r0.x = max(1, r0.x);
  r0.yz = float2(1280,720) * v1.xy;
  r0.yz = trunc(r0.yz);
  r0.yz = r0.yz / r0.xx;
  r0.yz = trunc(r0.yz);
  r0.xy = r0.yz * r0.xx;
  r0.xy = float2(0.000781250012,0.00138888892) * r0.xy;
  r1.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r0.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r1.w = saturate(r1.w);
  r0.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r0.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r0.w = saturate(r0.w);
  r1.xyzw = r1.xyzw + -r0.xyzw;
  r0.xyzw = g.rate_g * r1.xyzw + r0.xyzw;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = g.alpha_g * r0.w;
  // Original output above: o0.w = g.alpha_g * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}