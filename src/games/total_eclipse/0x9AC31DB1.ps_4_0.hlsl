// Original assets: adv/sys/compositor_sidewipe_blur_zoomin.dx11.pso; CRC32 0x9AC31DB1.
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
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r1.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r1.w = saturate(r1.w);
  // Original decompiler: r0.z = (int6)g.loop_g;
  // Repair scalar signed loop-count conversion/comparison from the original DXBC.
  r0.z = (float)g.loop_g;
  r0.z = 0.319999993 / r0.z;
  r2.xyzw = r1.xyzw;
  r0.w = 1;
  r3.xy = float2(0,0);
  while (true) {
  // Original decompiler: r3.z = cmp((int)r3.y >= (int6)g.loop_g);
  // Repair scalar signed loop-count conversion/comparison from the original DXBC.
    r3.z = cmp((int)r3.y >= (int)g.loop_g);
    if (r3.z != 0) break;
    r3.z = 1 + -r3.x;
    r3.zw = r0.xy * r3.zz + float2(0.5,0.5);
    r4.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r3.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r4.w = saturate(r4.w);
    r2.xyzw = r4.xyzw * g.power_g + r2.xyzw;
    r3.x = r3.x + r0.z;
    r0.w = g.power_g + r0.w;
    r3.y = (int)r3.y + 1;
  }
  r0.x = cmp(g.rate_g >= 1);
  if (r0.x != 0) {
    r1.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, v1.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r1.w = saturate(r1.w);
  } else {
    r0.xyzw = r2.xyzw / r0.wwww;
    r2.x = 1 + -g.rate_g;
    r3.y = v1.y;
    r1.xyzw = r0.xyzw;
    r2.y = 8;
    while (true) {
      r2.z = cmp((int)r2.y < 0);
      if (r2.z != 0) break;
      r2.z = (int)r2.y;
      r2.z = r2.z * r2.x;
      r2.z = -r2.z * 0.125 + v1.x;
      r3.x = r2.z + -r2.x;
      r2.z = cmp(r3.x >= 0);
      if (r2.z != 0) {
        r4.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r3.xy).xyzw;
        // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
        r4.w = saturate(r4.w);
        r4.xyzw = r4.xyzw + -r1.xyzw;
        r1.xyzw = r4.xyzw * float4(0.200000003,0.200000003,0.200000003,0.200000003) + r1.xyzw;
      }
      r2.y = (int)r2.y + -1;
    }
  }
  r0.x = 1 + g.exposure_g;
  r0.x = g.brightness_g * r0.x;
  o0.xyz = r1.xyz * r0.xxx;
  o0.w = g.alpha_g * r1.w;
  // Original output above: o0.w = g.alpha_g * r1.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}