#include "./common.hlsl"
Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[144];
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

  r0.yz = asuint(-cb0[128].yz + v1.xy);
  r1.x = asuint(cb0[128].x * asfloat(r0.y));
  r0.x = asuint(frac(asfloat(r1.x)));
  r1.x = asuint(asfloat(r0.x) / cb0[128].x);
  r0.w = asuint(-asfloat(r1.x) + asfloat(r0.y));
  r0.xyz = asuint(mad(asfloat(r0.xzw), cb0[128].www, float3(-0.386036009,-0.386036009,-0.386036009)));
  r0.xyz = asuint(float3(13.6054821,13.6054821,13.6054821) * asfloat(r0.xyz));
  r0.xyz = asuint(exp2(asfloat(r0.xyz)));
  r0.xyz = asuint(float3(-0.0479959995,-0.0479959995,-0.0479959995) + asfloat(r0.xyz));
  r0.xyz = asuint(float3(0.179999992,0.179999992,0.179999992) * asfloat(r0.xyz));
  r1.x = asuint(dot(float3(0.390404999,0.549941003,0.00892631989), asfloat(r0.xyz)));
  r1.y = asuint(dot(float3(0.070841603,0.963172019,0.00135775004), asfloat(r0.xyz)));
  r1.z = asuint(dot(float3(0.0231081992,0.128021002,0.936245024), asfloat(r0.xyz)));
  r0.xyz = asuint(cb0[129].xyz * asfloat(r1.xyz));
  r1.x = asuint(dot(float3(2.85846996,-1.62879002,-0.0248910002), asfloat(r0.xyz)));
  r1.y = asuint(dot(float3(-0.210181996,1.15820003,0.000324280991), asfloat(r0.xyz)));
  r1.z = asuint(dot(float3(-0.0418119989,-0.118169002,1.06867003), asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r1.xyz), float3(5.55555582,5.55555582,5.55555582), float3(0.0479959995,0.0479959995,0.0479959995)));
  r0.xyz = asuint(max(float3(0,0,0), asfloat(r0.xyz)));
  r0.xyz = asuint(log2(asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), float3(0.0734997839,0.0734997839,0.0734997839), float3(-0.0275523961,-0.0275523961,-0.0275523961)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), cb0[134].zzz, float3(0.0275523961,0.0275523961,0.0275523961)));
  r0.xyz = asuint(float3(13.6054821,13.6054821,13.6054821) * asfloat(r0.xyz));
  r0.xyz = asuint(exp2(asfloat(r0.xyz)));
  r0.xyz = asuint(float3(-0.0479959995,-0.0479959995,-0.0479959995) + asfloat(r0.xyz));
  r0.xyz = asuint(cb0[130].xyz * asfloat(r0.xyz));
  r0.xyz = asuint(float3(0.179999992,0.179999992,0.179999992) * asfloat(r0.xyz));
  r0.xyz = asuint(max(float3(0,0,0), asfloat(r0.xyz)));
  r0.xyz = asuint(log2(asfloat(r0.xyz)));
  r0.xyz = asuint(float3(0.454545468,0.454545468,0.454545468) * asfloat(r0.xyz));
  r0.xyz = asuint(exp2(asfloat(r0.xyz)));
  r1.xyz = asuint(asfloat(r0.xyz) + asfloat(r0.xyz));
  r2.xyz = asuint(asfloat(r0.xyz) * asfloat(r0.xyz));
  r3.xyz = asuint(min(float3(1,1,1), asfloat(r0.xyz)));
  r0.xyz = asuint(sqrt(asfloat(r0.xyz)));
  r0.w = asuint(dot(asfloat(r3.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r0.w = asuint(saturate(cb0[142].w + asfloat(r0.w)));
  r1.w = asuint(1 + -asfloat(r0.w));
  r3.xyz = asuint(float3(-0.5,-0.5,-0.5) + cb0[142].xyz);
  r3.xyz = asuint(mad(asfloat(r1.www), asfloat(r3.xyz), float3(0.5,0.5,0.5)));
  r4.xyz = asuint(mad(-(asfloat(r3.xyz)), float3(2.0,2.0,2.0), float3(1.0,1.0,1.0)));
  r2.xyz = asuint(asfloat(r4.xyz) * asfloat(r2.xyz));
  r2.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r3.xyz), asfloat(r2.xyz)));
  r4.xyz = (uint3)-(int3)(asfloat(r3.xyz) >= float3(0.5,0.5,0.5));
  r5.xyz = (r4.xyz != 0) ? uint3(0u,0u,0u) : uint3(0x3f800000u,0x3f800000u,0x3f800000u);
  r4.xyz = (uint3)(r4.xyz & uint3(0x3f800000u,0x3f800000u,0x3f800000u));
  r2.xyz = asuint(asfloat(r5.xyz) * asfloat(r2.xyz));
  r5.xyz = asuint(float3(1,1,1) + -asfloat(r3.xyz));
  r3.xyz = asuint(mad(asfloat(r3.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r1.xyz = asuint(asfloat(r5.xyz) * asfloat(r1.xyz));
  r0.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r3.xyz), asfloat(r1.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r4.xyz), asfloat(r2.xyz)));
  r1.xyz = asuint(asfloat(r0.xyz) + asfloat(r0.xyz));
  r2.xyz = asuint(asfloat(r0.xyz) * asfloat(r0.xyz));
  r0.xyz = asuint(sqrt(asfloat(r0.xyz)));
  r3.xyz = asuint(float3(-0.5,-0.5,-0.5) + cb0[143].xyz);
  r3.xyz = asuint(mad(asfloat(r0.www), asfloat(r3.xyz), float3(0.5,0.5,0.5)));
  r4.xyz = asuint(mad(-(asfloat(r3.xyz)), float3(2.0,2.0,2.0), float3(1.0,1.0,1.0)));
  r2.xyz = asuint(asfloat(r4.xyz) * asfloat(r2.xyz));
  r2.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r3.xyz), asfloat(r2.xyz)));
  r4.xyz = (uint3)-(int3)(asfloat(r3.xyz) >= float3(0.5,0.5,0.5));
  r5.xyz = (r4.xyz != 0) ? uint3(0u,0u,0u) : uint3(0x3f800000u,0x3f800000u,0x3f800000u);
  r4.xyz = (uint3)(r4.xyz & uint3(0x3f800000u,0x3f800000u,0x3f800000u));
  r2.xyz = asuint(asfloat(r5.xyz) * asfloat(r2.xyz));
  r5.xyz = asuint(float3(1,1,1) + -asfloat(r3.xyz));
  r3.xyz = asuint(mad(asfloat(r3.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r1.xyz = asuint(asfloat(r5.xyz) * asfloat(r1.xyz));
  r0.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r3.xyz), asfloat(r1.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r4.xyz), asfloat(r2.xyz)));
  r0.xyz = asuint(log2(abs(asfloat(r0.xyz))));
  r0.xyz = asuint(float3(2.20000005,2.20000005,2.20000005) * asfloat(r0.xyz));
  r0.xyz = asuint(exp2(asfloat(r0.xyz)));
  r1.x = asuint(dot(asfloat(r0.xyz), cb0[131].xyz));
  r1.y = asuint(dot(asfloat(r0.xyz), cb0[132].xyz));
  r1.z = asuint(dot(asfloat(r0.xyz), cb0[133].xyz));
  r0.xyz = asuint(cb0[139].xyz * asfloat(r1.xyz));
  r0.w = asuint(dot(asfloat(r1.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r2.xy = asuint(-cb0[141].xz + asfloat(r0.ww));
  r2.zw = asuint(cb0[141].yw + -cb0[141].xz);
  r2.zw = asuint(float2(1,1) / asfloat(r2.zw));
  r2.xy = asuint(saturate(asfloat(r2.xy) * asfloat(r2.zw)));
  r2.zw = asuint(mad(asfloat(r2.xy), float2(-2.0,-2.0), float2(3.0,3.0)));
  r2.xy = asuint(asfloat(r2.xy) * asfloat(r2.xy));
  r0.w = asuint(mad(-(asfloat(r2.z)), asfloat(r2.x), 1.0));
  r1.w = asuint(1 + -asfloat(r0.w));
  r1.w = asuint(mad(-(asfloat(r2.w)), asfloat(r2.y), asfloat(r1.w)));
  r2.x = asuint(asfloat(r2.w) * asfloat(r2.y));
  r0.xyz = asuint(asfloat(r1.www) * asfloat(r0.xyz));
  r2.yzw = asuint(cb0[138].xyz * asfloat(r1.xyz));
  r1.xyz = asuint(cb0[140].xyz * asfloat(r1.xyz));
  r0.xyz = asuint(mad(asfloat(r2.yzw), asfloat(r0.www), asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r2.xxx), asfloat(r0.xyz)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), cb0[137].xyz, cb0[135].xyz));
  r1.xyz = (uint3)-(int3)(float3(0.0,0.0,0.0) < asfloat(r0.xyz));
  r2.xyz = (uint3)-(int3)(asfloat(r0.xyz) < float3(0.0,0.0,0.0));
  r0.xyz = asuint(log2(abs(asfloat(r0.xyz))));
  r0.xyz = asuint(cb0[136].xyz * asfloat(r0.xyz));
  r0.xyz = asuint(exp2(asfloat(r0.xyz)));
  r1.xyz = (uint3)((uint3)(-(int3)r1.xyz) + r2.xyz);
  r1.xyz = asuint((float3)(int3)r1.xyz);
  r2.xyz = asuint(asfloat(r1.xyz) * asfloat(r0.xyz));
  r3.xy = r2.zy;
  r0.xy = asuint(mad(asfloat(r1.yz), asfloat(r0.yz), -(asfloat(r3.xy))));
  r1.x = (uint)-(int)(asfloat(r3.y) >= asfloat(r2.z));
  r1.x = (uint)(r1.x & 0x3f800000u);
  r3.zw = uint2(0xbf800000u,0x3f2aaaabu);
  r0.zw = uint2(0x3f800000u,0xbf800000u);
  r0.xyzw = asuint(mad(asfloat(r1.xxxx), asfloat(r0.xywz), asfloat(r3.xywz)));
  r1.x = (uint)-(int)(asfloat(r2.x) >= asfloat(r0.x));
  r1.x = (uint)(r1.x & 0x3f800000u);
  r3.z = r0.w;
  r0.w = r2.x;
  r2.x = asuint(dot(asfloat(r2.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r3.xyw = r0.wyx;
  r3.xyzw = asuint(asfloat(r3.xyzw) + -asfloat(r0.xyzw));
  r0.xyzw = asuint(mad(asfloat(r1.xxxx), asfloat(r3.xyzw), asfloat(r0.xyzw)));
  r1.x = asuint(min(asfloat(r0.w), asfloat(r0.y)));
  r1.x = asuint(-asfloat(r1.x) + asfloat(r0.x));
  r1.y = asuint(mad(asfloat(r1.x), 6.0, 9.99999975e-05));
  r0.y = asuint(asfloat(r0.w) + -asfloat(r0.y));
  r0.y = asuint(asfloat(r0.y) / asfloat(r1.y));
  r0.y = asuint(asfloat(r0.z) + asfloat(r0.y));
  r3.x = (r0.y & 0x7fffffffu);
  r2.z = asuint(cb0[134].x + asfloat(r3.x));
  r2.yw = uint2(0u,0u);
  r4.xyzw = asuint(t4.SampleBias(s0_s, asfloat(r2.zw), cb0[19].x).xyzw);
  r5.xyzw = asuint(t7.SampleBias(s0_s, asfloat(r2.xy), cb0[19].x).xyzw);
  r5.x = asuint(saturate(asfloat(r5.x)));
  r4.x = asuint(saturate(asfloat(r4.x)));
  r0.y = asuint(asfloat(r4.x) + asfloat(r2.z));
  {
    precise float3 sum = asfloat(r0.yyy) + float3(-0.5,0.5,-1.5);
    r0.yzw = asuint(sum);
  }
  r1.y = (uint)-(int)(1.0 < asfloat(r0.y));
  r0.w = (r1.y != 0) ? r0.w : r0.y;
  r0.y = (uint)-(int)(asfloat(r0.y) < 0.0);
  r0.y = (r0.y != 0) ? r0.z : r0.w;
  r0.yzw = asuint(float3(1,0.666666687,0.333333343) + asfloat(r0.yyy));
  r0.yzw = asuint(frac(asfloat(r0.yzw)));
  r0.yzw = asuint(mad(asfloat(r0.yzw), float3(6.0,6.0,6.0), float3(-3.0,-3.0,-3.0)));
  r0.yzw = asuint(saturate(float3(-1,-1,-1) + abs(asfloat(r0.yzw))));
  r0.yzw = asuint(float3(-1,-1,-1) + asfloat(r0.yzw));
  r1.y = asuint(9.99999975e-05 + asfloat(r0.x));
  r3.z = asuint(asfloat(r1.x) / asfloat(r1.y));
  r0.yzw = asuint(mad(asfloat(r3.zzz), asfloat(r0.yzw), float3(1.0,1.0,1.0)));
  r1.xyz = asuint(asfloat(r0.xxx) * asfloat(r0.yzw));
  r1.x = asuint(dot(asfloat(r1.xyz), float3(0.212672904,0.715152204,0.0721750036)));
  r0.xyz = asuint(mad(asfloat(r0.xxx), asfloat(r0.yzw), -(asfloat(r1.xxx))));
  r3.yw = uint2(0u,0u);
  r2.xyzw = asuint(t5.SampleBias(s0_s, asfloat(r3.xy), cb0[19].x).xyzw);
  r3.xyzw = asuint(t6.SampleBias(s0_s, asfloat(r3.zw), cb0[19].x).xyzw);
  r3.x = asuint(saturate(asfloat(r3.x)));
  r2.x = asuint(saturate(asfloat(r2.x)));
  r0.w = asuint(asfloat(r2.x) + asfloat(r2.x));
  r0.w = asuint(dot(asfloat(r3.xx), asfloat(r0.ww)));
  r0.w = asuint(asfloat(r5.x) * asfloat(r0.w));
  r0.w = asuint(dot(cb0[134].yy, asfloat(r0.ww)));
  r0.xyz = asuint(mad(asfloat(r0.www), asfloat(r0.xyz), asfloat(r1.xxx)));
  r0.w = asuint(max(asfloat(r0.x), asfloat(r0.y)));
  r0.w = asuint(max(asfloat(r0.w), asfloat(r0.z)));
  r0.w = asuint(1 + asfloat(r0.w));
  r0.w = asuint(1 / asfloat(r0.w));
  r0.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r0.www), float3(0.00390625,0.00390625,0.00390625)));
  r0.w = 0u;
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xw), cb0[19].x).xyzw);
  r1.x = asuint(saturate(asfloat(r1.x)));
  r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.yw), cb0[19].x).xyzw);
  r0.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.zw), cb0[19].x).xyzw);
  r1.z = asuint(saturate(asfloat(r0.x)));
  r1.y = asuint(saturate(asfloat(r2.x)));
  r0.xyz = asuint(float3(0.00390625,0.00390625,0.00390625) + asfloat(r1.xyz));
  r0.w = 0u;
  r1.xyzw = asuint(t1.SampleBias(s0_s, asfloat(r0.xw), cb0[19].x).xyzw);
  r1.x = asuint(saturate(asfloat(r1.x)));
  r2.xyzw = asuint(t2.SampleBias(s0_s, asfloat(r0.yw), cb0[19].x).xyzw);
  r0.xyzw = asuint(t3.SampleBias(s0_s, asfloat(r0.zw), cb0[19].x).xyzw);
  r1.z = asuint(saturate(asfloat(r0.x)));
  r1.y = asuint(saturate(asfloat(r2.x)));
  r0.x = asuint(max(asfloat(r1.x), asfloat(r1.y)));
  r0.x = asuint(max(asfloat(r0.x), asfloat(r1.z)));
  r0.x = asuint(1 + -asfloat(r0.x));
  r0.x = asuint(1 / asfloat(r0.x));
  r0.xyz = asuint(asfloat(r1.xyz) * asfloat(r0.xxx));
  float3 untonemapped = max(float3(0,0,0), asfloat(r0.xyz));
  o0.rgb = PostToneMapScale(applyUserTonemap(untonemapped, untonemapped, 0.18f));
  o0.w = 1;
  return;
}