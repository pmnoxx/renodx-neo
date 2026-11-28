// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

TextureCube<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerComparisonState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb3 : register(b3)
{
  float4 cb3[5];
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
  uint4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = asuint(dot(v6.xyz, v6.xyz));
  r0.y = asuint(sqrt(asfloat(r0.x)));
  r0.x = asuint(rsqrt(asfloat(r0.x)));
  r1.xyz = asuint(v6.xyz * asfloat(r0.xxx));
  r0.x = asuint(1 / asfloat(r0.y));
  r0.xyz = asuint(v6.xyz * asfloat(r0.xxx));
  { precise float lengthSquared = dot(asfloat(r0.xyz), asfloat(r0.xyz)); r0.w = asuint(lengthSquared); }
  r0.w = asuint(rsqrt(asfloat(r0.w)));
  r0.xyz = asuint(asfloat(r0.xyz) * asfloat(r0.www));
  r0.w = asuint(dot(v7.xyz, v7.xyz));
  r2.x = asuint(rsqrt(asfloat(r0.w)));
  r0.w = asuint(max(1.17549435e-38, asfloat(r0.w)));
  r0.w = asuint(rsqrt(asfloat(r0.w)));
  r2.xyz = asuint(v7.xyz * asfloat(r2.xxx));
  r0.x = asuint(saturate(dot(asfloat(r0.xyz), asfloat(r2.xyz))));
  r0.x = asuint(1 + -asfloat(r0.x));
  r0.x = asuint(log2(asfloat(r0.x)));
  r0.xy = asuint(cb3[2].yx * asfloat(r0.xx));
  r0.xy = asuint(exp2(asfloat(r0.xy)));
  r0.yz = asuint(float2(1,0.5) + -asfloat(r0.yy));
  r0.z = (uint)-(int)(asfloat(r0.z) < 0.0);
  o0.w = max(0, asfloat(r0.y));
  if (r0.z != 0) discard;
  r0.y = asuint(asfloat(r1.y) * asfloat(r1.y));
  r0.y = asuint(mad(asfloat(r1.x), asfloat(r1.x), -(asfloat(r0.y))));
  r2.xyzw = asuint(asfloat(r1.xyzz) * asfloat(r1.yzzx));
  r3.x = asuint(dot(cb1[28].xyzw, asfloat(r2.xyzw)));
  r3.y = asuint(dot(cb1[29].xyzw, asfloat(r2.xyzw)));
  r3.z = asuint(dot(cb1[30].xyzw, asfloat(r2.xyzw)));
  r2.xyz = asuint(mad(cb1[31].xyz, asfloat(r0.yyy), asfloat(r3.xyz)));
  r1.w = 0x3f800000u;
  r3.x = asuint(dot(cb1[25].xyzw, asfloat(r1.xyzw)));
  r3.y = asuint(dot(cb1[26].xyzw, asfloat(r1.xyzw)));
  r3.z = asuint(dot(cb1[27].xyzw, asfloat(r1.xyzw)));
  r2.xyz = asuint(asfloat(r3.xyz) + asfloat(r2.xyz));
  r2.xyz = asuint(max(float3(0,0,0), asfloat(r2.xyz)));
  r3.xyz = asuint(float3(1,1,1) + -cb3[3].xyz);
  r4.xyz = asuint(float3(1,1,1) + -cb3[4].xyz);
  r3.xyz = asuint(mad(-(asfloat(r3.xyz)), asfloat(r4.xyz), -(cb3[4].xyz)));
  r3.xyz = asuint(float3(1,1,1) + asfloat(r3.xyz));
  r3.xyz = asuint(mad(asfloat(r0.xxx), asfloat(r3.xyz), cb3[4].xyz));
  r0.xyz = asuint(asfloat(r3.xyz) * asfloat(r0.xxx));
  r1.w = (uint)-(int)(cb3[2].y < 5.0);
  r1.w = (uint)(r1.w & 0x3f800000u);
  r0.xyz = asuint(asfloat(r1.www) * asfloat(r0.xyz));
  r3.xyzw = asuint(t2.SampleBias(s2_s, v3.xy, cb0[19].x).xyzw);
  r0.xyz = asuint(mad(asfloat(r3.xyz), cb3[1].xyz, asfloat(r0.xyz)));
  r3.xyz = asuint(v7.xyz * asfloat(r0.www));
  r4.xyz = asuint(mad(v7.xyz, asfloat(r0.www), cb0[5].xyz));
  r0.w = asuint(dot(-asfloat(r3.xyz), asfloat(r1.xyz)));
  r0.w = asuint(asfloat(r0.w) + asfloat(r0.w));
  r5.xyz = asuint(mad(asfloat(r1.xyz), -(asfloat(r0.www)), -(asfloat(r3.xyz))));
  r0.w = asuint(saturate(dot(asfloat(r1.xyz), asfloat(r3.xyz))));
  r1.x = asuint(saturate(dot(asfloat(r1.xyz), cb0[5].xyz)));
  r0.w = asuint(1 + -asfloat(r0.w));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(mad(asfloat(r0.w), 2.23517418e-08, 0.0399999991));
  r0.xyzw = asuint(float4(0.959999979,0.959999979,0.959999979,0.5) * asfloat(r0.xyzw));
  r3.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r5.xyz), 6).xyzw);
  r1.y = asuint(-1 + asfloat(r3.w));
  r1.y = asuint(mad(cb1[15].w, asfloat(r1.y), 1.0));
  r1.y = asuint(max(0, asfloat(r1.y)));
  r1.y = asuint(log2(asfloat(r1.y)));
  r1.y = asuint(cb1[15].y * asfloat(r1.y));
  r1.y = asuint(exp2(asfloat(r1.y)));
  r1.y = asuint(cb1[15].x * asfloat(r1.y));
  r1.yzw = asuint(asfloat(r1.yyy) * asfloat(r3.xyz));
  r1.yzw = asuint(asfloat(r1.yzw) * asfloat(r0.www));
  r1.yzw = asuint(mad(asfloat(r2.xyz), asfloat(r0.xyz), asfloat(r1.yzw)));
  { precise float lengthSquared = dot(asfloat(r4.xyz), asfloat(r4.xyz)); r0.w = asuint(lengthSquared); }
  r0.w = asuint(max(1.17549435e-38, asfloat(r0.w)));
  r0.w = asuint(rsqrt(asfloat(r0.w)));
  r2.xyz = asuint(asfloat(r4.xyz) * asfloat(r0.www));
  r0.w = asuint(saturate(dot(cb0[5].xyz, asfloat(r2.xyz))));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(max(0.100000001, asfloat(r0.w)));
  r0.w = asuint(6.00012016 * asfloat(r0.w));
  r0.w = asuint(1 / asfloat(r0.w));
  r0.xyz = asuint(mad(asfloat(r0.www), float3(0.0399999991,0.0399999991,0.0399999991), asfloat(r0.xyz)));
  r2.xyz = asuint(-cb2[20].xyz + v5.xyz);
  { precise float lengthSquared = dot(asfloat(r2.xyz), asfloat(r2.xyz)); r2.x = asuint(lengthSquared); }
  r3.xyz = asuint(-cb2[21].xyz + v5.xyz);
  { precise float lengthSquared = dot(asfloat(r3.xyz), asfloat(r3.xyz)); r2.y = asuint(lengthSquared); }
  r3.xyz = asuint(-cb2[22].xyz + v5.xyz);
  { precise float lengthSquared = dot(asfloat(r3.xyz), asfloat(r3.xyz)); r2.z = asuint(lengthSquared); }
  r3.xyz = asuint(-cb2[23].xyz + v5.xyz);
  { precise float lengthSquared = dot(asfloat(r3.xyz), asfloat(r3.xyz)); r2.w = asuint(lengthSquared); }
  r2.xyzw = (uint4)-(int4)(asfloat(r2.xyzw) < cb2[24].xyzw);
  r3.xyz = (r2.xyz != 0) ? uint3(0xbf800000u,0xbf800000u,0xbf800000u) : uint3(0x80000000u,0x80000000u,0x80000000u);
  r2.xyzw = (uint4)(r2.xyzw & uint4(0x3f800000u,0x3f800000u,0x3f800000u,0x3f800000u));
  r3.xyz = asuint(asfloat(r2.yzw) + asfloat(r3.xyz));
  r2.yzw = asuint(max(float3(0,0,0), asfloat(r3.xyz)));
  r0.w = asuint(dot(asfloat(r2.xyzw), float4(4,3,2,1)));
  r0.w = asuint(4 + -asfloat(r0.w));
  r0.w = (uint)((uint)(asfloat(r0.w)));
  r0.w = (uint)(r0.w << 2u);
  r2.xyz = asuint(cb2[asint(r0.w)+1].xyz * v5.yyy);
  r2.xyz = asuint(mad(cb2[r0.w].xyz, v5.xxx, asfloat(r2.xyz)));
  r2.xyz = asuint(mad(cb2[r0.w + 2].xyz, v5.zzz, asfloat(r2.xyz)));
  r2.xyz = asuint(cb2[asint(r0.w)+3].xyz + asfloat(r2.xyz));
  r0.w = (uint)-(int)(0.0 >= asfloat(r2.z));
  r2.w = (uint)-(int)(asfloat(r2.z) >= 1.0);
  r2.x = asuint(t1.SampleCmpLevelZero(s1_s, asfloat(r2.xy), asfloat(r2.z)).x);
  r0.w = (uint)(r0.w | r2.w);
  r2.y = asuint(1 + -cb2[29].x);
  r2.x = asuint(mad(asfloat(r2.x), cb2[29].x, asfloat(r2.y)));
  r0.w = (r0.w != 0) ? 0x3f800000u : r2.x;
  r2.x = asuint(1 + -asfloat(r0.w));
  r2.yzw = asuint(-cb0[16].xyz + v5.xyz);
  { precise float lengthSquared = dot(asfloat(r2.yzw), asfloat(r2.yzw)); r2.y = asuint(lengthSquared); }
  r2.y = asuint(saturate(mad(asfloat(r2.y), cb2[29].z, cb2[29].w)));
  r0.w = asuint(mad(asfloat(r2.y), asfloat(r2.x), asfloat(r0.w)));
  r0.w = asuint(cb1[11].z * asfloat(r0.w));
  r0.w = asuint(asfloat(r0.w) * asfloat(r1.x));
  r2.xyz = asuint(cb0[6].xyz * asfloat(r0.www));
  o0.xyz = mad(asfloat(r0.xyz), asfloat(r2.xyz), asfloat(r1.yzw));
  o0.w = saturate(o0.w);
  return;
}