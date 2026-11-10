// Original assets: adv/sys/compositor_tears16.dx11.pso; CRC32 0x3874E438.
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
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 1500 * g.time_g;
  r0.xy = v1.xy * float2(40960,23040) + r0.xx;
  r0.xy = float2(0.00153398083,0.00153398083) * r0.xy;
  r0.xy = sin(r0.xy);
  r0.xy = g.rate_g * r0.xy;
  r0.xy = r0.xy * float2(0.00625000009,0.0111111114) + v1.xy;
  r0.xy = frac(r0.xy);
  r0.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r0.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r0.w = saturate(r0.w);
  r0.xyz = float3(1,1,1) + -r0.xyz;
  o0.w = r0.w;
  // Original output above: o0.w = r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  r0.w = 1 + g.exposure_g;
  r0.w = g.brightness_g * r0.w;
  o0.xyz = r0.xyz * r0.www;
  return;
}