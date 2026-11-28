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
  r1.x = asuint(asfloat(r0.x) * asfloat(r0.w));
  r0.x = asuint(mad(asfloat(r0.x), asfloat(r0.w), -0.00999999978));
  r0.x = asuint(saturate(1.35135138 * asfloat(r0.x)));
  r0.w = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.w) * asfloat(r0.x));
  r0.w = asuint(dot(asfloat(r0.yz), asfloat(r0.yz)));
  r0.w = asuint(sqrt(asfloat(r0.w)));
  {
    float sinValue = sin(asfloat(r0.w));
    float cosValue = cos(asfloat(r0.w));
    r2.x = asuint(sinValue);
    r3.x = asuint(cosValue);
  }
  r1.yz = asuint(asfloat(r2.xx) * asfloat(r0.zy));
  r0.y = asuint(mad(asfloat(r3.x), asfloat(r0.y), -(asfloat(r1.y))));
  r0.z = asuint(mad(asfloat(r3.x), asfloat(r0.z), asfloat(r1.z)));
  r2.xy = asuint(float2(0.5,0.5) + asfloat(r0.yz));
  r3.xyzw = asuint(cb1[1].xyzw * cb0[15].xxxx);
  r3.xyzw = asuint(mad(asfloat(r2.xyxy), cb1[4].xyxy, asfloat(r3.xyzw)));
  r0.yz = asuint(floor(asfloat(r3.xy)));
  r1.yz = asuint(frac(asfloat(r3.xy)));
  r2.zw = uint2(0u,0x41000000u);
  r0.w = 0xffffffffu;
  while (true) {
    r1.w = (uint)-(int)((int)1u < (int)r0.w);
    if (r1.w != 0) break;
    r3.y = asuint((float)(int)r0.w);
    r4.xy = r2.zw;
    r1.w = 0xffffffffu;
    while (true) {
      r4.z = (uint)-(int)((int)1u < (int)r1.w);
      if (r4.z != 0) break;
      r3.x = asuint((float)(int)r1.w);
      r4.zw = asuint(asfloat(r3.xy) + asfloat(r0.yz));
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
      r5.x = asuint(mad(asfloat(r4.z), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r4.w));
    r3.x = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r3.x), 0.5, asfloat(r3.y)));
      r4.zw = asuint(asfloat(r5.xy) + -asfloat(r1.yz));
    {
    precise float2 sum = asfloat(r4.zw) + float2(0.5,0.5);
    r4.zw = asuint(sum);
  }
      r3.x = asuint(dot(asfloat(r4.zw), asfloat(r4.zw)));
      r3.x = asuint(sqrt(asfloat(r3.x)));
      r4.z = (uint)-(int)(asfloat(r3.x) < asfloat(r4.y));
      r4.xy = (r4.zz != 0) ? r3.xx : r4.xy;
      r1.w = (uint)(r1.w + 1u);
    }
    r2.zw = r4.xy;
    r0.w = (uint)(r0.w + 1u);
  }
  r0.yz = asuint(float2(3,3) * asfloat(r3.zw));
  r1.yz = asuint(floor(asfloat(r0.yz)));
  r0.yz = asuint(frac(asfloat(r0.yz)));
  r3.xy = uint2(0u,0x41000000u);
  r0.w = 0xffffffffu;
  while (true) {
    r1.w = (uint)-(int)((int)1u < (int)r0.w);
    if (r1.w != 0) break;
    r4.y = asuint((float)(int)r0.w);
    r3.zw = r3.xy;
    r1.w = 0xffffffffu;
    while (true) {
      r2.w = (uint)-(int)((int)1u < (int)r1.w);
      if (r2.w != 0) break;
      r4.x = asuint((float)(int)r1.w);
      r4.zw = asuint(asfloat(r4.xy) + asfloat(r1.yz));
      r2.w = asuint(dot(asfloat(r4.zw), float2(15.2700005,99.4100037)));
      r4.z = asuint(dot(asfloat(r4.zw), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r2.w));
    r5.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r4.z));
    r5.x = asuint(sinValue);
  }
      r4.zw = asuint(frac(asfloat(r5.xy)));
      r4.zw = asuint(float2(10.7299995,10.7299995) * asfloat(r4.zw));
    {
    float sinValue = sin(asfloat(r4.z));
    r2.w = asuint(sinValue);
  }
      r5.x = asuint(mad(asfloat(r2.w), 0.5, asfloat(r4.x)));
    {
    float cosValue = cos(asfloat(r4.w));
    r2.w = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r2.w), 0.5, asfloat(r4.y)));
      r4.xz = asuint(asfloat(r5.xy) + -asfloat(r0.yz));
    {
    precise float2 sum = asfloat(r4.xz) + float2(0.5,0.5);
    r4.xz = asuint(sum);
  }
      r2.w = asuint(dot(asfloat(r4.xz), asfloat(r4.xz)));
      r2.w = asuint(sqrt(asfloat(r2.w)));
      r4.x = (uint)-(int)(asfloat(r2.w) < asfloat(r3.w));
      r3.zw = (r4.xx != 0) ? r2.ww : r3.zw;
      r1.w = (uint)(r1.w + 1u);
    }
    r3.xy = r3.zw;
    r0.w = (uint)(r0.w + 1u);
  }
  r0.y = asuint(asfloat(r3.x) * asfloat(r2.z));
  r0.y = asuint(log2(asfloat(r0.y)));
  r0.y = asuint(0.930000007 * asfloat(r0.y));
  r0.y = asuint(exp2(asfloat(r0.y)));
  r0.y = asuint(-0.119999997 + asfloat(r0.y));
  r0.y = asuint(saturate(3.57142854 * asfloat(r0.y)));
  r0.z = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r0.y = asuint(mad(-(asfloat(r0.z)), asfloat(r0.y), 1.0));
  r0.y = asuint(1 / asfloat(r0.y));
  r0.y = asuint(saturate(asfloat(r1.x) * asfloat(r0.y)));
  r0.z = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r0.y = asuint(asfloat(r0.z) * asfloat(r0.y));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.y));
  r1.xyzw = asuint(cb1[3].xyzw + -cb1[2].xyzw);
  r0.xyzw = asuint(mad(asfloat(r0.xxxx), asfloat(r1.xyzw), cb1[2].xyzw));
  r1.xy = asuint(cb1[4].zw * cb0[15].xx);
  r1.xy = asuint(mad(asfloat(r2.xy), cb1[5].xy, asfloat(r1.xy)));
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r0.xyzw = asuint(asfloat(r1.xyzw) + asfloat(r0.xyzw));
  r1.xy = asuint(mad(v1.xy, float2(2.0,2.0), float2(-1.0,-1.0)));
  r1.x = asuint(dot(asfloat(r1.xy), asfloat(r1.xy)));
  r1.x = asuint(sqrt(asfloat(r1.x)));
  r1.y = asuint(1 + -asfloat(r1.x));
  r1.z = asuint(ddx(asfloat(r1.x)));
  r1.x = asuint(ddy(asfloat(r1.x)));
  r1.x = asuint(abs(asfloat(r1.z)) + abs(asfloat(r1.x)));
  r1.x = asuint(saturate(asfloat(r1.y) / asfloat(r1.x)));
  r0.xyzw = asuint(asfloat(r1.xxxx) * asfloat(r0.xyzw));
  o0.xyzw = v2.xyzw * asfloat(r0.xyzw);
  o0.w = saturate(o0.w);
  return;
}