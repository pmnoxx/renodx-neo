// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[6];
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
  uint4 r0,r1,r2,r3,r4;
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
  r0.w = asuint(1 + -v1.y);
  r1.x = asuint(v1.y);
  r1.xy = asuint(mad(cb0[15].xx, float2(-0.5,-0.200000003), asfloat(r1.xx)));
  r1.z = asuint(4 * v1.x);
  r1.xyzw = asuint(float4(-0.5,-0.5,-0.5,-0.5) + asfloat(r1.zxzy));
  r2.x = asuint(dot(asfloat(r1.xy), float2(-5.96046448e-08,1)));
  r2.y = asuint(dot(asfloat(r1.xy), float2(-1,-5.96046448e-08)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r2.xy));
  r2.xyzw = asuint(t1.SampleLevel(s1_s, asfloat(r1.xy), 0).xyzw);
  r1.x = asuint(dot(asfloat(r1.zw), float2(-5.96046448e-08,1)));
  r1.y = asuint(dot(asfloat(r1.zw), float2(-1,-5.96046448e-08)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r1.xy));
  r1.xyzw = asuint(t3.SampleLevel(s3_s, asfloat(r1.xy), 0).xyzw);
  r1.xyz = asuint(mad(asfloat(r2.xyz), asfloat(r1.xyz), asfloat(r0.www)));
  o0.xyz = cb1[4].xyz * asfloat(r1.xyz);
  r1.xy = asuint(float2(-0.5,-0.5) + v1.yx);
  r1.z = asuint(dot(asfloat(r1.xy), asfloat(r1.xy)));
  r1.z = asuint(sqrt(asfloat(r1.z)));
  {
    float sinValue = sin(asfloat(r1.z));
    float cosValue = cos(asfloat(r1.z));
    r2.x = asuint(sinValue);
    r3.x = asuint(cosValue);
  }
  r2.xy = asuint(asfloat(r2.xx) * asfloat(r1.xy));
  r1.w = asuint(mad(asfloat(r3.x), asfloat(r1.y), -(asfloat(r2.x))));
  r2.x = asuint(mad(asfloat(r3.x), asfloat(r1.x), asfloat(r2.y)));
  r3.x = asuint(0.5 + asfloat(r1.w));
  r3.y = asuint(0.5 + asfloat(r2.x));
  r2.xy = asuint(mad(cb0[15].xx, float2(0.0,-0.200000003), asfloat(r3.xy)));
  r2.xy = asuint(float2(-0.5,-0.5) + asfloat(r2.xy));
  r3.x = asuint(dot(asfloat(r2.xy), float2(-5.96046448e-08,1)));
  r3.y = asuint(dot(asfloat(r2.xy), float2(-1,-5.96046448e-08)));
  r2.xy = asuint(float2(0.5,0.5) + asfloat(r3.xy));
  r2.xyzw = asuint(t4.SampleLevel(s4_s, asfloat(r2.xy), 0).xyzw);
  {
    float sinValue = sin(-(asfloat(r1.z)));
    float cosValue = cos(-(asfloat(r1.z)));
    r3.x = asuint(sinValue);
    r4.x = asuint(cosValue);
  }
  r1.zw = asuint(asfloat(r3.xx) * asfloat(r1.xy));
  r1.y = asuint(mad(asfloat(r4.x), asfloat(r1.y), -(asfloat(r1.z))));
  r1.x = asuint(mad(asfloat(r4.x), asfloat(r1.x), asfloat(r1.w)));
  r3.xy = asuint(float2(0.5,0.5) + asfloat(r1.yx));
  r1.xy = asuint(mad(cb0[15].xx, float2(0.0,-0.300000012), asfloat(r3.xy)));
  r1.xy = asuint(float2(-0.5,-0.5) + asfloat(r1.xy));
  r3.x = asuint(dot(asfloat(r1.xy), float2(-5.96046448e-08,1)));
  r3.y = asuint(dot(asfloat(r1.xy), float2(-1,-5.96046448e-08)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r3.xy));
  r1.xyzw = asuint(t2.SampleLevel(s2_s, asfloat(r1.xy), 0).xyzw);
  r1.x = asuint(asfloat(r2.x) * asfloat(r1.x));
  r1.x = asuint(asfloat(r1.x) * asfloat(r0.w));
  r1.x = asuint(log2(asfloat(r1.x)));
  r1.x = asuint(0.330000013 * asfloat(r1.x));
  r1.x = asuint(exp2(asfloat(r1.x)));
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r0.w = asuint(5 * asfloat(r0.w));
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r1.x = (uint)-(int)(cb0[21].w == 1.0);
  if (r1.x != 0) {
    r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
    r1.yz = asuint(mad(asfloat(r0.xy), float2(2.0,2.0), float2(-1.0,-1.0)));
    r2.xyzw = asuint(cb0[78].xyzw * -asfloat(r1.zzzz));
    r2.xyzw = asuint(mad(cb0[77].xyzw, asfloat(r1.yyyy), asfloat(r2.xyzw)));
    r1.xyzw = asuint(mad(cb0[79].xyzw, asfloat(r1.xxxx), asfloat(r2.xyzw)));
    r1.xyzw = asuint(cb0[80].xyzw + asfloat(r1.xyzw));
    r1.xyz = asuint(asfloat(r1.xyz) / asfloat(r1.www));
    r1.y = asuint(cb0[62].z * asfloat(r1.y));
    r1.x = asuint(mad(cb0[61].z, asfloat(r1.x), asfloat(r1.y)));
    r1.x = asuint(mad(cb0[63].z, asfloat(r1.z), asfloat(r1.x)));
    r1.x = asuint(cb0[64].z + asfloat(r1.x));
    r1.x = (r1.x & 0x7fffffffu);
  } else {
    r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
    r0.x = asuint(mad(cb0[20].z, asfloat(r2.x), cb0[20].w));
    r1.x = asuint(1 / asfloat(r0.x));
  }
  r0.x = asuint(asfloat(r1.x) + -asfloat(r0.z));
  r0.x = asuint(saturate(asfloat(r0.x) + asfloat(r0.x)));
  r0.x = asuint(asfloat(r0.w) * asfloat(r0.x));
  o0.w = cb1[5].x * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}