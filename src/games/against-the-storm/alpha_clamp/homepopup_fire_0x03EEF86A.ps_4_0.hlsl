// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

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
  uint4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(float4(-0.5,-0.5,-0.5,-0.5) + v1.xyxy);
  r0.xy = asuint(asfloat(r0.xy) + asfloat(r0.xy));
  {
    precise float2 sum = -abs(asfloat(r0.xy)) + float2(1.0,1.0);
    r0.xy = asuint(sum);
  }
  r0.xy = asuint(mad(asfloat(r0.xx), asfloat(r0.yy), float2(-0.00999999978,-0.0199999996)));
  r0.xy = asuint(saturate(float2(1.35135138,1.09890103) * asfloat(r0.xy)));
  r1.xy = asuint(mad(asfloat(r0.xy), float2(-2.0,-2.0), float2(3.0,3.0)));
  r0.xy = asuint(asfloat(r0.xy) * asfloat(r0.xy));
  r0.xy = asuint(asfloat(r1.xy) * asfloat(r0.xy));
  r1.xyzw = asuint(float4(0,-2,0,-1) * cb0[15].xxxx);
  r1.xyzw = asuint(mad(v1.xyxy, float4(2.0,1.0,2.0,1.0), asfloat(r1.xyzw)));
  r2.xyzw = asuint(t1.SampleBias(s1_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.xyzw = asuint(t0.SampleBias(s0_s, asfloat(r1.zw), cb0[19].x).xyzw);
  r2.xyz = asuint(asfloat(r2.xyz) + asfloat(r1.xyz));
  r1.w = asuint(dot(asfloat(r0.zw), asfloat(r0.zw)));
  r1.w = asuint(sqrt(asfloat(r1.w)));
  {
    float sinValue = sin(asfloat(r1.w));
    float cosValue = cos(asfloat(r1.w));
    r3.x = asuint(sinValue);
    r4.x = asuint(cosValue);
  }
  r3.xy = asuint(asfloat(r3.xx) * asfloat(r0.wz));
  r0.z = asuint(mad(asfloat(r4.x), asfloat(r0.z), -(asfloat(r3.x))));
  r0.w = asuint(mad(asfloat(r4.x), asfloat(r0.w), asfloat(r3.y)));
  r3.xy = asuint(float2(0.5,0.5) + asfloat(r0.zw));
  r0.zw = asuint(mad(cb0[15].xx, float2(0.0,-2.0), asfloat(r3.xy)));
  r3.zw = asuint(floor(asfloat(r0.zw)));
  r0.zw = asuint(frac(asfloat(r0.zw)));
  r4.xy = uint2(0u,0x41000000u);
  r1.w = 0xffffffffu;
  while (true) {
    r2.w = (uint)-(int)((int)1u < (int)r1.w);
    if (r2.w != 0) break;
    r5.y = asuint((float)(int)r1.w);
    r4.zw = r4.xy;
    r2.w = 0xffffffffu;
    while (true) {
      r5.z = (uint)-(int)((int)1u < (int)r2.w);
      if (r5.z != 0) break;
      r5.x = asuint((float)(int)r2.w);
      r5.zw = asuint(asfloat(r5.xy) + asfloat(r3.zw));
      r6.x = asuint(dot(asfloat(r5.zw), float2(15.2700005,99.4100037)));
      r5.z = asuint(dot(asfloat(r5.zw), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r6.x));
    r6.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r5.z));
    r6.x = asuint(sinValue);
  }
      r5.zw = asuint(frac(asfloat(r6.xy)));
      r5.zw = asuint(float2(33.9500008,33.9500008) * asfloat(r5.zw));
    {
    float sinValue = sin(asfloat(r5.z));
    r5.z = asuint(sinValue);
  }
      r6.x = asuint(mad(asfloat(r5.z), 0.5, asfloat(r5.x)));
    {
    float cosValue = cos(asfloat(r5.w));
    r5.x = asuint(cosValue);
  }
      r6.y = asuint(mad(asfloat(r5.x), 0.5, asfloat(r5.y)));
      r5.xz = asuint(asfloat(r6.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r5.xz) + float2(0.5,0.5);
    r5.xz = asuint(sum);
  }
      r5.x = asuint(dot(asfloat(r5.xz), asfloat(r5.xz)));
      r5.x = asuint(sqrt(asfloat(r5.x)));
      r5.z = (uint)-(int)(asfloat(r5.x) < asfloat(r4.w));
      r4.zw = (r5.zz != 0) ? r5.xx : r4.zw;
      r2.w = (uint)(r2.w + 1u);
    }
    r4.xy = r4.zw;
    r1.w = (uint)(r1.w + 1u);
  }
  r3.xyzw = asuint(mad(cb0[15].xxxx, float4(0.0,-1.5,1.0,0.0), asfloat(r3.xyxy)));
  r0.zw = asuint(float2(3,3) * asfloat(r3.xy));
  r3.xy = asuint(floor(asfloat(r0.zw)));
  r0.zw = asuint(frac(asfloat(r0.zw)));
  r4.yz = uint2(0u,0x41000000u);
  r1.w = 0xffffffffu;
  while (true) {
    r2.w = (uint)-(int)((int)1u < (int)r1.w);
    if (r2.w != 0) break;
    r5.y = asuint((float)(int)r1.w);
    r5.zw = r4.yz;
    r2.w = 0xffffffffu;
    while (true) {
      r4.w = (uint)-(int)((int)1u < (int)r2.w);
      if (r4.w != 0) break;
      r5.x = asuint((float)(int)r2.w);
      r6.xy = asuint(asfloat(r5.xy) + asfloat(r3.xy));
      r4.w = asuint(dot(asfloat(r6.xy), float2(15.2700005,99.4100037)));
      r6.x = asuint(dot(asfloat(r6.xy), float2(47.6300011,89.9800034)));
    {
    float sinValue = sin(asfloat(r4.w));
    r7.y = asuint(sinValue);
  }
    {
    float sinValue = sin(asfloat(r6.x));
    r7.x = asuint(sinValue);
  }
      r6.xy = asuint(frac(asfloat(r7.xy)));
      r6.xy = asuint(float2(10.7299995,10.7299995) * asfloat(r6.xy));
    {
    float sinValue = sin(asfloat(r6.x));
    r4.w = asuint(sinValue);
  }
      r7.x = asuint(mad(asfloat(r4.w), 0.5, asfloat(r5.x)));
    {
    float cosValue = cos(asfloat(r6.y));
    r4.w = asuint(cosValue);
  }
      r7.y = asuint(mad(asfloat(r4.w), 0.5, asfloat(r5.y)));
      r6.xy = asuint(asfloat(r7.xy) + -asfloat(r0.zw));
    {
    precise float2 sum = asfloat(r6.xy) + float2(0.5,0.5);
    r6.xy = asuint(sum);
  }
      r4.w = asuint(dot(asfloat(r6.xy), asfloat(r6.xy)));
      r4.w = asuint(sqrt(asfloat(r4.w)));
      r5.x = (uint)-(int)(asfloat(r4.w) < asfloat(r5.w));
      r5.zw = (r5.xx != 0) ? r4.ww : r5.zw;
      r2.w = (uint)(r2.w + 1u);
    }
    r4.yz = r5.zw;
    r1.w = (uint)(r1.w + 1u);
  }
  r0.z = asuint(asfloat(r4.x) * asfloat(r4.y));
  r0.z = asuint(log2(asfloat(r0.z)));
  r0.z = asuint(0.930000007 * asfloat(r0.z));
  r0.z = asuint(exp2(asfloat(r0.z)));
  r0.z = asuint(-0.119999997 + asfloat(r0.z));
  r0.z = asuint(saturate(3.57142854 * asfloat(r0.z)));
  r0.w = asuint(mad(asfloat(r0.z), -2.0, 3.0));
  r0.z = asuint(asfloat(r0.z) * asfloat(r0.z));
  r0.z = asuint(mad(-(asfloat(r0.w)), asfloat(r0.z), 1.07000005));
  r1.xyz = asuint(mad(asfloat(r0.yyy), asfloat(r1.xyz), float3(0.0700000003,0.0700000003,0.0700000003)));
  r0.y = asuint(1 / asfloat(r0.z));
  r0.yzw = asuint(saturate(asfloat(r1.xyz) * asfloat(r0.yyy)));
  r1.xyz = asuint(mad(asfloat(r0.yzw), float3(-2.0,-2.0,-2.0), float3(3.0,3.0,3.0)));
  r0.yzw = asuint(asfloat(r0.yzw) * asfloat(r0.yzw));
  r0.yzw = asuint(asfloat(r1.xyz) * asfloat(r0.yzw));
  r0.yzw = asuint(asfloat(r0.xxx) * asfloat(r0.yzw));
  r0.yzw = asuint(float3(3.22580647,1,1) * asfloat(r0.yzw));
  r0.yzw = asuint(min(float3(1,1,1), asfloat(r0.yzw)));
  r1.xyz = asuint(mad(asfloat(r0.yzw), float3(-2.0,-2.0,-2.0), float3(3.0,3.0,3.0)));
  r0.yzw = asuint(asfloat(r0.yzw) * asfloat(r0.yzw));
  r0.yzw = asuint(asfloat(r1.xyz) * asfloat(r0.yzw));
  r0.xyz = asuint(mad(asfloat(r0.xxx), asfloat(r2.xyz), asfloat(r0.yzw)));
  r0.yzw = asuint(mad(asfloat(r0.xyz), float3(0.450980425,0.286527991,-0.0164641608), float3(0.549019575,0.0,0.0164641608)));
  r1.xyzw = asuint(t2.SampleBias(s2_s, asfloat(r3.zw), cb0[19].x).xyzw);
  r2.xyzw = asuint(asfloat(r1.xyzx) + asfloat(r0.yzwx));
  r0.xyzw = asuint(v2.xyzw * asfloat(r2.xyzw));
  r1.x = (uint)-(int)(asfloat(r0.w) == 0.0);
  if (r1.x != 0) discard;
  r1.xy = asuint(v3.xy / v3.ww);
  r1.xyzw = asuint(t3.SampleBias(s3_s, asfloat(r1.xy), cb0[19].x).xyzw);
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