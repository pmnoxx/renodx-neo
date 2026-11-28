// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
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
  float4 v2 : INTERP1,
  float3 v3 : INTERP2,
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  nointerpolation float4 v6 : INTERP5,
  nointerpolation float2 v7 : INTERP6,
  uint v8 : SV_IsFrontFace0,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = asuint(0.0174532924 * v7.x);
  {
    float sinValue = sin(asfloat(r0.x));
    float cosValue = cos(asfloat(r0.x));
    r0.x = asuint(sinValue);
    r1.x = asuint(cosValue);
  }
  r1.yz = r0.xx;
  r0.xyz = asuint(mad(asfloat(r1.xyz), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r0.xyz = asuint(mad(asfloat(r0.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r1.y = asuint(cb0[15].x * v7.y);
  r1.x = asuint(cb0[15].x);
  r1.xy = asuint(float2(0,2) * asfloat(r1.xy));
  r1.xy = asuint(mad(v1.xy, float2(1.0,2.0), asfloat(r1.xy)));
  r1.xy = asuint(float2(-0.5,-0.5) + asfloat(r1.xy));
  r2.x = asuint(dot(asfloat(r1.xy), asfloat(r0.xz)));
  r2.y = asuint(dot(asfloat(r1.yx), asfloat(r0.xy)));
  r0.xy = asuint(float2(0.5,0.5) + asfloat(r2.xy));
  r0.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r0.xy), cb0[19].x).xyzw);
  r1.x = asuint(-cb1[3].x + v1.y);
  {
    precise float sum = asfloat(r1.x) + 0.540000021;
    r1.y = asuint(sum);
  }
  r1.x = asuint(1 + -asfloat(r1.x));
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  o0.w = v6.x * asfloat(r0.w);
  r0.w = asuint(saturate(0.662251651 * asfloat(r1.y)));
  r1.x = asuint(mad(asfloat(r0.w), -2.0, 3.0));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(asfloat(r1.x) * asfloat(r0.w));
  r1.xyz = asuint(cb1[1].xyz + -cb1[0].xyz);
  r1.xyz = asuint(mad(asfloat(r0.www), asfloat(r1.xyz), cb1[0].xyz));
  r1.xyz = asuint(v2.xyz * asfloat(r1.xyz));
  o0.xyz = asfloat(r1.xyz) * asfloat(r0.xyz);
  o0.w = saturate(o0.w);
  return;
}