// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
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
  float3 v3 : INTERP2,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = asuint(0.200000003 + cb1[3].x);
  r0.x = asuint(cb0[15].x * asfloat(r0.x));
  r0.xy = asuint(mad(asfloat(r0.xx), cb1[2].zw, v1.xy));
  r0.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r0.xy), cb0[19].x).xyzw);
  r0.w = asuint(cb1[3].x * cb0[15].x);
  r1.xy = asuint(mad(asfloat(r0.ww), cb1[2].xy, v1.xy));
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r0.xyz = asuint(asfloat(r1.xyz) + asfloat(r0.xyz));
  r1.xyz = asuint(cb1[5].xyz + -cb1[4].xyz);
  r0.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r1.xyz), cb1[4].xyz));
  r0.w = 0x3ecccccdu;
  o0.xyzw = v2.xyzw * asfloat(r0.xyzw);
  o0.w = saturate(o0.w);
  return;
}