// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
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
  float3 v2 : INTERP1,
  float3 v3 : INTERP2,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(float4(44.7000008,44.7000008,22.3500004,22.3500004) * v1.xyxy);
  r1.xyzw = asuint(floor(asfloat(r0.xyzw)));
  r0.xyzw = asuint(frac(asfloat(r0.xyzw)));
  r2.xyzw = asuint(float4(0,1,1,1) + asfloat(r1.zwzw));
  r2.x = asuint(dot(asfloat(r2.xy), float2(12.9898005,78.2330017)));
  r2.y = asuint(dot(asfloat(r2.zw), float2(12.9898005,78.2330017)));
  {
    float2 sinValue = sin(asfloat(r2.xy));
    r2.xy = asuint(sinValue);
  }
  r2.xy = asuint(float2(43758.5469,43758.5469) * asfloat(r2.xy));
  r2.xy = asuint(frac(asfloat(r2.xy)));
  r3.xyzw = asuint(asfloat(r0.xyzw) * asfloat(r0.xyzw));
  r0.xyzw = asuint(mad(-(asfloat(r0.xyzw)), float4(2.0,2.0,2.0,2.0), float4(3.0,3.0,3.0,3.0)));
  r4.xyzw = asuint(asfloat(r3.xyzw) * asfloat(r0.xyzw));
  r0.xyzw = asuint(mad(-(asfloat(r3.xyzw)), asfloat(r0.xyzw), float4(1.0,1.0,1.0,1.0)));
  r2.y = asuint(asfloat(r4.z) * asfloat(r2.y));
  r2.x = asuint(mad(asfloat(r0.z), asfloat(r2.x), asfloat(r2.y)));
  r2.x = asuint(asfloat(r4.w) * asfloat(r2.x));
  r2.y = asuint(dot(asfloat(r1.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r2.y));
    r2.y = asuint(sinValue);
  }
  r2.y = asuint(43758.5469 * asfloat(r2.y));
  r2.y = asuint(frac(asfloat(r2.y)));
  r3.xyzw = asuint(float4(1,1,1,0) + asfloat(r1.xyzw));
  r1.z = asuint(dot(asfloat(r3.zw), float2(12.9898005,78.2330017)));
  r1.w = asuint(dot(asfloat(r3.xy), float2(12.9898005,78.2330017)));
  {
    float2 sinValue = sin(asfloat(r1.zw));
    r1.zw = asuint(sinValue);
  }
  r1.zw = asuint(float2(43758.5469,43758.5469) * asfloat(r1.zw));
  r1.zw = asuint(frac(asfloat(r1.zw)));
  r1.zw = asuint(asfloat(r4.zx) * asfloat(r1.zw));
  r0.z = asuint(mad(asfloat(r0.z), asfloat(r2.y), asfloat(r1.z)));
  r0.z = asuint(mad(asfloat(r0.w), asfloat(r0.z), asfloat(r2.x)));
  r0.w = asuint(dot(asfloat(r1.xy), float2(12.9898005,78.2330017)));
  r2.xyzw = asuint(float4(1,0,0,1) + asfloat(r1.xyxy));
  {
    float sinValue = sin(asfloat(r0.w));
    r0.w = asuint(sinValue);
  }
  r0.zw = asuint(float2(0.25,43758.5469) * asfloat(r0.zw));
  r0.w = asuint(frac(asfloat(r0.w)));
  r1.x = asuint(dot(asfloat(r2.xy), float2(12.9898005,78.2330017)));
  r1.y = asuint(dot(asfloat(r2.zw), float2(12.9898005,78.2330017)));
  {
    float2 sinValue = sin(asfloat(r1.xy));
    r1.xy = asuint(sinValue);
  }
  r1.xy = asuint(float2(43758.5469,43758.5469) * asfloat(r1.xy));
  r1.xy = asuint(frac(asfloat(r1.xy)));
  r1.y = asuint(mad(asfloat(r0.x), asfloat(r1.y), asfloat(r1.w)));
  r1.xy = asuint(asfloat(r4.xy) * asfloat(r1.xy));
  r0.x = asuint(mad(asfloat(r0.x), asfloat(r0.w), asfloat(r1.x)));
  r0.x = asuint(mad(asfloat(r0.y), asfloat(r0.x), asfloat(r1.y)));
  r0.x = asuint(mad(asfloat(r0.x), 0.125, asfloat(r0.z)));
  r0.yz = asuint(float2(11.1750002,11.1750002) * v1.xy);
  r1.xy = asuint(floor(asfloat(r0.yz)));
  r1.zw = asuint(float2(1,1) + asfloat(r1.xy));
  r0.w = asuint(dot(asfloat(r1.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r0.w));
    r0.w = asuint(sinValue);
  }
  r0.w = asuint(43758.5469 * asfloat(r0.w));
  r0.yzw = asuint(frac(asfloat(r0.yzw)));
  r1.zw = asuint(asfloat(r0.yz) * asfloat(r0.yz));
  r0.yz = asuint(mad(-(asfloat(r0.yz)), float2(2.0,2.0), float2(3.0,3.0)));
  r2.xy = asuint(asfloat(r1.zw) * asfloat(r0.yz));
  r0.yz = asuint(mad(-(asfloat(r1.zw)), asfloat(r0.yz), float2(1.0,1.0)));
  r0.w = asuint(asfloat(r2.x) * asfloat(r0.w));
  r3.xyzw = asuint(float4(1,0,0,1) + asfloat(r1.xyxy));
  r1.x = asuint(dot(asfloat(r1.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r1.x));
    r1.x = asuint(sinValue);
  }
  r1.x = asuint(43758.5469 * asfloat(r1.x));
  r1.y = asuint(dot(asfloat(r3.zw), float2(12.9898005,78.2330017)));
  r1.z = asuint(dot(asfloat(r3.xy), float2(12.9898005,78.2330017)));
  {
    float2 sinValue = sin(asfloat(r1.yz));
    r1.yz = asuint(sinValue);
  }
  r1.yz = asuint(float2(43758.5469,43758.5469) * asfloat(r1.yz));
  r1.xyz = asuint(frac(asfloat(r1.xyz)));
  r1.z = asuint(asfloat(r2.x) * asfloat(r1.z));
  r1.x = asuint(mad(asfloat(r0.y), asfloat(r1.x), asfloat(r1.z)));
  r0.y = asuint(mad(asfloat(r0.y), asfloat(r1.y), asfloat(r0.w)));
  r0.y = asuint(asfloat(r2.y) * asfloat(r0.y));
  r0.y = asuint(mad(asfloat(r0.z), asfloat(r1.x), asfloat(r0.y)));
  r0.x = asuint(mad(asfloat(r0.y), 0.5, asfloat(r0.x)));
  r0.x = asuint(mad(asfloat(r0.x), 2.83999991, cb1[1].x));
  r0.y = asuint(-1.91999996 + asfloat(r0.x));
  o0.w = -1.41999996 + asfloat(r0.x);
  r0.x = (uint)-(int)(asfloat(r0.y) < 0.0);
  if (r0.x != 0) discard;
  r0.x = asuint(dot(v2.xyz, v2.xyz));
  r0.x = asuint(sqrt(asfloat(r0.x)));
  r0.x = asuint(1 / asfloat(r0.x));
  r0.xyz = asuint(v2.xyz * asfloat(r0.xxx));
  { precise float lengthSquared = dot(asfloat(r0.xyz), asfloat(r0.xyz)); r0.w = asuint(lengthSquared); }
  r0.w = asuint(rsqrt(asfloat(r0.w)));
  r0.xyz = asuint(asfloat(r0.xyz) * asfloat(r0.www));
  r0.w = asuint(dot(v3.xyz, v3.xyz));
  r0.w = asuint(rsqrt(asfloat(r0.w)));
  r1.xyz = asuint(v3.xyz * asfloat(r0.www));
  r0.x = asuint(saturate(dot(asfloat(r0.xyz), asfloat(r1.xyz))));
  r0.x = asuint(1 + -asfloat(r0.x));
  r0.x = asuint(log2(asfloat(r0.x)));
  r0.x = asuint(cb1[1].w * asfloat(r0.x));
  r0.x = asuint(exp2(asfloat(r0.x)));
  r0.x = asuint(cb1[1].z * asfloat(r0.x));
  r1.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  o0.xyz = mad(asfloat(r0.xxx), float3(0.915094316,0.353720993,0.0474813096), asfloat(r1.xyz));
  o0.w = saturate(o0.w);
  return;
}