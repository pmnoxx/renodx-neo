// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

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
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(mad(cb0[15].xxxx, float4(0.5,0.0,1.0,0.0), v1.xyxy));
  r1.xyz = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyz);
  r0.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.zw), cb0[19].x).xyzw);
  r0.xyz = asuint(asfloat(r1.xyz) + asfloat(r0.xyz));
  o0.w = v2.w * asfloat(r0.w);
  o0.xyz = v2.xyz * asfloat(r0.xyz);
  o0.w = saturate(o0.w);
  return;
}