// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[10];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[81];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  float3 v6 : INTERP5,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint(cb0[74].xyw * v4.yyy);
  r0.xyz = asuint(mad(cb0[73].xyw, v4.xxx, asfloat(r0.xyz)));
  r0.xyz = asuint(mad(cb0[75].xyw, v4.zzz, asfloat(r0.xyz)));
  r0.xyz = asuint(cb0[76].xyw + asfloat(r0.xyz));
  r1.xz = asuint(float2(0.5,0.5) * asfloat(r0.xz));
  r0.x = asuint(cb0[17].x * asfloat(r0.y));
  r1.w = asuint(0.5 * asfloat(r0.x));
  r0.xy = asuint(asfloat(r1.xw) + asfloat(r1.zz));
  r1.xyzw = asuint(t3.SampleBias(s3_s, v1.xy, cb0[19].x).xyzw);
  r2.xy = asuint(cb1[3].xx * v4.zx);
  r0.w = asuint(cb1[4].x * cb0[15].x);
  r2.zw = asuint(cb1[5].xy * asfloat(r0.ww));
  r2.xy = asuint(mad(asfloat(r2.xy), cb1[3].yy, asfloat(r2.zw)));
  r2.xyz = asuint(t1.SampleBias(s1_s, asfloat(r2.xy), cb0[19].x).xyz);
  r1.xyz = asuint(asfloat(r2.xyz) * asfloat(r1.xyz));
  r1.xyz = asuint(cb1[9].xyz * asfloat(r1.xyz));
  o0.xyz = v2.yzw * asfloat(r1.xyz);
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r0.w = (uint)-(int)(cb0[21].w == 1.0);
  if (r0.w != 0) {
    r0.w = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).x);
    r1.xy = asuint(mad(asfloat(r0.xy), float2(2.0,2.0), float2(-1.0,-1.0)));
    r2.xyzw = asuint(cb0[78].xyzw * -asfloat(r1.yyyy));
    r2.xyzw = asuint(mad(cb0[77].xyzw, asfloat(r1.xxxx), asfloat(r2.xyzw)));
    r2.xyzw = asuint(mad(cb0[79].xyzw, asfloat(r0.wwww), asfloat(r2.xyzw)));
    r2.xyzw = asuint(cb0[80].xyzw + asfloat(r2.xyzw));
    r1.xyz = asuint(asfloat(r2.xyz) / asfloat(r2.www));
    r0.w = asuint(cb0[62].z * asfloat(r1.y));
    r0.w = asuint(mad(cb0[61].z, asfloat(r1.x), asfloat(r0.w)));
    r0.w = asuint(mad(cb0[63].z, asfloat(r1.z), asfloat(r0.w)));
    r0.w = asuint(cb0[64].z + asfloat(r0.w));
    r0.w = (r0.w & 0x7fffffffu);
  } else {
    r0.x = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).x);
    r0.x = asuint(mad(cb0[20].z, asfloat(r0.x), cb0[20].w));
    r0.w = asuint(1 / asfloat(r0.x));
  }
  r0.x = asuint(asfloat(r0.w) + -asfloat(r0.z));
  r0.x = asuint(saturate(cb1[3].w * asfloat(r0.x)));
  r0.yz = asuint(float2(8,3) * v1.xy);
  r0.y = asuint(t2.SampleBias(s2_s, asfloat(r0.yz), cb0[19].x).x);
  r0.y = asuint(asfloat(r1.w) * asfloat(r0.y));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.y));
  r0.x = asuint(v2.x * asfloat(r0.x));
  o0.w = v3.x * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}