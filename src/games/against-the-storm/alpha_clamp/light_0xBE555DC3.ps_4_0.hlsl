// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 19:41:00 2026
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
  float3 v2 : INTERP1,
  float3 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  uint4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(float2(1,0.911757052) + -v1.yy);
  r0.yz = asuint(saturate(float2(11.3323526,1.0967834) * asfloat(r0.xy)));
  r0.y = asuint(0.982352912 * asfloat(r0.y));
  r0.y = asuint(mad(asfloat(r0.z), -(asfloat(r0.y)), asfloat(r0.y)));
  r0.z = asuint(0.0549999997 + asfloat(r0.y));
  r0.zw = asuint(float2(0.947867334,0.0773993805) * asfloat(r0.zy));
  r0.z = asuint(log2(abs(asfloat(r0.z))));
  r0.z = asuint(2.4000001 * asfloat(r0.z));
  r0.z = asuint(exp2(asfloat(r0.z)));
  r0.y = (uint)-(int)(0.0404499993 >= asfloat(r0.y));
  r0.y = (r0.y != 0) ? r0.w : r0.z;
  r0.z = asuint(saturate(asfloat(r0.x)));
  r0.zw = asuint(float2(1,1.05499995) + -asfloat(r0.zz));
  r1.xy = asuint(float2(0.0773993805,0.947867334) * asfloat(r0.zw));
  r0.z = (uint)-(int)(0.0404499993 >= asfloat(r0.z));
  r0.w = asuint(log2(asfloat(r1.y)));
  r0.w = asuint(2.4000001 * asfloat(r0.w));
  r0.w = asuint(exp2(asfloat(r0.w)));
  r0.z = (r0.z != 0) ? r1.x : r0.w;
  r0.y = asuint(asfloat(r0.y) + -asfloat(r0.z));
  r0.y = asuint(mad(cb1[2].x, asfloat(r0.y), asfloat(r0.z)));
  r0.z = asuint(0.612500012 * cb0[15].x);
  {
    float sinValue = sin(asfloat(r0.z));
    r0.z = asuint(sinValue);
  }
  r0.z = asuint(1 + asfloat(r0.z));
  r0.z = asuint(mad(asfloat(r0.z), 0.099999994, 0.300000012));
  o0.w = asfloat(r0.z) * asfloat(r0.y);
  r0.yzw = asuint(cb1[1].xyz + -cb1[0].xyz);
  o0.xyz = mad(asfloat(r0.xxx), asfloat(r0.yzw), cb1[0].xyz);
  o0.w = saturate(o0.w);
  return;
}