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
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)-(int2)(float2(0.0,0.0) != cb1[4].zy);
  r0.yzw = (r0.yyy != 0) ? uint3(0x3f800000u,0u,0u) : uint3(0xbf800000u,0xb3bbbd2eu,0xb3bbbd2eu);
  r0.yzw = asuint(mad(asfloat(r0.yzw), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r0.yzw = asuint(mad(asfloat(r0.yzw), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r1.xy = asuint(float2(-0.5,-0.5) + v1.xy);
  r2.x = asuint(dot(asfloat(r1.xy), asfloat(r0.yw)));
  r2.y = asuint(dot(asfloat(r1.yx), asfloat(r0.yz)));
  r0.yz = asuint(float2(0.5,0.5) + asfloat(r2.xy));
  r1.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r0.yz), cb0[19].x).xyzw);
  r0.y = asuint(v3.w * asfloat(r1.x));
  r1.xyzw = asuint(cb1[2].wwzz * cb0[15].xxxx);
  r1.xyzw = asuint(cb1[2].xyxy * asfloat(r1.xyzw));
  r1.xyzw = asuint(mad(v1.xyxy, cb1[1].zwxy, asfloat(r1.xyzw)));
  r2.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r1.xy), 0).xyzw);
  r1.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r1.zw), 0).xyzw);
  r1.xyz = asuint(asfloat(r2.xyz) + asfloat(r1.xyz));
  r0.z = asuint(cb1[4].x * asfloat(r1.x));
  r0.y = asuint(asfloat(r0.z) * asfloat(r0.y));
  r0.z = (uint)-(int)(asfloat(r0.y) < 0.0);
  o0.w = asfloat(r0.y);
  if (r0.z != 0) discard;
  r0.yzw = asuint(v2.zzz * asfloat(r1.xyz));
  r2.xy = asuint(v1.zw);
  r2.z = asuint(v2.x);
  r2.xyz = asuint(-v3.xyz + asfloat(r2.xyz));
  r0.yzw = asuint(mad(asfloat(r0.yzw), asfloat(r2.xyz), v3.xyz));
  r2.xyz = asuint(cb1[6].xyz + -cb1[5].xyz);
  r1.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r2.xyz), cb1[5].xyz));
  o0.xyz = asfloat((r0.xxx != 0) ? r1.xyz : r0.yzw);
  o0.w = saturate(o0.w);
  return;
}