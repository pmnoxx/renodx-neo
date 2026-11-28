// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
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
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(t0.SampleBias(s0_s, v2.xy, cb0[19].x).xyzw);
  r0.x = asuint(1 + -asfloat(r0.w));
  r0.x = asuint(log2(asfloat(r0.x)));
  r0.x = asuint(v2.z * asfloat(r0.x));
  r0.x = asuint(exp2(asfloat(r0.x)));
  r0.x = asuint(cb1[2].w * asfloat(r0.x));
  r1.xyzw = asuint(t1.SampleBias(s1_s, v2.xy, cb0[19].x).xyzw);
  o0.w = mad(asfloat(r0.x), cb1[3].y, asfloat(r1.w));
  r0.xyz = asuint(float3(1,1,1) + v4.xyz);
  o0.xyz = float3(0.5,0.5,0.5) * asfloat(r0.xyz);
  o0.w = saturate(o0.w);
  return;
}