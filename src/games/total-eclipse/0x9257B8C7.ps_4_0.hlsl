// Original assets: adv/sys/compositor_radial_blur_zoomin_first_end.dx11.pso; CRC32 0x9257B8C7.
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  // Original decompiler: r0.x = (int6)g.loop_g;
  // Repair scalar signed loop-count conversion/comparison from the original DXBC.
  r0.x = (float)g.loop_g;
  r0.y = 1 / r0.x;
  r1.xyzw = float4(0.5,0.5,0.5,0.5) + -v1.xyxy;
  r0.z = dot(r1.zw, r1.zw);
  r0.w = sqrt(r0.z);
  r0.z = rsqrt(r0.z);
  r2.xyzw = r1.zwzw * r0.zzzz;
  r3.xyzw = float4(0,0,0,0);
  r0.z = 0;
  while (true) {
    r4.x = (int)r0.z;
    r4.y = cmp(r4.x >= r0.x);
    if (r4.y != 0) break;
    r0.z = (int)r0.z + 1;
    r4.y = (int)r0.z;
    r4.y = r4.y * r0.y;
    r4.y = r4.y * r0.w;
    r4.y = g.power_g * r4.y;
    r4.y = 0.015625 * r4.y;
    r5.xyzw = r4.yyyy * r2.xyzw;
    r4.x = r4.x * r0.y;
    r4.xyzw = r4.xxxx * r1.xyzw;
    r4.xyzw = g.power_g * r4.xyzw;
    r4.xyzw = r4.xyzw * float4(0.119999997,0.119999997,0.119999997,0.119999997) + v1.xyxy;
    r6.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r4.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r6.w = saturate(r6.w);
    r4.xyzw = r5.xyzw * float4(3,3,6,6) + r4.xyzw;
    r5.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r4.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r5.w = saturate(r5.w);
    r5.xyzw = float4(0.200000003,0.200000003,0.200000003,0.200000003) * r5.xyzw;
    r4.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r4.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r4.w = saturate(r4.w);
    r5.xyzw = r6.xyzw * float4(0.699999988,0.699999988,0.699999988,0.699999988) + r5.xyzw;
    r4.xyzw = r4.xyzw * float4(0.100000001,0.100000001,0.100000001,0.100000001) + r5.xyzw;
    r3.xyzw = r4.xyzw + r3.xyzw;
  }
  r0.xyzw = r3.xyzw / r0.xxxx;
  r1.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r1.w = saturate(r1.w);
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