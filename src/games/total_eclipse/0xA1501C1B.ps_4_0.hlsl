// Original assets: adv/sys/compositor_shake_shift_and_stretchout.dx11.pso; CRC32 0xA1501C1B.
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
  r1.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r0.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r1.w = saturate(r1.w);
  r2.yw = frac(r0.yy);
  r3.xyzw = r1.xyzw;
  r0.y = 0;
  while (true) {
    r0.z = cmp(r0.y >= 512);
    if (r0.z != 0) break;
    r0.z = r0.y * 0.000781250012 + r0.x;
    r2.x = frac(r0.z);
    r4.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r4.w = saturate(r4.w);
    r4.xyzw = r4.xyzw + r3.xyzw;
    r0.z = -r0.y * 0.000781250012 + r0.x;
    r2.z = frac(r0.z);
    r5.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r5.w = saturate(r5.w);
    r3.xyzw = r5.xyzw + r4.xyzw;
    r0.y = 8 + r0.y;
  }
  r0.xyz = float3(0.00775193796,0.00775193796,0.00775193796) * r3.xyz;
  r0.w = g.alpha_g * r3.w;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = 0.00775193796 * r0.w;
  // Original output above: o0.w = 0.00775193796 * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}