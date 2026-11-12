// Original: shader2.dat/filtershadertonemaphdrwin.pso - native HDR renderer (Windows) scene tone map.
#include "./tonemap.hlsli"
// Readable rewrite of the 3Dmigoto decompile; compiles to the game bytecode (verify_rewrite.py).

cbuffer PSParamBuffer1 : register(b1)
{
  float4 g_ExposureParam : packoffset(c0);
  float4 g_Brightness : packoffset(c1);
  float4 g_VignettoParam : packoffset(c2);
}

SamplerState g_Texture0Sampler_s : register(s0);
SamplerState g_Texture2Sampler_s : register(s2);
SamplerState g_Texture3Sampler_s : register(s3);
Texture2D<float4> g_Texture0 : register(t0);
Texture2D<float4> g_Texture2 : register(t2);
Texture2D<float4> g_Texture3 : register(t3);
StructuredBuffer<float> g_AverageBrightnessBuffer : register(t5);

float4 main(float4 position : SV_POSITION0, float2 uv : TEXCOORD0) : SV_Target0 {
  float2 offset = uv - 0.5;
  float vignette = exp2(log2(saturate((1.0 - sqrt(dot(offset, offset))) / g_VignettoParam.x)) * g_VignettoParam.y);
  float3 bloom = g_Texture2.Sample(g_Texture2Sampler_s, uv).rgb;
  float3 scene = g_Texture0.Sample(g_Texture0Sampler_s, uv).rgb * vignette + bloom;
  float3 exposed = scene * g_AverageBrightnessBuffer[0];

  // Rational curve x(1 + 2x/3) / (x(1 + 2x/3) + 1); off when auto exposure is disabled.
  float3 factor = exposed * 0.666666687 + 1.0;
  float3 tonemapped = (exposed * factor) / (exposed * factor + 1.0);
  float3 mapped = g_ExposureParam.y > 0.0 ? tonemapped : scene;
  // Keep 20% of the unmapped scene.
  float3 mixed = (scene - mapped) * 0.2 + mapped;
  // HDR: the same 20% mix of the untonemapped scene, through a smooth curve for the LUT.
  float3 hdr_source = max(g_ExposureParam.y > 0.0 ? lerp(exposed, scene, 0.2) : scene, 0.0);
  float3 hdr_neutral = NierNeutralSDR(hdr_source);
  float3 luma_source = mixed;
  if (NIER_HDR_ENABLED) mixed = hdr_neutral;
  float3 lut_input = saturate(mixed);

  // 16x16x16 LUT (tonemaplut_hdr.pso) unwrapped to a 256x16 strip; blue picks the slice.
  float blue_slice = floor(lut_input.b * 14.9998999);
  float blend = lut_input.b * 15 - blue_slice;
  float2 lut_base = float2(blue_slice * 0.0625 + lut_input.r * 0.05859375, lut_input.g * 0.9375);
  float3 lut_lower = g_Texture3.Sample(g_Texture3Sampler_s, lut_base + float2(0.001953125, 0.03125)).rgb;
  float3 lut_upper = g_Texture3.Sample(g_Texture3Sampler_s, lut_base + float2(0.064453125, 0.03125)).rgb;
  float3 graded = blend * (lut_upper - lut_lower) + lut_lower;

  // Fade from the LUT back to the mixed scene as luminance goes from 0.25 to 1.
  float luma = dot(luma_source, float3(0.298911989, 0.586610973, 0.114478));
  float highlight = smoothstep(0.25, 1.0, luma);
  float3 color = highlight * (mixed - graded) + graded;
  // This LUT and output are linear, unlike the encoded SDR target.
  if (NIER_HDR_ENABLED) {
    color = renodx::draw::ToneMapPass(hdr_source, color, hdr_neutral);
  } else if (NIER_TONE_MAP_VANILLA) {
    color = saturate(color);
  }
  return float4(color, 0);
}
