// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

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
  float3 v2 : INTERP1,
  float3 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(t2.SampleBias(s2_s, v1.xy, cb0[19].x).xyzw);
  r1.x = asuint(-0.5 + asfloat(r0.w));
  r1.x = (uint)-(int)(asfloat(r1.x) < 0.0);
  if (r1.x != 0) discard;
  r1.xy = asuint(float2(-0.5,-0.5) + v1.yx);
  r1.z = asuint(dot(asfloat(r1.xy), asfloat(r1.xy)));
  r1.z = asuint(sqrt(asfloat(r1.z)));
  r1.z = asuint(0.5 * asfloat(r1.z));
  {
    float sinValue = sin(asfloat(r1.z));
    float cosValue = cos(asfloat(r1.z));
    r2.x = asuint(sinValue);
    r3.x = asuint(cosValue);
  }
  r1.zw = asuint(asfloat(r2.xx) * asfloat(r1.xy));
  r1.y = asuint(mad(asfloat(r3.x), asfloat(r1.y), -(asfloat(r1.z))));
  r1.x = asuint(mad(asfloat(r3.x), asfloat(r1.x), asfloat(r1.w)));
  r2.xy = asuint(float2(0.5,0.5) + asfloat(r1.yx));
  r1.xy = asuint(cb1[2].zw * asfloat(r2.xy));
  r1.z = asuint(cb1[2].x * cb0[15].x);
  r1.zw = asuint(mad(asfloat(r1.zz), float2(1.0,0.0), asfloat(r1.xy)));
  r1.xy = asuint(mad(cb0[15].xx, float2(0.5,0.0), asfloat(r1.xy)));
  r2.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.zw), cb0[19].x).xyzw);
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r2.xyz));
  r1.xyz = asuint(log2(asfloat(r1.xyz)));
  r1.xyz = asuint(cb1[2].yyy * asfloat(r1.xyz));
  r1.xyz = asuint(exp2(asfloat(r1.xyz)));
  r1.xyz = asuint(cb1[3].xyz * asfloat(r1.xyz));
  r1.w = asuint(saturate(asfloat(r0.x) + asfloat(r0.x)));
  r2.x = asuint(mad(asfloat(r1.w), -2.0, 3.0));
  r1.w = asuint(asfloat(r1.w) * asfloat(r1.w));
  r1.w = asuint(asfloat(r2.x) * asfloat(r1.w));
  o0.xyz = mad(asfloat(r1.www), asfloat(r1.xyz), asfloat(r0.xyz));
  o0.w = asfloat(r0.w);
  o0.w = saturate(o0.w);
  return;
}