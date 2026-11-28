#include "../common.hlsl"
// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[139];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  uint4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  r0.w = (uint)-(int)(0.0 < cb0[138].z);
  if (r0.w != 0) {
    r1.xy = asuint(-cb0[138].xy + v1.xy);
    r1.yz = asuint(cb0[138].zz * abs(asfloat(r1.xy)));
    r1.x = asuint(cb0[137].w * asfloat(r1.y));
    r0.w = asuint(dot(asfloat(r1.xz), asfloat(r1.xz)));
    r0.w = asuint(1 + -asfloat(r0.w));
    r0.w = asuint(max(0, asfloat(r0.w)));
    r0.w = asuint(log2(asfloat(r0.w)));
    r0.w = asuint(cb0[138].w * asfloat(r0.w));
    r0.w = asuint(exp2(asfloat(r0.w)));
    r1.xyz = asuint(float3(1,1,1) + -cb0[137].xyz);
    r1.xyz = asuint(mad(asfloat(r0.www), asfloat(r1.xyz), cb0[137].xyz));
    r0.xyz = asuint(asfloat(r1.xyz) * asfloat(r0.xyz));
  }
  float3 untonemapped = cb0[128].www * asfloat(r0.xyz);
  r0.xyz = asuint(saturate(cb0[128].www * asfloat(r0.xyz)));
  r0.w = (uint)-(int)(0.0 < cb0[129].w);
  if (r0.w != 0) {
    r1.xyz = (uint3)-(int3)(float3(0.00313080009,0.00313080009,0.00313080009) >= asfloat(r0.xyz));
    r2.xyz = asuint(float3(12.9232101,12.9232101,12.9232101) * asfloat(r0.xyz));
    r3.xyz = asuint(log2(asfloat(r0.xyz)));
    r3.xyz = asuint(float3(0.416666657,0.416666657,0.416666657) * asfloat(r3.xyz));
    r3.xyz = asuint(exp2(asfloat(r3.xyz)));
    r3.xyz = asuint(mad(asfloat(r3.xyz), float3(1.05499995,1.05499995,1.05499995), float3(-0.0549999997,-0.0549999997,-0.0549999997)));
    r1.xyz = (r1.xyz != 0) ? r2.xyz : r3.xyz;
    r2.xyz = asuint(cb0[129].zzz * asfloat(r1.zxy));
    r0.w = asuint(floor(asfloat(r2.x)));
    r2.xw = asuint(float2(0.5,0.5) * cb0[129].xy);
    r2.yz = asuint(mad(asfloat(r2.yz), cb0[129].xy, asfloat(r2.xw)));
    r2.x = asuint(mad(asfloat(r0.w), cb0[129].y, asfloat(r2.y)));
    r3.xyzw = asuint(t2.SampleLevel(s0_s, asfloat(r2.xz), 0).xyzw);
    r4.x = asuint(cb0[129].y);
    r4.y = 0u;
    r2.xy = asuint(asfloat(r4.xy) + asfloat(r2.xz));
    r2.xyzw = asuint(t2.SampleLevel(s0_s, asfloat(r2.xy), 0).xyzw);
    r0.w = asuint(mad(asfloat(r1.z), cb0[129].z, -(asfloat(r0.w))));
    r2.xyz = asuint(asfloat(r2.xyz) + -asfloat(r3.xyz));
    r2.xyz = asuint(mad(asfloat(r0.www), asfloat(r2.xyz), asfloat(r3.xyz)));
    r2.xyz = asuint(asfloat(r2.xyz) + -asfloat(r1.xyz));
    r1.xyz = asuint(mad(cb0[129].www, asfloat(r2.xyz), asfloat(r1.xyz)));
    r2.xyz = asuint(float3(0.0773993805,0.0773993805,0.0773993805) * asfloat(r1.xyz));
    r3.xyz = asuint(float3(0.0549999997,0.0549999997,0.0549999997) + asfloat(r1.xyz));
    r3.xyz = asuint(float3(0.947867334,0.947867334,0.947867334) * asfloat(r3.xyz));
    r3.xyz = asuint(log2(abs(asfloat(r3.xyz))));
    r3.xyz = asuint(float3(2.4000001,2.4000001,2.4000001) * asfloat(r3.xyz));
    r3.xyz = asuint(exp2(asfloat(r3.xyz)));
    r1.xyz = (uint3)-(int3)(float3(0.0404499993,0.0404499993,0.0404499993) >= asfloat(r1.xyz));
    r0.xyz = (r1.xyz != 0) ? r2.xyz : r3.xyz;
  }
  r0.xyw = asuint(cb0[128].zzz * asfloat(r0.xyz));
  r0.w = asuint(floor(asfloat(r0.w)));
  r1.xy = asuint(float2(0.5,0.5) * cb0[128].xy);
  r1.yz = asuint(mad(asfloat(r0.xy), cb0[128].xy, asfloat(r1.xy)));
  r1.x = asuint(mad(asfloat(r0.w), cb0[128].y, asfloat(r1.y)));
  r2.xyzw = asuint(t1.SampleLevel(s0_s, asfloat(r1.xz), 0).xyzw);
  r0.x = asuint(cb0[128].y);
  r0.y = 0u;
  r0.xy = asuint(asfloat(r1.xz) + asfloat(r0.xy));
  r1.xyzw = asuint(t1.SampleLevel(s0_s, asfloat(r0.xy), 0).xyzw);
  r0.x = asuint(mad(asfloat(r0.z), cb0[128].z, -(asfloat(r0.w))));
  r0.yzw = asuint(asfloat(r1.xyz) + -asfloat(r2.xyz));
  o0.xyz = mad(asfloat(r0.xxx), asfloat(r0.yzw), asfloat(r2.xyz));
  o0.xyz = UberLdrOutput(untonemapped, o0.xyz);
  o0.w = 1;
  return;
}