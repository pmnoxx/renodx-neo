// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[11];
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
  float3 v2 : INTERP1,
  float3 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint(cb0[74].xyw * v2.yyy);
  r0.xyz = asuint(mad(cb0[73].xyw, v2.xxx, asfloat(r0.xyz)));
  r0.xyz = asuint(mad(cb0[75].xyw, v2.zzz, asfloat(r0.xyz)));
  r0.xyz = asuint(cb0[76].xyw + asfloat(r0.xyz));
  r1.xz = asuint(float2(0.5,0.5) * asfloat(r0.xz));
  r0.x = asuint(cb0[17].x * asfloat(r0.y));
  r1.w = asuint(0.5 * asfloat(r0.x));
  r0.xy = asuint(asfloat(r1.xw) + asfloat(r1.zz));
  r1.xyzw = asuint(t1.SampleBias(s1_s, v1.xy, cb0[19].x).xyzw);
  r2.xyzw = asuint(cb1[1].xxxx * v2.zxzx);
  r0.w = asuint(cb1[1].w * cb0[15].x);
  r3.xy = asuint(cb1[2].xy * asfloat(r0.ww));
  r3.xy = asuint(mad(asfloat(r2.zw), cb1[1].yy, asfloat(r3.xy)));
  r3.xyzw = asuint(t2.SampleBias(s2_s, asfloat(r3.xy), cb0[19].x).xyzw);
  r4.xyzw = asuint(cb1[2].zzww * cb0[15].xxxx);
  r4.xyzw = asuint(cb1[3].xyxy * asfloat(r4.xyzw));
  r2.xyzw = asuint(mad(asfloat(r2.xyzw), cb1[5].xyxy, asfloat(r4.xyzw)));
  r2.xyzw = asuint(float4(3,3,5,5) * asfloat(r2.xyzw));
  r4.xyzw = asuint(floor(asfloat(r2.xyzw)));
  r2.xyzw = asuint(frac(asfloat(r2.xyzw)));
  r5.xy = uint2(0u,0x41000000u);
  r0.w = 0xffffffffu;
  while (true) {
    r3.w = (uint)-(int)((int)1u < (int)r0.w);
    if (r3.w != 0) break;
    r6.y = asuint((float)(int)r0.w);
    r5.zw = r5.xy;
    r3.w = 0xffffffffu;
    while (true) {
      r6.z = (uint)-(int)((int)1u < (int)r3.w);
      if (r6.z != 0) break;
      r6.x = asuint((float)(int)r3.w);
      r6.zw = asuint(asfloat(r6.xy) + asfloat(r4.xy));
      r7.x = asuint(dot(asfloat(r6.zw), float2(15.2700005,99.4100037)));
      r6.z = asuint(dot(asfloat(r6.zw), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r7.x));
    r7.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r6.z));
    r7.x = asuint(sinValue);
  }
      r6.zw = asuint(frac(asfloat(r7.xy)));
      r6.zw = asuint(float2(42.75,42.75) * asfloat(r6.zw));
    {
    float sinValue = sin(asfloat(r6.z));
    r6.z = asuint(sinValue);
  }
      r7.x = asuint(mad(asfloat(r6.z), 0.5, asfloat(r6.x)));
    {
    float cosValue = cos(asfloat(r6.w));
    r6.x = asuint(cosValue);
  }
      r7.y = asuint(mad(asfloat(r6.x), 0.5, asfloat(r6.y)));
      r6.xz = asuint(asfloat(r7.xy) + -asfloat(r2.xy));
    {
    precise float2 sum = asfloat(r6.xz) + float2(0.5,0.5);
    r6.xz = asuint(sum);
  }
      r6.x = asuint(dot(asfloat(r6.xz), asfloat(r6.xz)));
      r6.x = asuint(sqrt(asfloat(r6.x)));
      r6.z = (uint)-(int)(asfloat(r6.x) < asfloat(r5.w));
      r5.zw = (r6.zz != 0) ? r6.xx : r5.zw;
      r3.w = (uint)(r3.w + 1u);
    }
    r5.xy = r5.zw;
    r0.w = (uint)(r0.w + 1u);
  }
  r2.xy = uint2(0u,0x41000000u);
  r0.w = 0xffffffffu;
  while (true) {
    r3.w = (uint)-(int)((int)1u < (int)r0.w);
    if (r3.w != 0) break;
    r4.y = asuint((float)(int)r0.w);
    r5.yz = r2.xy;
    r3.w = 0xffffffffu;
    while (true) {
      r5.w = (uint)-(int)((int)1u < (int)r3.w);
      if (r5.w != 0) break;
      r4.x = asuint((float)(int)r3.w);
      r6.xy = asuint(asfloat(r4.xy) + asfloat(r4.zw));
      r5.w = asuint(dot(asfloat(r6.xy), float2(15.2700005,99.4100037)));
      r6.x = asuint(dot(asfloat(r6.xy), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r5.w));
    r7.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r6.x));
    r7.x = asuint(sinValue);
  }
      r6.xy = asuint(frac(asfloat(r7.xy)));
      r6.xy = asuint(float2(10.1000004,10.1000004) * asfloat(r6.xy));
    {
    float sinValue = sin(asfloat(r6.x));
    r5.w = asuint(sinValue);
  }
      r7.x = asuint(mad(asfloat(r5.w), 0.5, asfloat(r4.x)));
    {
    float cosValue = cos(asfloat(r6.y));
    r4.x = asuint(cosValue);
  }
      r7.y = asuint(mad(asfloat(r4.x), 0.5, asfloat(r4.y)));
      r6.xy = asuint(asfloat(r7.xy) + -asfloat(r2.zw));
    {
    precise float2 sum = asfloat(r6.xy) + float2(0.5,0.5);
    r6.xy = asuint(sum);
  }
      r4.x = asuint(dot(asfloat(r6.xy), asfloat(r6.xy)));
      r4.x = asuint(sqrt(asfloat(r4.x)));
      r5.w = (uint)-(int)(asfloat(r4.x) < asfloat(r5.z));
      r5.yz = (r5.ww != 0) ? r4.xx : r5.yz;
      r3.w = (uint)(r3.w + 1u);
    }
    r2.xy = r5.yz;
    r0.w = (uint)(r0.w + 1u);
  }
  r0.w = asuint(asfloat(r5.x) * asfloat(r2.x));
  r2.xyz = asuint(cb1[4].xyz * asfloat(r0.www));
  r1.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r3.xyz), asfloat(r2.xyz)));
  r0.w = asuint(1 / cb1[10].x);
  r1.xyz = asuint(saturate(asfloat(r1.xyz) * asfloat(r0.www)));
  r2.xyz = asuint(mad(asfloat(r1.xyz), float3(-2.0,-2.0,-2.0), float3(3.0,3.0,3.0)));
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r1.xyz));
  r1.xyz = asuint(asfloat(r2.xyz) * asfloat(r1.xyz));
  r2.xyz = asuint(-cb1[7].xyz + cb1[6].xyz);
  o0.xyz = mad(asfloat(r1.xyz), asfloat(r2.xyz), cb1[7].xyz);
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r0.w = (uint)-(int)(cb0[21].w == 1.0);
  if (r0.w != 0) {
    r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
    r1.xy = asuint(mad(asfloat(r0.xy), float2(2.0,2.0), float2(-1.0,-1.0)));
    r3.xyzw = asuint(cb0[78].xyzw * -asfloat(r1.yyyy));
    r3.xyzw = asuint(mad(cb0[77].xyzw, asfloat(r1.xxxx), asfloat(r3.xyzw)));
    r2.xyzw = asuint(mad(cb0[79].xyzw, asfloat(r2.xxxx), asfloat(r3.xyzw)));
    r2.xyzw = asuint(cb0[80].xyzw + asfloat(r2.xyzw));
    r1.xyz = asuint(asfloat(r2.xyz) / asfloat(r2.www));
    r0.w = asuint(cb0[62].z * asfloat(r1.y));
    r0.w = asuint(mad(cb0[61].z, asfloat(r1.x), asfloat(r0.w)));
    r0.w = asuint(mad(cb0[63].z, asfloat(r1.z), asfloat(r0.w)));
    r0.w = asuint(cb0[64].z + asfloat(r0.w));
    r0.w = (r0.w & 0x7fffffffu);
  } else {
    r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
    r0.x = asuint(mad(cb0[20].z, asfloat(r2.x), cb0[20].w));
    r0.w = asuint(1 / asfloat(r0.x));
  }
  r0.x = asuint(asfloat(r0.w) + -asfloat(r0.z));
  r0.x = asuint(saturate(cb1[1].z * asfloat(r0.x)));
  r0.y = asuint(1 + -cb1[8].x);
  r0.z = asuint(1 + -asfloat(r0.x));
  r0.x = asuint(mad(asfloat(r0.y), asfloat(r0.z), asfloat(r0.x)));
  o0.w = asfloat(r0.x) * asfloat(r1.w);
  o0.w = saturate(o0.w);
  return;
}