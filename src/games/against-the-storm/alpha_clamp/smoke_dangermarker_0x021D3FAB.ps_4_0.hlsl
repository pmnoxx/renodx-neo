// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
cbuffer cb1 : register(b1)
{
  float4 cb1[2];
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
  r1.xyzw = asuint(float4(0.5,0.5,0.5,0.5) + asfloat(r0.yzyz));
  r2.xyzw = asuint(cb1[0].xyzw * cb0[15].xxxx);
  r1.xyzw = asuint(mad(asfloat(r1.xyzw), cb1[1].xyxy, asfloat(r2.xyzw)));
  r0.yz = asuint(floor(asfloat(r1.xy)));
  r1.xy = asuint(frac(asfloat(r1.xy)));
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
      r4.xy = asuint(asfloat(r3.xy) + asfloat(r0.yz));
      r4.z = asuint(dot(asfloat(r4.xy), float2(15.2700005,99.4100037)));
      r4.x = asuint(dot(asfloat(r4.xy), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r4.xz));
    r5.xy = asuint(sinValue);
  }
      r4.xy = asuint(frac(asfloat(r5.xy)));
      r4.xy = asuint(float2(33.9500008,33.9500008) * asfloat(r4.xy));
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
      r4.xy = asuint(asfloat(r5.xy) + -asfloat(r1.xy));
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
  r0.yz = asuint(float2(3,3) * asfloat(r1.zw));
  r1.xy = asuint(floor(asfloat(r0.yz)));
  r0.yz = asuint(frac(asfloat(r0.yz)));
  r1.zw = uint2(0u,0x41000000u);
  r2.y = 0xffffffffu;
  while (true) {
    r2.z = (uint)-(int)((int)1u < (int)r2.y);
    if (r2.z != 0) break;
    r3.y = asuint((float)(int)r2.y);
    r2.zw = r1.zw;
    r3.z = 0xffffffffu;
    while (true) {
      r3.w = (uint)-(int)((int)1u < (int)r3.z);
      if (r3.w != 0) break;
      r3.x = asuint((float)(int)r3.z);
      r4.xy = asuint(asfloat(r3.xy) + asfloat(r1.xy));
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
      r4.xy = asuint(float2(10.7299995,10.7299995) * asfloat(r4.xy));
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
      r3.xw = asuint(asfloat(r5.xy) + -asfloat(r0.yz));
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
    r1.zw = r2.zw;
    r2.y = (uint)(r2.y + 1u);
  }
  r0.y = asuint(asfloat(r2.x) * asfloat(r1.z));
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
  r1.xy = asuint(v1.zw);
  r1.z = asuint(v2.x);
  o0.xyz = asfloat(r1.xyz) * asfloat(r0.xxx);
  o0.w = v2.y * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}