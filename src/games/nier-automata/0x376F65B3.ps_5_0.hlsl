// Original: shader.dat/saoupsampling.pso - depth-aware upsample of the half-resolution
// ambient occlusion term to the full-resolution AO target. 1 is unoccluded.
#include "./shared.h"

cbuffer HPixel_Buffer : register(b12)
{
  float4 g_TargetUvParam : packoffset(c0);
}

cbuffer CB : register(b8)
{
  float4 SaoGlobalParams : packoffset(c0);
}

SamplerState g_texSrcSampler_s : register(s0);
SamplerState g_texZSampler_s : register(s1);
Texture2D<float4> g_texSrc : register(t0);
Texture2D<float4> g_texZ : register(t1);

#define cmp -

// Unmodified 3Dmigoto decompile of the game shader.
float GameAmbientOcclusion(float2 v1) {
  float4 r0,r1,r2,r3,r4;

  r0.x = g_texZ.Sample(g_texZSampler_s, v1.xy).x;
  r0.y = cmp(SaoGlobalParams.w < r0.x);
  if (r0.y != 0) {
    return 1;
  }
  r0.yz = float2(1,1) / g_TargetUvParam.zw;
  r1.xy = g_TargetUvParam.zw * v1.xy;
  r1.xy = floor(r1.xy);
  r1.xy = (int2)r1.xy;
  r1.xy = (int2)r1.xy & int2(1,1);
  r1.xy = (int2)r1.xy;
  r1.zw = r1.yx * float2(2,2) + float2(1,1);
  r2.xy = r1.xy * float2(-2,-2) + float2(3,3);
  r1.xy = float2(-2,-2) + r1.xy;
  r3.zw = r1.xy * r0.yz + v1.xy;
  r3.xy = r0.yz * float2(2,2) + r3.zw;
  r0.yzw = g_texSrc.Sample(g_texSrcSampler_s, r3.zw).xyz;
  r1.x = r1.w * r1.z;
  r0.z = dot(r0.zw, float2(0.996108949,0.00389105058));
  r0.z = r0.x + -r0.z;
  r0.z = 1.00000004e-036 + abs(r0.z);
  r0.z = 1 / r0.z;
  r0.w = r1.x * r0.z;
  r4.xyz = g_texSrc.Sample(g_texSrcSampler_s, r3.xw).xyz;
  r1.yz = r2.xy * r1.zw;
  r1.w = dot(r4.yz, float2(0.996108949,0.00389105058));
  r1.w = -r1.w + r0.x;
  r1.w = 1.00000004e-036 + abs(r1.w);
  r1.w = 1 / r1.w;
  r1.y = r1.y * r1.w;
  r0.z = r1.x * r0.z + r1.y;
  r1.x = r1.y * r4.x;
  r0.y = r0.w * r0.y + r1.x;
  r1.xyw = g_texSrc.Sample(g_texSrcSampler_s, r3.zy).xyz;
  r0.w = dot(r1.yw, float2(0.996108949,0.00389105058));
  r0.w = r0.x + -r0.w;
  r0.w = 1.00000004e-036 + abs(r0.w);
  r0.w = 1 / r0.w;
  r1.y = r1.z * r0.w;
  r0.z = r1.z * r0.w + r0.z;
  r0.y = r1.y * r1.x + r0.y;
  r1.xyz = g_texSrc.Sample(g_texSrcSampler_s, r3.xy).xyz;
  r0.w = r2.x * r2.y;
  r1.y = dot(r1.yz, float2(0.996108949,0.00389105058));
  r0.x = -r1.y + r0.x;
  r0.x = 1.00000004e-036 + abs(r0.x);
  r0.x = 1 / r0.x;
  r1.y = r0.w * r0.x;
  r0.x = r0.w * r0.x + r0.z;
  r0.y = r1.y * r1.x + r0.y;
  return r0.y / r0.x;
}

float main(float4 position : SV_POSITION0, float2 uv : TEXCOORD0) : SV_Target0 {
  float strength = shader_injection.ambient_occlusion_strength;
  // pow(0, 0) is undefined, and no occlusion needs no samples.
  if (strength <= 0.f) return 1.f;
  return pow(saturate(GameAmbientOcclusion(uv)), strength);
}
