// Original assets: adv/sys/compositor_radial_blur_zoomin.dx11.pso; CRC32 0x61E19493.
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

SamplerState texture1_g_Sampler_s : register(s1);
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
  r0.z = g.power_g * g.rate_g;
  r1.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r1.w = saturate(r1.w);
  // Original decompiler: r0.w = (int6)g.loop_g;
  // Repair scalar signed loop-count conversion/comparison from the original DXBC.
  r0.w = (float)g.loop_g;
  r0.w = 0.319999993 / r0.w;
  r2.xyzw = r1.xyzw;
  r3.xyz = float3(1,0,0);
  while (true) {
  // Original decompiler: r3.w = cmp((int)r3.z >= (int6)g.loop_g);
  // Repair scalar signed loop-count conversion/comparison from the original DXBC.
    r3.w = cmp((int)r3.z >= (int)g.loop_g);
    if (r3.w != 0) break;
    r3.w = 1 + -r3.y;
    r4.xy = r0.xy * r3.ww + float2(0.5,0.5);
    r4.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r4.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r4.w = saturate(r4.w);
    r2.xyzw = r4.xyzw * r0.zzzz + r2.xyzw;
    r3.y = r3.y + r0.w;
    r3.x = g.power_g * g.rate_g + r3.x;
    r3.z = (int)r3.z + 1;
  }
  r0.xyzw = r2.xyzw / r3.xxxx;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = g.alpha_g * r0.w;
  // Original output above: o0.w = g.alpha_g * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}