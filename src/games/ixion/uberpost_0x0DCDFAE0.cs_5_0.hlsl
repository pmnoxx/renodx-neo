#include "./common.hlsl"

RWTexture2DArray<float4> u0 : register(u0);

Texture2D<float4> t4 : register(t4);

Texture3D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2DArray<float4> t1 : register(t1);

Texture2DArray<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[13];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[51];
}




// 3Dmigoto declarations
#define cmp -


[numthreads(8, 8, 1)]
void main(
  uint3 vThreadGroupID : SV_GroupID,
  uint3 vThreadIDInGroup : SV_GroupThreadID,
  uint3 vThreadID : SV_DispatchThreadID,
  uint vThreadIDInGroupFlattened : SV_GroupIndex)
{
  uint4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint((float3)(uint3)((int3)vThreadID.xyz));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r0.xy));
  r1.zw = asuint(cb0[47].zw * asfloat(r1.xy));
  r2.xy = asuint(mad(-(cb0[47].zw), float2(0.5,0.5), float2(1.0,1.0)));
  r2.xy = asuint(min(asfloat(r2.xy), asfloat(r1.zw)));
  r0.xy = asuint(cb0[50].xy * asfloat(r2.xy));
  r2.xyz = asuint(t0.SampleLevel(s0_s, asfloat(r0.xyz), 0).xyz);
  r0.w = (uint)-(int)(0.0 != cb1[7].z);
  if (r0.w != 0) {
    r3.xy = asuint(cb0[50].xy * asfloat(r1.zw));
    r3.xy = asuint(mad(asfloat(r3.xy), cb1[11].xy, float2(0.5,0.5)));
    r3.zw = asuint(floor(asfloat(r3.xy)));
    r3.xy = asuint(frac(asfloat(r3.xy)));
    r4.xyzw = asuint(mad(-(asfloat(r3.xyxy)), float4(0.5,0.5,0.166666672,0.166666672), float4(0.5,0.5,0.5,0.5)));
    r4.xyzw = asuint(mad(asfloat(r3.xyxy), asfloat(r4.xyzw), float4(0.5,0.5,-0.5,-0.5)));
    r5.xy = asuint(mad(asfloat(r3.xy), float2(0.5,0.5), float2(-1.0,-1.0)));
    r5.zw = asuint(asfloat(r3.xy) * asfloat(r3.xy));
    r5.xy = asuint(mad(asfloat(r5.zw), asfloat(r5.xy), float2(0.666666687,0.666666687)));
    r4.xyzw = asuint(mad(asfloat(r3.xyxy), asfloat(r4.xyzw), float4(0.166666672,0.166666672,0.166666672,0.166666672)));
    r3.xy = asuint(float2(1,1) + -asfloat(r5.xy));
    r3.xy = asuint(asfloat(r3.xy) + -asfloat(r4.xy));
    r3.xy = asuint(asfloat(r3.xy) + -asfloat(r4.zw));
    r4.zw = asuint(asfloat(r4.zw) + asfloat(r5.xy));
    r4.xy = asuint(asfloat(r4.xy) + asfloat(r3.xy));
    r5.zw = asuint(rcp(asfloat(r4.zw)));
    r5.zw = asuint(mad(asfloat(r5.xy), asfloat(r5.zw), float2(-1.0,-1.0)));
    r6.xy = asuint(rcp(asfloat(r4.xy)));
    r5.xy = asuint(mad(asfloat(r3.xy), asfloat(r6.xy), float2(1.0,1.0)));
    r6.xyzw = asuint(asfloat(r5.zwxw) + asfloat(r3.zwzw));
  {
    precise float4 sum = asfloat(r6.xyzw) + float4(-0.5,-0.5,-0.5,-0.5);
    r6.xyzw = asuint(sum);
  }
    r6.xyzw = asuint(cb1[11].zwzw * asfloat(r6.xyzw));
    r0.xy = asuint(min(cb0[50].xy, asfloat(r6.xy)));
    r7.xyz = asuint(t1.SampleLevel(s0_s, asfloat(r0.xyz), 0).xyz);
    r0.xy = asuint(min(cb0[50].xy, asfloat(r6.zw)));
    r6.xyz = asuint(t1.SampleLevel(s0_s, asfloat(r0.xyz), 0).xyz);
    r6.xyz = asuint(asfloat(r6.xyz) * asfloat(r4.xxx));
    r6.xyz = asuint(mad(asfloat(r4.zzz), asfloat(r7.xyz), asfloat(r6.xyz)));
    r3.xyzw = asuint(asfloat(r5.zyxy) + asfloat(r3.zwzw));
  {
    precise float4 sum = asfloat(r3.xyzw) + float4(-0.5,-0.5,-0.5,-0.5);
    r3.xyzw = asuint(sum);
  }
    r3.xyzw = asuint(cb1[11].zwzw * asfloat(r3.xyzw));
    r0.xy = asuint(min(cb0[50].xy, asfloat(r3.xy)));
    r5.xyz = asuint(t1.SampleLevel(s0_s, asfloat(r0.xyz), 0).xyz);
    r0.xy = asuint(min(cb0[50].xy, asfloat(r3.zw)));
    r0.xyz = asuint(t1.SampleLevel(s0_s, asfloat(r0.xyz), 0).xyz);
    r0.xyz = asuint(asfloat(r4.xxx) * asfloat(r0.xyz));
    r0.xyz = asuint(mad(asfloat(r4.zzz), asfloat(r5.xyz), asfloat(r0.xyz)));
    r0.xyz = asuint(asfloat(r4.yyy) * asfloat(r0.xyz));
    r0.xyz = asuint(mad(asfloat(r4.www), asfloat(r6.xyz), asfloat(r0.xyz)));
    r0.w = asuint(max(asfloat(r2.x), asfloat(r2.y)));
    r0.w = asuint(max(asfloat(r0.w), asfloat(r2.z)));
    r3.xy = asuint(-cb1[8].yx + asfloat(r0.ww));
    r2.w = asuint(max(0, asfloat(r3.x)));
    r2.w = asuint(min(cb1[8].z, asfloat(r2.w)));
    r2.w = asuint(asfloat(r2.w) * asfloat(r2.w));
    r2.w = asuint(cb1[8].w * asfloat(r2.w));
    r2.w = asuint(max(asfloat(r2.w), asfloat(r3.y)));
    r0.w = asuint(max(9.99999975e-05, asfloat(r0.w)));
    r0.w = asuint(asfloat(r2.w) / asfloat(r0.w));
    r3.xyz = asuint(mad(-(asfloat(r2.xyz)), asfloat(r0.www), asfloat(r2.xyz)));
    r3.xyz = asuint(mad(asfloat(r0.xyz), cb1[9].xyz, asfloat(r3.xyz)));
    r3.xyz = asuint(asfloat(r3.xyz) + -asfloat(r2.xyz));
    r2.xyz = asuint(mad(cb1[7].xxx * injectedData.fxBloom, asfloat(r3.xyz), asfloat(r2.xyz)));
    r0.w = (uint)-(int)(0.0 != cb1[7].w);
    if (r0.w != 0) {
      r3.xy = asuint(mad(asfloat(r1.zw), cb1[10].xy, cb1[10].zw));
      r3.xyz = asuint(t2.SampleLevel(s0_s, asfloat(r3.xy), 0).xyz);
      r0.xyz = asuint(asfloat(r3.xyz) * asfloat(r0.xyz));
      r2.xyz = asuint(mad(asfloat(r0.xyz), cb1[7].yyy, asfloat(r2.xyz)));
    }
  }
  r0.x = (uint)((uint)(cb1[1].z));
  if (r0.x == 0) {
    r0.xy = asuint(mad(asfloat(r1.xy), cb0[47].zw, -(cb1[1].xy)));
    r0.yz = asuint(cb1[2].xx * abs(asfloat(r0.yx)) * min(1, injectedData.fxVignette));
    r0.w = asuint(cb0[47].x / cb0[47].y);
    r0.w = asuint(-1 + asfloat(r0.w));
    r0.w = asuint(mad(cb1[2].w, asfloat(r0.w), 1.0));
    r0.x = asuint(asfloat(r0.z) * asfloat(r0.w));
    r0.xy = asuint(saturate(asfloat(r0.xy)));
    r0.xy = asuint(log2(asfloat(r0.xy)));
    r0.xy = asuint(cb1[2].zz * asfloat(r0.xy));
    r0.xy = asuint(exp2(asfloat(r0.xy)));
    r0.x = asuint(dot(asfloat(r0.xy), asfloat(r0.xy)));
    r0.x = asuint(1 + -asfloat(r0.x));
    r0.x = asuint(max(0, asfloat(r0.x)));
    r0.x = asuint(log2(asfloat(r0.x)));
    r0.x = asuint(cb1[2].y * asfloat(r0.x) * max(1, injectedData.fxVignette));
    r0.x = asuint(exp2(asfloat(r0.x)));
    r0.yzw = asuint(float3(1,1,1) + -cb1[3].xyz);
    r0.xyz = asuint(mad(asfloat(r0.xxx), asfloat(r0.yzw), cb1[3].xyz));
    r0.xyz = asuint(asfloat(r2.xyz) * asfloat(r0.xyz));
  } else {
    r0.w = asuint(t4.SampleLevel(s2_s, asfloat(r1.zw), 0).w);
    r1.x = asuint(mad(asfloat(r0.w), 0.305306017, 0.682171106));
    r1.x = asuint(mad(asfloat(r0.w), asfloat(r1.x), 0.0125228781));
    r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
    r1.xyz = asuint(float3(1,1,1) + -cb1[3].xyz);
    r1.xyz = asuint(mad(asfloat(r0.www), asfloat(r1.xyz), cb1[3].xyz));
    r1.xyz = asuint(mad(asfloat(r2.xyz), asfloat(r1.xyz), -(asfloat(r2.xyz))));
    r0.xyz = asuint(mad(cb1[3].www, asfloat(r1.xyz), asfloat(r2.xyz)));
  }
  float3 color = asfloat(r0.xyz);
  float3 lut_out;
  if (0.0 != cb1[12].x) {
    lut_out = lutShaper(color);
  } else {
    float3 lut_coord = lutShaper(cb1[6].z * color);
    if (injectedData.colorGradeLUTSampling == 0.f) {
      lut_coord = cb1[6].y * lut_coord;
      lut_coord = lut_coord * cb1[6].x + 0.5 * cb1[6].x;
      lut_out = t3.SampleLevel(s1_s, lut_coord, 0).xyz;
    } else {
      lut_out = renodx::lut::SampleTetrahedral(t3, lut_coord, 1 / cb1[6].x);
    }
  }
  r1.xyz = asuint(lut_out);
  u0[(uint3)((int3)vThreadID.xyz)] = asfloat(r1.xyzx);
  return;
}