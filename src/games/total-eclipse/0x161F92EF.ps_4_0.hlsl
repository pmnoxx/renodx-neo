// Original assets: adv/sys/compositor_dizzy_fade.dx11.pso; CRC32 0x161F92EF.
// ---- Created with 3Dmigoto v1.3.16 on Tue Nov 10 02:45:24 2026

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
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = g.rate_g * 2 + -1;
  r0.x = 1.57079637 * r0.x;
  r0.x = cos(r0.x);
  r0.x = log2(abs(r0.x));
  r0.x = 3.5 * r0.x;
  r0.x = exp2(r0.x);
  r0.x = 0.0500000007 * r0.x;
  r1.yz = float2(0,0);
  r2.xyzw = float4(0,0,0,0);
  r0.y = -3.5;
  while (true) {
    r0.z = cmp(r0.y >= 3.5);
    if (r0.z != 0) break;
    r0.z = r0.y * r0.y;
    r0.z = -0.103049651 * r0.z;
    r0.z = exp2(r0.z);
    r0.z = 0.150786012 * r0.z;
    r0.w = r0.y * r0.x;
    r1.xw = float2(0.142857149,0.142857149) * r0.ww;
    r3.xyzw = v1.xyxy + r1.xyzw;
    r4.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r3.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r4.w = saturate(r4.w);
    r4.xyzw = r4.xyzw * r0.zzzz + r2.xyzw;
    r3.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r3.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r3.w = saturate(r3.w);
    r2.xyzw = r3.xyzw * r0.zzzz + r4.xyzw;
    r0.y = 1 + r0.y;
  }
  r0.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r0.w = saturate(r0.w);
  r1.xyzw = r2.xyzw * float4(0.618146598,0.618146598,0.618146598,0.618146598) + -r0.xyzw;
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