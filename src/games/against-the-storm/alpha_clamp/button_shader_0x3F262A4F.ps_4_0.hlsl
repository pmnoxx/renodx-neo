// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
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
  float3 v2 : INTERP1,
  float3 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(t2.SampleBias(s2_s, v1.xy, cb0[19].x).xyzw);
  r1.x = (uint)-(int)(asfloat(r0.w) < 0.0);
  if (r1.x != 0) discard;
  r1.xyzw = asuint(float4(-0.300000012,-0.150000006,-0.200000003,0) * cb0[125].xxxx);
  r1.xyzw = asuint(mad(v1.xyxy, cb1[5].xyxy, asfloat(r1.xyzw)));
  r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.zw), cb0[19].x).xyzw);
  r1.xyz = asuint(cb1[3].xyz * asfloat(r1.xyz));
  r2.xyz = asuint(cb1[3].xyz * asfloat(r2.xyz));
  r3.xyzw = asuint(t1.SampleBias(s1_s, v1.xy, cb0[19].x).xyzw);
  r1.xyz = asuint(asfloat(r3.xyz) * asfloat(r1.xyz));
  r1.xyz = asuint(mad(asfloat(r3.xyz), asfloat(r2.xyz), asfloat(r1.xyz)));
  r1.xyz = asuint(asfloat(r1.xyz) / cb1[5].zzz);
  r1.xyz = asuint(cb1[2].yyy * asfloat(r1.xyz));
  r1.w = asuint(1 + -v1.x);
  r1.w = asuint(0.899999976 * asfloat(r1.w));
  r1.w = asuint(log2(asfloat(r1.w)));
  r1.w = asuint(cb1[2].x * asfloat(r1.w));
  r1.w = asuint(exp2(asfloat(r1.w)));
  o0.xyz = mad(asfloat(r1.www), asfloat(r1.xyz), asfloat(r0.xyz));
  o0.w = asfloat(r0.w);
  o0.w = saturate(o0.w);
  return;
}