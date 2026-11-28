// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[5];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[129];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(float2(-0.5,-0.5) + v1.xy);
  r0.z = asuint(dot(asfloat(r0.xy), asfloat(r0.xy)));
  r0.z = asuint(asfloat(r0.z) * asfloat(r0.z));
  r0.z = asuint(10 * asfloat(r0.z));
  r0.xy = asuint(mad(asfloat(r0.xy), asfloat(r0.zz), v1.xy));
  r0.zw = asuint(cb1[3].zw + asfloat(r0.xy));
  r0.zw = asuint(float2(0.349999994,0.349999994) * asfloat(r0.zw));
  r1.xy = asuint(floor(asfloat(r0.zw)));
  r0.zw = asuint(frac(asfloat(r0.zw)));
  r1.zw = uint2(0u,0x41000000u);
  r2.x = 0xffffffffu;
  while (true) {
    r2.y = (uint)-(int)((int)1u < (int)r2.x);
    if (r2.y != 0) break;
    r3.y = asuint((float)(int)r2.x);
    r2.yz = r1.zw;
    r2.w = 0xffffffffu;
    while (true) {
      r3.z = (uint)-(int)((int)1u < (int)r2.w);
      if (r3.z != 0) break;
      r3.x = asuint((float)(int)r2.w);
      r3.zw = asuint(asfloat(r3.xy) + asfloat(r1.xy));
      r4.x = asuint(dot(asfloat(r3.zw), float2(15.2700005,99.4100037)));
      r3.z = asuint(dot(asfloat(r3.zw), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r4.x));
    r4.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r3.z));
    r4.x = asuint(sinValue);
  }
      r3.zw = asuint(frac(asfloat(r4.xy)));
      r3.zw = asuint(asfloat(r3.zw) + asfloat(r3.zw));
    {
    float sinValue = sin(asfloat(r3.z));
    r3.z = asuint(sinValue);
  }
      r4.x = asuint(mad(asfloat(r3.z), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r3.w));
    r3.x = asuint(cosValue);
  }
      r4.y = asuint(mad(asfloat(r3.x), 0.5, asfloat(r3.y)));
      r3.xz = asuint(asfloat(r4.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r3.xz) + float2(0.5,0.5);
    r3.xz = asuint(sum);
  }
      r3.x = asuint(dot(asfloat(r3.xz), asfloat(r3.xz)));
      r3.x = asuint(sqrt(asfloat(r3.x)));
      r3.z = (uint)-(int)(asfloat(r3.x) < asfloat(r2.z));
      r2.yz = (r3.zz != 0) ? r3.xx : r2.yz;
      r2.w = (uint)(r2.w + 1u);
    }
    r1.zw = r2.yz;
    r2.x = (uint)(r2.x + 1u);
  }
  r0.zw = asuint(float2(-0.409999996,-0.560000002) + asfloat(r1.zz));
  r0.zw = asuint(saturate(float2(3.99999952,6.24999905) * asfloat(r0.zw)));
  r1.xy = asuint(mad(asfloat(r0.zw), float2(-2.0,-2.0), float2(3.0,3.0)));
  r0.zw = asuint(asfloat(r0.zw) * asfloat(r0.zw));
  r0.zw = asuint(asfloat(r1.xy) * asfloat(r0.zw));
  r1.xyzw = asuint(float4(1,1,0.410607636,0) * asfloat(r0.wwww));
  r1.xyzw = asuint(mad(asfloat(r0.zzzz), float4(1.88689435,0.634780824,0.0155769009,0.0), asfloat(r1.xyzw)));
  r2.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  r2.xyzw = asuint(float4(1,1,1,1) + -asfloat(r2.xyzw));
  r2.xyzw = asuint(log2(asfloat(r2.xyzw)));
  r2.xyzw = asuint(cb1[3].xxxx * asfloat(r2.xyzw));
  r2.xyzw = asuint(exp2(asfloat(r2.xyzw)));
  r2.xyzw = asuint(cb1[2].xyzw * asfloat(r2.xyzw));
  r0.xy = asuint(mad(asfloat(r0.xy), float2(0.5,0.5), float2(0.25,0.25)));
  r0.xy = asuint(-v1.xy + asfloat(r0.xy));
  r0.xy = asuint(mad(cb1[4].yy, asfloat(r0.xy), v1.xy));
  r0.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r0.xy), cb0[19].x).xyzw);
  r0.xyzw = asuint(mad(asfloat(r2.xyzw), cb1[3].yyyy, asfloat(r0.xyzw)));
  r0.xyzw = asuint(mad(asfloat(r1.xyzw), cb1[4].xxxx, asfloat(r0.xyzw)));
  r1.x = asuint(cb1[4].z * v2.w);
  r0.xyzw = asuint(asfloat(r1.xxxx) * asfloat(r0.xyzw));
  r0.xyzw = asuint(v2.xyzw * asfloat(r0.xyzw));
  r1.x = (uint)-(int)(asfloat(r0.w) == 0.0);
  if (r1.x != 0) discard;
  r1.xy = asuint(v3.xy / v3.ww);
  r1.xyzw = asuint(t2.SampleBias(s2_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.w = asuint(dot(cb0[126].xyzw, cb0[126].xyzw));
  r1.w = (uint)-(int)(asfloat(r1.w) != 0.0);
  r2.xyzw = asuint(float4(1,1,1,1) + -cb0[127].xyzw);
  r2.x = asuint(dot(asfloat(r2.xyzw), cb0[126].xyzw));
  r2.xyz = asuint(asfloat(r2.xxx) * asfloat(r1.xyz));
  r1.xyz = (r1.www != 0) ? r2.xyz : r1.xyz;
  r2.xyz = asuint(cb0[125].xxx * asfloat(r1.xyz));
  r1.xyz = asuint(cb0[125].yyy * asfloat(r1.xyz));
  r1.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r2.xyz), asfloat(r1.xyz)));
  r1.xyz = asuint(mad(cb0[128].xxx, asfloat(r1.xyz), -(asfloat(r0.xyz))));
  r1.w = 0u;
  r0.xyzw = asuint(mad(cb0[128].yyyy, asfloat(r1.xyzw), asfloat(r0.xyzw)));
  o0.xyzw = max(float4(0,0,0,0), asfloat(r0.xyzw));
  o0.w = saturate(o0.w);
  return;
}