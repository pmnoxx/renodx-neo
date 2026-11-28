// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[20];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float3 v3 : INTERP2,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(float4(-0.5,-0.5,-0.5,-0.5) + v2.xyxy);
  r0.xy = asuint(asfloat(r0.xy) + asfloat(r0.xy));
  {
    precise float2 sum = -abs(asfloat(r0.xy)) + float2(1.0,1.0);
    r0.xy = asuint(sum);
  }
  r0.xy = asuint(mad(asfloat(r0.xx), asfloat(r0.yy), float2(-0.00999999978,-0.0199999996)));
  r0.xy = asuint(saturate(float2(1.35135138,1.09890103) * asfloat(r0.xy)));
  r1.xy = asuint(mad(asfloat(r0.xy), float2(-2.0,-2.0), float2(3.0,3.0)));
  r0.xy = asuint(asfloat(r0.xy) * asfloat(r0.xy));
  r0.xy = asuint(asfloat(r1.xy) * asfloat(r0.xy));
  r1.xyzw = asuint(float4(0,-2,0,-1) * cb0[15].xxxx);
  r1.xyzw = asuint(mad(v2.xyxy, float4(2.0,1.0,2.0,1.0), asfloat(r1.xyzw)));
  r2.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.zw), cb0[19].x).xyzw);
  r1.y = asuint(asfloat(r2.x) + asfloat(r1.x));
  r1.z = asuint(dot(asfloat(r0.zw), asfloat(r0.zw)));
  r1.z = asuint(sqrt(asfloat(r1.z)));
  {
    float sinValue = sin(asfloat(r1.z));
    float cosValue = cos(asfloat(r1.z));
    r2.x = asuint(sinValue);
    r3.x = asuint(cosValue);
  }
  r1.zw = asuint(asfloat(r2.xx) * asfloat(r0.wz));
  r0.z = asuint(mad(asfloat(r3.x), asfloat(r0.z), -(asfloat(r1.z))));
  r0.w = asuint(mad(asfloat(r3.x), asfloat(r0.w), asfloat(r1.w)));
  r2.xy = asuint(float2(0.5,0.5) + asfloat(r0.zw));
  r0.zw = asuint(mad(cb0[15].xx, float2(0.0,-2.0), asfloat(r2.xy)));
  r1.zw = asuint(floor(asfloat(r0.zw)));
  r0.zw = asuint(frac(asfloat(r0.zw)));
  r2.zw = uint2(0u,0x41000000u);
  r3.x = 0xffffffffu;
  while (true) {
    r3.y = (uint)-(int)((int)1u < (int)r3.x);
    if (r3.y != 0) break;
    r4.y = asuint((float)(int)r3.x);
    r3.yz = r2.zw;
    r3.w = 0xffffffffu;
    while (true) {
      r4.z = (uint)-(int)((int)1u < (int)r3.w);
      if (r4.z != 0) break;
      r4.x = asuint((float)(int)r3.w);
      r4.zw = asuint(asfloat(r4.xy) + asfloat(r1.zw));
      r5.x = asuint(dot(asfloat(r4.zw), float2(15.2700005,99.4100037)));
      r4.z = asuint(dot(asfloat(r4.zw), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r5.x));
    r5.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r4.z));
    r5.x = asuint(sinValue);
  }
      r4.zw = asuint(frac(asfloat(r5.xy)));
      r4.zw = asuint(float2(33.9500008,33.9500008) * asfloat(r4.zw));
    {
    float sinValue = sin(asfloat(r4.z));
    r4.z = asuint(sinValue);
  }
      r5.x = asuint(mad(asfloat(r4.z), 0.5, asfloat(r4.x)));
    {
    float cosValue = cos(asfloat(r4.w));
    r4.x = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r4.x), 0.5, asfloat(r4.y)));
      r4.xz = asuint(asfloat(r5.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r4.xz) + float2(0.5,0.5);
    r4.xz = asuint(sum);
  }
      r4.x = asuint(dot(asfloat(r4.xz), asfloat(r4.xz)));
      r4.x = asuint(sqrt(asfloat(r4.x)));
      r4.z = (uint)-(int)(asfloat(r4.x) < asfloat(r3.z));
      r3.yz = (r4.zz != 0) ? r4.xx : r3.yz;
      r3.w = (uint)(r3.w + 1u);
    }
    r2.zw = r3.yz;
    r3.x = (uint)(r3.x + 1u);
  }
  r3.xyzw = asuint(mad(cb0[15].xxxx, float4(0.0,-1.5,1.0,0.0), asfloat(r2.xyxy)));
  r0.zw = asuint(float2(3,3) * asfloat(r3.xy));
  r1.zw = asuint(floor(asfloat(r0.zw)));
  r0.zw = asuint(frac(asfloat(r0.zw)));
  r2.xyw = uint3(0u,0x41000000u,0xffffffffu);
  while (true) {
    r3.x = (uint)-(int)((int)1u < (int)r2.w);
    if (r3.x != 0) break;
    r3.y = asuint((float)(int)r2.w);
    r4.xy = r2.xy;
    r4.z = 0xffffffffu;
    while (true) {
      r4.w = (uint)-(int)((int)1u < (int)r4.z);
      if (r4.w != 0) break;
      r3.x = asuint((float)(int)r4.z);
      r5.xy = asuint(asfloat(r3.xy) + asfloat(r1.zw));
      r4.w = asuint(dot(asfloat(r5.xy), float2(15.2700005,99.4100037)));
      r5.x = asuint(dot(asfloat(r5.xy), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r4.w));
    r6.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r5.x));
    r6.x = asuint(sinValue);
  }
      r5.xy = asuint(frac(asfloat(r6.xy)));
      r5.xy = asuint(float2(10.7299995,10.7299995) * asfloat(r5.xy));
    {
    float sinValue = sin(asfloat(r5.x));
    r4.w = asuint(sinValue);
  }
      r6.x = asuint(mad(asfloat(r4.w), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r5.y));
    r3.x = asuint(cosValue);
  }
      r6.y = asuint(mad(asfloat(r3.x), 0.5, asfloat(r3.y)));
      r5.xy = asuint(asfloat(r6.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r5.xy) + float2(0.5,0.5);
    r5.xy = asuint(sum);
  }
      r3.x = asuint(dot(asfloat(r5.xy), asfloat(r5.xy)));
      r3.x = asuint(sqrt(asfloat(r3.x)));
      r4.w = (uint)-(int)(asfloat(r3.x) < asfloat(r4.y));
      r4.xy = (r4.ww != 0) ? r3.xx : r4.xy;
      r4.z = (uint)(r4.z + 1u);
    }
    r2.xy = r4.xy;
    r2.w = (uint)(r2.w + 1u);
  }
  r0.z = asuint(asfloat(r2.z) * asfloat(r2.x));
  r0.z = asuint(log2(asfloat(r0.z)));
  r0.z = asuint(0.930000007 * asfloat(r0.z));
  r0.z = asuint(exp2(asfloat(r0.z)));
  r0.z = asuint(-0.119999997 + asfloat(r0.z));
  r0.z = asuint(saturate(3.57142854 * asfloat(r0.z)));
  r0.w = asuint(mad(asfloat(r0.z), -2.0, 3.0));
  r0.z = asuint(asfloat(r0.z) * asfloat(r0.z));
  r0.z = asuint(mad(-(asfloat(r0.w)), asfloat(r0.z), 1.07000005));
  r0.y = asuint(mad(asfloat(r0.y), asfloat(r1.x), 0.0700000003));
  r0.z = asuint(1 / asfloat(r0.z));
  r0.y = asuint(saturate(asfloat(r0.y) * asfloat(r0.z)));
  r0.z = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r0.y = asuint(asfloat(r0.z) * asfloat(r0.y));
  r0.y = asuint(asfloat(r0.x) * asfloat(r0.y));
  r0.y = asuint(3.22580647 * asfloat(r0.y));
  r0.y = asuint(min(1, asfloat(r0.y)));
  r0.z = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r0.y = asuint(asfloat(r0.z) * asfloat(r0.y));
  r0.x = asuint(mad(asfloat(r0.x), asfloat(r1.y), asfloat(r0.y)));
  r1.xyzw = asuint(t2.SampleBias(s2_s, asfloat(r3.zw), cb0[19].x).xyzw);
  o0.w = asfloat(r1.x) + asfloat(r0.x);
  r0.xyz = asuint(float3(1,1,1) + v3.xyz);
  o0.xyz = float3(0.5,0.5,0.5) * asfloat(r0.xyz);
  o0.w = saturate(o0.w);
  return;
}