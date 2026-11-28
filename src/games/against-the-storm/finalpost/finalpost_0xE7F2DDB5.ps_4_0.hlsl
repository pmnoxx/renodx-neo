#include "../common.hlsl"
// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[131];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(mad(v1.xy, cb0[130].xy, cb0[130].zw));
  r0.xyzw = asuint(t1.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
  r0.x = asuint(-0.5 + asfloat(r0.w));
  r0.x = asuint(asfloat(r0.x) + asfloat(r0.x));
  r1.xyzw = asuint(t0.SampleBias(s1_s, v1.xy, cb0[19].x).xyzw);
  r0.xyz = asuint(asfloat(r1.xyz) * asfloat(r0.xxx));
  r0.xyz = asuint(cb0[129].xxx * asfloat(r0.xyz));
  r0.w = asuint(dot(asfloat(r1.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r0.w = asuint(sqrt(asfloat(r0.w)));
  r0.w = asuint(mad(cb0[129].y, -(asfloat(r0.w)), 1.0));
  r0.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r0.www), asfloat(r1.xyz)));
  r1.xyz = asuint(log2(abs(asfloat(r0.xyz))));
  r1.xyz = asuint(float3(0.416666657,0.416666657,0.416666657) * asfloat(r1.xyz));
  r1.xyz = asuint(exp2(asfloat(r1.xyz)));
  r1.xyz = asuint(mad(asfloat(r1.xyz), float3(1.05499995,1.05499995,1.05499995), float3(-0.0549999997,-0.0549999997,-0.0549999997)));
  r2.xyz = (uint3)-(int3)(float3(0.00313080009,0.00313080009,0.00313080009) >= asfloat(r0.xyz));
  r0.xyz = asuint(float3(12.9232101,12.9232101,12.9232101) * asfloat(r0.xyz));
  o0.xyz = asfloat((r2.xyz != 0) ? r0.xyz : r1.xyz);
  o0.xyz = FinalizeOutput(renodx::color::srgb::DecodeSafe(o0.xyz));
  o0.w = 1;
  return;
}