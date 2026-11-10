// Original assets: adv/sys/compositor_tears9.dx11.pso; CRC32 0xF05F86D4.
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
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 1 + -g.rate_g;
  r0.x = saturate(-r0.x * g.power_g + 1);
  r0.x = r0.x * 1.0625 + -0.03125;
  r0.x = -v1.y + r0.x;
  r0.x = max(-0.03125, r0.x);
  r0.x = min(0.03125, r0.x);
  r0.x = 0.03125 + r0.x;
  r0.x = -r0.x * 16 + 1;
  r1.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r1.w = saturate(r1.w);
  r1.xyzw = float4(-0,-0,-0,-1) + r1.xyzw;
  o0.xyzw = r0.xxxx * r1.xyzw + float4(0,0,0,1);
  // Original output above: o0.xyzw = r0.xxxx * r1.xyzw + float4(0,0,0,1);
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}