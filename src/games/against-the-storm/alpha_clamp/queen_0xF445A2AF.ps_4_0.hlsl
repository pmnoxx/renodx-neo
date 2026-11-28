// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[2];
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
  uint4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  r1.x = (uint)-(int)(asfloat(r0.w) == 0.0);
  if (r1.x != 0) discard;
  r1.xy = asuint(float2(-0.5,-0.5) + v1.yx);
  r1.z = asuint(dot(asfloat(r1.xy), asfloat(r1.xy)));
  r1.z = asuint(sqrt(asfloat(r1.z)));
  r1.z = asuint(asfloat(r1.z) + asfloat(r1.z));
  {
    float sinValue = sin(asfloat(r1.z));
    float cosValue = cos(asfloat(r1.z));
    r2.x = asuint(sinValue);
    r3.x = asuint(cosValue);
  }
  r1.zw = asuint(asfloat(r2.xx) * asfloat(r1.xy));
  r1.y = asuint(mad(asfloat(r3.x), asfloat(r1.y), -(asfloat(r1.z))));
  r1.x = asuint(mad(asfloat(r3.x), asfloat(r1.x), asfloat(r1.w)));
  r2.xy = asuint(float2(0.5,0.5) + asfloat(r1.yx));
  r1.xy = asuint(mad(cb0[15].xx, cb1[1].xx, asfloat(r2.xy)));
  r2.xyzw = asuint(float4(5.0999999,5.0999999,2.54999995,2.54999995) * asfloat(r1.xyxy));
  r3.xyzw = asuint(floor(asfloat(r2.xyzw)));
  r2.xyzw = asuint(frac(asfloat(r2.xyzw)));
  r4.xyzw = asuint(asfloat(r2.xyzw) * asfloat(r2.xyzw));
  r2.xyzw = asuint(mad(-(asfloat(r2.xyzw)), float4(2.0,2.0,2.0,2.0), float4(3.0,3.0,3.0,3.0)));
  r5.xyzw = asuint(asfloat(r4.xyzw) * asfloat(r2.xyzw));
  r6.xyzw = asuint(float4(1,0,0,1) + asfloat(r3.xyxy));
  r7.xyzw = asuint(float4(1,1,1,0) + asfloat(r3.xyzw));
  r1.z = asuint(dot(asfloat(r3.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r1.z));
    r1.z = asuint(sinValue);
  }
  r1.w = asuint(dot(asfloat(r6.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r1.w));
    r1.w = asuint(sinValue);
  }
  r1.xyzw = asuint(float4(1.27499998,1.27499998,43758.5469,43758.5469) * asfloat(r1.xyzw));
  r1.zw = asuint(frac(asfloat(r1.zw)));
  r3.x = asuint(dot(asfloat(r6.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.x));
    r3.x = asuint(sinValue);
  }
  r3.y = asuint(dot(asfloat(r7.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.y));
    r3.y = asuint(sinValue);
  }
  r3.xy = asuint(float2(43758.5469,43758.5469) * asfloat(r3.xy));
  r3.xy = asuint(frac(asfloat(r3.xy)));
  r2.xyzw = asuint(mad(-(asfloat(r4.xyzw)), asfloat(r2.xyzw), float4(1.0,1.0,1.0,1.0)));
  r1.w = asuint(asfloat(r5.x) * asfloat(r1.w));
  r1.z = asuint(mad(asfloat(r2.x), asfloat(r1.z), asfloat(r1.w)));
  r1.w = asuint(asfloat(r5.x) * asfloat(r3.y));
  r1.w = asuint(mad(asfloat(r2.x), asfloat(r3.x), asfloat(r1.w)));
  r1.w = asuint(asfloat(r5.y) * asfloat(r1.w));
  r1.z = asuint(mad(asfloat(r2.y), asfloat(r1.z), asfloat(r1.w)));
  r4.xyzw = asuint(float4(0,1,1,1) + asfloat(r3.zwzw));
  r1.w = asuint(dot(asfloat(r3.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r1.w));
    r1.w = asuint(sinValue);
  }
  r1.w = asuint(43758.5469 * asfloat(r1.w));
  r1.w = asuint(frac(asfloat(r1.w)));
  r2.x = asuint(dot(asfloat(r7.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r2.x));
    r2.x = asuint(sinValue);
  }
  r2.y = asuint(dot(asfloat(r4.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r2.y));
    r2.y = asuint(sinValue);
  }
  r2.xy = asuint(float2(43758.5469,43758.5469) * asfloat(r2.xy));
  r2.xy = asuint(frac(asfloat(r2.xy)));
  r3.x = asuint(dot(asfloat(r4.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.x));
    r3.x = asuint(sinValue);
  }
  r3.x = asuint(43758.5469 * asfloat(r3.x));
  r3.x = asuint(frac(asfloat(r3.x)));
  r2.x = asuint(asfloat(r5.z) * asfloat(r2.x));
  r1.w = asuint(mad(asfloat(r2.z), asfloat(r1.w), asfloat(r2.x)));
  r2.x = asuint(asfloat(r5.z) * asfloat(r3.x));
  r2.x = asuint(mad(asfloat(r2.z), asfloat(r2.y), asfloat(r2.x)));
  r2.x = asuint(asfloat(r5.w) * asfloat(r2.x));
  r1.w = asuint(mad(asfloat(r2.w), asfloat(r1.w), asfloat(r2.x)));
  r1.w = asuint(0.25 * asfloat(r1.w));
  r1.z = asuint(mad(asfloat(r1.z), 0.125, asfloat(r1.w)));
  r2.xy = asuint(floor(asfloat(r1.xy)));
  r1.xy = asuint(frac(asfloat(r1.xy)));
  r2.zw = asuint(asfloat(r1.xy) * asfloat(r1.xy));
  r1.xy = asuint(mad(-(asfloat(r1.xy)), float2(2.0,2.0), float2(3.0,3.0)));
  r3.xy = asuint(asfloat(r2.zw) * asfloat(r1.xy));
  r4.xyzw = asuint(float4(1,0,0,1) + asfloat(r2.xyxy));
  r3.zw = asuint(float2(1,1) + asfloat(r2.xy));
  r1.w = asuint(dot(asfloat(r2.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r1.w));
    r1.w = asuint(sinValue);
  }
  r1.w = asuint(43758.5469 * asfloat(r1.w));
  r1.w = asuint(frac(asfloat(r1.w)));
  r2.x = asuint(dot(asfloat(r4.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r2.x));
    r2.x = asuint(sinValue);
  }
  r2.x = asuint(43758.5469 * asfloat(r2.x));
  r2.y = asuint(dot(asfloat(r4.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r2.y));
    r2.y = asuint(sinValue);
  }
  r2.y = asuint(43758.5469 * asfloat(r2.y));
  r2.xy = asuint(frac(asfloat(r2.xy)));
  r3.z = asuint(dot(asfloat(r3.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.z));
    r3.z = asuint(sinValue);
  }
  r3.z = asuint(43758.5469 * asfloat(r3.z));
  r3.z = asuint(frac(asfloat(r3.z)));
  r1.xy = asuint(mad(-(asfloat(r2.zw)), asfloat(r1.xy), float2(1.0,1.0)));
  r2.x = asuint(asfloat(r3.x) * asfloat(r2.x));
  r1.w = asuint(mad(asfloat(r1.x), asfloat(r1.w), asfloat(r2.x)));
  r2.x = asuint(asfloat(r3.x) * asfloat(r3.z));
  r1.x = asuint(mad(asfloat(r1.x), asfloat(r2.y), asfloat(r2.x)));
  r1.x = asuint(asfloat(r3.y) * asfloat(r1.x));
  r1.x = asuint(mad(asfloat(r1.y), asfloat(r1.w), asfloat(r1.x)));
  r1.x = asuint(mad(asfloat(r1.x), 0.5, asfloat(r1.z)));
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.xx), cb0[19].x).xyzw);
  r2.xyz = asuint(float3(1,1,1) + -asfloat(r0.xyz));
  r2.xyz = asuint(asfloat(r2.xyz) + asfloat(r2.xyz));
  r3.xyz = asuint(float3(1,1,1) + -asfloat(r1.xyz));
  r2.xyz = asuint(mad(-(asfloat(r2.xyz)), asfloat(r3.xyz), float3(1.0,1.0,1.0)));
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r0.xyz));
  r1.xyz = asuint(asfloat(r1.xyz) + asfloat(r1.xyz));
  r3.xyz = (uint3)-(int3)(float3(0.5,0.5,0.5) >= asfloat(r0.xyz));
  r4.xyz = (uint3)(r3.xyz & uint3(0x3f800000u,0x3f800000u,0x3f800000u));
  r3.xyz = (r3.xyz != 0) ? uint3(0u,0u,0u) : uint3(0x3f800000u,0x3f800000u,0x3f800000u);
  r2.xyz = asuint(asfloat(r3.xyz) * asfloat(r2.xyz));
  r1.xyz = asuint(mad(asfloat(r1.xyz), asfloat(r4.xyz), asfloat(r2.xyz)));
  r1.xyz = asuint(asfloat(r1.xyz) + -asfloat(r0.xyz));
  r0.xyz = asuint(mad(asfloat(r1.xyz), float3(0.5,0.5,0.5), asfloat(r0.xyz)));
  o0.xyzw = v2.xyzw * asfloat(r0.xyzw);
  o0.w = saturate(o0.w);
  return;
}