// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[2];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[20];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float3 v2 : INTERP1,
  float3 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  r0.w = (uint)-(int)(asfloat(r0.w) >= cb1[1].x);
  o0.xyz = asfloat(r0.xyz);
  o0.w = asfloat((uint)(r0.w & 0x3f800000u));
  o0.w = saturate(o0.w);
  return;
}