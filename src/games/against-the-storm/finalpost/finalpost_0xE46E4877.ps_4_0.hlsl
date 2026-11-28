#include "../common.hlsl"
// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[132];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  uint4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(cb0[128].xyxy * v1.xyxy);
  r0.xyzw = (uint4)((int4)(asfloat(r0.xyzw)));
  r1.xyzw = (uint4)(r0.zwzw + uint4(0xffffffffu,0xffffffffu,1u,0xffffffffu));
  r0.xyzw = (uint4)(r0.xyzw + uint4(0xffffffffu,1u,1u,1u));
  r0.xyzw = asuint((float4)(int4)r0.xyzw);
  r0.xyzw = asuint(max(float4(0,0,0,0), asfloat(r0.xyzw)));
  r1.xyzw = asuint((float4)(int4)r1.xyzw);
  r1.xyzw = asuint(max(float4(0,0,0,0), asfloat(r1.xyzw)));
  r2.xyzw = asuint(float4(-1,-1,-1,-1) + cb0[128].xyxy);
  r1.xyzw = asuint(min(asfloat(r2.xyzw), asfloat(r1.xyzw)));
  r0.xyzw = asuint(min(asfloat(r2.xyzw), asfloat(r0.xyzw)));
  r0.xyzw = (uint4)((int4)(asfloat(r0.zwxy)));
  r1.xyzw = (uint4)((int4)(asfloat(r1.zwxy)));
  r2.xy = r1.zw;
  r2.zw = uint2(0u,0u);
  r2.xyzw = asuint(t0.Load((int3)r2.xyz).xyzw);
  r2.xyz = r2.xyz;
  r2.x = asuint(dot(asfloat(r2.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r3.xy = r0.zw;
  r3.zw = uint2(0u,0u);
  r3.xyzw = asuint(t0.Load((int3)r3.xyz).xyzw);
  r3.xyz = r3.xyz;
  r2.y = asuint(dot(asfloat(r3.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r2.z = asuint(asfloat(r2.x) + asfloat(r2.y));
  r1.zw = uint2(0u,0u);
  r1.xyzw = asuint(t0.Load((int3)r1.xyz).xyzw);
  r1.xyz = r1.xyz;
  r1.x = asuint(dot(asfloat(r1.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r0.zw = uint2(0u,0u);
  r0.xyzw = asuint(t0.Load((int3)r0.xyz).xyzw);
  r0.xyz = r0.xyz;
  r0.x = asuint(dot(asfloat(r0.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r0.y = asuint(asfloat(r1.x) + asfloat(r0.x));
  r3.yw = asuint(asfloat(r2.zz) + -asfloat(r0.yy));
  r0.y = asuint(asfloat(r2.x) + asfloat(r1.x));
  r0.z = asuint(asfloat(r2.y) + asfloat(r0.x));
  r0.z = asuint(asfloat(r0.y) + -asfloat(r0.z));
  r0.y = asuint(asfloat(r0.y) + asfloat(r2.y));
  r0.y = asuint(asfloat(r0.y) + asfloat(r0.x));
  r0.y = asuint(0.03125 * asfloat(r0.y));
  r0.y = asuint(max(0.0078125, asfloat(r0.y)));
  r0.w = asuint(min(abs(asfloat(r0.z)), abs(asfloat(r3.w))));
  r3.xz = (r0.zz ^ 0x80000000u);
  r0.y = asuint(asfloat(r0.w) + asfloat(r0.y));
  r0.y = asuint(1 / asfloat(r0.y));
  r3.xyzw = asuint(asfloat(r3.xyzw) * asfloat(r0.yyyy));
  r3.xyzw = asuint(max(float4(-8,-8,-8,-8), asfloat(r3.xyzw)));
  r3.xyzw = asuint(min(float4(8,8,8,8), asfloat(r3.xyzw)));
  r3.xyzw = asuint(cb0[128].zwzw * asfloat(r3.xyzw));
  r4.xyzw = asuint(mad(asfloat(r3.zwzw), float4(-0.5,-0.5,-0.166666672,-0.166666672), v1.xyxy));
  r3.xyzw = asuint(mad(asfloat(r3.xyzw), float4(0.166666672,0.166666672,0.5,0.5), v1.xyxy));
  r5.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r4.xy), cb0[19].x).xyzw);
  r4.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r4.zw), cb0[19].x).xyzw);
  r4.xyz = r4.xyz;
  r5.xyz = r5.xyz;
  r6.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r3.zw), cb0[19].x).xyzw);
  r3.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r3.xy), cb0[19].x).xyzw);
  r3.xyz = r3.xyz;
  r0.yzw = asuint(asfloat(r4.xyz) + asfloat(r3.xyz));
  r6.xyz = r6.xyz;
  r1.yzw = asuint(asfloat(r6.xyz) + asfloat(r5.xyz));
  r1.yzw = asuint(float3(0.25,0.25,0.25) * asfloat(r1.yzw));
  r1.yzw = asuint(mad(asfloat(r0.yzw), float3(0.25,0.25,0.25), asfloat(r1.yzw)));
  r0.yzw = asuint(float3(0.5,0.5,0.5) * asfloat(r0.yzw));
  r2.z = asuint(dot(asfloat(r1.yzw), float3(0.212672904,0.715152204,0.0721750036)));
  r2.w = asuint(min(asfloat(r1.x), asfloat(r2.y)));
  r1.x = asuint(max(asfloat(r1.x), asfloat(r2.y)));
  r1.x = asuint(max(asfloat(r1.x), asfloat(r0.x)));
  r0.x = asuint(min(asfloat(r2.w), asfloat(r0.x)));
  r3.xyzw = asuint(t0.SampleBias(s1_s, v1.xy, cb0[19].x).xyzw);
  r3.xyz = r3.xyz;
  r2.y = asuint(dot(asfloat(r3.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r2.w = asuint(min(asfloat(r2.y), asfloat(r2.x)));
  r2.x = asuint(max(asfloat(r2.y), asfloat(r2.x)));
  r1.x = asuint(max(asfloat(r2.x), asfloat(r1.x)));
  r1.x = (uint)-(int)(asfloat(r1.x) < asfloat(r2.z));
  r0.x = asuint(min(asfloat(r2.w), asfloat(r0.x)));
  r0.x = (uint)-(int)(asfloat(r2.z) < asfloat(r0.x));
  r0.x = (uint)(r1.x | r0.x);
  r0.xyz = (r0.xxx != 0) ? r0.yzw : r1.yzw;
  r1.xyz = asuint(log2(asfloat(r0.xyz)));
  r1.xyz = asuint(float3(0.416666657,0.416666657,0.416666657) * asfloat(r1.xyz));
  r1.xyz = asuint(exp2(asfloat(r1.xyz)));
  r1.xyz = asuint(mad(asfloat(r1.xyz), float3(1.05499995,1.05499995,1.05499995), float3(-0.0549999997,-0.0549999997,-0.0549999997)));
  r2.xyz = (uint3)-(int3)(float3(0.00313080009,0.00313080009,0.00313080009) >= asfloat(r0.xyz));
  r0.xyz = asuint(float3(12.9232101,12.9232101,12.9232101) * asfloat(r0.xyz));
  r0.xyz = (r2.xyz != 0) ? r0.xyz : r1.xyz;
  r1.xy = asuint(mad(v1.xy, cb0[131].xy, cb0[131].zw));
  r1.xyzw = asuint(t1.SampleBias(s2_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r0.w = asuint(mad(asfloat(r1.w), 2.0, -1.0));
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