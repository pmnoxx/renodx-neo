// Original assets: adv/sys/compositor_tears10.dx11.pso; CRC32 0x588E6AAC.
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
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r0.z = dot(r0.xy, r0.xy);
  r0.z = sqrt(r0.z);
  r0.z = 2048 * r0.z;
  r0.z = sin(r0.z);
  r0.xy = r0.zz * float2(0.00625000149,0.0111111142) + r0.xy;
  r1.xyz = float3(0,0,0);
  r0.z = 0;
  while (true) {
    r0.w = cmp(r0.z >= 1.15468216);
    if (r0.w != 0) break;
    r2.xy = r0.zz * float2(0.000781250012,0.00138888892) + r0.xy;
    r3.xy = float2(0.5,0.5) + r2.xy;
    r3.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r3.xy).xyzw;
    r3.xyz = r3.xyz + r1.xyz;
    r2.zw = -r0.zz * float2(0.000781250012,0.00138888892) + r0.xy;
    r2.xyzw = float4(0.5,0.5,0.5,0.5) + r2.zwxw;
    r4.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.xy).xyzw;
    r3.xyz = r4.xyz + r3.xyz;
    r2.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.zw).xyzw;
    r1.xyz = r2.xyz * float3(2,2,2) + r3.xyz;
    r0.z = 1 + r0.z;
  }
  r0.xyz = float3(0.125,0.125,0.125) * r1.xyz;
  r0.w = 1 + g.exposure_g;
  r0.w = g.brightness_g * r0.w;
  o0.xyz = r0.xyz * r0.www;
  o0.w = g.alpha_g;
  // Original output above: o0.w = g.alpha_g;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}