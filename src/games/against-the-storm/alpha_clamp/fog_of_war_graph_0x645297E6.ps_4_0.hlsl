// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[81];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float3 v1 : INTERP0,
  float3 v2 : INTERP1,
  float3 v3 : INTERP2,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint(cb0[74].xyw * v1.yyy);
  r0.xyz = asuint(mad(cb0[73].xyw, v1.xxx, asfloat(r0.xyz)));
  r0.xyz = asuint(mad(cb0[75].xyw, v1.zzz, asfloat(r0.xyz)));
  r0.xyz = asuint(cb0[76].xyw + asfloat(r0.xyz));
  r1.xz = asuint(float2(0.5,0.5) * asfloat(r0.xz));
  r0.x = asuint(cb0[17].x * asfloat(r0.y));
  r1.w = asuint(0.5 * asfloat(r0.x));
  r0.xy = asuint(asfloat(r1.xw) + asfloat(r1.zz));
  r1.xy = asuint(v1.xy / cb1[6].xx);
  r1.zw = asuint(cb1[9].yz + asfloat(r1.xy));
  r2.xyzw = asuint(t5.SampleBias(s5_s, asfloat(r1.zw), cb0[19].x).xyzw);
  r0.w = asuint(1 + -asfloat(r2.x));
  r0.w = asuint(log2(asfloat(r0.w)));
  r0.w = asuint(0.00999999978 * asfloat(r0.w));
  r0.w = asuint(exp2(asfloat(r0.w)));
  r1.zw = asuint(cb1[10].xy * cb0[15].xx);
  r2.yz = asuint(mad(asfloat(r1.xy), cb1[15].xy, asfloat(r1.zz)));
  r3.xyzw = asuint(t2.SampleBias(s2_s, asfloat(r2.yz), cb0[19].x).xyzw);
  r0.w = asuint(saturate(mad(-(asfloat(r0.w)), asfloat(r3.x), asfloat(r2.x))));
  r1.z = (uint)-(int)(cb1[2].x >= asfloat(r0.w));
  r2.xw = asuint(mad(asfloat(r1.xy), cb1[11].xy, cb1[10].zw));
  r3.xyzw = asuint(t1.SampleLevel(s1_s, asfloat(r2.xw), 0).xyzw);
  r3.xyz = asuint(cb1[3].xyz * asfloat(r3.xyz));
  r2.xyzw = asuint(t3.SampleBias(s3_s, asfloat(r2.yz), cb0[19].x).xyzw);
  r4.xy = asuint(float2(3,3) + cb1[15].xy);
  r4.xy = asuint(mad(asfloat(r1.xy), asfloat(r4.xy), asfloat(r1.ww)));
  r4.xyzw = asuint(t4.SampleBias(s4_s, asfloat(r4.xy), cb0[19].x).xyzw);
  r4.xyz = asuint(asfloat(r4.xyz) + -asfloat(r2.xyz));
  r2.xyz = asuint(mad(asfloat(r4.xyz), float3(0.5,0.5,0.5), asfloat(r2.xyz)));
  r2.xyz = asuint(asfloat(r3.xyz) * asfloat(r2.xyz));
  r0.w = asuint(asfloat(r0.w) / cb1[2].x);
  r3.xyz = asuint(mad(asfloat(r2.xyz), cb1[8].xyz, -(asfloat(r2.xyz))));
  r2.xyz = asuint(mad(asfloat(r0.www), asfloat(r3.xyz), asfloat(r2.xyz)));
  r2.xyz = (uint3)(r1.zzz & r2.xyz);
  r1.x = asuint(dot(asfloat(r1.xy), asfloat(r1.xy)));
  r1.x = asuint(sqrt(asfloat(r1.x)));
  r1.x = asuint(log2(asfloat(r1.x)));
  r1.x = asuint(cb1[11].z * asfloat(r1.x));
  r1.x = asuint(exp2(asfloat(r1.x)));
  r1.x = asuint(cb1[11].w * asfloat(r1.x));
  r1.x = asuint(cb1[12].x * asfloat(r1.x));
  r1.x = asuint(10 * asfloat(r1.x));
  r1.yzw = asuint(mad(asfloat(r2.xyz), cb1[13].xyz, -(asfloat(r2.xyz))));
  o0.xyz = mad(asfloat(r1.xxx), asfloat(r1.yzw), asfloat(r2.xyz));
  r0.w = asuint(1 + -asfloat(r0.w));
  r0.w = asuint(cb1[9].w * asfloat(r0.w));
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r1.x = (uint)-(int)(cb0[21].w == 1.0);
  if (r1.x != 0) {
    r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
    r1.yz = asuint(mad(asfloat(r0.xy), float2(2.0,2.0), float2(-1.0,-1.0)));
    r2.xyzw = asuint(cb0[78].xyzw * -asfloat(r1.zzzz));
    r2.xyzw = asuint(mad(cb0[77].xyzw, asfloat(r1.yyyy), asfloat(r2.xyzw)));
    r1.xyzw = asuint(mad(cb0[79].xyzw, asfloat(r1.xxxx), asfloat(r2.xyzw)));
    r1.xyzw = asuint(cb0[80].xyzw + asfloat(r1.xyzw));
    r1.xyz = asuint(asfloat(r1.xyz) / asfloat(r1.www));
    r1.y = asuint(cb0[62].z * asfloat(r1.y));
    r1.x = asuint(mad(cb0[61].z, asfloat(r1.x), asfloat(r1.y)));
    r1.x = asuint(mad(cb0[63].z, asfloat(r1.z), asfloat(r1.x)));
    r1.x = asuint(cb0[64].z + asfloat(r1.x));
    r1.x = (r1.x & 0x7fffffffu);
  } else {
    r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
    r0.x = asuint(mad(cb0[20].z, asfloat(r2.x), cb0[20].w));
    r1.x = asuint(1 / asfloat(r0.x));
  }
  r0.x = asuint(asfloat(r1.x) + -asfloat(r0.z));
  r0.x = asuint(saturate(cb1[14].w * asfloat(r0.x)));
  r0.y = asuint(asfloat(r0.w) * asfloat(r0.x));
  r0.x = asuint(mad(asfloat(r0.w), asfloat(r0.x), -(cb1[9].x)));
  r0.x = (uint)-(int)(asfloat(r0.x) < 0.0);
  if (r0.x != 0) discard;
  o0.w = asfloat(r0.y);
  o0.w = saturate(o0.w);
  return;
}