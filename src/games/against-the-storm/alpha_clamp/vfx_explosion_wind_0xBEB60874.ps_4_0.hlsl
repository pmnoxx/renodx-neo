// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
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
  float4 v2 : INTERP1,
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  float3 v6 : INTERP5,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint(cb0[74].xyw * v4.yyy);
  r0.xyz = asuint(mad(cb0[73].xyw, v4.xxx, asfloat(r0.xyz)));
  r0.xyz = asuint(mad(cb0[75].xyw, v4.zzz, asfloat(r0.xyz)));
  r0.xyz = asuint(cb0[76].xyw + asfloat(r0.xyz));
  r1.xz = asuint(float2(0.5,0.5) * asfloat(r0.xz));
  r0.x = asuint(cb0[17].x * asfloat(r0.y));
  r1.w = asuint(0.5 * asfloat(r0.x));
  r0.xy = asuint(asfloat(r1.xw) + asfloat(r1.zz));
  r1.xyzw = asuint(cb1[3].yyxx * cb0[125].xxxx);
  r1.xyzw = asuint(cb1[2].zwxy * asfloat(r1.xyzw));
  r1.xyzw = asuint(mad(v1.xyxy, cb1[1].xyzw, asfloat(r1.xyzw)));
  r0.w = asuint(0.0174532924 * cb1[3].z);
  r1.xyzw = asuint(float4(-0.5,-0.5,-0.5,-0.5) + asfloat(r1.xyzw));
  {
    float sinValue = sin(asfloat(r0.w));
    float cosValue = cos(asfloat(r0.w));
    r2.x = asuint(sinValue);
    r3.x = asuint(cosValue);
  }
  r3.yz = r2.xx;
  r2.xyz = asuint(mad(asfloat(r3.xyz), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r2.xyz = asuint(mad(asfloat(r2.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r3.x = asuint(dot(asfloat(r1.xy), asfloat(r2.xz)));
  r3.y = asuint(dot(asfloat(r1.yx), asfloat(r2.xy)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r3.xy));
  r3.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.x = asuint(dot(asfloat(r1.zw), asfloat(r2.xz)));
  r1.y = asuint(dot(asfloat(r1.wz), asfloat(r2.xy)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r1.xy));
  r1.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.xyz = asuint(asfloat(r3.xyz) + asfloat(r1.xyz));
  r2.xy = asuint(v1.zw);
  r2.z = asuint(v2.x);
  o0.xyz = asfloat(r2.xyz) * asfloat(r1.xyz);
  r1.yz = asuint(float2(0.00999999978,0.0700000003) + v1.yy);
  {
    precise float sum = -(asfloat(r1.z)) + 1.05999994;
    r0.w = asuint(sum);
  }
  r0.w = asuint(saturate(2.22222209 * asfloat(r0.w)));
  r1.z = asuint(mad(asfloat(r0.w), -2.0, 3.0));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(asfloat(r1.z) * asfloat(r0.w));
  r1.y = asuint(saturate(asfloat(r1.y)));
  r1.z = asuint(mad(asfloat(r1.y), -2.0, 3.0));
  r1.y = asuint(asfloat(r1.y) * asfloat(r1.y));
  r1.y = asuint(asfloat(r1.z) * asfloat(r1.y));
  r0.w = asuint(asfloat(r1.y) * asfloat(r0.w));
  r0.w = asuint(log2(asfloat(r0.w)));
  r0.w = asuint(0.709999979 * asfloat(r0.w));
  r0.w = asuint(exp2(asfloat(r0.w)));
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r1.y = (uint)-(int)(cb0[21].w == 1.0);
  if (r1.y != 0) {
    r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
    r1.yz = asuint(mad(asfloat(r0.xy), float2(2.0,2.0), float2(-1.0,-1.0)));
    r3.xyzw = asuint(cb0[78].xyzw * -asfloat(r1.zzzz));
    r3.xyzw = asuint(mad(cb0[77].xyzw, asfloat(r1.yyyy), asfloat(r3.xyzw)));
    r2.xyzw = asuint(mad(cb0[79].xyzw, asfloat(r2.xxxx), asfloat(r3.xyzw)));
    r2.xyzw = asuint(cb0[80].xyzw + asfloat(r2.xyzw));
    r1.yzw = asuint(asfloat(r2.xyz) / asfloat(r2.www));
    r1.z = asuint(cb0[62].z * asfloat(r1.z));
    r1.y = asuint(mad(cb0[61].z, asfloat(r1.y), asfloat(r1.z)));
    r1.y = asuint(mad(cb0[63].z, asfloat(r1.w), asfloat(r1.y)));
    r1.y = asuint(cb0[64].z + asfloat(r1.y));
    r1.y = (r1.y & 0x7fffffffu);
  } else {
    r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
    r0.x = asuint(mad(cb0[20].z, asfloat(r2.x), cb0[20].w));
    r1.y = asuint(1 / asfloat(r0.x));
  }
  r0.x = asuint(saturate(asfloat(r1.y) + -asfloat(r0.z)));
  r0.x = asuint(asfloat(r0.w) * asfloat(r0.x));
  r0.x = asuint(v3.w * asfloat(r0.x));
  o0.w = asfloat(r1.x) * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}