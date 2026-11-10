#include "./tonemap.hlsli"
// ---- Created with 3Dmigoto v1.4.1 on Tue Nov 10 09:07:27 2026

cbuffer PSParamBuffer1 : register(b1)
{
  float4 g_ExposureParam : packoffset(c0);
  float4 g_Brightness : packoffset(c1);
  float4 g_VignettoParam : packoffset(c2);
}

SamplerState g_Texture0Sampler_s : register(s0);
SamplerState g_Texture1Sampler_s : register(s1);
SamplerState g_Texture2Sampler_s : register(s2);
Texture2D<float4> g_Texture0 : register(t0);
Texture2D<float4> g_Texture1 : register(t1);
Texture2D<float4> g_Texture2 : register(t2);
StructuredBuffer<float> g_AverageBrightnessBuffer : register(t5);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  bool hdr_enabled = shader_injection.peak_white_nits > 0.0;
  float3 hdr_source, hdr_neutral;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r0.x = dot(r0.xy, r0.xy);
  r0.x = sqrt(r0.x);
  r0.x = 1 + -r0.x;
  r0.x = saturate(r0.x / g_VignettoParam.x);
  r0.x = log2(r0.x);
  r0.x = g_VignettoParam.y * r0.x;
  r0.x = exp2(r0.x);
  r0.yzw = g_Texture2.Sample(g_Texture2Sampler_s, v1.xy).xyz;
  r1.xyz = g_Texture0.Sample(g_Texture0Sampler_s, v1.xy).xyz;
  r0.xyzw = r1.zzxy * r0.xxxx + r0.wwyz;
  r1.x = g_AverageBrightnessBuffer[0].x;
  r1.xyzw = r1.xxxx * r0.yyzw;
  // Capture before the SDR rational curve; r1.zwy is original RGB.
  hdr_source = max(g_ExposureParam.y > 0.0 ? r1.zwy : r0.zwy, 0.0);
  hdr_neutral = NierNeutralSDR(hdr_source);
  r2.xyzw = r1.yyzw * float4(0.666666687,0.666666687,0.666666687,0.666666687) + float4(1,1,1,1);
  r3.xyzw = r2.xyzw * r1.xyzw;
  r1.xyzw = r1.yyzw * r2.yyzw + float4(1,1,1,1);
  r1.xyzw = r3.xyzw / r1.xyzw;
  r2.x = cmp(0 < g_ExposureParam.y);
  r0.xyzw = saturate(r2.xxxx ? r1.xyzw : r0.xyzw);
  if (hdr_enabled) r0 = hdr_neutral.bbrg;
  r1.xyw = float3(14.9998999,0.9375,0.05859375) * r0.xwz;
  r0.x = floor(r1.x);
  r1.x = r0.x * 0.0625 + r1.w;
  r1.xyzw = float4(0.001953125,0.03125,0.064453125,0.03125) + r1.xyxy;
  r0.x = r0.y * 15 + -r0.x;
  r0.yzw = g_Texture1.Sample(g_Texture1Sampler_s, r1.zw).xyz;
  r1.xyz = g_Texture1.Sample(g_Texture1Sampler_s, r1.xy).xyz;
  r0.yzw = -r1.xyz + r0.yzw;
  o0.xyz = r0.xxx * r0.yzw + r1.xyz;
  if (hdr_enabled) {
    // LUT builder 89CEEF9A folds sRGB encoding and brightness into this LUT.
    o0.xyz = renodx::draw::RenderIntermediatePass(
        renodx::draw::ToneMapPass(hdr_source, renodx::color::srgb::DecodeSafe(o0.xyz), hdr_neutral));
  }
  o0.w = 0;
  return;
}