// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

TextureCube<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb3 : register(b3)
{
  float4 cb3[5];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[12];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[32];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[20];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float3 v1 : INTERP2,
  float4 v2 : INTERP4,
  float4 v3 : INTERP5,
  float4 v4 : INTERP6,
  float3 v5 : INTERP7,
  float3 v6 : INTERP8,
  float3 v7 : INTERP9,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = asuint(dot(v6.xyz, v6.xyz));
  r0.y = asuint(sqrt(asfloat(r0.x)));
  r0.y = asuint(1 / asfloat(r0.y));
  r0.yzw = asuint(v6.xyz * asfloat(r0.yyy));
  r1.x = asuint(dot(v7.xyz, v7.xyz));
  r1.y = asuint(rsqrt(asfloat(r1.x)));
  r1.yzw = asuint(v7.xyz * asfloat(r1.yyy));
  r2.xyz = asuint(t2.SampleBias(s2_s, v3.xy, cb0[19].x).xyz);
  { precise float lengthSquared = dot(asfloat(r0.yzw), asfloat(r0.yzw)); r2.w = asuint(lengthSquared); }
  r2.w = asuint(rsqrt(asfloat(r2.w)));
  r0.yzw = asuint(asfloat(r2.www) * asfloat(r0.yzw));
  r0.y = asuint(saturate(dot(asfloat(r0.yzw), asfloat(r1.yzw))));
  r0.y = asuint(1 + -asfloat(r0.y));
  r0.y = asuint(log2(asfloat(r0.y)));
  r0.yz = asuint(cb3[2].yx * asfloat(r0.yy));
  r0.yz = asuint(exp2(asfloat(r0.yz)));
  r1.yzw = asuint(float3(1,1,1) + -cb3[3].xyz);
  r3.xyz = asuint(float3(1,1,1) + -cb3[4].xyz);
  r1.yzw = asuint(mad(-(asfloat(r1.yzw)), asfloat(r3.xyz), float3(1.0,1.0,1.0)));
  r1.yzw = asuint(-cb3[4].xyz + asfloat(r1.yzw));
  r1.yzw = asuint(mad(asfloat(r0.yyy), asfloat(r1.yzw), cb3[4].xyz));
  r1.yzw = asuint(asfloat(r1.yzw) * asfloat(r0.yyy));
  r0.y = (uint)-(int)(cb3[2].y < 5.0);
  r0.y = (uint)(r0.y & 0x3f800000u);
  r1.yzw = asuint(asfloat(r1.yzw) * asfloat(r0.yyy));
  r1.yzw = asuint(mad(asfloat(r2.xyz), cb3[1].xyz, asfloat(r1.yzw)));
  r0.yz = asuint(float2(1,0.5) + -asfloat(r0.zz));
  r0.z = (uint)-(int)(asfloat(r0.z) < 0.0);
  if (r0.z != 0) discard;
  r0.x = asuint(rsqrt(asfloat(r0.x)));
  r2.xyz = asuint(v6.xyz * asfloat(r0.xxx));
  r0.x = asuint(max(1.17549435e-38, asfloat(r1.x)));
  r0.x = asuint(rsqrt(asfloat(r0.x)));
  r3.xyz = asuint(v7.xyz * asfloat(r0.xxx));
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
  o0.w = max(0, asfloat(r0.y));
  r0.yzw = asuint(float3(0.959999979,0.959999979,0.959999979) * asfloat(r1.yzw));
  r1.x = (uint)-(int)(cb2[11].y != -1.0);
  if (r1.x != 0) {
    r1.xy = asuint(cb2[1].xy * v5.yy);
    r1.xy = asuint(mad(cb2[0].xy, v5.xx, asfloat(r1.xy)));
    r1.xy = asuint(mad(cb2[2].xy, v5.zz, asfloat(r1.xy)));
    r1.xy = asuint(cb2[3].xy + asfloat(r1.xy));
    r1.xy = asuint(mad(asfloat(r1.xy), float2(0.5,0.5), float2(0.5,0.5)));
    r1.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyzw);
    r5.xy = (uint2)-(int2)(cb2[11].yy == float2(0.0,1.0));
    r1.w = (r5.y != 0) ? r1.w : r1.x;
    r1.xyz = (r5.xxx != 0) ? r1.xyz : r1.www;
  } else {
    r1.xyz = uint3(0x3f800000u,0x3f800000u,0x3f800000u);
  }
  r1.xyz = asuint(cb0[6].xyz * asfloat(r1.xyz));
  r1.w = asuint(dot(-asfloat(r3.xyz), asfloat(r2.xyz)));
  r1.w = asuint(asfloat(r1.w) + asfloat(r1.w));
  r5.xyz = asuint(mad(asfloat(r2.xyz), -(asfloat(r1.www)), -(asfloat(r3.xyz))));
  r1.w = asuint(saturate(dot(asfloat(r2.xyz), asfloat(r3.xyz))));
  r1.w = asuint(1 + -asfloat(r1.w));
  r1.w = asuint(asfloat(r1.w) * asfloat(r1.w));
  r1.w = asuint(asfloat(r1.w) * asfloat(r1.w));
  r3.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r5.xyz), 6).xyzw);
  r2.w = asuint(-1 + asfloat(r3.w));
  r2.w = asuint(mad(cb1[15].w, asfloat(r2.w), 1.0));
  r2.w = asuint(max(0, asfloat(r2.w)));
  r2.w = asuint(log2(asfloat(r2.w)));
  r2.w = asuint(cb1[15].y * asfloat(r2.w));
  r2.w = asuint(exp2(asfloat(r2.w)));
  r2.w = asuint(cb1[15].x * asfloat(r2.w));
  r3.xyz = asuint(asfloat(r2.www) * asfloat(r3.xyz));
  r1.w = asuint(mad(asfloat(r1.w), 2.23517418e-08, 0.0399999991));
  r1.w = asuint(0.5 * asfloat(r1.w));
  r3.xyz = asuint(asfloat(r3.xyz) * asfloat(r1.www));
  r3.xyz = asuint(mad(asfloat(r4.xyz), asfloat(r0.yzw), asfloat(r3.xyz)));
  r1.w = asuint(saturate(dot(asfloat(r2.xyz), cb0[5].xyz)));
  r1.w = asuint(cb1[11].z * asfloat(r1.w));
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r1.www));
  r2.xyz = asuint(mad(v7.xyz, asfloat(r0.xxx), cb0[5].xyz));
  { precise float lengthSquared = dot(asfloat(r2.xyz), asfloat(r2.xyz)); r0.x = asuint(lengthSquared); }
  r0.x = asuint(max(1.17549435e-38, asfloat(r0.x)));
  r0.x = asuint(rsqrt(asfloat(r0.x)));
  r2.xyz = asuint(asfloat(r2.xyz) * asfloat(r0.xxx));
  r0.x = asuint(saturate(dot(cb0[5].xyz, asfloat(r2.xyz))));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(max(0.100000001, asfloat(r0.x)));
  r0.x = asuint(6.00012016 * asfloat(r0.x));
  r0.x = asuint(1 / asfloat(r0.x));
  r0.xyz = asuint(mad(asfloat(r0.xxx), float3(0.0399999991,0.0399999991,0.0399999991), asfloat(r0.yzw)));
  o0.xyz = mad(asfloat(r0.xyz), asfloat(r1.xyz), asfloat(r3.xyz));
  o0.w = saturate(o0.w);
  return;
}