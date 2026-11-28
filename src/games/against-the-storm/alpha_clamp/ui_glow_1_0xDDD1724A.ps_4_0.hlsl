// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[5];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[132];
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
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = asuint(float4(-0.5,-0.5,-0.5,-0.5) + v1.xyxy);
  r0.x = asuint(dot(asfloat(r0.xyzw), asfloat(r0.xyzw)));
  r0.yz = asuint(mad(v1.yx, float2(1.0,-1.0), float2(-0.5,0.5)));
  r0.xy = asuint(mad(asfloat(r0.yz), asfloat(r0.xx), v1.xy));
  r1.x = asuint(v1.w);
  r1.y = asuint(v2.x);
  r0.xy = asuint(mad(asfloat(r0.xy), float2(5.0,1.0), asfloat(r1.xy)));
  r0.zw = asuint(floor(asfloat(r0.xy)));
  r0.xy = asuint(frac(asfloat(r0.xy)));
  r1.xyz = uint3(0u,0x41000000u,0xffffffffu);
  while (true) {
    r1.w = (uint)-(int)((int)1u < (int)r1.z);
    if (r1.w != 0) break;
    r2.y = asuint((float)(int)r1.z);
    r2.zw = r1.xy;
    r1.w = 0xffffffffu;
    while (true) {
      r3.x = (uint)-(int)((int)1u < (int)r1.w);
      if (r3.x != 0) break;
      r2.x = asuint((float)(int)r1.w);
      r3.xy = asuint(asfloat(r2.xy) + asfloat(r0.zw));
      r3.z = asuint(dot(asfloat(r3.xy), float2(15.2700005,99.4100037)));
      r3.x = asuint(dot(asfloat(r3.xy), float2(47.6300011,89.9800034)));
    {
    float2 sinValue = sin(asfloat(r3.xz));
    r4.xy = asuint(sinValue);
  }
      r3.xy = asuint(frac(asfloat(r4.xy)));
      r3.xy = asuint(float2(10.0699997,10.0699997) * asfloat(r3.xy));
    {
    float sinValue = sin(asfloat(r3.x));
    r3.x = asuint(sinValue);
  }
      r4.x = asuint(mad(asfloat(r3.x), 0.5, asfloat(r2.x)));
    {
    float cosValue = cos(asfloat(r3.y));
    r2.x = asuint(cosValue);
  }
      r4.y = asuint(mad(asfloat(r2.x), 0.5, asfloat(r2.y)));
      r3.xy = asuint(asfloat(r4.xy) + -asfloat(r0.xy));
    {
    precise float2 sum = asfloat(r3.xy) + float2(0.5,0.5);
    r3.xy = asuint(sum);
  }
      r2.x = asuint(dot(asfloat(r3.xy), asfloat(r3.xy)));
      r2.x = asuint(sqrt(asfloat(r2.x)));
      r3.x = (uint)-(int)(asfloat(r2.x) < asfloat(r2.w));
      r2.zw = (r3.xx != 0) ? r2.xx : r2.zw;
      r1.w = (uint)(r1.w + 1u);
    }
    r1.xy = r2.zw;
    r1.z = (uint)(r1.z + 1u);
  }
  r0.xy = asuint(float2(-0.289999992,-0.379999995) + asfloat(r1.xx));
  r0.xy = asuint(saturate(float2(1.75438583,2.94117618) * asfloat(r0.xy)));
  r0.zw = asuint(mad(asfloat(r0.xy), float2(-2.0,-2.0), float2(3.0,3.0)));
  r0.xy = asuint(asfloat(r0.xy) * asfloat(r0.xy));
  r0.xy = asuint(asfloat(r0.zw) * asfloat(r0.xy));
  r1.xyzw = asuint(float4(0.495230556,0.2719253,0.0489835069,0) * asfloat(r0.yyyy));
  r0.xyzw = asuint(mad(asfloat(r0.xxxx), float4(0.334180772,0.229606509,0.0694079325,0.0), asfloat(r1.xyzw)));
  r1.xyzw = asuint(t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw);
  r1.xyzw = asuint(float4(1,1,1,1) + -asfloat(r1.xyzw));
  r1.xyzw = asuint(log2(asfloat(r1.xyzw)));
  r1.xyzw = asuint(v1.zzzz * asfloat(r1.xyzw));
  r1.xyzw = asuint(exp2(asfloat(r1.xyzw)));
  r1.xyzw = asuint(cb1[2].xyzw * asfloat(r1.xyzw));
  r2.xyzw = asuint(t1.SampleBias(s1_s, v1.xy, cb0[19].x).xyzw);
  r1.xyzw = asuint(mad(asfloat(r1.xyzw), cb1[3].yyyy, asfloat(r2.xyzw)));
  r0.xyzw = asuint(mad(asfloat(r0.xyzw), cb1[4].xxxx, asfloat(r1.xyzw)));
  r0.xyzw = asuint(v3.xyzw * asfloat(r0.xyzw));
  r1.x = (uint)-(int)(asfloat(r0.w) == 0.0);
  if (r1.x != 0) discard;
  r1.xy = asuint(v4.xy / v4.ww);
  r2.xyzw = asuint(t2.SampleBias(s2_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.z = asuint(dot(cb0[126].xyzw, cb0[126].xyzw));
  r1.z = (uint)-(int)(asfloat(r1.z) != 0.0);
  r3.xyzw = asuint(float4(1,1,1,1) + -cb0[127].xyzw);
  r1.w = asuint(dot(asfloat(r3.xyzw), cb0[126].xyzw));
  r3.xyz = asuint(asfloat(r2.xyz) * asfloat(r1.www));
  r2.xyz = (r1.zzz != 0) ? r3.xyz : r2.xyz;
  r1.xyzw = asuint(t3.SampleBias(s3_s, asfloat(r1.xy), cb0[19].x).xyzw);
  r1.w = asuint(dot(cb0[129].xyzw, cb0[129].xyzw));
  r1.w = (uint)-(int)(asfloat(r1.w) != 0.0);
  r3.xyzw = asuint(float4(1,1,1,1) + -cb0[130].xyzw);
  r2.w = asuint(dot(asfloat(r3.xyzw), cb0[129].xyzw));
  r3.xyz = asuint(asfloat(r2.www) * asfloat(r1.xyz));
  r1.xyz = (r1.www != 0) ? r3.xyz : r1.xyz;
  r3.xyz = asuint(cb0[128].xxx * asfloat(r1.xyz));
  r1.xyz = asuint(cb0[128].yyy * asfloat(r1.xyz));
  r3.xyz = asuint(mad(asfloat(r2.xyz), cb0[125].xxx, asfloat(r3.xyz)));
  r1.xyz = asuint(mad(asfloat(r2.xyz), cb0[125].yyy, asfloat(r1.xyz)));
  r1.xyz = asuint(mad(asfloat(r0.xyz), asfloat(r3.xyz), asfloat(r1.xyz)));
  r1.xyz = asuint(mad(cb0[131].xxx, asfloat(r1.xyz), -(asfloat(r0.xyz))));
  r1.w = 0u;
  r0.xyzw = asuint(mad(cb0[131].yyyy, asfloat(r1.xyzw), asfloat(r0.xyzw)));
  o0.xyzw = max(float4(0,0,0,0), asfloat(r0.xyzw));
  o0.w = saturate(o0.w);
  return;
}