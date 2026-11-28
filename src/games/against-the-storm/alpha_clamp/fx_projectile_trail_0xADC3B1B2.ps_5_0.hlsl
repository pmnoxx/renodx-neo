// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[8];
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
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  float3 v5 : INTERP4,
  float3 v6 : INTERP5,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(float2(-0.5,-0.5) + v1.xy);
  r0.z = asuint(dot(asfloat(r0.xxyy), asfloat(r0.xxyy)));
  r1.xyzw = asuint(mad(v1.yxyx, float4(1.0,-1.0,1.0,-1.0), float4(-0.5,0.5,-0.5,0.5)));
  r1.xyzw = asuint(mad(asfloat(r1.xyzw), asfloat(r0.zzzz), v1.xyxy));
  r1.xyzw = asuint(mad(cb0[15].xxxx, float4(0.430000007,-0.200000003,0.430000007,-0.200000003), asfloat(r1.xyzw)));
  r1.xyzw = asuint(float4(1.5,1.5,1.77999997,1.77999997) * asfloat(r1.xyzw));
  r2.xyzw = asuint(floor(asfloat(r1.xyzw)));
  r1.xyzw = asuint(frac(asfloat(r1.xyzw)));
  r0.zw = uint2(0u,0x41000000u);
  r3.x = 0xffffffffu;
  while (true) {
    r3.y = (uint)-(int)((int)1u < (int)r3.x);
    if (r3.y != 0) break;
    r4.y = asuint((float)(int)r3.x);
    r3.yz = r0.zw;
    r3.w = 0xffffffffu;
    while (true) {
      r4.z = (uint)-(int)((int)1u < (int)r3.w);
      if (r4.z != 0) break;
      r4.x = asuint((float)(int)r3.w);
      r4.zw = asuint(asfloat(r4.xy) + asfloat(r2.xy));
      r5.x = asuint(dot(asfloat(r4.zw), float2(15.2700005,99.4100037)));
      r4.z = asuint(dot(asfloat(r4.zw), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r5.x));
    r5.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r4.z));
    r5.x = asuint(sinValue);
  }
      r4.zw = asuint(frac(asfloat(r5.xy)));
      r4.zw = asuint(asfloat(r4.zw) + asfloat(r4.zw));
    {
    float sinValue = sin(asfloat(r4.z));
    r4.z = asuint(sinValue);
  }
      r5.x = asuint(mad(asfloat(r4.z), 0.5, asfloat(r4.x)));
    {
    float cosValue = cos(asfloat(r4.w));
    r4.x = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r4.x), 0.5, asfloat(r4.y)));
      r4.xz = asuint(asfloat(r5.xy) + -asfloat(r1.xy));
    {
    precise float2 sum = asfloat(r4.xz) + float2(0.5,0.5);
    r4.xz = asuint(sum);
  }
      r4.x = asuint(dot(asfloat(r4.xz), asfloat(r4.xz)));
      r4.x = asuint(sqrt(asfloat(r4.x)));
      r4.z = (uint)-(int)(asfloat(r4.x) < asfloat(r3.z));
      r3.yz = (r4.zz != 0) ? r4.xx : r3.yz;
      r3.w = (uint)(r3.w + 1u);
    }
    r0.zw = r3.yz;
    r3.x = (uint)(r3.x + 1u);
  }
  r1.xy = uint2(0u,0x41000000u);
  r0.w = 0xffffffffu;
  while (true) {
    r2.x = (uint)-(int)((int)1u < (int)r0.w);
    if (r2.x != 0) break;
    r2.y = asuint((float)(int)r0.w);
    r3.xy = r1.xy;
    r3.z = 0xffffffffu;
    while (true) {
      r3.w = (uint)-(int)((int)1u < (int)r3.z);
      if (r3.w != 0) break;
      r2.x = asuint((float)(int)r3.z);
      r4.xy = asuint(asfloat(r2.xy) + asfloat(r2.zw));
      r3.w = asuint(dot(asfloat(r4.xy), float2(15.2700005,99.4100037)));
      r4.x = asuint(dot(asfloat(r4.xy), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r3.w));
    r5.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r4.x));
    r5.x = asuint(sinValue);
  }
      r4.xy = asuint(frac(asfloat(r5.xy)));
      r4.xy = asuint(float2(6.96999979,6.96999979) * asfloat(r4.xy));
    {
    float sinValue = sin(asfloat(r4.x));
    r3.w = asuint(sinValue);
  }
      r5.x = asuint(mad(asfloat(r3.w), 0.5, asfloat(r2.x)));
    {
    float cosValue = cos(asfloat(r4.y));
    r2.x = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r2.x), 0.5, asfloat(r2.y)));
      r4.xy = asuint(asfloat(r5.xy) + -asfloat(r1.zw));
    {
    precise float2 sum = asfloat(r4.xy) + float2(0.5,0.5);
    r4.xy = asuint(sum);
  }
      r2.x = asuint(dot(asfloat(r4.xy), asfloat(r4.xy)));
      r2.x = asuint(sqrt(asfloat(r2.x)));
      r3.w = (uint)-(int)(asfloat(r2.x) < asfloat(r3.y));
      r3.xy = (r3.ww != 0) ? r2.xx : r3.xy;
      r3.z = (uint)(r3.z + 1u);
    }
    r1.xy = r3.xy;
    r0.w = (uint)(r0.w + 1u);
  }
  r0.z = asuint(asfloat(r1.x) + asfloat(r0.z));
  r0.zw = asuint(-v2.xy + asfloat(r0.zz));
  r0.zw = asuint(mad(cb1[7].yy, asfloat(r0.zw), v2.xy));
  r1.x = asuint(cb1[4].x * cb0[15].x);
  r0.zw = asuint(cb1[3].xy * asfloat(r0.zw));
  r1.xy = asuint(mad(asfloat(r1.xx), cb1[3].zw, asfloat(r0.zw)));
  r1.xyz = asuint(t0.SampleLevel(s0_s, asfloat(r1.xy), 0).xyz);
  r1.w = asuint(0.400000006 + cb1[4].x);
  r1.w = asuint(cb0[15].x * asfloat(r1.w));
  r0.zw = asuint(mad(asfloat(r1.ww), cb1[3].zw, asfloat(r0.zw)));
  r2.xyz = asuint(t1.SampleLevel(s1_s, asfloat(r0.zw), 0).xyz);
  r1.xyz = asuint(asfloat(r2.xyz) + asfloat(r1.xyz));
  r0.y = asuint(dot(asfloat(r0.xy), float2(-0.999964654,-0.00840735435)));
  r0.y = asuint(0.5 + asfloat(r0.y));
  r0.z = asuint(mad(asfloat(r0.y), 2.0, -1.13));
  r0.z = asuint(saturate(0.740740716 * asfloat(r0.z)));
  r0.w = asuint(mad(asfloat(r0.z), -2.0, 3.0));
  r0.z = asuint(asfloat(r0.z) * asfloat(r0.z));
  r0.z = asuint(asfloat(r0.w) * asfloat(r0.z));
  r2.xyz = asuint(mad(asfloat(r0.zzz), float3(0.5,0.5,0.5), asfloat(r2.xyz)));
  r1.xyz = asuint(asfloat(r2.xyz) + asfloat(r1.xyz));
  r0.w = asuint(dot(v1.xx, cb1[7].xx));
  r2.xyz = asuint(cb1[6].xyz + -cb1[5].xyz);
  r2.xyz = asuint(mad(asfloat(r0.www), asfloat(r2.xyz), cb1[5].xyz));
  r1.yzw = asuint(asfloat(r2.xyz) * asfloat(r1.xyz));
  o0.xyz = v3.xyz * asfloat(r1.yzw);
  r0.y = asuint(asfloat(r1.x) * asfloat(r0.y));
  r0.y = asuint(mad(asfloat(r0.y), 8.61999989, asfloat(r0.z)));
  r0.y = asuint(log2(asfloat(r0.y)));
  r0.y = asuint(cb1[7].z * asfloat(r0.y));
  r0.y = asuint(exp2(asfloat(r0.y)));
  r0.x = asuint(asfloat(r0.x) + asfloat(r0.x));
  {
    precise float sum = -abs(asfloat(r0.x)) + 1.0;
    r0.x = asuint(sum);
  }
  r0.z = asuint(1 + -v1.y);
  r0.z = asuint(v1.y * asfloat(r0.z));
  r0.x = asuint(dot(asfloat(r0.xx), asfloat(r0.zz)));
  r0.z = asuint(1 / cb1[4].y);
  r0.x = asuint(saturate(asfloat(r0.x) * asfloat(r0.z)));
  r0.z = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.z) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.y) * asfloat(r0.x));
  r0.x = asuint(cb1[7].w * asfloat(r0.x));
  r0.x = asuint(v3.w * asfloat(r0.x));
  r0.y = (uint)-(int)(asfloat(r0.x) < 0.0);
  if (r0.y != 0) discard;
  o0.w = asfloat(r0.x);
  o0.w = saturate(o0.w);
  return;
}