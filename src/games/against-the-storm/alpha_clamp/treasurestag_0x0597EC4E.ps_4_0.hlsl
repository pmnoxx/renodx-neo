// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[5];
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
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

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
  r0.xy = asuint(cb1[2].yx * asfloat(r0.xx));
  r0.xy = asuint(exp2(asfloat(r0.xy)));
  r0.z = asuint(0.5 + -asfloat(r0.y));
  r0.z = (uint)-(int)(asfloat(r0.z) < 0.0);
  if (r0.z != 0) discard;
  r1.xyz = asuint(float3(1,1,1) + -cb1[3].xyz);
  r2.xyz = asuint(float3(1,1,1) + -cb1[4].xyz);
  r1.xyz = asuint(mad(-(asfloat(r1.xyz)), asfloat(r2.xyz), -(cb1[4].xyz)));
  r1.xyz = asuint(float3(1,1,1) + asfloat(r1.xyz));
  r1.xyz = asuint(mad(asfloat(r0.xxx), asfloat(r1.xyz), cb1[4].xyz));
  r0.xzw = asuint(asfloat(r1.xyz) * asfloat(r0.xxx));
  o0.w = 1 + -asfloat(r0.y);
  r0.y = (uint)-(int)(cb1[2].y < 5.0);
  r0.y = (uint)(r0.y & 0x3f800000u);
  r0.xyz = asuint(asfloat(r0.xzw) * asfloat(r0.yyy));
  r1.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  o0.xyz = mad(asfloat(r1.xyz), cb1[1].xyz, asfloat(r0.xyz));
  o0.w = saturate(o0.w);
  return;
}