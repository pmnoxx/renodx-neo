// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[8];
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
  uint4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
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
  r2.xy = asuint(mad(v2.zx, cb1[1].xx, float2(-0.5,-0.5)));
  {
    float sinValue = sin(cb1[7].z);
    float cosValue = cos(cb1[7].z);
    r3.x = asuint(sinValue);
    r4.x = asuint(cosValue);
  }
  r4.yz = r3.xx;
  r3.xyz = asuint(mad(asfloat(r4.xyz), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r3.xyz = asuint(mad(asfloat(r3.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r4.x = asuint(dot(asfloat(r2.xy), asfloat(r3.xz)));
  r4.y = asuint(dot(asfloat(r2.yx), asfloat(r3.xy)));
  r2.xy = asuint(float2(0.5,0.5) + asfloat(r4.xy));
  r0.w = asuint(cb1[2].w * cb0[15].x);
  r2.zw = asuint(cb1[3].xy * asfloat(r0.ww));
  r2.zw = asuint(mad(asfloat(r2.xy), cb1[1].yy, asfloat(r2.zw)));
  r0.w = asuint(cb1[1].z * cb0[15].x);
  r3.xyzw = asuint(mad(cb1[1].zzzz, cb0[15].xxxx, asfloat(r2.xyxy)));
  r3.xyzw = asuint(cb1[7].yyyy * asfloat(r3.xyzw));
  r4.xy = asuint(floor(asfloat(r3.zw)));
  r4.zw = asuint(frac(asfloat(r3.zw)));
  r5.xy = asuint(asfloat(r4.zw) * asfloat(r4.zw));
  r4.zw = asuint(mad(-(asfloat(r4.zw)), float2(2.0,2.0), float2(3.0,3.0)));
  r5.zw = asuint(asfloat(r5.xy) * asfloat(r4.zw));
  r6.xyzw = asuint(float4(1,0,0,1) + asfloat(r4.xyxy));
  r7.xy = asuint(float2(1,1) + asfloat(r4.xy));
  r4.x = asuint(dot(asfloat(r4.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.x));
    r4.x = asuint(sinValue);
  }
  r4.x = asuint(43758.5469 * asfloat(r4.x));
  r4.y = asuint(dot(asfloat(r6.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.y));
    r4.y = asuint(sinValue);
  }
  r4.y = asuint(43758.5469 * asfloat(r4.y));
  r4.xy = asuint(frac(asfloat(r4.xy)));
  r6.x = asuint(dot(asfloat(r6.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r6.x));
    r6.x = asuint(sinValue);
  }
  r6.x = asuint(43758.5469 * asfloat(r6.x));
  r6.y = asuint(dot(asfloat(r7.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r6.y));
    r6.y = asuint(sinValue);
  }
  r6.y = asuint(43758.5469 * asfloat(r6.y));
  r6.xy = asuint(frac(asfloat(r6.xy)));
  r4.zw = asuint(mad(-(asfloat(r5.xy)), asfloat(r4.zw), float2(1.0,1.0)));
  r4.y = asuint(asfloat(r5.z) * asfloat(r4.y));
  r4.x = asuint(mad(asfloat(r4.z), asfloat(r4.x), asfloat(r4.y)));
  r4.y = asuint(asfloat(r6.y) * asfloat(r5.z));
  r4.y = asuint(mad(asfloat(r4.z), asfloat(r6.x), asfloat(r4.y)));
  r4.y = asuint(asfloat(r5.w) * asfloat(r4.y));
  r4.x = asuint(mad(asfloat(r4.w), asfloat(r4.x), asfloat(r4.y)));
  r3.xyzw = asuint(float4(0.5,0.5,0.25,0.25) * asfloat(r3.xyzw));
  r5.xyzw = asuint(floor(asfloat(r3.xyzw)));
  r3.xyzw = asuint(frac(asfloat(r3.xyzw)));
  r6.xyzw = asuint(asfloat(r3.xyzw) * asfloat(r3.xyzw));
  r3.xyzw = asuint(mad(-(asfloat(r3.xyzw)), float4(2.0,2.0,2.0,2.0), float4(3.0,3.0,3.0,3.0)));
  r7.xyzw = asuint(asfloat(r6.xyzw) * asfloat(r3.xyzw));
  r8.xyzw = asuint(float4(1,0,0,1) + asfloat(r5.xyxy));
  r9.xyzw = asuint(float4(1,1,1,0) + asfloat(r5.xyzw));
  r4.y = asuint(dot(asfloat(r5.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.y));
    r4.y = asuint(sinValue);
  }
  r4.y = asuint(43758.5469 * asfloat(r4.y));
  r4.z = asuint(dot(asfloat(r8.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.z));
    r4.z = asuint(sinValue);
  }
  r4.z = asuint(43758.5469 * asfloat(r4.z));
  r4.w = asuint(dot(asfloat(r8.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.w));
    r4.w = asuint(sinValue);
  }
  r4.w = asuint(43758.5469 * asfloat(r4.w));
  r4.yzw = asuint(frac(asfloat(r4.yzw)));
  r5.x = asuint(dot(asfloat(r9.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r5.x));
    r5.x = asuint(sinValue);
  }
  r5.x = asuint(43758.5469 * asfloat(r5.x));
  r5.x = asuint(frac(asfloat(r5.x)));
  r3.xyzw = asuint(mad(-(asfloat(r6.xyzw)), asfloat(r3.xyzw), float4(1.0,1.0,1.0,1.0)));
  r4.z = asuint(asfloat(r7.x) * asfloat(r4.z));
  r4.y = asuint(mad(asfloat(r3.x), asfloat(r4.y), asfloat(r4.z)));
  r4.z = asuint(asfloat(r7.x) * asfloat(r5.x));
  r3.x = asuint(mad(asfloat(r3.x), asfloat(r4.w), asfloat(r4.z)));
  r3.x = asuint(asfloat(r7.y) * asfloat(r3.x));
  r3.x = asuint(mad(asfloat(r3.y), asfloat(r4.y), asfloat(r3.x)));
  r3.x = asuint(0.25 * asfloat(r3.x));
  r3.x = asuint(mad(asfloat(r4.x), 0.125, asfloat(r3.x)));
  r4.xyzw = asuint(float4(0,1,1,1) + asfloat(r5.zwzw));
  r3.y = asuint(dot(asfloat(r5.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.y));
    r3.y = asuint(sinValue);
  }
  r3.y = asuint(43758.5469 * asfloat(r3.y));
  r3.y = asuint(frac(asfloat(r3.y)));
  r5.x = asuint(dot(asfloat(r9.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r5.x));
    r5.x = asuint(sinValue);
  }
  r5.x = asuint(43758.5469 * asfloat(r5.x));
  r5.x = asuint(frac(asfloat(r5.x)));
  r4.x = asuint(dot(asfloat(r4.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.x));
    r4.x = asuint(sinValue);
  }
  r4.x = asuint(43758.5469 * asfloat(r4.x));
  r4.y = asuint(dot(asfloat(r4.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.y));
    r4.y = asuint(sinValue);
  }
  r4.y = asuint(43758.5469 * asfloat(r4.y));
  r4.xy = asuint(frac(asfloat(r4.xy)));
  r4.z = asuint(asfloat(r7.z) * asfloat(r5.x));
  r3.y = asuint(mad(asfloat(r3.z), asfloat(r3.y), asfloat(r4.z)));
  r4.y = asuint(asfloat(r7.z) * asfloat(r4.y));
  r3.z = asuint(mad(asfloat(r3.z), asfloat(r4.x), asfloat(r4.y)));
  r3.z = asuint(asfloat(r7.w) * asfloat(r3.z));
  r3.y = asuint(mad(asfloat(r3.w), asfloat(r3.y), asfloat(r3.z)));
  r3.x = asuint(mad(asfloat(r3.y), 0.5, asfloat(r3.x)));
  r3.yz = asuint(asfloat(r3.xx) + -asfloat(r2.zw));
  r2.zw = asuint(mad(cb1[7].xx, asfloat(r3.yz), asfloat(r2.zw)));
  r3.yzw = asuint(t2.SampleBias(s2_s, asfloat(r2.zw), cb0[19].x).xyz);
  r2.zw = asuint(cb1[2].xy * asfloat(r0.ww));
  r2.xy = asuint(mad(asfloat(r2.xy), cb1[2].zz, asfloat(r2.zw)));
  r2.zw = asuint(asfloat(r3.xx) + -asfloat(r2.xy));
  r2.xy = asuint(mad(cb1[7].xx, asfloat(r2.zw), asfloat(r2.xy)));
  r2.xyz = asuint(t2.SampleBias(s2_s, asfloat(r2.xy), cb0[19].x).xyz);
  r1.xyz = asuint(saturate(mad(asfloat(r1.xyz), asfloat(r3.yzw), asfloat(r2.xyz))));
  r2.xyz = asuint(mad(asfloat(r1.xyz), float3(-2.0,-2.0,-2.0), float3(3.0,3.0,3.0)));
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r1.xyz));
  r1.xyz = asuint(asfloat(r2.xyz) * asfloat(r1.xyz));
  r2.xyz = asuint(cb1[5].xyz + -cb1[4].xyz);
  o0.xyz = mad(asfloat(r1.xyz), asfloat(r2.xyz), cb1[4].xyz);
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r0.w = (uint)-(int)(cb0[21].w == 1.0);
  if (r0.w != 0) {
    r0.w = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).x);
    r1.xy = asuint(mad(asfloat(r0.xy), float2(2.0,2.0), float2(-1.0,-1.0)));
    r2.xyzw = asuint(cb0[78].xyzw * -asfloat(r1.yyyy));
    r2.xyzw = asuint(mad(cb0[77].xyzw, asfloat(r1.xxxx), asfloat(r2.xyzw)));
    r2.xyzw = asuint(mad(cb0[79].xyzw, asfloat(r0.wwww), asfloat(r2.xyzw)));
    r2.xyzw = asuint(cb0[80].xyzw + asfloat(r2.xyzw));
    r1.xyz = asuint(asfloat(r2.xyz) / asfloat(r2.www));
    r0.w = asuint(cb0[62].z * asfloat(r1.y));
    r0.w = asuint(mad(cb0[61].z, asfloat(r1.x), asfloat(r0.w)));
    r0.w = asuint(mad(cb0[63].z, asfloat(r1.z), asfloat(r0.w)));
    r0.w = asuint(cb0[64].z + asfloat(r0.w));
    r0.w = (r0.w & 0x7fffffffu);
  } else {
    r0.x = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).x);
    r0.x = asuint(mad(cb0[20].z, asfloat(r0.x), cb0[20].w));
    r0.w = asuint(1 / asfloat(r0.x));
  }
  r0.x = asuint(asfloat(r0.w) + -asfloat(r0.z));
  r0.x = asuint(saturate(1.14999998 * asfloat(r0.x)));
  o0.w = asfloat(r0.x) * asfloat(r1.w);
  o0.w = saturate(o0.w);
  return;
}