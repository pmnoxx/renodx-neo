// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[9];
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
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(cb1[0].xy * cb0[125].xx);
  r0.xz = asuint(cb1[7].yz * asfloat(r0.xx));
  r0.yw = asuint(cb1[8].xy * asfloat(r0.yy));
  r0.yw = asuint(mad(v1.xy, cb1[4].xy, asfloat(r0.yw)));
  r0.xz = asuint(mad(v1.xy, cb1[3].zw, asfloat(r0.xz)));
  r0.xyzw = asuint(float4(-0.5,-0.5,-0.5,-0.5) + asfloat(r0.xyzw));
  r1.x = asuint(dot(asfloat(r0.xz), float2(-5.96046448e-08,1)));
  r1.y = asuint(dot(asfloat(r0.xz), float2(-1,-5.96046448e-08)));
  r0.xz = asuint(float2(0.5,0.5) + asfloat(r1.xy));
  r1.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r0.xz), 0).xyzw);
  r2.x = asuint(dot(asfloat(r0.yw), float2(-5.96046448e-08,1)));
  r2.y = asuint(dot(asfloat(r0.yw), float2(-1,-5.96046448e-08)));
  r0.xy = asuint(float2(0.5,0.5) + asfloat(r2.xy));
  r0.xyzw = asuint(t1.SampleLevel(s1_s, asfloat(r0.xy), 0).xyzw);
  r0.xyz = asuint(asfloat(r1.xyz) + asfloat(r0.xyz));
  r1.xy = asuint(float2(1,1) + -v1.yx);
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.x));
  r1.x = asuint(v1.x * asfloat(r1.y));
  r1.x = asuint(cb1[7].x * asfloat(r1.x));
  r0.w = asuint(cb1[3].y * asfloat(r0.w));
  r0.w = asuint(asfloat(r0.w) / cb1[3].x);
  r0.w = asuint(asfloat(r0.w) / cb1[3].x);
  r0.w = asuint(asfloat(r0.w) * asfloat(r1.x));
  o0.w = dot(v2.ww, asfloat(r0.ww));
  r1.xyz = asuint(cb1[2].xyz + -cb1[1].xyz);
  o0.xyz = mad(asfloat(r0.xyz), asfloat(r1.xyz), cb1[1].xyz);
  o0.w = saturate(o0.w);
  return;
}