// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

TextureCube<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerComparisonState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb4 : register(b4)
{
  float4 cb4[2];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[12];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[30];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[20];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float3 v1 : INTERP2,
  float4 v2 : INTERP3,
  float4 v3 : INTERP4,
  float4 v4 : INTERP5,
  float4 v5 : INTERP6,
  float3 v6 : INTERP7,
  float3 v7 : INTERP8,
  float3 v8 : INTERP9,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(float2(4,1) * v4.xy);
  r0.xyzw = asuint(mad(cb0[15].xxxx, float4(0.0,1.0,0.0,0.400000006), asfloat(r0.xyxy)));
  r0.xyzw = asuint(float4(4.96000004,4.96000004,7.55000019,7.55000019) * asfloat(r0.xyzw));
  r1.xyzw = asuint(floor(asfloat(r0.xyzw)));
  r0.xyzw = asuint(frac(asfloat(r0.xyzw)));
  r2.xyz = uint3(0u,0x41000000u,0xffffffffu);
  while (true) {
    r2.w = (uint)-(int)((int)1u < (int)r2.z);
    if (r2.w != 0) break;
    r3.y = asuint((float)(int)r2.z);
    r3.zw = r2.xy;
    r2.w = 0xffffffffu;
    while (true) {
      r4.x = (uint)-(int)((int)1u < (int)r2.w);
      if (r4.x != 0) break;
      r3.x = asuint((float)(int)r2.w);
      r4.xy = asuint(asfloat(r3.xy) + asfloat(r1.xy));
      r4.z = asuint(dot(asfloat(r4.xy), float2(15.2700005,99.4100037)));
      r4.x = asuint(dot(asfloat(r4.xy), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r4.xz));
    r5.xy = asuint(sinValue);
  }
      r4.xy = asuint(frac(asfloat(r5.xy)));
      r4.xy = asuint(float2(33.9500008,33.9500008) * asfloat(r4.xy));
    {
    float sinValue = sin(asfloat(r4.x));
    r4.x = asuint(sinValue);
  }
      r5.x = asuint(mad(asfloat(r4.x), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r4.y));
    r3.x = asuint(cosValue);
  }
      r5.y = asuint(mad(asfloat(r3.x), 0.5, asfloat(r3.y)));
      r4.xy = asuint(asfloat(r5.xy) + -asfloat(r0.xy));
    {
    precise float2 sum = asfloat(r4.xy) + float2(0.5,0.5);
    r4.xy = asuint(sum);
  }
      r3.x = asuint(dot(asfloat(r4.xy), asfloat(r4.xy)));
      r3.x = asuint(sqrt(asfloat(r3.x)));
      r4.x = (uint)-(int)(asfloat(r3.x) < asfloat(r3.w));
      r3.zw = (r4.xx != 0) ? r3.xx : r3.zw;
      r2.w = (uint)(r2.w + 1u);
    }
    r2.xy = r3.zw;
    r2.z = (uint)(r2.z + 1u);
  }
  r0.xy = uint2(0u,0x41000000u);
  r1.x = 0xffffffffu;
  while (true) {
    r1.y = (uint)-(int)((int)1u < (int)r1.x);
    if (r1.y != 0) break;
    r3.y = asuint((float)(int)r1.x);
    r2.yz = r0.xy;
    r1.y = 0xffffffffu;
    while (true) {
      r2.w = (uint)-(int)((int)1u < (int)r1.y);
      if (r2.w != 0) break;
      r3.x = asuint((float)(int)r1.y);
      r3.zw = asuint(asfloat(r3.xy) + asfloat(r1.zw));
      r2.w = asuint(dot(asfloat(r3.zw), float2(15.2700005,99.4100037)));
      r3.z = asuint(dot(asfloat(r3.zw), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r2.w));
    r4.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r3.z));
    r4.x = asuint(sinValue);
  }
      r3.zw = asuint(frac(asfloat(r4.xy)));
      r3.zw = asuint(float2(10.7299995,10.7299995) * asfloat(r3.zw));
    {
    float sinValue = sin(asfloat(r3.z));
    r2.w = asuint(sinValue);
  }
      r4.x = asuint(mad(asfloat(r2.w), 0.5, asfloat(r3.x)));
    {
    float cosValue = cos(asfloat(r3.w));
    r2.w = asuint(cosValue);
  }
      r4.y = asuint(mad(asfloat(r2.w), 0.5, asfloat(r3.y)));
      r3.xz = asuint(asfloat(r4.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r3.xz) + float2(0.5,0.5);
    r3.xz = asuint(sum);
  }
      r2.w = asuint(dot(asfloat(r3.xz), asfloat(r3.xz)));
      r2.w = asuint(sqrt(asfloat(r2.w)));
      r3.x = (uint)-(int)(asfloat(r2.w) < asfloat(r2.z));
      r2.yz = (r3.xx != 0) ? r2.ww : r2.yz;
      r1.y = (uint)(r1.y + 1u);
    }
    r0.xy = r2.yz;
    r1.x = (uint)(r1.x + 1u);
  }
  r0.x = asuint(asfloat(r2.x) * asfloat(r0.x));
  r0.x = asuint(log2(asfloat(r0.x)));
  r0.x = asuint(0.930000007 * asfloat(r0.x));
  r0.x = asuint(exp2(asfloat(r0.x)));
  r0.x = asuint(-0.119999997 + asfloat(r0.x));
  r0.x = asuint(saturate(3.57142854 * asfloat(r0.x)));
  r0.y = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.xy = asuint(mad(-(asfloat(r0.yy)), asfloat(r0.xx), float2(1.0,1.5)));
  r0.z = asuint(-0.5 + v4.x);
  r0.z = asuint(asfloat(r0.z) + asfloat(r0.z));
  {
    precise float sum = -abs(asfloat(r0.z)) + 1.0;
    r0.z = asuint(sum);
  }
  r0.z = asuint(v4.y * asfloat(r0.z));
  r0.xy = asuint(float2(1,1) / asfloat(r0.xy));
  r0.x = asuint(saturate(asfloat(r0.z) * asfloat(r0.x)));
  r0.w = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r1.x = asuint(asfloat(r0.w) * asfloat(r0.x));
  r1.xyz = asuint(mad(asfloat(r1.xxx), float3(1.83607006,-0.00931385718,0.0), float3(1.0,0.00931385718,0.0)));
  r1.w = asuint(mad(v4.y, 2.16000009, -0.620000005));
  r0.y = asuint(saturate(asfloat(r1.w) * asfloat(r0.y)));
  r1.w = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r0.y = asuint(asfloat(r1.w) * asfloat(r0.y));
  r2.xyz = asuint(-cb4[1].xyz + cb4[0].xyz);
  r2.xyz = asuint(mad(asfloat(r0.yyy), asfloat(r2.xyz), cb4[1].xyz));
  r2.xyz = asuint(asfloat(r2.xyz) + -asfloat(r1.xyz));
  r1.xyz = asuint(mad(asfloat(r0.yyy), asfloat(r2.xyz), asfloat(r1.xyz)));
  r0.x = asuint(mad(asfloat(r0.w), asfloat(r0.x), -0.0199999996));
  r0.x = asuint(saturate(4.5454545 * asfloat(r0.x)));
  r0.y = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.y) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.z));
  r0.x = asuint(saturate(1.63934422 * asfloat(r0.x)));
  r0.y = asuint(mad(asfloat(r0.x), -2.0, 3.0));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
  r0.x = asuint(asfloat(r0.y) * asfloat(r0.x));
  r0.y = asuint(dot(v7.xyz, v7.xyz));
  r0.y = asuint(rsqrt(asfloat(r0.y)));
  r0.yzw = asuint(v7.xyz * asfloat(r0.yyy));
  r1.w = asuint(dot(v8.xyz, v8.xyz));
  r1.w = asuint(max(1.17549435e-38, asfloat(r1.w)));
  r1.w = asuint(rsqrt(asfloat(r1.w)));
  r2.xyz = asuint(v8.xyz * asfloat(r1.www));
  o0.w = min(1, asfloat(r0.x));
  r0.x = asuint(t1.SampleCmpLevelZero(s1_s, v2.xy, v2.z).x);
  r2.w = asuint(1 + -cb2[29].x);
  r0.x = asuint(mad(asfloat(r0.x), cb2[29].x, asfloat(r2.w)));
  r2.w = (uint)-(int)(0.0 >= v2.z);
  r3.x = (uint)-(int)(v2.z >= 1.0);
  r2.w = (uint)(r2.w | r3.x);
  r0.x = (r2.w != 0) ? 0x3f800000u : r0.x;
  r3.xyz = asuint(-cb0[16].xyz + v6.xyz);
  { precise float lengthSquared = dot(asfloat(r3.xyz), asfloat(r3.xyz)); r2.w = asuint(lengthSquared); }
  r2.w = asuint(saturate(mad(asfloat(r2.w), cb2[29].z, cb2[29].w)));
  r3.x = asuint(1 + -asfloat(r0.x));
  r0.x = asuint(mad(asfloat(r2.w), asfloat(r3.x), asfloat(r0.x)));
  r2.w = (uint)-(int)(cb3[11].y != -1.0);
  if (r2.w != 0) {
    r3.xy = asuint(cb3[1].xy * v6.yy);
    r3.xy = asuint(mad(cb3[0].xy, v6.xx, asfloat(r3.xy)));
    r3.xy = asuint(mad(cb3[2].xy, v6.zz, asfloat(r3.xy)));
    r3.xy = asuint(cb3[3].xy + asfloat(r3.xy));
    r3.xy = asuint(mad(asfloat(r3.xy), float2(0.5,0.5), float2(0.5,0.5)));
    r3.xyzw = asuint(t2.SampleBias(s2_s, asfloat(r3.xy), cb0[19].x).xyzw);
    r4.xy = (uint2)-(int2)(cb3[11].yy == float2(0.0,1.0));
    r2.w = (r4.y != 0) ? r3.w : r3.x;
    r3.xyz = (r4.xxx != 0) ? r3.xyz : r2.www;
  } else {
    r3.xyz = uint3(0x3f800000u,0x3f800000u,0x3f800000u);
  }
  r3.xyz = asuint(cb0[6].xyz * asfloat(r3.xyz));
  r2.w = asuint(dot(-asfloat(r2.xyz), asfloat(r0.yzw)));
  r2.w = asuint(asfloat(r2.w) + asfloat(r2.w));
  r4.xyz = asuint(mad(asfloat(r0.yzw), -(asfloat(r2.www)), -(asfloat(r2.xyz))));
  r2.x = asuint(saturate(dot(asfloat(r0.yzw), asfloat(r2.xyz))));
  r2.x = asuint(1 + -asfloat(r2.x));
  r2.x = asuint(asfloat(r2.x) * asfloat(r2.x));
  r2.x = asuint(asfloat(r2.x) * asfloat(r2.x));
  r4.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r4.xyz), 6).xyzw);
  r2.y = asuint(-1 + asfloat(r4.w));
  r2.y = asuint(mad(cb1[15].w, asfloat(r2.y), 1.0));
  r2.y = asuint(max(0, asfloat(r2.y)));
  r2.y = asuint(log2(asfloat(r2.y)));
  r2.y = asuint(cb1[15].y * asfloat(r2.y));
  r2.y = asuint(exp2(asfloat(r2.y)));
  r2.y = asuint(cb1[15].x * asfloat(r2.y));
  r2.yzw = asuint(asfloat(r2.yyy) * asfloat(r4.xyz));
  r2.x = asuint(mad(asfloat(r2.x), 2.23517418e-08, 0.0399999991));
  r2.x = asuint(0.5 * asfloat(r2.x));
  r0.x = asuint(cb1[11].z * asfloat(r0.x));
  r0.y = asuint(saturate(dot(asfloat(r0.yzw), cb0[5].xyz)));
  r0.x = asuint(asfloat(r0.x) * asfloat(r0.y));
  r0.xyz = asuint(asfloat(r3.xyz) * asfloat(r0.xxx));
  r3.xyz = asuint(mad(v8.xyz, asfloat(r1.www), cb0[5].xyz));
  { precise float lengthSquared = dot(asfloat(r3.xyz), asfloat(r3.xyz)); r0.w = asuint(lengthSquared); }
  r0.w = asuint(max(1.17549435e-38, asfloat(r0.w)));
  r0.w = asuint(rsqrt(asfloat(r0.w)));
  r3.xyz = asuint(asfloat(r3.xyz) * asfloat(r0.www));
  r0.w = asuint(saturate(dot(cb0[5].xyz, asfloat(r3.xyz))));
  r0.w = asuint(asfloat(r0.w) * asfloat(r0.w));
  r0.w = asuint(max(0.100000001, asfloat(r0.w)));
  r0.w = asuint(6.00012016 * asfloat(r0.w));
  r0.w = asuint(1 / asfloat(r0.w));
  r0.w = asuint(0.0399999991 * asfloat(r0.w));
  r0.xyz = asuint(asfloat(r0.www) * asfloat(r0.xyz));
  r0.xyz = asuint(mad(asfloat(r2.yzw), asfloat(r2.xxx), asfloat(r0.xyz)));
  o0.xyz = asfloat(r0.xyz) + asfloat(r1.xyz);
  o0.w = saturate(o0.w);
  return;
}