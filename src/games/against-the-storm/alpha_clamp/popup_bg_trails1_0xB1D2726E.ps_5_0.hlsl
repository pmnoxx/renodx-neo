// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[7];
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
  uint4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(cb1[2].xxyy * cb0[125].xxxx);
  r0.xyzw = asuint(float4(-1,-0.200000003,-1,0.200000003) * asfloat(r0.xyzw));
  r0.xy = asuint(mad(v1.xy, cb1[5].zw, asfloat(r0.xy)));
  r0.zw = asuint(mad(v1.xy, cb1[6].xy, asfloat(r0.zw)));
  r1.xyz = asuint(t1.SampleLevel(s1_s, asfloat(r0.zw), 0).xyz);
  r0.xyz = asuint(t0.SampleLevel(s0_s, asfloat(r0.xy), 0).xyz);
  r0.xyz = asuint(asfloat(r0.xyz) * asfloat(r1.xyz));
  r0.w = asuint(1 + -v1.y);
  r0.w = asuint(v1.y * asfloat(r0.w));
  r0.w = asuint(asfloat(r0.x) * asfloat(r0.w));
  r0.w = asuint(v2.w * asfloat(r0.w));
  r0.w = asuint(dot(cb1[5].yy, asfloat(r0.ww)));
  o0.w = asfloat(r0.w) / cb1[5].x;
  r1.xyz = asuint(cb1[4].xyz + -cb1[3].xyz);
  o0.xyz = mad(asfloat(r0.xyz), asfloat(r1.xyz), cb1[3].xyz);
  o0.w = saturate(o0.w);
  return;
}