#include "../common.hlsl"
// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

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
  uint4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.zw = uint2(0u,0u);
  r1.xy = asuint(cb0[128].xy * v1.xy);
  r1.xy = (uint2)((int2)(asfloat(r1.xy)));
  r2.xyzw = (uint4)(r1.xyxy + uint4(0u,0xffffffffu,0xffffffffu,0u));
  r0.xy = r2.zw;
  r0.xyz = asuint(t0.Load((int3)r0.xyz).xyz);
  r3.zw = uint2(0u,0u);
  r4.xyzw = (uint4)(r1.xyxy + uint4(0u,1u,1u,0u));
  r3.xy = r4.zw;
  r3.xyz = asuint(t0.Load((int3)r3.xyz).xyz);
  r5.xyz = asuint(max(asfloat(r3.xyz), asfloat(r0.xyz)));
  r2.zw = uint2(0u,0u);
  r2.xyz = asuint(t0.Load((int3)r2.xyz).xyz);
  r5.xyz = asuint(max(asfloat(r2.xyz), asfloat(r5.xyz)));
  r4.zw = uint2(0u,0u);
  r4.xyz = asuint(t0.Load((int3)r4.xyz).xyz);
  r5.xyz = asuint(max(asfloat(r5.xyz), asfloat(r4.xyz)));
  r1.zw = uint2(0u,0u);
  r6.xyz = asuint(t0.Load((int3)r1.xyz).xyz);
  r7.xyz = asuint(max(asfloat(r6.xyz), asfloat(r5.xyz)));
  r5.xyz = asuint(float3(4,4,4) * asfloat(r5.xyz));
  r5.xyz = asuint(rcp(asfloat(r5.xyz)));
  r7.xyz = asuint(float3(1,1,1) + -asfloat(r7.xyz));
  r8.xyz = asuint(min(asfloat(r3.xyz), asfloat(r0.xyz)));
  r8.xyz = asuint(min(asfloat(r8.xyz), asfloat(r2.xyz)));
  r8.xyz = asuint(min(asfloat(r8.xyz), asfloat(r4.xyz)));
  r9.xyz = asuint(mad(asfloat(r8.xyz), float3(4.0,4.0,4.0), float3(-4.0,-4.0,-4.0)));
  r8.xyz = asuint(min(asfloat(r8.xyz), asfloat(r6.xyz)));
  r5.xyz = asuint(asfloat(r8.xyz) * asfloat(r5.xyz));
  r8.xyz = asuint(rcp(asfloat(r9.xyz)));
  r7.xyz = asuint(asfloat(r8.xyz) * asfloat(r7.xyz));
  r5.xyz = asuint(max(asfloat(r7.xyz), -asfloat(r5.xyz)));
  r0.w = asuint(max(asfloat(r5.y), asfloat(r5.z)));
  r0.w = asuint(max(asfloat(r5.x), asfloat(r0.w)));
  r0.w = asuint(min(0, asfloat(r0.w)));
  r0.w = asuint(max(-0.1875, asfloat(r0.w)));
  r0.w = asuint(cb0[136].x * asfloat(r0.w));
  r0.xyz = asuint(asfloat(r0.www) * asfloat(r0.xyz));
  r0.xyz = asuint(mad(asfloat(r0.www), asfloat(r2.xyz), asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.www), asfloat(r4.xyz), asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.www), asfloat(r3.xyz), asfloat(r0.xyz)));
  r0.w = asuint(mad(asfloat(r0.w), 4.0, 1.0));
  r0.xyz = asuint(asfloat(r0.xyz) + asfloat(r6.xyz));
  r1.z = (uint)((uint)(-(int)r0.w) + 0x7ef19fffu);
  r0.w = asuint(mad(-(asfloat(r1.z)), asfloat(r0.w), 2.0));
  r0.w = asuint(asfloat(r1.z) * asfloat(r0.w));
  r0.xyz = asuint(asfloat(r0.xyz) * asfloat(r0.www));
  r0.x = asuint(dot(asfloat(r0.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r2.xyzw = (uint4)(r1.xyxy + uint4(0xffffffffu,0xffffffffu,1u,0xffffffffu));
  r1.xyzw = (uint4)(r1.xyxy + uint4(0xffffffffu,1u,1u,1u));
  r1.xyzw = asuint((float4)(int4)r1.xyzw);
  r1.xyzw = asuint(max(float4(0,0,0,0), asfloat(r1.xyzw)));
  r2.xyzw = asuint((float4)(int4)r2.xyzw);
  r2.xyzw = asuint(max(float4(0,0,0,0), asfloat(r2.xyzw)));
  r3.xyzw = asuint(float4(-1,-1,-1,-1) + cb0[128].xyxy);
  r2.xyzw = asuint(min(asfloat(r3.xyzw), asfloat(r2.xyzw)));
  r1.xyzw = asuint(min(asfloat(r3.xyzw), asfloat(r1.xyzw)));
  r1.xyzw = (uint4)((int4)(asfloat(r1.zwxy)));
  r2.xyzw = (uint4)((int4)(asfloat(r2.zwxy)));
  r3.xy = r2.zw;
  r3.zw = uint2(0u,0u);
  r0.yzw = asuint(t0.Load((int3)r3.xyz).xyz);
  r0.yzw = r0.yzw;
  r0.y = asuint(dot(asfloat(r0.yzw), float3(0.212672904,0.715152204,0.0721750036)));
  r0.z = asuint(min(asfloat(r0.x), asfloat(r0.y)));
  r0.x = asuint(max(asfloat(r0.x), asfloat(r0.y)));
  r2.zw = uint2(0u,0u);
  r2.xyz = asuint(t0.Load((int3)r2.xyz).xyz);
  r2.xyz = r2.xyz;
  r0.w = asuint(dot(asfloat(r2.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r2.xy = r1.zw;
  r2.zw = uint2(0u,0u);
  r2.xyz = asuint(t0.Load((int3)r2.xyz).xyz);
  r2.xyz = r2.xyz;
  r2.x = asuint(dot(asfloat(r2.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r2.y = asuint(min(asfloat(r2.x), asfloat(r0.w)));
  r1.zw = uint2(0u,0u);
  r1.xyz = asuint(t0.Load((int3)r1.xyz).xyz);
  r1.xyz = r1.xyz;
  r1.x = asuint(dot(asfloat(r1.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r1.y = asuint(min(asfloat(r2.y), asfloat(r1.x)));
  r0.z = asuint(min(asfloat(r1.y), asfloat(r0.z)));
  r1.y = asuint(asfloat(r2.x) + asfloat(r0.y));
  r0.y = asuint(asfloat(r0.y) + asfloat(r0.w));
  r1.z = asuint(asfloat(r1.x) + asfloat(r0.w));
  r0.w = asuint(max(asfloat(r2.x), asfloat(r0.w)));
  r0.w = asuint(max(asfloat(r0.w), asfloat(r1.x)));
  r0.x = asuint(max(asfloat(r0.x), asfloat(r0.w)));
  r3.yw = asuint(asfloat(r1.yy) + -asfloat(r1.zz));
  r0.w = asuint(asfloat(r2.x) + asfloat(r1.x));
  r1.y = asuint(asfloat(r0.y) + asfloat(r2.x));
  r0.y = asuint(asfloat(r0.y) + -asfloat(r0.w));
  r0.w = asuint(asfloat(r1.y) + asfloat(r1.x));
  r0.w = asuint(0.03125 * asfloat(r0.w));
  r0.w = asuint(max(0.0078125, asfloat(r0.w)));
  r1.x = asuint(min(abs(asfloat(r0.y)), abs(asfloat(r3.w))));
  r3.xz = (r0.yy ^ 0x80000000u);
  r0.y = asuint(asfloat(r1.x) + asfloat(r0.w));
  r0.y = asuint(rcp(asfloat(r0.y)));
  r1.xyzw = asuint(asfloat(r3.xyzw) * asfloat(r0.yyyy));
  r1.xyzw = asuint(max(float4(-8,-8,-8,-8), asfloat(r1.xyzw)));
  r1.xyzw = asuint(min(float4(8,8,8,8), asfloat(r1.xyzw)));
  r1.xyzw = asuint(cb0[128].zwzw * asfloat(r1.xyzw));
  r2.xyzw = asuint(mad(asfloat(r1.zwzw), float4(-0.5,-0.5,-0.166666672,-0.166666672), v1.xyxy));
  r1.xyzw = asuint(mad(asfloat(r1.xyzw), float4(0.166666672,0.166666672,0.5,0.5), v1.xyxy));
  r3.xyz = asuint(t0.SampleBias(s0_s, asfloat(r2.xy), cb0[19].x).xyz);
  r2.xyz = asuint(t0.SampleBias(s0_s, asfloat(r2.zw), cb0[19].x).xyz);
  r2.xyz = r2.xyz;
  r3.xyz = r3.xyz;
  r4.xyz = asuint(t0.SampleBias(s0_s, asfloat(r1.zw), cb0[19].x).xyz);
  r1.xyz = asuint(t0.SampleBias(s0_s, asfloat(r1.xy), cb0[19].x).xyz);
  r1.xyz = r1.xyz;
  r1.xyz = asuint(asfloat(r2.xyz) + asfloat(r1.xyz));
  r4.xyz = r4.xyz;
  r2.xyz = asuint(asfloat(r4.xyz) + asfloat(r3.xyz));
  r2.xyz = asuint(float3(0.25,0.25,0.25) * asfloat(r2.xyz));
  r2.xyz = asuint(mad(asfloat(r1.xyz), float3(0.25,0.25,0.25), asfloat(r2.xyz)));
  r1.xyz = asuint(float3(0.5,0.5,0.5) * asfloat(r1.xyz));
  r0.y = asuint(dot(asfloat(r2.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r0.xz = (uint2)-(int2)(asfloat(r0.xy) < asfloat(r0.yz));
  r0.x = (uint)(r0.x | r0.z);
  r0.xyz = (r0.xxx != 0) ? r1.xyz : r2.xyz;
  r1.xy = asuint(mad(v1.xy, cb0[130].xy, cb0[130].zw));
  r0.w = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).w);
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
  r1.xyz = asuint(log2(abs(asfloat(r0.xyz))));
  r1.xyz = asuint(float3(0.416666657,0.416666657,0.416666657) * asfloat(r1.xyz));
  r1.xyz = asuint(exp2(asfloat(r1.xyz)));
  r1.xyz = asuint(mad(asfloat(r1.xyz), float3(1.05499995,1.05499995,1.05499995), float3(-0.0549999997,-0.0549999997,-0.0549999997)));
  r2.xyz = (uint3)-(int3)(float3(0.00313080009,0.00313080009,0.00313080009) >= asfloat(r0.xyz));
  r0.xyz = asuint(float3(12.9232101,12.9232101,12.9232101) * asfloat(r0.xyz));
  r0.xyz = (r2.xyz != 0) ? r0.xyz : r1.xyz;
  r1.xy = asuint(mad(v1.xy, cb0[131].xy, cb0[131].zw));
  r0.w = asuint(t2.SampleBias(s2_s, asfloat(r1.xy), cb0[19].x).w);
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