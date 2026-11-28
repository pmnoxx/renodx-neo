// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
}

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
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint(float3(-0.5,-0.5,-0.5) + v1.xxy);
  r0.x = asuint(asfloat(r0.x) + asfloat(r0.x));
  {
    precise float sum = -abs(asfloat(r0.x)) + 1.0;
    r0.x = asuint(sum);
  }
  r0.w = asuint(1 + -v1.y);
  r0.w = asuint(v1.y * asfloat(r0.w));
  r0.x = asuint(dot(asfloat(r0.xx), asfloat(r0.ww)));
  r0.w = asuint(-0.00999999978 + asfloat(r0.x));
  r0.w = asuint(saturate(1.35135138 * asfloat(r0.w)));
  r1.x = asuint(mad(asfloat(r0.w), -2.0, 3.0));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r1.x = asuint(dot(asfloat(r0.yz), asfloat(r0.yz)));
  r1.x = asuint(sqrt(asfloat(r1.x)));
  {
    float sinValue = sin(asfloat(r1.x));
    float cosValue = cos(asfloat(r1.x));
    r1.x = asuint(sinValue);
    r2.x = asuint(cosValue);
  }
  r1.xy = asuint(asfloat(r1.xx) * asfloat(r0.zy));
  r0.y = asuint(mad(asfloat(r2.x), asfloat(r0.y), -(asfloat(r1.x))));
  r0.z = asuint(mad(asfloat(r2.x), asfloat(r0.z), asfloat(r1.y)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r0.yz));
  r2.xyzw = asuint(cb1[1].xyzw * cb0[15].xxxx);
  r2.xyzw = asuint(mad(asfloat(r1.xyxy), cb1[4].xyxy, asfloat(r2.xyzw)));
  r0.yz = asuint(floor(asfloat(r2.xy)));
  r1.zw = asuint(frac(asfloat(r2.xy)));
  r2.xy = uint2(0u,0x41000000u);
  r3.x = 0xffffffffu;
  while (true) {
    r3.y = (uint)-(int)((int)1u < (int)r3.x);
    if (r3.y != 0) break;
    r4.y = asuint((float)(int)r3.x);
    r3.yz = r2.xy;
    r3.w = 0xffffffffu;
    while (true) {
      r4.z = (uint)-(int)((int)1u < (int)r3.w);
      if (r4.z != 0) break;
      r4.x = asuint((float)(int)r3.w);
      r4.zw = asuint(asfloat(r4.xy) + asfloat(r0.yz));
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
      r4.xz = asuint(asfloat(r5.xy) + -asfloat(r1.zw));
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
    r2.xy = r3.yz;
    r3.x = (uint)(r3.x + 1u);
  }
  r0.yz = asuint(float2(3,3) * asfloat(r2.zw));
  r1.zw = asuint(floor(asfloat(r0.yz)));
  r0.yz = asuint(frac(asfloat(r0.yz)));
  r2.yzw = uint3(0u,0x41000000u,0xffffffffu);
  while (true) {
    r3.x = (uint)-(int)((int)1u < (int)r2.w);
    if (r3.x != 0) break;
    r3.y = asuint((float)(int)r2.w);
    r3.zw = r2.yz;
    r4.x = 0xffffffffu;
    while (true) {
      r4.y = (uint)-(int)((int)1u < (int)r4.x);
      if (r4.y != 0) break;
      r3.x = asuint((float)(int)r4.x);
      r4.yz = asuint(asfloat(r3.xy) + asfloat(r1.zw));
      r4.w = asuint(dot(asfloat(r4.yz), float2(15.2700005,99.4100037)));
      r4.y = asuint(dot(asfloat(r4.yz), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r4.yw));
    r5.xy = asuint(sinValue);
  }
      r4.yz = asuint(frac(asfloat(r5.xy)));
      r4.yz = asuint(float2(10.7299995,10.7299995) * asfloat(r4.yz));
    {
    float sinValue = sin(asfloat(r4.y));
    r4.y = asuint(sinValue);
  }
      r5.x = asuint(mad(asfloat(r4.y), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r4.z));
    r3.x = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r3.x), 0.5, asfloat(r3.y)));
      r4.yz = asuint(asfloat(r5.xy) + -asfloat(r0.yz));
    {
    precise float2 sum = asfloat(r4.yz) + float2(0.5,0.5);
    r4.yz = asuint(sum);
  }
      r3.x = asuint(dot(asfloat(r4.yz), asfloat(r4.yz)));
      r3.x = asuint(sqrt(asfloat(r3.x)));
      r4.y = (uint)-(int)(asfloat(r3.x) < asfloat(r3.w));
      r3.zw = (r4.yy != 0) ? r3.xx : r3.zw;
      r4.x = (uint)(r4.x + 1u);
    }
    r2.yz = r3.zw;
    r2.w = (uint)(r2.w + 1u);
  }
  r0.y = asuint(asfloat(r2.x) * asfloat(r2.y));
  r0.y = asuint(log2(asfloat(r0.y)));
  r0.y = asuint(0.930000007 * asfloat(r0.y));
  r0.y = asuint(exp2(asfloat(r0.y)));
  r0.y = asuint(-0.119999997 + asfloat(r0.y));
  r0.y = asuint(saturate(3.57142854 * asfloat(r0.y)));
  r0.z = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r0.y = asuint(mad(-(asfloat(r0.z)), asfloat(r0.y), 1.0));
  r0.y = asuint(1 / asfloat(r0.y));
  r0.x = asuint(saturate(asfloat(r0.x) * asfloat(r0.y)));
  r0.y = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.y) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.w) * asfloat(r0.x));
  r0.y = asuint(v1.w * asfloat(r0.x));
  r0.zw = asuint(cb1[4].zw * cb0[15].xx);
  r0.zw = asuint(mad(asfloat(r1.xy), cb1[5].xy, asfloat(r0.zw)));
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.zw), cb0[19].x).xyzw);
  o0.xy = mad(v1.zw, asfloat(r0.xx), asfloat(r1.xy));
  o0.z = 0;
  o0.w = asfloat(r0.y);
  o0.w = saturate(o0.w);
  return;
}