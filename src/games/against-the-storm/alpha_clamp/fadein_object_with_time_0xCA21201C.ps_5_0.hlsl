// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

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
  float4 v2 : INTERP1,
  float3 v3 : INTERP2,
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint(cb0[74].xyw * v3.yyy);
  r0.xyz = asuint(mad(cb0[73].xyw, v3.xxx, asfloat(r0.xyz)));
  r0.xyz = asuint(mad(cb0[75].xyw, v3.zzz, asfloat(r0.xyz)));
  r0.xyz = asuint(cb0[76].xyw + asfloat(r0.xyz));
  r1.xz = asuint(float2(0.5,0.5) * asfloat(r0.xz));
  r0.x = asuint(cb0[17].x * asfloat(r0.y));
  r1.w = asuint(0.5 * asfloat(r0.x));
  r0.xy = asuint(asfloat(r1.xw) + asfloat(r1.zz));
  r1.xyzw = asuint(cb1[3].yyxx * cb0[15].xxxx);
  r1.xyzw = asuint(cb1[2].zwxy * asfloat(r1.xyzw));
  r1.xyzw = asuint(mad(v1.xyxy, cb1[1].xyzw, asfloat(r1.xyzw)));
  r2.xyz = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyz);
  r1.xyz = asuint(t1.SampleBias(s1_s, asfloat(r1.zw), cb0[19].x).xyz);
  r1.xyz = asuint(asfloat(r2.xyz) + asfloat(r1.xyz));
  o0.xyz = cb1[4].xyz * asfloat(r1.xyz);
  r1.xyz = asuint(float3(0.00999999978,0.0700000003,-0.5) + v1.yyx);
  {
    precise float sum = -(asfloat(r1.y)) + 1.05999994;
    r0.w = asuint(sum);
  }
  r0.w = asuint(saturate(2.22222209 * asfloat(r0.w)));
  r1.y = asuint(mad(asfloat(r0.w), -2.0, 3.0));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(asfloat(r1.y) * asfloat(r0.w));
  r1.x = asuint(saturate(asfloat(r1.x)));
  r1.y = asuint(mad(asfloat(r1.x), -2.0, 3.0));
  r1.x = asuint(asfloat(r1.x) * asfloat(r1.x));
  r1.x = asuint(asfloat(r1.y) * asfloat(r1.x));
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r0.w = asuint(log2(asfloat(r0.w)));
  r0.w = asuint(0.709999979 * asfloat(r0.w));
  r0.w = asuint(exp2(asfloat(r0.w)));
  r1.x = asuint(asfloat(r1.z) + asfloat(r1.z));
  {
    precise float sum = -abs(asfloat(r1.x)) + 1.0;
    r1.x = asuint(sum);
  }
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r0.w = asuint(cb1[5].x * asfloat(r0.w));
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r1.x = (uint)-(int)(cb0[21].w == 1.0);
  if (r1.x != 0) {
    r1.x = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).x);
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
    r0.x = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).x);
    r0.x = asuint(mad(cb0[20].z, asfloat(r0.x), cb0[20].w));
    r1.x = asuint(1 / asfloat(r0.x));
  }
  r0.x = asuint(saturate(asfloat(r1.x) + -asfloat(r0.z)));
  r0.x = asuint(asfloat(r0.w) * asfloat(r0.x));
  o0.w = v2.w * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}