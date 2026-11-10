// Original assets: adv/sys/compositor_battered.dx11.pso; CRC32 0xA5A2BF96.
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

SamplerState texture1_g_Sampler_s : register(s1);
Texture2D<float4> texture1_g_Texture : register(t1);


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

  r0.x = cmp(g.rate_g < 1);
  if (r0.x != 0) {
    r0.x = saturate(g.rate_g);
    r0.x = 1 + -r0.x;
    r0.x = 30 * r0.x;
    r0.x = trunc(r0.x);
    r0.yz = float2(1.67551625,6.70206499) * r0.xx;
    r0.x = r0.x * 0.0316666663 + 0.0500000007;
    r0.y = cos(r0.y);
    r1.xy = float2(1.078125,1.13888884) + -r0.xx;
    r2.y = r0.y * r1.x + r0.x;
    r0.y = sin(r0.z);
    r2.z = r0.y * r1.y + r0.x;
    r0.xy = float2(10,10) * r2.yz;
    r0.xy = trunc(r0.xy);
    r0.xy = float2(0.100000001,0.100000001) * r0.xy;
    r0.zw = float2(-0.5,-0.5) + v1.xy;
    r0.xy = r0.zw / r0.xy;
    r0.yz = float2(0.5,0.5) + r0.xy;
    r1.xy = cmp(r0.yz < float2(0,0));
    r0.w = 1 + -r0.y;
    r0.w = trunc(r0.w);
    r0.w = r0.y + r0.w;
    r1.zw = cmp(float2(1,1) < r0.yz);
    r2.x = trunc(r0.y);
    r2.x = -r2.x + r0.y;
    r0.y = r1.z ? r2.x : r0.y;
    r0.x = r1.x ? r0.w : r0.y;
    r0.y = (int)r1.y | (int)r1.w;
    r1.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r0.xz).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r1.w = saturate(r1.w);
    r0.xyzw = r0.yyyy ? float4(0,0,0,1) : r1.xyzw;
    r1.x = 1 + g.exposure_g;
    r1.x = g.brightness_g * r1.x;
    o0.xyz = r1.xxx * r0.xyz;
    o0.w = g.alpha_g * r0.w;
  // Original output above: o0.w = g.alpha_g * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  } else {
    r0.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, v1.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r0.w = saturate(r0.w);
    r1.x = 1 + g.exposure_g;
    r1.x = g.brightness_g * r1.x;
    o0.xyz = r1.xxx * r0.xyz;
    o0.w = g.alpha_g * r0.w;
  // Original output above: o0.w = g.alpha_g * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  }
  return;
}