// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:01 2026
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[3];
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
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(mad(v1.xy, float2(2.0,2.0), float2(-1.0,-1.0)));
  r0.xy = asuint(float2(1.15470052,-1.00408745) * asfloat(r0.xy));
  r0.z = asuint(min(abs(asfloat(r0.x)), abs(asfloat(r0.y))));
  r0.w = asuint(max(abs(asfloat(r0.x)), abs(asfloat(r0.y))));
  r0.w = asuint(1 / asfloat(r0.w));
  r0.z = asuint(asfloat(r0.z) * asfloat(r0.w));
  r0.w = asuint(asfloat(r0.z) * asfloat(r0.z));
  r1.x = asuint(mad(asfloat(r0.w), 0.0208350997, -0.0851330012));
  r1.x = asuint(mad(asfloat(r0.w), asfloat(r1.x), 0.180141002));
  r1.x = asuint(mad(asfloat(r0.w), asfloat(r1.x), -0.330299497));
  r0.w = asuint(mad(asfloat(r0.w), asfloat(r1.x), 0.999866009));
  r1.x = asuint(asfloat(r0.z) * asfloat(r0.w));
  r1.y = (uint)-(int)(abs(asfloat(r0.y)) < abs(asfloat(r0.x)));
  r1.x = asuint(mad(asfloat(r1.x), -2.0, 1.57079637));
  r1.x = (uint)(r1.y & r1.x);
  r0.z = asuint(mad(asfloat(r0.z), asfloat(r0.w), asfloat(r1.x)));
  r0.w = (uint)-(int)(asfloat(r0.y) < -(asfloat(r0.y)));
  r0.w = (uint)(r0.w & 0xc0490fdbu);
  r0.z = asuint(asfloat(r0.z) + asfloat(r0.w));
  r0.w = asuint(min(asfloat(r0.x), asfloat(r0.y)));
  r1.x = asuint(max(asfloat(r0.x), asfloat(r0.y)));
  r0.w = (uint)-(int)(asfloat(r0.w) < -(asfloat(r0.w)));
  r1.x = (uint)-(int)(asfloat(r1.x) >= -(asfloat(r1.x)));
  r0.w = (uint)(r0.w & r1.x);
  r0.z = (r0.w != 0) ? (r0.z ^ 0x80000000u) : r0.z;
  r0.w = asuint(mad(asfloat(r0.z), 0.95492965, 0.5));
  r0.w = asuint(floor(asfloat(r0.w)));
  r0.z = asuint(mad(asfloat(r0.w), 1.04719758, -(asfloat(r0.z))));
  {
    float cosValue = cos(asfloat(r0.z));
    r0.z = asuint(cosValue);
  }
  r0.x = asuint(dot(asfloat(r0.xy), asfloat(r0.xy)));
  r0.x = asuint(sqrt(asfloat(r0.x)));
  r0.y = asuint(asfloat(r0.z) * asfloat(r0.x));
  r0.x = asuint(mad(-(asfloat(r0.z)), asfloat(r0.x), 1.0));
  r0.z = asuint(ddx(asfloat(r0.y)));
  r0.y = asuint(ddy(asfloat(r0.y)));
  r0.y = asuint(abs(asfloat(r0.z)) + abs(asfloat(r0.y)));
  r0.x = asuint(saturate(asfloat(r0.x) / asfloat(r0.y)));
  r0.yz = asuint(float2(-0.5,-0.5) + v1.xy);
  r0.y = asuint(dot(asfloat(r0.yz), asfloat(r0.yz)));
  r0.y = asuint(sqrt(asfloat(r0.y)));
  r0.y = asuint(log2(asfloat(r0.y)));
  r0.y = asuint(3.25 * asfloat(r0.y));
  r0.y = asuint(exp2(asfloat(r0.y)));
  r0.y = asuint(asfloat(r0.x) * asfloat(r0.y));
  r0.y = asuint(6.25 * asfloat(r0.y));
  r0.y = asuint(min(1, asfloat(r0.y)));
  r0.z = asuint(mad(asfloat(r0.y), -2.0, 3.0));
  r0.y = asuint(asfloat(r0.y) * asfloat(r0.y));
  r1.xyzw = asuint(mad(cb0[15].xxxx, float4(-0.200000003,-0.200000003,-0.0,-0.400000006), v1.xyxy));
  r2.xyzw = asuint(mad(asfloat(r1.xyxy), cb1[0].zwzw, float4(-0.5,0.5,0.5,0.5)));
  r2.xyzw = asuint(floor(asfloat(r2.xyzw)));
  r2.xyzw = asuint(float4(0.5,0.5,0.5,0.5) + asfloat(r2.xyzw));
  r2.xyzw = asuint(cb1[0].xyxy * asfloat(r2.xyzw));
  r3.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r2.xy), 0).xyzw);
  r2.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r2.zw), 0).xyzw);
  r1.xy = asuint(mad(asfloat(r1.xy), cb1[0].zw, float2(0.5,-0.5)));
  r1.xy = asuint(floor(asfloat(r1.xy)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r1.xy));
  r1.xy = asuint(cb1[0].xy * asfloat(r1.xy));
  r4.xyzw = asuint(t0.SampleLevel(s0_s, asfloat(r1.xy), 0).yzxw);
  r5.xyzw = asuint(mad(asfloat(r1.zwzw), cb1[1].zwzw, float4(-0.5,0.5,0.5,0.5)));
  r5.xyzw = asuint(floor(asfloat(r5.xyzw)));
  r5.xyzw = asuint(float4(0.5,0.5,0.5,0.5) + asfloat(r5.xyzw));
  r5.xyzw = asuint(cb1[1].xyxy * asfloat(r5.xyzw));
  r6.xyzw = asuint(t1.SampleLevel(s1_s, asfloat(r5.xy), 0).xyzw);
  r5.xyzw = asuint(t1.SampleLevel(s1_s, asfloat(r5.zw), 0).xyzw);
  r1.xy = asuint(mad(asfloat(r1.zw), cb1[1].zw, float2(0.5,-0.5)));
  r1.xy = asuint(floor(asfloat(r1.xy)));
  r1.xy = asuint(float2(0.5,0.5) + asfloat(r1.xy));
  r1.xy = asuint(cb1[1].xy * asfloat(r1.xy));
  r1.xyzw = asuint(t1.SampleLevel(s1_s, asfloat(r1.xy), 0).yzxw);
  r4.x = r3.x;
  r4.y = r2.x;
  r1.x = r6.x;
  r1.y = r5.x;
  r1.xyz = asuint(asfloat(r4.xyz) + asfloat(r1.xyz));
  r0.yzw = asuint(mad(asfloat(r0.zzz), asfloat(r0.yyy), asfloat(r1.xyz)));
  r0.x = asuint(asfloat(r0.x) + asfloat(r0.x));
  r1.x = asuint(saturate(asfloat(r0.y) + asfloat(r0.y)));
  r1.y = asuint(mad(asfloat(r1.x), -2.0, 3.0));
  r1.x = asuint(asfloat(r1.x) * asfloat(r1.x));
  r1.x = asuint(asfloat(r1.y) * asfloat(r1.x));
  r1.y = asuint(mad(v1.y, 1.36000001, 0.119999997));
  r1.y = asuint(saturate(0.869565248 * asfloat(r1.y)));
  r1.z = asuint(mad(asfloat(r1.y), -2.0, 3.0));
  r1.y = asuint(asfloat(r1.y) * asfloat(r1.y));
  r1.y = asuint(mad(-(asfloat(r1.z)), asfloat(r1.y), 1.0));
  r1.x = asuint(asfloat(r1.x) * asfloat(r1.y));
  r1.w = asuint(asfloat(r1.x) * asfloat(r0.x));
  r0.x = (uint)-(int)(asfloat(r1.w) == 0.0);
  if (r0.x != 0) discard;
  r2.xyz = asuint(float3(-0.0539018996,-0.0339934565,-1) + cb1[2].xyz);
  r1.xyz = asuint(mad(asfloat(r0.yzw), asfloat(r2.xyz), float3(0.0539018996,0.0339934565,1.0)));
  o0.xyzw = v2.xyzw * asfloat(r1.xyzw);
  o0.w = saturate(o0.w);
  return;
}