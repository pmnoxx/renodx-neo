#include "../common.hlsl"
// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[143];
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

  r0.xyzw = asuint(mad(v1.xyxy, float4(2.0,2.0,2.0,2.0), float4(-1.0,-1.0,-1.0,-1.0)));
  r1.x = asuint(dot(asfloat(r0.zw), asfloat(r0.zw)));
  r0.xyzw = asuint(asfloat(r1.xxxx) * asfloat(r0.xyzw));
  r0.xyzw = asuint(cb0[136].xxxx * asfloat(r0.xyzw));
  r1.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  r0.xyzw = asuint(mad(asfloat(r0.xyzw), float4(-0.333333343,-0.333333343,-0.666666687,-0.666666687), v1.xyxy));
  r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
  r0.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.zw), cb0[19].x).xyzw);
  r1.yz = asuint(mad(v1.xy, cb0[141].zw, float2(0.5,0.5)));
  r2.xz = asuint(floor(asfloat(r1.yz)));
  r1.yz = asuint(frac(asfloat(r1.yz)));
  r3.xyzw = asuint(mad(-(asfloat(r1.yzyz)), float4(0.5,0.5,0.166666672,0.166666672), float4(0.5,0.5,0.5,0.5)));
  r3.xyzw = asuint(mad(asfloat(r1.yzyz), asfloat(r3.xyzw), float4(0.5,0.5,-0.5,-0.5)));
  r4.xy = asuint(mad(asfloat(r1.yz), float2(0.5,0.5), float2(-1.0,-1.0)));
  r4.zw = asuint(asfloat(r1.yz) * asfloat(r1.yz));
  r4.xy = asuint(mad(asfloat(r4.zw), asfloat(r4.xy), float2(0.666666687,0.666666687)));
  r3.xyzw = asuint(mad(asfloat(r1.yzyz), asfloat(r3.xyzw), float4(0.166666672,0.166666672,0.166666672,0.166666672)));
  r1.yz = asuint(float2(1,1) + -asfloat(r4.xy));
  r1.yz = asuint(asfloat(r1.yz) + -asfloat(r3.xy));
  r1.yz = asuint(asfloat(r1.yz) + -asfloat(r3.zw));
  r3.zw = asuint(asfloat(r3.zw) + asfloat(r4.xy));
  r3.xy = asuint(asfloat(r3.xy) + asfloat(r1.yz));
  r4.zw = asuint(float2(1,1) / asfloat(r3.zw));
  r4.zw = asuint(mad(asfloat(r4.xy), asfloat(r4.zw), float2(-1.0,-1.0)));
  r5.xy = asuint(float2(1,1) / asfloat(r3.xy));
  r4.xy = asuint(mad(asfloat(r1.yz), asfloat(r5.xy), float2(1.0,1.0)));
  r5.xyzw = asuint(asfloat(r4.zwxw) + asfloat(r2.xzxz));
  {
    precise float4 sum = asfloat(r5.xyzw) + float4(-0.5,-0.5,-0.5,-0.5);
    r5.xyzw = asuint(sum);
  }
  r5.xyzw = asuint(cb0[141].xyxy * asfloat(r5.xyzw));
  r5.xyzw = asuint(min(float4(1,1,1,1), asfloat(r5.xyzw)));
  r6.xyzw = asuint(t1.SampleLevel(s0_s, asfloat(r5.xy), 0).xyzw);
  r5.xyzw = asuint(t1.SampleLevel(s0_s, asfloat(r5.zw), 0).xyzw);
  r5.xyzw = asuint(asfloat(r5.xyzw) * asfloat(r3.xxxx));
  r5.xyzw = asuint(mad(asfloat(r3.zzzz), asfloat(r6.xyzw), asfloat(r5.xyzw)));
  r4.xyzw = asuint(asfloat(r4.zyxy) + asfloat(r2.xzxz));
  {
    precise float4 sum = asfloat(r4.xyzw) + float4(-0.5,-0.5,-0.5,-0.5);
    r4.xyzw = asuint(sum);
  }
  r4.xyzw = asuint(cb0[141].xyxy * asfloat(r4.xyzw));
  r4.xyzw = asuint(min(float4(1,1,1,1), asfloat(r4.xyzw)));
  r6.xyzw = asuint(t1.SampleLevel(s0_s, asfloat(r4.xy), 0).xyzw);
  r4.xyzw = asuint(t1.SampleLevel(s0_s, asfloat(r4.zw), 0).xyzw);
  r4.xyzw = asuint(asfloat(r4.xyzw) * asfloat(r3.xxxx));
  r4.xyzw = asuint(mad(asfloat(r3.zzzz), asfloat(r6.xyzw), asfloat(r4.xyzw)));
  r4.xyzw = asuint(asfloat(r4.xyzw) * asfloat(r3.yyyy));
  r3.xyzw = asuint(mad(asfloat(r3.wwww), asfloat(r5.xyzw), asfloat(r4.xyzw)));
  r0.w = (uint)-(int)(0.0 < cb0[131].x);
  if (r0.w != 0) {
    r1.yzw = asuint(asfloat(r3.xyz) * asfloat(r3.www));
    r3.xyz = asuint(float3(8,8,8) * asfloat(r1.yzw));
  }
  r1.yzw = asuint(cb0[130].xxx * asfloat(r3.xyz));
  r0.x = r1.x;
  r0.y = r2.y;
  r0.xyz = asuint(mad(asfloat(r1.yzw), cb0[130].yzw, asfloat(r0.xyz)));
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
    r3.xyzw = asuint(t3.SampleLevel(s0_s, asfloat(r2.xz), 0).xyzw);
    r4.x = asuint(cb0[129].y);
    r4.y = 0u;
    r2.xy = asuint(asfloat(r4.xy) + asfloat(r2.xz));
    r2.xyzw = asuint(t3.SampleLevel(s0_s, asfloat(r2.xy), 0).xyzw);
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
  r2.xyzw = asuint(t2.SampleLevel(s0_s, asfloat(r1.xz), 0).xyzw);
  r0.x = asuint(cb0[128].y);
  r0.y = 0u;
  r0.xy = asuint(asfloat(r1.xz) + asfloat(r0.xy));
  r1.xyzw = asuint(t2.SampleLevel(s0_s, asfloat(r0.xy), 0).xyzw);
  r0.x = asuint(mad(asfloat(r0.z), cb0[128].z, -(asfloat(r0.w))));
  r0.yzw = asuint(asfloat(r1.xyz) + -asfloat(r2.xyz));
  r0.xyz = asuint(mad(asfloat(r0.xxx), asfloat(r0.yzw), asfloat(r2.xyz)));
  r1.xy = asuint(mad(v1.xy, cb0[142].xy, cb0[142].zw));
  r1.xyzw = asuint(t4.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r0.w = asuint(mad(asfloat(r1.w), 2.0, -1.0));
  r1.x = (uint)-(int)(asfloat(r0.w) >= 0.0);
  r1.x = (r1.x != 0) ? 0x3f800000u : 0xbf800000u;
  r0.w = asuint(1 + -abs(asfloat(r0.w)));
  r0.xyzw = asuint(sqrt(asfloat(r0.xyzw)));
  r0.w = asuint(1 + -asfloat(r0.w));
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r1.xyz = (uint3)-(int3)(float3(0.00313080009,0.00313080009,0.00313080009) >= asfloat(r0.xyz));
  r2.xyz = asuint(float3(12.9232101,12.9232101,12.9232101) * asfloat(r0.xyz));
  r0.xyz = asuint(log2(asfloat(r0.xyz)));
  r0.xyz = asuint(float3(0.416666657,0.416666657,0.416666657) * asfloat(r0.xyz));
  r0.xyz = asuint(exp2(asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), float3(1.05499995,1.05499995,1.05499995), float3(-0.0549999997,-0.0549999997,-0.0549999997)));
  r0.xyz = (r1.xyz != 0) ? r2.xyz : r0.xyz;
  r0.xyz = asuint(mad(asfloat(r0.www), float3(0.00392156886,0.00392156886,0.00392156886), asfloat(r0.xyz)));
  r1.xyz = asuint(float3(0.0773993805,0.0773993805,0.0773993805) * asfloat(r0.xyz));
  r2.xyz = asuint(float3(0.0549999997,0.0549999997,0.0549999997) + asfloat(r0.xyz));
  r2.xyz = asuint(float3(0.947867334,0.947867334,0.947867334) * asfloat(r2.xyz));
  r2.xyz = asuint(log2(abs(asfloat(r2.xyz))));
  r2.xyz = asuint(float3(2.4000001,2.4000001,2.4000001) * asfloat(r2.xyz));
  r2.xyz = asuint(exp2(asfloat(r2.xyz)));
  r0.xyz = (uint3)-(int3)(float3(0.0404499993,0.0404499993,0.0404499993) >= asfloat(r0.xyz));
  r0.xyz = (r0.xyz != 0) ? r1.xyz : r2.xyz;
  o0.xyz = max(float3(0,0,0), asfloat(r0.xyz));
  o0.xyz = UberLdrOutput(untonemapped, o0.xyz);
  o0.w = 1;
  return;
}