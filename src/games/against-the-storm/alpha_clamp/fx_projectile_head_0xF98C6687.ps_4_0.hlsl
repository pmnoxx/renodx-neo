// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[3];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[16];
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
  uint4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(float2(-0.5,-0.5) + v1.xy);
  r0.z = asuint(dot(asfloat(r0.xy), asfloat(r0.xy)));
  r0.z = asuint(sqrt(asfloat(r0.z)));
  r0.z = asuint(0.5 * asfloat(r0.z));
  {
    float sinValue = sin(asfloat(r0.z));
    float cosValue = cos(asfloat(r0.z));
    r1.x = asuint(sinValue);
    r2.x = asuint(cosValue);
  }
  r0.zw = asuint(asfloat(r1.xx) * asfloat(r0.yx));
  r0.z = asuint(mad(asfloat(r2.x), asfloat(r0.x), -(asfloat(r0.z))));
  r0.w = asuint(mad(asfloat(r2.x), asfloat(r0.y), asfloat(r0.w)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r0.zw));
  r0.zw = asuint(mad(cb0[15].xx, float2(0.350000024,0.350000024), asfloat(r1.xy)));
  r0.zw = asuint(float2(3.73000002,3.73000002) * asfloat(r0.zw));
  r1.xy = asuint(floor(asfloat(r0.zw)));
  r0.zw = asuint(frac(asfloat(r0.zw)));
  r1.zw = uint2(0u,0x41000000u);
  r2.x = 0xffffffffu;
  while (true) {
    r2.y = (uint)-(int)((int)1u < (int)r2.x);
    if (r2.y != 0) break;
    r3.y = asuint((float)(int)r2.x);
    r2.yz = r1.zw;
    r2.w = 0xffffffffu;
    while (true) {
      r3.z = (uint)-(int)((int)1u < (int)r2.w);
      if (r3.z != 0) break;
      r3.x = asuint((float)(int)r2.w);
      r3.zw = asuint(asfloat(r3.xy) + asfloat(r1.xy));
      r4.x = asuint(dot(asfloat(r3.zw), float2(15.2700005,99.4100037)));
      r3.z = asuint(dot(asfloat(r3.zw), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r4.x));
    r4.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r3.z));
    r4.x = asuint(sinValue);
  }
      r3.zw = asuint(frac(asfloat(r4.xy)));
      r3.zw = asuint(float2(-6.67000008,-6.67000008) * asfloat(r3.zw));
    {
    float sinValue = sin(asfloat(r3.z));
    r3.z = asuint(sinValue);
  }
      r4.x = asuint(mad(asfloat(r3.z), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r3.w));
    r3.x = asuint(cosValue);
  }
      r4.y = asuint(mad(asfloat(r3.x), 0.5, asfloat(r3.y)));
      r3.xz = asuint(asfloat(r4.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r3.xz) + float2(0.5,0.5);
    r3.xz = asuint(sum);
  }
      r3.x = asuint(dot(asfloat(r3.xz), asfloat(r3.xz)));
      r3.x = asuint(sqrt(asfloat(r3.x)));
      r3.z = (uint)-(int)(asfloat(r3.x) < asfloat(r2.z));
      r2.yz = (r3.zz != 0) ? r3.xx : r2.yz;
      r2.w = (uint)(r2.w + 1u);
    }
    r1.zw = r2.yz;
    r2.x = (uint)(r2.x + 1u);
  }
  r0.z = asuint(0.0399999991 * asfloat(r1.z));
  r0.zw = asuint(mad(v1.xy, asfloat(r0.zz), v1.xy));
  r1.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r0.zw), 0).xyzw);
  o0.xyz = cb1[2].xyz * asfloat(r1.xyz);
  r0.x = asuint(dot(asfloat(r0.xy), float2(-0.999964654,-0.00840735435)));
  r0.xy = asuint(float2(0.5,0.219999999) + asfloat(r0.xx));
  r0.x = asuint(asfloat(r0.x) + asfloat(r0.x));
  r0.zw = asuint(mad(cb0[15].xx, float2(1.0,0.0), v1.xy));
  r0.zw = asuint(float2(3.77999997,3.77999997) * asfloat(r0.zw));
  r1.yz = asuint(floor(asfloat(r0.zw)));
  r0.zw = asuint(frac(asfloat(r0.zw)));
  r2.xy = uint2(0u,0x41000000u);
  r1.w = 0xffffffffu;
  while (true) {
    r2.z = (uint)-(int)((int)1u < (int)r1.w);
    if (r2.z != 0) break;
    r3.y = asuint((float)(int)r1.w);
    r2.zw = r2.xy;
    r3.z = 0xffffffffu;
    while (true) {
      r3.w = (uint)-(int)((int)1u < (int)r3.z);
      if (r3.w != 0) break;
      r3.x = asuint((float)(int)r3.z);
      r4.xy = asuint(asfloat(r3.xy) + asfloat(r1.yz));
      r3.w = asuint(dot(asfloat(r4.xy), float2(15.2700005,99.4100037)));
      r4.x = asuint(dot(asfloat(r4.xy), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r3.w));
    r5.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r4.x));
    r5.x = asuint(sinValue);
  }
      r4.xy = asuint(frac(asfloat(r5.xy)));
      r4.xy = asuint(float2(3.04999995,3.04999995) * asfloat(r4.xy));
    {
    float sinValue = sin(asfloat(r4.x));
    r3.w = asuint(sinValue);
  }
      r5.x = asuint(mad(asfloat(r3.w), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r4.y));
    r3.x = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r3.x), 0.5, asfloat(r3.y)));
      r3.xw = asuint(asfloat(r5.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r3.xw) + float2(0.5,0.5);
    r3.xw = asuint(sum);
  }
      r3.x = asuint(dot(asfloat(r3.xw), asfloat(r3.xw)));
      r3.x = asuint(sqrt(asfloat(r3.x)));
      r3.w = (uint)-(int)(asfloat(r3.x) < asfloat(r2.w));
      r2.zw = (r3.ww != 0) ? r3.xx : r2.zw;
      r3.z = (uint)(r3.z + 1u);
    }
    r2.xy = r2.zw;
    r1.w = (uint)(r1.w + 1u);
  }
  r2.yz = uint2(0u,0x41000000u);
  r1.w = 0xffffffffu;
  while (true) {
    r2.w = (uint)-(int)((int)1u < (int)r1.w);
    if (r2.w != 0) break;
    r3.y = asuint((float)(int)r1.w);
    r3.zw = r2.yz;
    r2.w = 0xffffffffu;
    while (true) {
      r4.x = (uint)-(int)((int)1u < (int)r2.w);
      if (r4.x != 0) break;
      r3.x = asuint((float)(int)r2.w);
      r4.xy = asuint(asfloat(r3.xy) + asfloat(r1.yz));
      r4.z = asuint(dot(asfloat(r4.xy), float2(15.2700005,99.4100037)));
      r4.x = asuint(dot(asfloat(r4.xy), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r4.xz));
    r5.xy = asuint(sinValue);
  }
      r4.xy = asuint(frac(asfloat(r5.xy)));
      r4.xy = asuint(float2(3.04999995,3.04999995) * asfloat(r4.xy));
    {
    float sinValue = sin(asfloat(r4.x));
    r4.x = asuint(sinValue);
  }
      r5.x = asuint(mad(asfloat(r4.x), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r4.y));
    r3.x = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r3.x), 0.5, asfloat(r3.y)));
      r4.xy = asuint(asfloat(r5.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r4.xy) + float2(0.5,0.5);
    r4.xy = asuint(sum);
  }
      r3.x = asuint(dot(asfloat(r4.xy), asfloat(r4.xy)));
      r3.x = asuint(sqrt(asfloat(r3.x)));
      r4.x = (uint)-(int)(asfloat(r3.x) < asfloat(r3.w));
      r3.zw = (r4.xx != 0) ? r3.xx : r3.zw;
      r2.w = (uint)(r2.w + 1u);
    }
    r2.yz = r3.zw;
    r1.w = (uint)(r1.w + 1u);
  }
  r0.z = asuint(asfloat(r2.x) * asfloat(r2.y));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.z));
  r0.x = asuint(mad(asfloat(r0.y), 1.24000001, asfloat(r0.x)));
  r0.x = asuint(-0.109999999 + asfloat(r0.x));
  r0.x = asuint(saturate(1.16279066 * asfloat(r0.x)));
  r0.y = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.y) * asfloat(r0.x));
  r0.x = asuint(asfloat(r1.x) * asfloat(r0.x));
  r0.y = (uint)-(int)(asfloat(r0.x) < 0.0);
  if (r0.y != 0) discard;
  o0.w = asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}