#include "../common.hlsl"
// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[141];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  uint4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(float2(-0.5,-0.5) + v1.xy);
  r0.zw = asuint(mad(asfloat(r0.xy), cb0[135].zz, float2(0.5,0.5)));
  r0.xy = asuint(mad(asfloat(r0.xy), cb0[135].zz, -(cb0[134].xy)));
  r0.xy = asuint(cb0[134].zw * asfloat(r0.xy));
  r1.x = asuint(dot(asfloat(r0.xy), asfloat(r0.xy)));
  r1.x = asuint(sqrt(asfloat(r1.x)));
  r1.y = (uint)-(int)(0.0 < cb0[135].w);
  if (r1.y != 0) {
    r1.zw = asuint(cb0[135].xy * asfloat(r1.xx));
  {
    float sinValue = sin(asfloat(r1.z));
    float cosValue = cos(asfloat(r1.z));
    r2.x = asuint(sinValue);
    r3.x = asuint(cosValue);
  }
    r1.z = asuint(asfloat(r2.x) / asfloat(r3.x));
    r1.w = asuint(1 / asfloat(r1.w));
    r1.z = asuint(mad(asfloat(r1.z), asfloat(r1.w), -1.0));
    r1.zw = asuint(mad(asfloat(r0.xy), asfloat(r1.zz), asfloat(r0.zw)));
  } else {
    r2.x = asuint(1 / asfloat(r1.x));
    r2.x = asuint(cb0[135].x * asfloat(r2.x));
    r1.x = asuint(cb0[135].y * asfloat(r1.x));
    r2.y = asuint(min(1, abs(asfloat(r1.x))));
    r2.z = asuint(max(1, abs(asfloat(r1.x))));
    r2.z = asuint(1 / asfloat(r2.z));
    r2.y = asuint(asfloat(r2.y) * asfloat(r2.z));
    r2.z = asuint(asfloat(r2.y) * asfloat(r2.y));
    r2.w = asuint(mad(asfloat(r2.z), 0.0208350997, -0.0851330012));
    r2.w = asuint(mad(asfloat(r2.z), asfloat(r2.w), 0.180141002));
    r2.w = asuint(mad(asfloat(r2.z), asfloat(r2.w), -0.330299497));
    r2.z = asuint(mad(asfloat(r2.z), asfloat(r2.w), 0.999866009));
    r2.w = asuint(asfloat(r2.y) * asfloat(r2.z));
    r3.x = (uint)-(int)(1.0 < abs(asfloat(r1.x)));
    r2.w = asuint(mad(asfloat(r2.w), -2.0, 1.57079637));
    r2.w = (uint)(r3.x & r2.w);
    r2.y = asuint(mad(asfloat(r2.y), asfloat(r2.z), asfloat(r2.w)));
    r1.x = asuint(min(1, asfloat(r1.x)));
    r1.x = (uint)-(int)(asfloat(r1.x) < -(asfloat(r1.x)));
    r1.x = (r1.x != 0) ? (r2.y ^ 0x80000000u) : r2.y;
    r1.x = asuint(mad(asfloat(r2.x), asfloat(r1.x), -1.0));
    r1.zw = asuint(mad(asfloat(r0.xy), asfloat(r1.xx), asfloat(r0.zw)));
  }
  r0.xyzw = asuint(mad(v1.xyxy, float4(2.0,2.0,2.0,2.0), float4(-1.0,-1.0,-1.0,-1.0)));
  r1.x = asuint(dot(asfloat(r0.zw), asfloat(r0.zw)));
  r0.xyzw = asuint(asfloat(r1.xxxx) * asfloat(r0.xyzw));
  r0.xyzw = asuint(cb0[136].xxxx * asfloat(r0.xyzw));
  r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.zw), cb0[19].x).xyzw);
  r0.xyzw = asuint(mad(asfloat(r0.xyzw), float4(-0.333333343,-0.333333343,-0.666666687,-0.666666687), v1.xyxy));
  r0.xyzw = asuint(float4(-0.5,-0.5,-0.5,-0.5) + asfloat(r0.xyzw));
  r3.xyzw = asuint(mad(asfloat(r0.xyzw), cb0[135].zzzz, float4(0.5,0.5,0.5,0.5)));
  r0.xyzw = asuint(mad(asfloat(r0.xyzw), cb0[135].zzzz, -(cb0[134].xyxy)));
  r0.xyzw = asuint(cb0[134].zwzw * asfloat(r0.xyzw));
  r1.x = asuint(dot(asfloat(r0.xy), asfloat(r0.xy)));
  r1.x = asuint(sqrt(asfloat(r1.x)));
  if (r1.y != 0) {
    r2.yz = asuint(cb0[135].xy * asfloat(r1.xx));
  {
    float sinValue = sin(asfloat(r2.y));
    float cosValue = cos(asfloat(r2.y));
    r4.x = asuint(sinValue);
    r5.x = asuint(cosValue);
  }
    r2.y = asuint(asfloat(r4.x) / asfloat(r5.x));
    r2.z = asuint(1 / asfloat(r2.z));
    r2.y = asuint(mad(asfloat(r2.y), asfloat(r2.z), -1.0));
    r2.yz = asuint(mad(asfloat(r0.xy), asfloat(r2.yy), asfloat(r3.xy)));
  } else {
    r2.w = asuint(1 / asfloat(r1.x));
    r2.w = asuint(cb0[135].x * asfloat(r2.w));
    r1.x = asuint(cb0[135].y * asfloat(r1.x));
    r4.x = asuint(min(1, abs(asfloat(r1.x))));
    r4.y = asuint(max(1, abs(asfloat(r1.x))));
    r4.y = asuint(1 / asfloat(r4.y));
    r4.x = asuint(asfloat(r4.x) * asfloat(r4.y));
    r4.y = asuint(asfloat(r4.x) * asfloat(r4.x));
    r4.z = asuint(mad(asfloat(r4.y), 0.0208350997, -0.0851330012));
    r4.z = asuint(mad(asfloat(r4.y), asfloat(r4.z), 0.180141002));
    r4.z = asuint(mad(asfloat(r4.y), asfloat(r4.z), -0.330299497));
    r4.y = asuint(mad(asfloat(r4.y), asfloat(r4.z), 0.999866009));
    r4.z = asuint(asfloat(r4.x) * asfloat(r4.y));
    r4.w = (uint)-(int)(1.0 < abs(asfloat(r1.x)));
    r4.z = asuint(mad(asfloat(r4.z), -2.0, 1.57079637));
    r4.z = (uint)(r4.w & r4.z);
    r4.x = asuint(mad(asfloat(r4.x), asfloat(r4.y), asfloat(r4.z)));
    r1.x = asuint(min(1, asfloat(r1.x)));
    r1.x = (uint)-(int)(asfloat(r1.x) < -(asfloat(r1.x)));
    r1.x = (r1.x != 0) ? (r4.x ^ 0x80000000u) : r4.x;
    r1.x = asuint(mad(asfloat(r2.w), asfloat(r1.x), -1.0));
    r2.yz = asuint(mad(asfloat(r0.xy), asfloat(r1.xx), asfloat(r3.xy)));
  }
  r4.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r2.yz), cb0[19].x).xyzw);
  r0.x = asuint(dot(asfloat(r0.zw), asfloat(r0.zw)));
  r0.x = asuint(sqrt(asfloat(r0.x)));
  if (r1.y != 0) {
    r1.xy = asuint(cb0[135].xy * asfloat(r0.xx));
  {
    float sinValue = sin(asfloat(r1.x));
    float cosValue = cos(asfloat(r1.x));
    r1.x = asuint(sinValue);
    r3.x = asuint(cosValue);
  }
    r0.y = asuint(asfloat(r1.x) / asfloat(r3.x));
    r1.x = asuint(1 / asfloat(r1.y));
    r0.y = asuint(mad(asfloat(r0.y), asfloat(r1.x), -1.0));
    r1.xy = asuint(mad(asfloat(r0.zw), asfloat(r0.yy), asfloat(r3.zw)));
  } else {
    r0.y = asuint(1 / asfloat(r0.x));
    r0.y = asuint(cb0[135].x * asfloat(r0.y));
    r0.x = asuint(cb0[135].y * asfloat(r0.x));
    r2.y = asuint(min(1, abs(asfloat(r0.x))));
    r2.z = asuint(max(1, abs(asfloat(r0.x))));
    r2.z = asuint(1 / asfloat(r2.z));
    r2.y = asuint(asfloat(r2.y) * asfloat(r2.z));
    r2.z = asuint(asfloat(r2.y) * asfloat(r2.y));
    r2.w = asuint(mad(asfloat(r2.z), 0.0208350997, -0.0851330012));
    r2.w = asuint(mad(asfloat(r2.z), asfloat(r2.w), 0.180141002));
    r2.w = asuint(mad(asfloat(r2.z), asfloat(r2.w), -0.330299497));
    r2.z = asuint(mad(asfloat(r2.z), asfloat(r2.w), 0.999866009));
    r2.w = asuint(asfloat(r2.y) * asfloat(r2.z));
    r3.x = (uint)-(int)(1.0 < abs(asfloat(r0.x)));
    r2.w = asuint(mad(asfloat(r2.w), -2.0, 1.57079637));
    r2.w = (uint)(r3.x & r2.w);
    r2.y = asuint(mad(asfloat(r2.y), asfloat(r2.z), asfloat(r2.w)));
    r0.x = asuint(min(1, asfloat(r0.x)));
    r0.x = (uint)-(int)(asfloat(r0.x) < -(asfloat(r0.x)));
    r0.x = (r0.x != 0) ? (r2.y ^ 0x80000000u) : r2.y;
    r0.x = asuint(mad(asfloat(r0.y), asfloat(r0.x), -1.0));
    r1.xy = asuint(mad(asfloat(r0.zw), asfloat(r0.xx), asfloat(r3.zw)));
  }
  r0.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r0.w = (uint)-(int)(0.0 < cb0[138].z);
  if (r0.w != 0) {
    r1.xy = asuint(-cb0[138].xy + asfloat(r1.zw));
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
    r0.x = r2.x;
    r0.y = r4.y;
    r0.xyz = asuint(asfloat(r0.xyz) * asfloat(r1.xyz));
  } else {
    r0.x = r2.x;
    r0.y = r4.y;
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
  r1.xy = asuint(mad(v1.xy, cb0[140].xy, cb0[140].zw));
  r1.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r0.w = asuint(-0.5 + asfloat(r1.w));
  r0.w = asuint(asfloat(r0.w) + asfloat(r0.w));
  r1.x = asuint(dot(asfloat(r0.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r1.x = asuint(sqrt(asfloat(r1.x)));
  r1.x = asuint(mad(cb0[139].y, -(asfloat(r1.x)), 1.0));
  r1.yzw = asuint(asfloat(r0.xyz) * asfloat(r0.www));
  r1.yzw = asuint(cb0[139].xxx * asfloat(r1.yzw));
  r0.xyz = asuint(mad(asfloat(r1.yzw), asfloat(r1.xxx), asfloat(r0.xyz)));
  r1.xyz = (uint3)-(int3)(float3(0.00313080009,0.00313080009,0.00313080009) >= asfloat(r0.xyz));
  r2.xyz = asuint(float3(12.9232101,12.9232101,12.9232101) * asfloat(r0.xyz));
  r0.xyz = asuint(log2(abs(asfloat(r0.xyz))));
  r0.xyz = asuint(float3(0.416666657,0.416666657,0.416666657) * asfloat(r0.xyz));
  r0.xyz = asuint(exp2(asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), float3(1.05499995,1.05499995,1.05499995), float3(-0.0549999997,-0.0549999997,-0.0549999997)));
  o0.xyz = asfloat((r1.xyz != 0) ? r2.xyz : r0.xyz);
  o0.xyz = FinalizeOutput(UberLdrOutput(untonemapped, renodx::color::srgb::DecodeSafe(o0.xyz)));
  o0.w = 1;
  return;
}