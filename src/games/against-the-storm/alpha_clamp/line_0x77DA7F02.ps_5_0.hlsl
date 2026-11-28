// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[3];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[126];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float3 v3 : INTERP2,
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = asuint(cb1[1].z * cb0[125].x);
  r0.y = asuint(cb1[1].x * v1.x);
  r0.x = asuint(mad(asfloat(r0.x), cb1[1].w, asfloat(r0.y)));
  r0.y = asuint(mad(v1.y, cb1[1].y, cb1[2].x));
  r0.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
  o0.xyzw = v2.xyzw * asfloat(r0.xyzw);
  o0.w = saturate(o0.w);
  return;
}