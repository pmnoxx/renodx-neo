// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[2];
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
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = asuint(0.540000021 + v1.y);
  r0.x = asuint(saturate(0.662251651 * asfloat(r0.x)));
  r0.y = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.y) * asfloat(r0.x));
  r0.xyz = asuint(mad(asfloat(r0.xxx), float3(-0.515557051,-0.665635824,-0.677590132), float3(0.560452402,0.721982002,0.761529326)));
  r0.w = asuint(0.0174532924 * cb1[1].x);
  {
    float sinValue = sin(asfloat(r0.w));
    float cosValue = cos(asfloat(r0.w));
    r1.x = asuint(sinValue);
    r2.x = asuint(cosValue);
  }
  r2.yz = r1.xx;
  r1.xyz = asuint(mad(asfloat(r2.xyz), float3(0.5,-0.5,0.5), float3(0.5,0.5,0.5)));
  r1.xyz = asuint(mad(asfloat(r1.xyz), float3(2.0,2.0,2.0), float3(-1.0,-1.0,-1.0)));
  r2.xy = asuint(float2(0,-0.200000003) * cb0[15].xx);
  r2.xy = asuint(mad(v1.xy, float2(1.0,2.0), asfloat(r2.xy)));
  r2.xy = asuint(float2(-0.5,-0.5) + asfloat(r2.xy));
  r3.x = asuint(dot(asfloat(r2.xy), asfloat(r1.xz)));
  r3.y = asuint(dot(asfloat(r2.yx), asfloat(r1.xy)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r3.xy));
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.xy), cb0[19].x).xyzw);
  o0.xyz = asfloat(r1.xyz) * asfloat(r0.xyz);
  o0.w = asfloat(r1.x);
  o0.w = saturate(o0.w);
  return;
}