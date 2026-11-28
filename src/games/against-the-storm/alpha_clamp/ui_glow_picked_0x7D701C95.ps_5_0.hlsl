// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
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
  uint4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(t2.SampleBias(s2_s, v1.xy, cb0[19].x).xyzw);
  r1.xyz = asuint(t1.SampleBias(s1_s, v1.xy, cb0[19].x).xyz);
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r0.xyz = asuint(cb1[3].xyz * asfloat(r0.xyz));
  r1.w = (uint)-(int)(asfloat(r0.w) < 0.0);
  o0.w = asfloat(r0.w);
  if (r1.w != 0) discard;
  r2.xy = asuint(float2(-0.5,-0.5) + v1.yx);
  r0.w = asuint(dot(asfloat(r2.xy), asfloat(r2.xy)));
  r0.w = asuint(sqrt(asfloat(r0.w)));
  r0.w = asuint(asfloat(r0.w) + asfloat(r0.w));
  {
    float sinValue = sin(asfloat(r0.w));
    float cosValue = cos(asfloat(r0.w));
    r3.x = asuint(sinValue);
    r4.x = asuint(cosValue);
  }
  r2.zw = asuint(asfloat(r3.xx) * asfloat(r2.xy));
  r0.w = asuint(mad(asfloat(r4.x), asfloat(r2.y), -(asfloat(r2.z))));
  r1.w = asuint(mad(asfloat(r4.x), asfloat(r2.x), asfloat(r2.w)));
  r2.y = asuint(0.5 + asfloat(r1.w));
  r2.x = asuint(0.5 + asfloat(r0.w));
  r2.zw = asuint(float2(0.200000003,0) * cb0[125].xx);
  r2.xy = asuint(mad(asfloat(r2.xy), float2(2.0,2.0), asfloat(r2.zw)));
  r0.w = asuint(t3.SampleBias(s3_s, asfloat(r2.xy), cb0[19].x).x);
  r2.xyz = asuint(cb1[3].xyz * asfloat(r0.www));
  r3.xyzw = asuint(mad(cb0[125].xxxx, float4(0.0500000007,0.0200000014,0.200000003,0.0), v1.xyxy));
  r4.xyz = asuint(t0.SampleBias(s0_s, asfloat(r3.xy), cb0[19].x).xyz);
  r3.xyz = asuint(t0.SampleBias(s0_s, asfloat(r3.zw), cb0[19].x).xyz);
  r3.xyz = asuint(cb1[3].xyz * asfloat(r3.xyz));
  r3.xyz = asuint(asfloat(r3.xyz) * asfloat(r1.xyz));
  r2.xyz = asuint(mad(asfloat(r4.xyz), cb1[3].xyz, asfloat(r2.xyz)));
  r1.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r2.xyz), asfloat(r3.xyz)));
  r1.xyz = asuint(v2.www * asfloat(r1.xyz));
  r0.w = asuint(0.899999976 * v1.x);
  r0.w = asuint(log2(asfloat(r0.w)));
  r0.w = asuint(cb1[2].x * asfloat(r0.w));
  r0.w = asuint(exp2(asfloat(r0.w)));
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r0.www));
  r1.xyz = asuint(float3(1.42857146,1.42857146,1.42857146) * asfloat(r1.xyz));
  o0.xyz = mad(asfloat(r0.xyz), asfloat(r0.www), asfloat(r1.xyz));
  o0.w = saturate(o0.w);
  return;
}