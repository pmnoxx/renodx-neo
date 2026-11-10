// Original assets: adv/sys/compositor_tears15.dx11.pso; CRC32 0x07F13C43.
// ---- Created with 3Dmigoto v1.3.16 on Tue Nov 10 02:45:25 2026

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

  r0.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
  r0.w = saturate(r0.w);
  o0.xyzw = r0.xyzw * float4(-1,-1,-1,1) + float4(1,1,1,0);
  // Original output above: o0.xyzw = r0.xyzw * float4(-1,-1,-1,1) + float4(1,1,1,0);
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}