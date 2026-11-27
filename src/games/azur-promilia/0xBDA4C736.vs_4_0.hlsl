// Lens Render Pipeline/UI/Default (_SRGB_OUTPUT)
#include "./ui.hlsl"

cbuffer cb2 : register(b2)
{
  float4 cb2[5];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[4];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[68];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD0,
  out float4 o3 : TEXCOORD1,
  out float4 o4 : TEXCOORD2)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cb1[0].y;
  r0.y = cb1[1].y;
  r0.z = cb1[2].y;
  r1.xyw = cb1[3].xyz + -cb0[6].xyz;
  r0.w = r1.y;
  r2.xyz = v0.xyz;
  r2.w = 1;
  r0.x = dot(r0.xyzw, r2.xyzw);
  r0.xyzw = cb0[65].xyzw * r0.xxxx;
  r3.w = r1.x;
  r3.x = cb1[0].x;
  r3.y = cb1[1].x;
  r3.z = cb1[2].x;
  r3.x = dot(r3.xyzw, r2.xyzw);
  r0.xyzw = cb0[64].xyzw * r3.xxxx + r0.xyzw;
  r1.x = cb1[0].z;
  r1.y = cb1[1].z;
  r1.z = cb1[2].z;
  r1.x = dot(r1.xyzw, r2.xyzw);
  r0.xyzw = cb0[66].xyzw * r1.xxxx + r0.xyzw;
  r1.x = cb1[0].w;
  r1.y = cb1[1].w;
  r1.z = cb1[2].w;
  r1.w = cb1[3].w;
  r1.x = dot(r1.xyzw, r2.xyzw);
  r0.xyzw = cb0[67].xyzw * r1.xxxx + r0.xyzw;
  o0.xyzw = r0.xyzw;
  o1.xyzw = cb2[0].xyzw * v1.xyzw;
  o2.xy = v2.xy * cb2[3].xy + cb2[3].zw;
  r0.y = cb0[9].x * r0.y;
  r1.xzw = float3(0.5,0.5,0.5) * r0.xwy;
  o3.xy = r1.xw + r1.zz;
  o3.zw = r0.zw;
  r1.z = cb0[48].x * cb0[10].x;
  r1.w = cb0[49].y * cb0[10].y;
  r0.xy = r0.ww / abs(r1.zw);
  r0.xy = cb2[4].xy * float2(0.25,0.25) + abs(r0.xy);
  o4.zw = float2(0.25,0.25) / r0.xy;
  r0.xyzw = max(float4(-2e+010,-2e+010,-2e+010,-2e+010), cb2[2].xyzw);
  r0.xyzw = min(float4(2e+010,2e+010,2e+010,2e+010), r0.xyzw);
  r0.xy = v0.xy * float2(2,2) + -r0.xy;
  o4.xy = r0.xy + -r0.zw;
  o0 = HideUidVertex(o0);
  return;
}
