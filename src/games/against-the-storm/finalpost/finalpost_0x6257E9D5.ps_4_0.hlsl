#include "../common.hlsl"
// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[137];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  uint4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.zw = uint2(0u,0u);
  r1.xy = asuint(cb0[128].xy * v1.xy);
  r1.xy = (uint2)((int2)(asfloat(r1.xy)));
  r2.xyzw = (uint4)(r1.xyxy + uint4(0u,0xffffffffu,0xffffffffu,0u));
  r0.xy = r2.zw;
  r0.xyz = asuint(t0.Load((int3)r0.xyz).xyz);
  r3.xyzw = (uint4)(r1.xyxy + uint4(0u,1u,1u,0u));
  r4.xy = r3.zw;
  r4.zw = uint2(0u,0u);
  r4.xyz = asuint(t0.Load((int3)r4.xyz).xyz);
  r5.xyz = asuint(max(asfloat(r4.xyz), asfloat(r0.xyz)));
  r2.zw = uint2(0u,0u);
  r2.xyz = asuint(t0.Load((int3)r2.xyz).xyz);
  r5.xyz = asuint(max(asfloat(r2.xyz), asfloat(r5.xyz)));
  r3.zw = uint2(0u,0u);
  r3.xyz = asuint(t0.Load((int3)r3.xyz).xyz);
  r5.xyz = asuint(max(asfloat(r5.xyz), asfloat(r3.xyz)));
  r1.zw = uint2(0u,0u);
  r1.xyz = asuint(t0.Load((int3)r1.xyz).xyz);
  r6.xyz = asuint(max(asfloat(r5.xyz), asfloat(r1.xyz)));
  r5.xyz = asuint(float3(4,4,4) * asfloat(r5.xyz));
  r5.xyz = asuint(rcp(asfloat(r5.xyz)));
  r6.xyz = asuint(float3(1,1,1) + -asfloat(r6.xyz));
  r7.xyz = asuint(min(asfloat(r4.xyz), asfloat(r0.xyz)));
  r7.xyz = asuint(min(asfloat(r7.xyz), asfloat(r2.xyz)));
  r7.xyz = asuint(min(asfloat(r7.xyz), asfloat(r3.xyz)));
  r8.xyz = asuint(mad(asfloat(r7.xyz), float3(4.0,4.0,4.0), float3(-4.0,-4.0,-4.0)));
  r7.xyz = asuint(min(asfloat(r7.xyz), asfloat(r1.xyz)));
  r5.xyz = asuint(asfloat(r7.xyz) * asfloat(r5.xyz));
  r7.xyz = asuint(rcp(asfloat(r8.xyz)));
  r6.xyz = asuint(asfloat(r7.xyz) * asfloat(r6.xyz));
  r5.xyz = asuint(max(asfloat(r6.xyz), -asfloat(r5.xyz)));
  r0.w = asuint(max(asfloat(r5.y), asfloat(r5.z)));
  r0.w = asuint(max(asfloat(r5.x), asfloat(r0.w)));
  r0.w = asuint(min(0, asfloat(r0.w)));
  r0.w = asuint(max(-0.1875, asfloat(r0.w)));
  r0.w = asuint(cb0[136].x * asfloat(r0.w));
  r0.xyz = asuint(asfloat(r0.www) * asfloat(r0.xyz));
  r0.xyz = asuint(mad(asfloat(r0.www), asfloat(r2.xyz), asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.www), asfloat(r3.xyz), asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.www), asfloat(r4.xyz), asfloat(r0.xyz)));
  r0.w = asuint(mad(asfloat(r0.w), 4.0, 1.0));
  r0.xyz = asuint(asfloat(r0.xyz) + asfloat(r1.xyz));
  r1.x = (uint)((uint)(-(int)r0.w) + 0x7ef19fffu);
  r0.w = asuint(mad(-(asfloat(r1.x)), asfloat(r0.w), 2.0));
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r0.xyz = asuint(asfloat(r0.xyz) * asfloat(r0.www));
  r1.xy = asuint(mad(v1.xy, cb0[130].xy, cb0[130].zw));
  r0.w = asuint(t1.SampleBias(s0_s, asfloat(r1.xy), cb0[19].x).w);
  r0.w = asuint(-0.5 + asfloat(r0.w));
  r0.w = asuint(asfloat(r0.w) + asfloat(r0.w));
  r1.xyz = asuint(asfloat(r0.xyz) * asfloat(r0.www));
  r1.xyz = asuint(cb0[129].xxx * asfloat(r1.xyz));
  r0.w = asuint(dot(asfloat(r0.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r0.w = asuint(sqrt(asfloat(r0.w)));
  r0.w = asuint(mad(cb0[129].y, -(asfloat(r0.w)), 1.0));
  r0.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r0.www), asfloat(r0.xyz)));
  r1.xyz = asuint(log2(abs(asfloat(r0.xyz))));
  r1.xyz = asuint(float3(0.416666657,0.416666657,0.416666657) * asfloat(r1.xyz));
  r1.xyz = asuint(exp2(asfloat(r1.xyz)));
  r1.xyz = asuint(mad(asfloat(r1.xyz), float3(1.05499995,1.05499995,1.05499995), float3(-0.0549999997,-0.0549999997,-0.0549999997)));
  r2.xyz = (uint3)-(int3)(float3(0.00313080009,0.00313080009,0.00313080009) >= asfloat(r0.xyz));
  r0.xyz = asuint(float3(12.9232101,12.9232101,12.9232101) * asfloat(r0.xyz));
  r0.xyz = (r2.xyz != 0) ? r0.xyz : r1.xyz;
  r1.xy = asuint(mad(v1.xy, cb0[131].xy, cb0[131].zw));
  r0.w = asuint(t2.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).w);
  r0.w = asuint(mad(asfloat(r0.w), 2.0, -1.0));
  r1.x = asuint(1 + -abs(asfloat(r0.w)));
  r0.w = (uint)-(int)(asfloat(r0.w) >= 0.0);
  r0.w = (r0.w != 0) ? 0x3f800000u : 0xbf800000u;
  r1.x = asuint(sqrt(asfloat(r1.x)));
  r1.x = asuint(1 + -asfloat(r1.x));
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r0.xyz = asuint(mad(asfloat(r0.www), float3(0.00392156886,0.00392156886,0.00392156886), asfloat(r0.xyz)));
  r1.xyz = asuint(float3(0.0549999997,0.0549999997,0.0549999997) + asfloat(r0.xyz));
  r1.xyz = asuint(float3(0.947867334,0.947867334,0.947867334) * asfloat(r1.xyz));
  r1.xyz = asuint(log2(abs(asfloat(r1.xyz))));
  r1.xyz = asuint(float3(2.4000001,2.4000001,2.4000001) * asfloat(r1.xyz));
  r1.xyz = asuint(exp2(asfloat(r1.xyz)));
  r2.xyz = asuint(float3(0.0773993805,0.0773993805,0.0773993805) * asfloat(r0.xyz));
  r0.xyz = (uint3)-(int3)(float3(0.0404499993,0.0404499993,0.0404499993) >= asfloat(r0.xyz));
  o0.xyz = asfloat((r0.xyz != 0) ? r2.xyz : r1.xyz);
  o0.xyz = FinalizeOutput(renodx::color::srgb::DecodeSafe(o0.xyz));
  o0.w = 1;
  return;
}