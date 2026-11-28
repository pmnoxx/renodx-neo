// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

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
  float4 v3 : INTERP2,
  float4 v4 : INTERP3,
  float3 v5 : INTERP4,
  float3 v6 : INTERP5,
  float3 v7 : INTERP6,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyz);
  r0.xyz = asuint(-v2.xxx + asfloat(r0.xyz));
  o0.xyz = v3.xyz * asfloat(r0.xyz);
  r0.x = asuint(v3.w * asfloat(r0.x));
  r0.yz = asuint(mad(cb0[15].xx, float2(0.0,-0.400000006), v1.xy));
  r0.yz = asuint(float2(3,3) * asfloat(r0.yz));
  r1.xy = asuint(floor(asfloat(r0.yz)));
  r0.yz = asuint(frac(asfloat(r0.yz)));
  r1.zw = uint2(0u,0x41000000u);
  r0.w = 0xffffffffu;
  while (true) {
    r2.x = (uint)-(int)((int)1u < (int)r0.w);
    if (r2.x != 0) break;
    r2.y = asuint((float)(int)r0.w);
    r2.zw = r1.zw;
    r3.x = 0xffffffffu;
    while (true) {
      r3.y = (uint)-(int)((int)1u < (int)r3.x);
      if (r3.y != 0) break;
      r2.x = asuint((float)(int)r3.x);
      r3.yz = asuint(asfloat(r2.xy) + asfloat(r1.xy));
      r3.w = asuint(dot(asfloat(r3.yz), float2(15.2700005,99.4100037)));
      r3.y = asuint(dot(asfloat(r3.yz), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r3.yw));
    r4.xy = asuint(sinValue);
  }
      r3.yz = asuint(frac(asfloat(r4.xy)));
      r3.yz = asuint(float2(7.48999977,7.48999977) * asfloat(r3.yz));
    {
    float sinValue = sin(asfloat(r3.y));
    r3.y = asuint(sinValue);
  }
      r4.x = asuint(mad(asfloat(r3.y), 0.5, asfloat(r2.x)));
    {
    float cosValue = cos(asfloat(r3.z));
    r2.x = asuint(cosValue);
  }
      r4.y = asuint(mad(asfloat(r2.x), 0.5, asfloat(r2.y)));
      r3.yz = asuint(asfloat(r4.xy) + -asfloat(r0.yz));
    {
    precise float2 sum = asfloat(r3.yz) + float2(0.5,0.5);
    r3.yz = asuint(sum);
  }
      r2.x = asuint(dot(asfloat(r3.yz), asfloat(r3.yz)));
      r2.x = asuint(sqrt(asfloat(r2.x)));
      r3.y = (uint)-(int)(asfloat(r2.x) < asfloat(r2.w));
      r2.zw = (r3.yy != 0) ? r2.xx : r2.zw;
      r3.x = (uint)(r3.x + 1u);
    }
    r1.zw = r2.zw;
    r0.w = (uint)(r0.w + 1u);
  }
  r0.y = asuint(log2(asfloat(r1.z)));
  r0.y = asuint(1.47000003 * asfloat(r0.y));
  r0.y = asuint(exp2(asfloat(r0.y)));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.y));
  o0.w = v4.x * asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}