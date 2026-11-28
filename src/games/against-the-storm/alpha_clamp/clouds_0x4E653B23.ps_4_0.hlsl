// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[7];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[77];
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
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint(cb0[74].xyw * v2.yyy);
  r0.xyz = asuint(mad(cb0[73].xyw, v2.xxx, asfloat(r0.xyz)));
  r0.xyz = asuint(mad(cb0[75].xyw, v2.zzz, asfloat(r0.xyz)));
  r0.xyz = asuint(cb0[76].xyw + asfloat(r0.xyz));
  r0.y = asuint(cb0[17].x * asfloat(r0.y));
  r1.xzw = asuint(float3(0.5,0.5,0.5) * asfloat(r0.xzy));
  r0.xy = asuint(asfloat(r1.xw) + asfloat(r1.zz));
  r0.xy = asuint(asfloat(r0.xy) / asfloat(r0.zz));
  r0.xy = asuint(mad(asfloat(r0.xy), float2(2.0,2.0), float2(-1.0,-1.0)));
  r0.x = asuint(dot(asfloat(r0.xy), asfloat(r0.xy)));
  r0.x = asuint(sqrt(asfloat(r0.x)));
  r0.x = asuint(log2(asfloat(r0.x)));
  r0.x = asuint(cb1[4].y * asfloat(r0.x));
  r0.x = asuint(exp2(asfloat(r0.x)));
  r0.yz = asuint(float2(-0.5,-0.5) + v1.xy);
  r0.y = asuint(dot(asfloat(r0.yz), asfloat(r0.yz)));
  r0.z = asuint(asfloat(r0.y) + asfloat(r0.y));
  r0.y = asuint(3 * asfloat(r0.y));
  r1.xy = asuint(mad(v1.yx, float2(1.0,-1.0), float2(-0.5,0.5)));
  r0.zw = asuint(mad(asfloat(r1.xy), asfloat(r0.zz), v1.xy));
  r1.xy = asuint(mad(asfloat(r1.xy), asfloat(r0.yy), v1.xy));
  r2.xyzw = asuint(cb1[0].zwxy * cb0[15].xxxx);
  r0.yz = asuint(mad(asfloat(r0.zw), cb1[6].xx, asfloat(r2.xy)));
  r1.xy = asuint(mad(asfloat(r1.xy), cb1[6].xx, asfloat(r2.zw)));
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r2.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.yz), cb0[19].x).xyzw);
  r0.yzw = asuint(asfloat(r2.xyz) + asfloat(r1.xyz));
  r0.yzw = asuint(asfloat(r0.yzw) / cb1[1].xxx);
  r0.yzw = asuint(asfloat(r0.yzw) * asfloat(r0.yzw));
  r1.x = asuint(mad(asfloat(r0.y), cb1[4].x, 0.0399999991));
  r0.yzw = asuint(cb1[4].xxx * asfloat(r0.yzw));
  r0.x = asuint(saturate(asfloat(r1.x) * asfloat(r0.x)));
  o0.w = cb1[4].x * asfloat(r0.x);
  r1.xyz = asuint(-cb1[3].xyz + cb1[2].xyz);
  o0.xyz = mad(asfloat(r0.yzw), asfloat(r1.xyz), cb1[3].xyz);
  o0.w = saturate(o0.w);
  return;
}