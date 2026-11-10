// Original assets: adv/sys/compositor_zoomin.dx11.pso; CRC32 0xF187CA72.
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
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r0.xy = r0.xy + r0.xy;
  r0.z = dot(r0.xy, r0.xy);
  r0.z = 1 + r0.z;
  r0.z = sqrt(r0.z);
  r0.xy = r0.xy * r0.zz;
  r0.z = 1 + -g.rate_g;
  r1.xyzw = float4(0,0,0,0);
  r0.w = 0;
  r2.x = 0;
  while (true) {
    r2.y = cmp((int)r2.x >= 64);
    if (r2.y != 0) break;
    r2.yz = r0.xy * r0.ww + v1.xy;
    r3.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r2.yz).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r3.w = saturate(r3.w);
    r1.xyzw = r3.xyzw * float4(0.015625,0.015625,0.015625,0.015625) + r1.xyzw;
    r0.w = r0.z * 0.00390625 + r0.w;
    r2.x = (int)r2.x + 1;
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