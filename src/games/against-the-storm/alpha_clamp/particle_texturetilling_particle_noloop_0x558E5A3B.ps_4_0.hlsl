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
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  float3 v6 : INTERP5,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(float2(0.0700000003,0.00999999978) + v1.yy);
  {
    precise float sum = -(asfloat(r0.x)) + 1.05999994;
    r0.x = asuint(sum);
  }
  r0.xy = asuint(saturate(float2(2.22222209,0.53191489) * asfloat(r0.xy)));
  r0.z = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.z) * asfloat(r0.x));
  r0.z = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r0.y = asuint(asfloat(r0.z) * asfloat(r0.y));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.y));
  r0.x = asuint(log2(asfloat(r0.x)));
  r0.x = asuint(0.709999979 * asfloat(r0.x));
  r0.x = asuint(exp2(asfloat(r0.x)));
  r0.yz = asuint(v1.xy + v1.zw);
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.yz), cb0[19].x).xyzw);
  r0.x = asuint(saturate(dot(asfloat(r0.xx), asfloat(r1.xx))));
  o0.xyz = mad(asfloat(r1.xyz), float3(0.0,0.000647697598,-0.0292019993), float3(0.0,0.0298484284,0.0648033097));
  o0.w = v3.w * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}