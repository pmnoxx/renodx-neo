// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s3_s : register(s3);

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
  float4 v3 : INTERP2,
  float4 v4 : INTERP3,
  float3 v5 : INTERP4,
  float3 v6 : INTERP5,
  float3 v7 : INTERP6,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
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
  r0.xy = asuint(float2(5,0.366519153) * cb0[15].xx);
  r1.xyzw = asuint(mad(cb0[15].xxxx, float4(0.350000024,0.350000024,0.699999988,0.699999988), asfloat(r1.xyxy)));
  r0.zw = asuint(float2(3.73000002,3.73000002) * asfloat(r1.xy));
  r1.xy = asuint(floor(asfloat(r0.zw)));
  r0.zw = asuint(frac(asfloat(r0.zw)));
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
    r2.xy = r3.zw;
    r2.z = (uint)(r2.z + 1u);
  }
  r0.z = asuint(0.0399999991 * asfloat(r2.x));
  r0.zw = asuint(mad(v1.xy, asfloat(r0.zz), v1.xy));
  {
    float2 sinValue = sin(asfloat(r0.xy));
    r2.yz = asuint(sinValue);
  }
  r0.x = asuint(1 + asfloat(r2.y));
  r0.x = asuint(0.5 * asfloat(r0.x));
  r0.x = asuint(max(0.0199999996, asfloat(r0.x)));
  r0.x = asuint(min(0.0399999991, asfloat(r0.x)));
  r0.xz = asuint(asfloat(r0.zw) + asfloat(r0.xx));
  {
    precise float2 sum = asfloat(r0.xz) + float2(-0.5,-0.5);
    r0.xz = asuint(sum);
  }
  {
    float cosValue = cos(asfloat(r0.y));
    r2.x = asuint(cosValue);
  }
  r2.xyz = asuint(mad(asfloat(r2.xzz), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r2.xyz = asuint(mad(asfloat(r2.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r1.x = asuint(dot(asfloat(r0.xz), asfloat(r2.xz)));
  r1.y = asuint(dot(asfloat(r0.zx), asfloat(r2.xy)));
  r0.xy = asuint(float2(0.5,0.5) + asfloat(r1.xy));
  r0.xyz = asuint(t1.SampleBias(s1_s, asfloat(r0.xy), cb0[19].x).xyz);
  r1.xy = asuint(asfloat(r1.zw) + asfloat(r1.zw));
  r2.xy = asuint(floor(asfloat(r1.xy)));
  r1.xy = asuint(frac(asfloat(r1.xy)));
  r2.zw = uint2(0u,0x41000000u);
  r0.w = 0xffffffffu;
  while (true) {
    r3.x = (uint)-(int)((int)1u < (int)r0.w);
    if (r3.x != 0) break;
    r3.y = asuint((float)(int)r0.w);
    r3.zw = r2.zw;
    r4.x = 0xffffffffu;
    while (true) {
      r4.y = (uint)-(int)((int)1u < (int)r4.x);
      if (r4.y != 0) break;
      r3.x = asuint((float)(int)r4.x);
      r4.yz = asuint(asfloat(r3.xy) + asfloat(r2.xy));
      r4.w = asuint(dot(asfloat(r4.yz), float2(15.2700005,99.4100037)));
      r4.y = asuint(dot(asfloat(r4.yz), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r4.yw));
    r5.xy = asuint(sinValue);
  }
      r4.yz = asuint(frac(asfloat(r5.xy)));
      r4.yz = asuint(float2(-6.67000008,-6.67000008) * asfloat(r4.yz));
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
      r4.yz = asuint(asfloat(r5.xy) + -asfloat(r1.xy));
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
    r2.zw = r3.zw;
    r0.w = (uint)(r0.w + 1u);
  }
  r0.w = asuint(0.0399999991 * asfloat(r2.z));
  r1.xy = asuint(mad(v1.xy, asfloat(r0.ww), v1.xy));
  r2.xyzw = asuint(float4(0.383972436,3,0.34906584,6) * cb0[15].xxxx);
  r3.xy = asuint(float2(-0.5,-0.5) + asfloat(r1.xy));
  {
    float sinValue = sin(asfloat(r2.x));
    float cosValue = cos(asfloat(r2.x));
    r2.x = asuint(sinValue);
    r4.x = asuint(cosValue);
  }
  r4.yz = r2.xx;
  r4.xyz = asuint(mad(asfloat(r4.xyz), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r4.xyz = asuint(mad(asfloat(r4.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r5.x = asuint(dot(asfloat(r3.xy), asfloat(r4.xz)));
  r5.y = asuint(dot(asfloat(r3.yx), asfloat(r4.xy)));
  r3.xy = asuint(float2(0.5,0.5) + asfloat(r5.xy));
  r3.xyz = asuint(t2.SampleBias(s2_s, asfloat(r3.xy), cb0[19].x).xyz);
  r5.xy = asuint(floor(asfloat(r1.zw)));
  r1.zw = asuint(frac(asfloat(r1.zw)));
  r5.zw = uint2(0u,0x41000000u);
  r0.w = 0xffffffffu;
  while (true) {
    r2.x = (uint)-(int)((int)1u < (int)r0.w);
    if (r2.x != 0) break;
    r6.y = asuint((float)(int)r0.w);
    r6.zw = r5.zw;
    r2.x = 0xffffffffu;
    while (true) {
      r3.w = (uint)-(int)((int)1u < (int)r2.x);
      if (r3.w != 0) break;
      r6.x = asuint((float)(int)r2.x);
      r7.xy = asuint(asfloat(r6.xy) + asfloat(r5.xy));
      r3.w = asuint(dot(asfloat(r7.xy), float2(15.2700005,99.4100037)));
      r4.w = asuint(dot(asfloat(r7.xy), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r3.w));
    r7.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r4.w));
    r7.x = asuint(sinValue);
  }
      r7.xy = asuint(frac(asfloat(r7.xy)));
      r7.xy = asuint(float2(-6.67000008,-6.67000008) * asfloat(r7.xy));
    {
    float sinValue = sin(asfloat(r7.x));
    r3.w = asuint(sinValue);
  }
      r8.x = asuint(mad(asfloat(r3.w), 0.5, asfloat(r6.x)));
    {
    float cosValue = cos(asfloat(r7.y));
    r3.w = asuint(cosValue);
  }
      r8.y = asuint(mad(asfloat(r3.w), 0.5, asfloat(r6.y)));
      r7.xy = asuint(asfloat(r8.xy) + -asfloat(r1.zw));
    {
    precise float2 sum = asfloat(r7.xy) + float2(0.5,0.5);
    r7.xy = asuint(sum);
  }
      r3.w = asuint(dot(asfloat(r7.xy), asfloat(r7.xy)));
      r3.w = asuint(sqrt(asfloat(r3.w)));
      r4.w = (uint)-(int)(asfloat(r3.w) < asfloat(r6.w));
      r6.zw = (r4.ww != 0) ? r3.ww : r6.zw;
      r2.x = (uint)(r2.x + 1u);
    }
    r5.zw = r6.zw;
    r0.w = (uint)(r0.w + 1u);
  }
  r0.w = asuint(0.0399999991 * asfloat(r5.z));
  r1.zw = asuint(mad(v1.xy, asfloat(r0.ww), v1.xy));
  {
    float3 sinValue = sin(asfloat(r2.yzw));
    r5.yzw = asuint(sinValue);
  }
  r2.xy = asuint(float2(1,1) + asfloat(r5.yw));
  r2.xy = asuint(float2(0.5,0.5) * asfloat(r2.xy));
  r2.xy = asuint(min(float2(0.0199999996,0.0149999997), asfloat(r2.xy)));
  r1.zw = asuint(asfloat(r2.xx) + asfloat(r1.zw));
  {
    precise float2 sum = asfloat(r1.zw) + float2(-0.5,-0.5);
    r1.zw = asuint(sum);
  }
  {
    float cosValue = cos(asfloat(r2.z));
    r5.x = asuint(cosValue);
  }
  r2.xzw = asuint(mad(asfloat(r5.xzz), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r2.xzw = asuint(mad(asfloat(r2.xzw), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r5.x = asuint(dot(asfloat(r1.zw), asfloat(r2.xw)));
  r5.y = asuint(dot(asfloat(r1.wz), asfloat(r2.xz)));
  r1.zw = asuint(float2(0.5,0.5) + asfloat(r5.xy));
  r2.xzw = asuint(t0.SampleBias(s0_s, asfloat(r1.zw), cb0[19].x).xyz);
  r2.xzw = asuint(asfloat(r2.xzw) * asfloat(r3.yyy));
  r0.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r3.xxx), asfloat(r2.xzw)));
  r1.xy = asuint(asfloat(r2.yy) + asfloat(r1.xy));
  {
    precise float2 sum = asfloat(r1.xy) + float2(-0.5,-0.5);
    r1.xy = asuint(sum);
  }
  r2.x = asuint(dot(asfloat(r1.xy), asfloat(r4.xz)));
  r2.y = asuint(dot(asfloat(r1.yx), asfloat(r4.xy)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r2.xy));
  r1.xyz = asuint(t3.SampleBias(s3_s, asfloat(r1.xy), cb0[19].x).xyz);
  r0.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r3.zzz), asfloat(r0.xyz)));
  r1.xyz = asuint(-v3.xyz + v2.xyz);
  o0.xyz = mad(asfloat(r0.xyz), asfloat(r1.xyz), v3.xyz);
  o0.w = v4.w * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}