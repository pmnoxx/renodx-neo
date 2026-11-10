// Original assets: adv/sys/compositor_stretch_vertical.dx11.pso; CRC32 0x9E1FC3EE.
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
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 0;
  r1.xyzw = float4(0,0,0,0);
  r0.yz = float2(0,0);
  while (true) {
    r0.w = cmp((int)r0.z >= 64);
    if (r0.w != 0) break;
    r2.xy = v1.xy + -r0.xy;
    r2.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r2.w = saturate(r2.w);
    r3.xy = v1.xy + r0.xy;
    r3.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r3.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r3.w = saturate(r3.w);
    r2.xyzw = r3.xyzw + r2.xyzw;
    r1.xyzw = r2.xyzw * float4(0.0078125,0.0078125,0.0078125,0.0078125) + r1.xyzw;
    r0.y = g.rate_g * 0.015625 + r0.y;
    r0.z = (int)r0.z + 1;
  }
  // Original decompiler: r0.xy = float2(-0.5,1) + g.rate_g;
  // Repair original DXBC cb1[1].xw: rate/exposure, not rate broadcast.
  r0.xy = float2(-0.5,1) + float2(g.rate_g, g.exposure_g);
  r0.x = max(0, r0.x);
  r0.x = min(0.5, r0.x);
  r0.x = r0.x + r0.x;
  r2.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r2.w = saturate(r2.w);
  r2.xyzw = r2.xyzw + -r1.xyzw;
  r1.xyzw = r0.xxxx * r2.xyzw + r1.xyzw;
  r0.x = g.brightness_g * r0.y;
  o0.xyz = r1.xyz * r0.xxx;
  o0.w = g.alpha_g * r1.w;
  // Original output above: o0.w = g.alpha_g * r1.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}