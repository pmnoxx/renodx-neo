// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
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
  float4 v2 : INTERP1,
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  float3 v6 : INTERP5,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = asuint(cb1[0].x * v2.w);
  r1.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  r0.y = asuint(1 + -asfloat(r1.w));
  o0.xyz = v3.xyz * asfloat(r1.xyz);
  r0.x = (uint)-(int)(asfloat(r0.x) >= asfloat(r0.y));
  r0.x = (uint)(r0.x & 0x3f800000u);
  o0.w = v3.w * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}