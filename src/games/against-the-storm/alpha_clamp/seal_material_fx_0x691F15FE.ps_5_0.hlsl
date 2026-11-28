// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[16];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float4 v3 : INTERP2,
  float4 v4 : INTERP3,
  float3 v5 : INTERP4,
  float3 v6 : INTERP5,
  float3 v7 : INTERP6,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(float2(-0.5,-0.5) + v1.yx);
  r0.z = asuint(dot(asfloat(r0.xy), asfloat(r0.xy)));
  r0.z = asuint(sqrt(asfloat(r0.z)));
  r0.z = asuint(0.5 * asfloat(r0.z));
  {
    float sinValue = sin(asfloat(r0.z));
    float cosValue = cos(asfloat(r0.z));
    r1.x = asuint(sinValue);
    r2.x = asuint(cosValue);
  }
  r0.zw = asuint(asfloat(r1.xx) * asfloat(r0.xy));
  r0.y = asuint(mad(asfloat(r2.x), asfloat(r0.y), -(asfloat(r0.z))));
  r0.x = asuint(mad(asfloat(r2.x), asfloat(r0.x), asfloat(r0.w)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r0.yx));
  r0.xyzw = asuint(mad(cb0[15].xxxx, float4(0.350000024,0.350000024,0.699999988,0.699999988), asfloat(r1.xyxy)));
  r0.xyzw = asuint(float4(3.73000002,3.73000002,5,5) * asfloat(r0.xyzw));
  r1.xyzw = asuint(floor(asfloat(r0.xyzw)));
  r0.xyzw = asuint(frac(asfloat(r0.xyzw)));
  r2.xyz = uint3(0u,0x41000000u,0xffffffffu);
  while (true) {
    r2.w = (uint)-(int)((int)1u < (int)r2.z);
    if (r2.w != 0) break;
    r3.y = asuint((float)(int)r2.z);
    r3.zw = r2.xy;
    r2.w = 0xffffffffu;
    while (true) {
      r4.x = (uint)-(int)((int)1u < (int)r2.w);
      if (r4.x != 0) break;
      r3.x = asuint((float)(int)r2.w);
      r4.xy = asuint(asfloat(r3.xy) + asfloat(r1.xy));
      r4.z = asuint(dot(asfloat(r4.xy), float2(15.2700005,99.4100037)));
      r4.x = asuint(dot(asfloat(r4.xy), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r4.xz));
    r5.xy = asuint(sinValue);
  }
      r4.xy = asuint(frac(asfloat(r5.xy)));
      r4.xy = asuint(float2(-6.67000008,-6.67000008) * asfloat(r4.xy));
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
      r4.xy = asuint(asfloat(r5.xy) + -asfloat(r0.xy));
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
    r2.xy = r3.zw;
    r2.z = (uint)(r2.z + 1u);
  }
  r0.x = asuint(0.0399999991 * asfloat(r2.x));
  r0.xy = asuint(mad(v1.xy, asfloat(r0.xx), v1.xy));
  r0.x = asuint(t0.Gather(s0_s, asfloat(r0.xy)).x);
  r1.xy = uint2(0u,0x41000000u);
  r0.y = 0xffffffffu;
  while (true) {
    r2.x = (uint)-(int)((int)1u < (int)r0.y);
    if (r2.x != 0) break;
    r2.y = asuint((float)(int)r0.y);
    r2.zw = r1.xy;
    r3.x = 0xffffffffu;
    while (true) {
      r3.y = (uint)-(int)((int)1u < (int)r3.x);
      if (r3.y != 0) break;
      r2.x = asuint((float)(int)r3.x);
      r3.yz = asuint(asfloat(r2.xy) + asfloat(r1.zw));
      r3.w = asuint(dot(asfloat(r3.yz), float2(15.2700005,99.4100037)));
      r3.y = asuint(dot(asfloat(r3.yz), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r3.yw));
    r4.xy = asuint(sinValue);
  }
      r3.yz = asuint(frac(asfloat(r4.xy)));
      r3.yz = asuint(float2(-6.67000008,-6.67000008) * asfloat(r3.yz));
    {
    float sinValue = sin(asfloat(r3.y));
    r3.y = asuint(sinValue);
  }
      r4.x = asuint(mad(asfloat(r3.y), 0.5, asfloat(r2.x)));
    {
    float cosValue = cos(asfloat(r3.z));
    r2.x = asuint(cosValue);
  }
      r4.y = asuint(mad(asfloat(r2.x), 0.5, asfloat(r2.y)));
      r3.yz = asuint(asfloat(r4.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r3.yz) + float2(0.5,0.5);
    r3.yz = asuint(sum);
  }
      r2.x = asuint(dot(asfloat(r3.yz), asfloat(r3.yz)));
      r2.x = asuint(sqrt(asfloat(r2.x)));
      r3.y = (uint)-(int)(asfloat(r2.x) < asfloat(r2.w));
      r2.zw = (r3.yy != 0) ? r2.xx : r2.zw;
      r3.x = (uint)(r3.x + 1u);
    }
    r1.xy = r2.zw;
    r0.y = (uint)(r0.y + 1u);
  }
  r0.y = asuint(0.0399999991 * asfloat(r1.x));
  r0.yz = asuint(mad(v1.xy, asfloat(r0.yy), v1.xy));
  r0.y = asuint(t0.Gather(s0_s, asfloat(r0.yz)).x);
  r0.y = asuint(asfloat(r0.y) + -asfloat(r0.x));
  r0.x = asuint(mad(asfloat(r0.y), 0.5, asfloat(r0.x)));
  r0.yzw = asuint(-v3.xyz + v2.xyz);
  o0.xyz = mad(asfloat(r0.xxx), asfloat(r0.yzw), v3.xyz);
  o0.w = v4.w * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}