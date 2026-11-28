// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

TextureCube<float4> t0 : register(t0);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerComparisonState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb4 : register(b4)
{
  float4 cb4[5];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[30];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[32];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[24];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float3 v1 : INTERP2,
  float4 v2 : INTERP3,
  float4 v3 : INTERP4,
  float4 v4 : INTERP5,
  float4 v5 : INTERP6,
  float3 v6 : INTERP7,
  float3 v7 : INTERP8,
  float3 v8 : INTERP9,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = asuint(dot(v7.xyz, v7.xyz));
  r0.y = asuint(sqrt(asfloat(r0.x)));
  r0.y = asuint(1 / asfloat(r0.y));
  r0.yzw = asuint(v7.xyz * asfloat(r0.yyy));
  r1.x = asuint(dot(v8.xyz, v8.xyz));
  r1.y = asuint(rsqrt(asfloat(r1.x)));
  r1.yzw = asuint(v8.xyz * asfloat(r1.yyy));
  r2.xyz = asuint(t4.SampleBias(s4_s, v4.xy, cb0[19].x).xyz);
  { precise float lengthSquared = dot(asfloat(r0.yzw), asfloat(r0.yzw)); r2.w = asuint(lengthSquared); }
  r2.w = asuint(rsqrt(asfloat(r2.w)));
  r0.yzw = asuint(asfloat(r2.www) * asfloat(r0.yzw));
  r0.y = asuint(saturate(dot(asfloat(r0.yzw), asfloat(r1.yzw))));
  r0.y = asuint(1 + -asfloat(r0.y));
  r0.y = asuint(log2(asfloat(r0.y)));
  r0.yz = asuint(cb4[2].yx * asfloat(r0.yy));
  r0.yz = asuint(exp2(asfloat(r0.yz)));
  r1.yzw = asuint(float3(1,1,1) + -cb4[3].xyz);
  r3.xyz = asuint(float3(1,1,1) + -cb4[4].xyz);
  r1.yzw = asuint(mad(-(asfloat(r1.yzw)), asfloat(r3.xyz), float3(1.0,1.0,1.0)));
  r1.yzw = asuint(-cb4[4].xyz + asfloat(r1.yzw));
  r1.yzw = asuint(mad(asfloat(r0.yyy), asfloat(r1.yzw), cb4[4].xyz));
  r1.yzw = asuint(asfloat(r1.yzw) * asfloat(r0.yyy));
  r0.y = (uint)-(int)(cb4[2].y < 5.0);
  r0.y = (uint)(r0.y & 0x3f800000u);
  r1.yzw = asuint(asfloat(r1.yzw) * asfloat(r0.yyy));
  r1.yzw = asuint(mad(asfloat(r2.xyz), cb4[1].xyz, asfloat(r1.yzw)));
  r0.yz = asuint(float2(1,0.5) + -asfloat(r0.zz));
  r0.z = (uint)-(int)(asfloat(r0.z) < 0.0);
  if (r0.z != 0) discard;
  r0.x = asuint(rsqrt(asfloat(r0.x)));
  r2.xyz = asuint(v7.xyz * asfloat(r0.xxx));
  r0.x = asuint(max(1.17549435e-38, asfloat(r1.x)));
  r0.x = asuint(rsqrt(asfloat(r0.x)));
  r3.xyz = asuint(v8.xyz * asfloat(r0.xxx));
  r2.w = 0x3f800000u;
  r4.x = asuint(dot(cb1[25].xyzw, asfloat(r2.xyzw)));
  r4.y = asuint(dot(cb1[26].xyzw, asfloat(r2.xyzw)));
  r4.z = asuint(dot(cb1[27].xyzw, asfloat(r2.xyzw)));
  r5.xyzw = asuint(asfloat(r2.xyzz) * asfloat(r2.yzzx));
  r6.x = asuint(dot(cb1[28].xyzw, asfloat(r5.xyzw)));
  r6.y = asuint(dot(cb1[29].xyzw, asfloat(r5.xyzw)));
  r6.z = asuint(dot(cb1[30].xyzw, asfloat(r5.xyzw)));
  r0.z = asuint(asfloat(r2.y) * asfloat(r2.y));
  r0.z = asuint(mad(asfloat(r2.x), asfloat(r2.x), -(asfloat(r0.z))));
  r5.xyz = asuint(mad(cb1[31].xyz, asfloat(r0.zzz), asfloat(r6.xyz)));
  r4.xyz = asuint(asfloat(r5.xyz) + asfloat(r4.xyz));
  r4.xyz = asuint(max(float3(0,0,0), asfloat(r4.xyz)));
  r0.zw = asuint(rcp(cb0[4].xy));
  r5.xy = asuint(v0.xy * asfloat(r0.zw));
  r0.z = asuint(mad(asfloat(r5.y), cb0[23].x, cb0[23].y));
  r5.z = asuint(1 + -asfloat(r0.z));
  o0.w = max(0, asfloat(r0.y));
  r0.yzw = asuint(float3(0.959999979,0.959999979,0.959999979) * asfloat(r1.yzw));
  r1.x = asuint(t1.SampleBias(s1_s, asfloat(r5.xz), cb0[19].x).x);
  r1.y = asuint(-1 + asfloat(r1.x));
  r1.y = asuint(mad(cb0[9].w, asfloat(r1.y), 1.0));
  r1.x = asuint(min(1, asfloat(r1.x)));
  r1.z = asuint(t2.SampleCmpLevelZero(s2_s, v2.xy, v2.z).x);
  r1.w = asuint(1 + -cb2[29].x);
  r1.z = asuint(mad(asfloat(r1.z), cb2[29].x, asfloat(r1.w)));
  r1.w = (uint)-(int)(0.0 >= v2.z);
  r2.w = (uint)-(int)(v2.z >= 1.0);
  r1.w = (uint)(r1.w | r2.w);
  r1.z = (r1.w != 0) ? 0x3f800000u : r1.z;
  r5.xyz = asuint(-cb0[16].xyz + v6.xyz);
  { precise float lengthSquared = dot(asfloat(r5.xyz), asfloat(r5.xyz)); r1.w = asuint(lengthSquared); }
  r1.w = asuint(saturate(mad(asfloat(r1.w), cb2[29].z, cb2[29].w)));
  r2.w = asuint(1 + -asfloat(r1.z));
  r1.z = asuint(mad(asfloat(r1.w), asfloat(r2.w), asfloat(r1.z)));
  r1.w = (uint)-(int)(cb3[11].y != -1.0);
  if (r1.w != 0) {
    r5.xy = asuint(cb3[1].xy * v6.yy);
    r5.xy = asuint(mad(cb3[0].xy, v6.xx, asfloat(r5.xy)));
    r5.xy = asuint(mad(cb3[2].xy, v6.zz, asfloat(r5.xy)));
    r5.xy = asuint(cb3[3].xy + asfloat(r5.xy));
    r5.xy = asuint(mad(asfloat(r5.xy), float2(0.5,0.5), float2(0.5,0.5)));
    r5.xyzw = asuint(t3.SampleBias(s3_s, asfloat(r5.xy), cb0[19].x).xyzw);
    r6.xy = (uint2)-(int2)(cb3[11].yy == float2(0.0,1.0));
    r1.w = (r6.y != 0) ? r5.w : r5.x;
    r5.xyz = (r6.xxx != 0) ? r5.xyz : r1.www;
  } else {
    r5.xyz = uint3(0x3f800000u,0x3f800000u,0x3f800000u);
  }
  r5.xyz = asuint(cb0[6].xyz * asfloat(r5.xyz));
  r5.xyz = asuint(asfloat(r5.xyz) * asfloat(r1.yyy));
  r1.y = asuint(dot(-asfloat(r3.xyz), asfloat(r2.xyz)));
  r1.y = asuint(asfloat(r1.y) + asfloat(r1.y));
  r6.xyz = asuint(mad(asfloat(r2.xyz), -(asfloat(r1.yyy)), -(asfloat(r3.xyz))));
  r1.y = asuint(saturate(dot(asfloat(r2.xyz), asfloat(r3.xyz))));
  r1.y = asuint(1 + -asfloat(r1.y));
  r1.y = asuint(asfloat(r1.y) * asfloat(r1.y));
  r1.y = asuint(asfloat(r1.y) * asfloat(r1.y));
  r3.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r6.xyz), 6).xyzw);
  r1.w = asuint(-1 + asfloat(r3.w));
  r1.w = asuint(mad(cb1[15].w, asfloat(r1.w), 1.0));
  r1.w = asuint(max(0, asfloat(r1.w)));
  r1.w = asuint(log2(asfloat(r1.w)));
  r1.w = asuint(cb1[15].y * asfloat(r1.w));
  r1.w = asuint(exp2(asfloat(r1.w)));
  r1.w = asuint(cb1[15].x * asfloat(r1.w));
  r3.xyz = asuint(asfloat(r1.www) * asfloat(r3.xyz));
  r1.y = asuint(mad(asfloat(r1.y), 2.23517418e-08, 0.0399999991));
  r1.y = asuint(0.5 * asfloat(r1.y));
  r3.xyz = asuint(asfloat(r3.xyz) * asfloat(r1.yyy));
  r3.xyz = asuint(mad(asfloat(r4.xyz), asfloat(r0.yzw), asfloat(r3.xyz)));
  r1.y = asuint(cb1[11].z * asfloat(r1.z));
  r1.z = asuint(saturate(dot(asfloat(r2.xyz), cb0[5].xyz)));
  r1.y = asuint(asfloat(r1.y) * asfloat(r1.z));
  r1.yzw = asuint(asfloat(r5.xyz) * asfloat(r1.yyy));
  r2.xyz = asuint(mad(v8.xyz, asfloat(r0.xxx), cb0[5].xyz));
  { precise float lengthSquared = dot(asfloat(r2.xyz), asfloat(r2.xyz)); r0.x = asuint(lengthSquared); }
  r0.x = asuint(max(1.17549435e-38, asfloat(r0.x)));
  r0.x = asuint(rsqrt(asfloat(r0.x)));
  r2.xyz = asuint(asfloat(r2.xyz) * asfloat(r0.xxx));
  r0.x = asuint(saturate(dot(cb0[5].xyz, asfloat(r2.xyz))));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(max(0.100000001, asfloat(r0.x)));
  r0.x = asuint(6.00012016 * asfloat(r0.x));
  r0.x = asuint(1 / asfloat(r0.x));
  r2.xyz = asuint(mad(asfloat(r0.xxx), float3(0.0399999991,0.0399999991,0.0399999991), asfloat(r0.yzw)));
  r1.yzw = asuint(asfloat(r2.xyz) * asfloat(r1.yzw));
  r1.xyz = asuint(mad(asfloat(r3.xyz), asfloat(r1.xxx), asfloat(r1.yzw)));
  o0.xyz = mad(v5.yzw, asfloat(r0.yzw), asfloat(r1.xyz));
  o0.w = saturate(o0.w);
  return;
}