// Lens Render Pipeline/TMP/Distance Field (_SRGB_OUTPUT)
#include "./ui.hlsl"

cbuffer cb3 : register(b3)
{
  float4 cb3[21];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[7];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[7];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[36];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  out float4 o0 : SV_POSITION0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD0,
  out float4 o3 : TEXCOORD1,
  out float4 o4 : TEXCOORD2,
  out float4 o5 : TEXCOORD3,
  out float4 o6 : TEXCOORD5)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cb2[0].y;
  r0.y = cb2[1].y;
  r0.z = cb2[2].y;
  r1.xyw = cb2[3].xyz + -cb0[32].xyz;
  r0.w = r1.y;
  r2.w = 1;
  r2.z = v0.z;
  r2.xy = cb0[25].zw + v0.xy;
  r3.y = dot(r0.xyzw, r2.xyzw);
  r4.xyzw = cb3[18].xyzw * r3.yyyy;
  r5.w = r1.x;
  r5.x = cb2[0].x;
  r5.y = cb2[1].x;
  r5.z = cb2[2].x;
  r3.x = dot(r5.xyzw, r2.xyzw);
  r4.xyzw = cb3[17].xyzw * r3.xxxx + r4.xyzw;
  r1.x = cb2[0].z;
  r1.y = cb2[1].z;
  r1.z = cb2[2].z;
  r3.z = dot(r1.xyzw, r2.xyzw);
  r4.xyzw = cb3[19].xyzw * r3.zzzz + r4.xyzw;
  r3.xyz = cb1[4].xyz + -r3.xyz;
  r6.x = cb2[0].w;
  r6.y = cb2[1].w;
  r6.z = cb2[2].w;
  r6.w = cb2[3].w;
  r3.w = dot(r6.xyzw, r2.xyzw);
  r4.xyzw = cb3[20].xyzw * r3.wwww + r4.xyzw;
  o0.xyzw = r4.xyzw;
  r4.xyz = max(float3(0,0,0), v2.xyz);
  r4.xyz = log2(r4.xyz);
  r4.xyz = float3(0.416666657,0.416666657,0.416666657) * r4.xyz;
  r4.xyz = exp2(r4.xyz);
  r4.xyz = r4.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  o1.xyz = max(float3(0,0,0), r4.xyz);
  o1.w = v2.w;
  o2.xy = v3.xy;
  r4.xy = cb3[6].xy * cb1[6].yy;
  r4.xy = cb3[5].xy * cb1[6].xx + r4.xy;
  r6.z = cb0[30].w * abs(r4.x);
  r6.w = cb0[31].x * abs(r4.y);
  r4.xy = r4.ww / r6.zw;
  r3.w = dot(r4.xy, r4.xy);
  r4.xy = cb0[29].zw * float2(0.25,0.25) + r4.xy;
  o4.zw = float2(0.25,0.25) / r4.xy;
  r3.w = rsqrt(r3.w);
  r4.x = cb0[30].z * abs(v4.y);
  r4.y = 1 + cb0[31].z;
  r4.x = r4.x * r4.y;
  r4.y = r4.x * r3.w;
  r4.z = 1 + -cb0[31].y;
  r4.z = abs(r4.y) * r4.z;
  r3.w = r3.w * r4.x + -r4.z;
  r6.x = dot(v1.xyz, cb2[4].xyz);
  r6.y = dot(v1.xyz, cb2[5].xyz);
  r6.z = dot(v1.xyz, cb2[6].xyz);
  r4.x = dot(r6.xyz, r6.xyz);
  r4.x = max(9.99999975e-006, r4.x);
  r4.x = rsqrt(r4.x);
  r6.xyz = r6.xyz * r4.xxx;
  r4.x = dot(r3.xyz, r3.xyz);
  r4.x = rsqrt(r4.x);
  r3.xyz = r4.xxx * r3.xyz;
  r3.x = dot(r6.xyz, r3.xyz);
  r3.x = abs(r3.x) * r3.w + r4.z;
  r3.y = cmp(cb3[8].w == 0.000000);
  r3.y = r3.y ? r3.x : r4.y;
  r3.x = cmp(0 >= v4.y);
  r3.x = r3.x ? 1.000000 : 0;
  r3.z = cb0[24].z + -cb0[24].y;
  r3.x = r3.x * r3.z + cb0[24].y;
  r3.x = r3.x * 0.25 + cb0[4].x;
  r3.x = cb0[24].w * r3.x;
  r3.w = 0.5 * r3.x;
  o3.yw = r3.yw;
  r3.y = 0.5 / r3.y;
  r3.z = -cb0[6].x * cb0[24].w + 1;
  r3.z = -cb0[4].y * cb0[24].w + r3.z;
  r3.z = r3.z * 0.5 + -r3.y;
  o3.x = -r3.x * 0.5 + r3.z;
  r3.x = -r3.x * 0.5 + 0.5;
  o3.z = r3.x + r3.y;
  r3.xyzw = max(float4(-2e+010,-2e+010,-2e+010,-2e+010), cb0[28].xyzw);
  r3.xyzw = min(float4(2e+010,2e+010,2e+010,2e+010), r3.xyzw);
  r3.xy = r2.xy * float2(2,2) + -r3.xy;
  o4.xy = r3.xy + -r3.zw;
  r2.w = v0.w;
  r3.x = dot(r5.xyzw, r2.xyzw);
  r3.y = dot(r0.xyzw, r2.xyzw);
  r3.z = dot(r1.xyzw, r2.xyzw);
  r0.xyz = cb1[4].xyz + -r3.xyz;
  r1.xyz = cb0[13].xyz * r0.yyy;
  r0.xyw = cb0[12].xyz * r0.xxx + r1.xyz;
  o5.xyz = cb0[14].xyz * r0.zzz + r0.xyw;
  r0.x = 0.000244140625 * v4.x;
  r0.z = floor(r0.x);
  r0.w = -r0.z * 4096 + v4.x;
  r0.xy = float2(0.001953125,0.001953125) * r0.zw;
  o6.xy = r0.xy * cb0[34].xy + cb0[34].zw;
  o6.zw = r0.xy * cb0[35].xy + cb0[35].zw;
  o0 = HideUidVertex(o0);
  return;
}
