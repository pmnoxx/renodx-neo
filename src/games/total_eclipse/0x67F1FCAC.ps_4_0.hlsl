// Original assets: adv/sys/compositor_tears2.dx11.pso; CRC32 0x67F1FCAC.
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
Texture2D<float4> texture0_g_Texture : register(t0);


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

  r0.xy = float2(0.5,3) * g.time_g;
  r0.z = v1.y * 9 + r0.x;
  r0.z = frac(r0.z);
  r0.z = cmp(0.699999988 >= r0.z);
  r0.z = r0.z ? 0.000391 : 0;
  r0.z = v1.x + r0.z;
  r0.x = r0.z * 16 + r0.x;
  r0.x = frac(r0.x);
  r0.x = cmp(0.699999988 >= r0.x);
  r0.x = r0.x ? 0.000694 : 0;
  r0.x = v1.y + r0.x;
  r0.w = r0.x * 62.831852 + r0.y;
  r0.w = sin(r0.w);
  r1.x = r0.w * 0.000390625006 + r0.z;
  r0.y = r1.x * 62.831852 + r0.y;
  r0.y = sin(r0.y);
  r1.y = r0.y * 0.000694444461 + r0.x;
  r0.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r0.w = saturate(r0.w);
  r1.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r1.w = saturate(r1.w);
  r0.xyzw = -r1.xyzw + r0.xyzw;
  r0.xyzw = g.alpha_g * r0.xyzw + r1.xyzw;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = r0.w;
  // Original output above: o0.w = r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}