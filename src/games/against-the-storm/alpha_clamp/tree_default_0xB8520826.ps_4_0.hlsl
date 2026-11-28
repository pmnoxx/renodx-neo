// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[8];
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
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  r1.x = asuint(-0.699999988 + asfloat(r0.w));
  r1.x = (uint)-(int)(asfloat(r1.x) < 0.0);
  if (r1.x != 0) discard;
  r1.x = asuint(dot(v3.xyz, v3.xyz));
  r1.x = asuint(sqrt(asfloat(r1.x)));
  r1.x = asuint(1 / asfloat(r1.x));
  r1.xyz = asuint(v3.xyz * asfloat(r1.xxx));
  { precise float lengthSquared = dot(asfloat(r1.xyz), asfloat(r1.xyz)); r1.w = asuint(lengthSquared); }
  r1.w = asuint(rsqrt(asfloat(r1.w)));
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r1.www));
  r1.w = asuint(dot(v4.xyz, v4.xyz));
  r1.w = asuint(rsqrt(asfloat(r1.w)));
  r2.xyz = asuint(v4.xyz * asfloat(r1.www));
  r1.x = asuint(saturate(dot(asfloat(r1.xyz), asfloat(r2.xyz))));
  r1.x = asuint(1 + -asfloat(r1.x));
  r1.x = asuint(log2(asfloat(r1.x)));
  r1.y = asuint(3 * cb0[15].x);
  {
    float sinValue = sin(asfloat(r1.y));
    r1.y = asuint(sinValue);
  }
  r1.y = asuint(mad(asfloat(r1.y), -0.25, 1.0));
  r1.x = asuint(asfloat(r1.y) * asfloat(r1.x));
  r1.x = asuint(exp2(asfloat(r1.x)));
  r1.x = asuint(0.100000001 + asfloat(r1.x));
  r1.y = asuint(cb1[5].y * v2.y);
  r1.y = asuint(mad(cb1[4].y, v2.x, asfloat(r1.y)));
  r1.y = asuint(mad(cb1[6].y, v2.z, asfloat(r1.y)));
  r1.y = asuint(cb1[7].y + asfloat(r1.y));
  {
    precise float sum = -(asfloat(r1.y)) + 3.5;
    r1.y = asuint(sum);
  }
  r1.y = asuint(max(0.5, asfloat(r1.y)));
  r1.y = asuint(min(1, asfloat(r1.y)));
  r1.yzw = asuint(mad(asfloat(r1.yyy), -(cb0[125].xyz), cb0[125].xyz));
  r0.xyz = asuint(asfloat(r1.yzw) + asfloat(r0.xyz));
  o0.w = asfloat(r0.w);
  o0.xyz = mad(asfloat(r1.xxx), cb0[125].xyz, asfloat(r0.xyz));
  o0.w = saturate(o0.w);
  return;
}