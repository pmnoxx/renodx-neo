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
  float4 cb0[16];
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

  {
    float sinValue = sin(cb1[3].w);
    float cosValue = cos(cb1[3].w);
    r0.x = asuint(sinValue);
    r1.x = asuint(cosValue);
  }
  r1.yz = r0.xx;
  r0.xyz = asuint(mad(asfloat(r1.xyz), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r0.w = asuint(cb1[3].x * cb0[15].x);
  r1.xy = asuint(cb1[2].xy * v1.xy);
  r1.zw = asuint(mad(asfloat(r0.ww), cb1[2].zw, asfloat(r1.xy)));
  r1.zw = asuint(float2(-0.5,-0.5) + asfloat(r1.zw));
  r2.x = asuint(dot(asfloat(r1.zw), asfloat(r0.xz)));
  r2.y = asuint(dot(asfloat(r1.wz), asfloat(r0.xy)));
  r0.xy = asuint(float2(0.5,0.5) + asfloat(r2.xy));
  r0.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r0.xy), 0).xyzw);
  r0.w = asuint(0.400000006 + cb1[3].x);
  r0.w = asuint(cb0[15].x * asfloat(r0.w));
  r1.xy = asuint(mad(asfloat(r0.ww), cb1[2].zw, asfloat(r1.xy)));
  r1.xyzw = asuint(t1.SampleLevel(s1_s, asfloat(r1.xy), 0).xyzw);
  r0.xyz = asuint(asfloat(r1.xyz) + asfloat(r0.xyz));
  r2.xy = asuint(float2(-0.5,-0.5) + v1.xy);
  r0.w = asuint(dot(asfloat(r2.xy), float2(-0.999964654,-0.00840735435)));
  r0.w = asuint(0.5 + asfloat(r0.w));
  r0.w = asuint(mad(asfloat(r0.w), 2.0, -1.13));
  r0.w = asuint(saturate(0.740740716 * asfloat(r0.w)));
  r1.w = asuint(mad(asfloat(r0.w), -2.0, 3.0));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(asfloat(r1.w) * asfloat(r0.w));
  r1.xyz = asuint(mad(asfloat(r0.www), float3(0.5,0.5,0.5), asfloat(r1.xyz)));
  r0.xyz = asuint(asfloat(r1.xyz) + asfloat(r0.xyz));
  r1.x = asuint(dot(asfloat(r2.xy), float2(-5.96046448e-08,1)));
  r1.y = asuint(asfloat(r2.x) + asfloat(r2.x));
  {
    precise float sum = -abs(asfloat(r1.y)) + 1.0;
    r1.y = asuint(sum);
  }
  r1.x = asuint(0.5 + asfloat(r1.x));
  r1.x = asuint(asfloat(r1.x) * asfloat(r0.x));
  o0.xyz = v2.xyz * asfloat(r0.xyz);
  r0.x = asuint(mad(asfloat(r1.x), 8.61999989, asfloat(r0.w)));
  r0.x = asuint(log2(asfloat(r0.x)));
  r0.x = asuint(cb1[3].z * asfloat(r0.x));
  r0.x = asuint(exp2(asfloat(r0.x)));
  r0.y = asuint(1 + -v1.y);
  r0.y = asuint(v1.y * asfloat(r0.y));
  r0.y = asuint(dot(asfloat(r1.yy), asfloat(r0.yy)));
  r0.z = asuint(1 / cb1[3].y);
  r0.y = asuint(saturate(asfloat(r0.y) * asfloat(r0.z)));
  r0.z = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r0.y = asuint(asfloat(r0.z) * asfloat(r0.y));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.y));
  r0.x = asuint(v2.w * asfloat(r0.x));
  r0.y = (uint)-(int)(asfloat(r0.x) < 0.0);
  o0.w = asfloat(r0.x);
  if (r0.y != 0) discard;
  o0.w = saturate(o0.w);
  return;
}