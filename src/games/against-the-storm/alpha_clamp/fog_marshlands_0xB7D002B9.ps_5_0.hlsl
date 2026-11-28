// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[11];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[126];
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
  uint4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
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
  r1.xy = asuint(cb1[6].xx * v2.zx);
  r1.xyzw = asuint(float4(-0.0399999991,-0.0399999991,-0.0299999993,-0.0299999993) * asfloat(r1.xyxy));
  r2.xyz = asuint(t4.SampleBias(s4_s, asfloat(r1.xy), cb0[19].x).xyz);
  r0.w = asuint(0.0500000007 * cb0[15].x);
  r1.xy = asuint(mad(asfloat(r0.ww), cb1[7].xy, asfloat(r1.zw)));
  r1.xyz = asuint(t2.SampleBias(s2_s, asfloat(r1.xy), cb0[19].x).xyz);
  r1.xyz = asuint(asfloat(r2.xyz) * asfloat(r1.xyz));
  r2.xy = asuint(mad(v2.zx, cb1[6].xx, float2(-0.5,-0.5)));
  r3.x = asuint(dot(asfloat(r2.xy), float2(0.52532196,0.850903511)));
  r3.y = asuint(dot(asfloat(r2.xy), float2(-0.850903511,0.52532196)));
  r2.xy = asuint(float2(0.5,0.5) + asfloat(r3.xy));
  r2.zw = asuint(cb1[7].zz * asfloat(r2.xy));
  r3.xyzw = asuint(float4(-0.200000003,-0.200000003,-0.100000001,-0.100000001) * asfloat(r2.xyxy));
  r4.xyzw = asuint(floor(asfloat(r3.xyzw)));
  r3.xyzw = asuint(frac(asfloat(r3.xyzw)));
  r5.xyzw = asuint(asfloat(r3.xyzw) * asfloat(r3.xyzw));
  r3.xyzw = asuint(mad(-(asfloat(r3.xyzw)), float4(2.0,2.0,2.0,2.0), float4(3.0,3.0,3.0,3.0)));
  r6.xyzw = asuint(asfloat(r5.xyzw) * asfloat(r3.xyzw));
  r7.xyzw = asuint(float4(1,0,0,1) + asfloat(r4.xyxy));
  r8.xyzw = asuint(float4(1,1,1,0) + asfloat(r4.xyzw));
  r0.w = asuint(dot(asfloat(r4.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r0.w));
    r0.w = asuint(sinValue);
  }
  r0.w = asuint(43758.5469 * asfloat(r0.w));
  r0.w = asuint(frac(asfloat(r0.w)));
  r1.w = asuint(dot(asfloat(r7.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r1.w));
    r1.w = asuint(sinValue);
  }
  r1.w = asuint(43758.5469 * asfloat(r1.w));
  r1.w = asuint(frac(asfloat(r1.w)));
  r4.x = asuint(dot(asfloat(r7.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.x));
    r4.x = asuint(sinValue);
  }
  r4.x = asuint(43758.5469 * asfloat(r4.x));
  r4.y = asuint(dot(asfloat(r8.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.y));
    r4.y = asuint(sinValue);
  }
  r4.y = asuint(43758.5469 * asfloat(r4.y));
  r4.xy = asuint(frac(asfloat(r4.xy)));
  r3.xyzw = asuint(mad(-(asfloat(r5.xyzw)), asfloat(r3.xyzw), float4(1.0,1.0,1.0,1.0)));
  r1.w = asuint(asfloat(r6.x) * asfloat(r1.w));
  r0.w = asuint(mad(asfloat(r3.x), asfloat(r0.w), asfloat(r1.w)));
  r1.w = asuint(asfloat(r6.x) * asfloat(r4.y));
  r1.w = asuint(mad(asfloat(r3.x), asfloat(r4.x), asfloat(r1.w)));
  r1.w = asuint(asfloat(r6.y) * asfloat(r1.w));
  r0.w = asuint(mad(asfloat(r3.y), asfloat(r0.w), asfloat(r1.w)));
  r5.xyzw = asuint(float4(0,1,1,1) + asfloat(r4.zwzw));
  r1.w = asuint(dot(asfloat(r4.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r1.w));
    r1.w = asuint(sinValue);
  }
  r1.w = asuint(43758.5469 * asfloat(r1.w));
  r1.w = asuint(frac(asfloat(r1.w)));
  r3.x = asuint(dot(asfloat(r8.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.x));
    r3.x = asuint(sinValue);
  }
  r3.x = asuint(43758.5469 * asfloat(r3.x));
  r3.y = asuint(dot(asfloat(r5.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.y));
    r3.y = asuint(sinValue);
  }
  r3.y = asuint(43758.5469 * asfloat(r3.y));
  r3.xy = asuint(frac(asfloat(r3.xy)));
  r4.x = asuint(dot(asfloat(r5.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r4.x));
    r4.x = asuint(sinValue);
  }
  r4.x = asuint(43758.5469 * asfloat(r4.x));
  r4.x = asuint(frac(asfloat(r4.x)));
  r3.x = asuint(asfloat(r6.z) * asfloat(r3.x));
  r1.w = asuint(mad(asfloat(r3.z), asfloat(r1.w), asfloat(r3.x)));
  r3.x = asuint(asfloat(r6.z) * asfloat(r4.x));
  r3.x = asuint(mad(asfloat(r3.z), asfloat(r3.y), asfloat(r3.x)));
  r3.x = asuint(asfloat(r6.w) * asfloat(r3.x));
  r1.w = asuint(mad(asfloat(r3.w), asfloat(r1.w), asfloat(r3.x)));
  r1.w = asuint(0.25 * asfloat(r1.w));
  r0.w = asuint(mad(asfloat(r0.w), 0.125, asfloat(r1.w)));
  r3.xy = asuint(float2(-0.0500000007,-0.0500000007) * asfloat(r2.xy));
  r3.zw = asuint(floor(asfloat(r3.xy)));
  r3.xy = asuint(frac(asfloat(r3.xy)));
  r4.xy = asuint(asfloat(r3.xy) * asfloat(r3.xy));
  r3.xy = asuint(mad(-(asfloat(r3.xy)), float2(2.0,2.0), float2(3.0,3.0)));
  r4.zw = asuint(asfloat(r4.xy) * asfloat(r3.xy));
  r5.xyzw = asuint(float4(1,0,0,1) + asfloat(r3.zwzw));
  r6.xy = asuint(float2(1,1) + asfloat(r3.zw));
  r1.w = asuint(dot(asfloat(r3.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r1.w));
    r1.w = asuint(sinValue);
  }
  r1.w = asuint(43758.5469 * asfloat(r1.w));
  r1.w = asuint(frac(asfloat(r1.w)));
  r3.z = asuint(dot(asfloat(r5.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.z));
    r3.z = asuint(sinValue);
  }
  r3.z = asuint(43758.5469 * asfloat(r3.z));
  r3.w = asuint(dot(asfloat(r5.zw), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r3.w));
    r3.w = asuint(sinValue);
  }
  r3.w = asuint(43758.5469 * asfloat(r3.w));
  r3.zw = asuint(frac(asfloat(r3.zw)));
  r5.x = asuint(dot(asfloat(r6.xy), float2(12.9898005,78.2330017)));
  {
    float sinValue = sin(asfloat(r5.x));
    r5.x = asuint(sinValue);
  }
  r5.x = asuint(43758.5469 * asfloat(r5.x));
  r5.x = asuint(frac(asfloat(r5.x)));
  r3.xy = asuint(mad(-(asfloat(r4.xy)), asfloat(r3.xy), float2(1.0,1.0)));
  r3.z = asuint(asfloat(r4.z) * asfloat(r3.z));
  r1.w = asuint(mad(asfloat(r3.x), asfloat(r1.w), asfloat(r3.z)));
  r3.z = asuint(asfloat(r5.x) * asfloat(r4.z));
  r3.x = asuint(mad(asfloat(r3.x), asfloat(r3.w), asfloat(r3.z)));
  r3.x = asuint(asfloat(r4.w) * asfloat(r3.x));
  r1.w = asuint(mad(asfloat(r3.y), asfloat(r1.w), asfloat(r3.x)));
  r0.w = asuint(mad(asfloat(r1.w), 0.5, asfloat(r0.w)));
  r3.xy = asuint(mad(-(asfloat(r2.xy)), cb1[7].zz, asfloat(r0.ww)));
  r3.xy = asuint(mad(cb0[125].xx, asfloat(r3.xy), asfloat(r2.zw)));
  r0.w = asuint(t5.SampleBias(s5_s, asfloat(r3.xy), cb0[19].x).x);
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r0.www));
  r3.xyz = asuint(cb1[8].xyz * asfloat(r1.xyz));
  r4.xy = asuint(cb1[10].xy * v1.xy);
  r4.xyzw = asuint(t6.SampleBias(s6_s, asfloat(r4.xy), cb0[19].x).xyzw);
  r2.xy = asuint(cb1[6].yy * asfloat(r2.xy));
  r5.xyz = asuint(t1.SampleBias(s1_s, asfloat(r2.xy), cb0[19].x).xyz);
  r2.xyz = asuint(t3.SampleBias(s3_s, asfloat(r2.zw), cb0[19].x).xyz);
  r2.xyz = asuint(mad(asfloat(r5.xyz), float3(0.393621355,0.393621355,0.393621355), asfloat(r2.xyz)));
  r2.xyz = asuint(float3(0.0417492017,0.0859378725,0.0944127738) + asfloat(r2.xyz));
  r2.xyz = asuint(saturate(asfloat(r4.xyz) * asfloat(r2.xyz)));
  r4.xyz = asuint(mad(asfloat(r2.xyz), float3(-2.0,-2.0,-2.0), float3(3.0,3.0,3.0)));
  r2.xyz = asuint(asfloat(r2.xyz) * asfloat(r2.xyz));
  r2.xyz = asuint(asfloat(r4.xyz) * asfloat(r2.xyz));
  r1.xyz = asuint(mad(-(asfloat(r1.xyz)), cb1[8].xyz, cb1[9].xyz));
  o0.xyz = mad(asfloat(r2.xyz), asfloat(r1.xyz), asfloat(r3.xyz));
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r0.w = (uint)-(int)(cb0[21].w == 1.0);
  if (r0.w != 0) {
    r0.w = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).x);
    r1.xy = asuint(mad(asfloat(r0.xy), float2(2.0,2.0), float2(-1.0,-1.0)));
    r2.xyzw = asuint(cb0[78].xyzw * -asfloat(r1.yyyy));
    r1.xyzw = asuint(mad(cb0[77].xyzw, asfloat(r1.xxxx), asfloat(r2.xyzw)));
    r1.xyzw = asuint(mad(cb0[79].xyzw, asfloat(r0.wwww), asfloat(r1.xyzw)));
    r1.xyzw = asuint(cb0[80].xyzw + asfloat(r1.xyzw));
    r1.xyz = asuint(asfloat(r1.xyz) / asfloat(r1.www));
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
  r0.x = asuint(saturate(cb1[10].z * asfloat(r0.x)));
  r0.y = asuint(1 + -cb1[10].w);
  r0.z = asuint(1 + -asfloat(r0.x));
  r0.x = asuint(mad(asfloat(r0.y), asfloat(r0.z), asfloat(r0.x)));
  o0.w = asfloat(r0.x) * asfloat(r4.w);
  o0.w = saturate(o0.w);
  return;
}