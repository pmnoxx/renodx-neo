// Original assets: adv/sys/compositor_stretchout_horizontal.dx11.pso; CRC32 0x79FAA200.
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
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 512 * g.rate_g;
  r0.x = trunc(r0.x);
  r0.y = 0.015625 * r0.x;
  r0.y = max(1, r0.y);
  r1.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r1.w = saturate(r1.w);
  r2.yw = frac(v1.yy);
  r3.xyzw = r1.xyzw;
  r0.zw = float2(1,0);
  while (true) {
    r4.x = cmp(r0.w >= r0.x);
    if (r4.x != 0) break;
    r4.x = r0.w * 0.000781250012 + v1.x;
    r2.x = frac(r4.x);
    r4.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r4.w = saturate(r4.w);
    r4.xyzw = r4.xyzw + r3.xyzw;
    r2.x = -r0.w * 0.000781250012 + v1.x;
    r2.z = frac(r2.x);
    r5.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r5.w = saturate(r5.w);
    r3.xyzw = r5.xyzw + r4.xyzw;
    r0.z = 2 + r0.z;
    r0.w = r0.w + r0.y;
  }
  r0.xyzw = r3.xyzw / r0.zzzz;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = g.alpha_g * r0.w;
  // Original output above: o0.w = g.alpha_g * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}