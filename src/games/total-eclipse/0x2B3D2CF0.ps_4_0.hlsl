// Original assets: adv/sys/compositor_shake_shift.dx11.pso; CRC32 0x2B3D2CF0.
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
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(g.rate_g < 1);
  r0.y = dot(g.time_g, float2(12.9898005,78.2330017));
  r0.y = sin(r0.y);
  r0.y = 43758.5469 * r0.y;
  r0.y = frac(r0.y);
  r1.x = g.time_g + r0.y;
  r1.y = g.time_g;
  r0.z = dot(r1.xy, float2(12.9898005,78.2330017));
  r0.z = sin(r0.z);
  r0.z = 43758.5469 * r0.z;
  r0.z = frac(r0.z);
  r0.y = -0.5 + r0.y;
  r1.x = r0.y * 0.0234375 + v1.x;
  r0.y = -0.5 + r0.z;
  r1.y = r0.y * 0.0416666679 + v1.y;
  r0.xy = r0.xx ? r1.xy : v1.xy;
  r0.zw = cmp(r0.xy < float2(0,0));
  r1.xy = cmp(float2(1,1) < r0.xy);
  r0.z = (int)r0.z | (int)r1.x;
  r0.z = (int)r0.w | (int)r0.z;
  r0.z = (int)r1.y | (int)r0.z;
  if (r0.z != 0) {
    r1.xyzw = float4(0,0,0,1);
  } else {
    r2.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r0.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r2.w = saturate(r2.w);
    r0.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r0.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r0.w = saturate(r0.w);
    r0.xyzw = r0.xyzw + -r2.xyzw;
    r1.xyzw = g.rate_g * r0.xyzw + r2.xyzw;
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