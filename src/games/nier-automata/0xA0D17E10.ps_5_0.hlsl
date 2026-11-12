// Original: shader2.dat/filtershadertonemap_simple.pso - single-LUT SDR scene tone map.
#include "./tonemap.hlsli"
// Readable rewrite of the 3Dmigoto decompile; compiles to identical bytecode (verify_rewrite.py).

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

float4 main(float4 position : SV_POSITION0, float2 uv : TEXCOORD0) : SV_Target0 {
  float2 offset = uv - 0.5;
  float vignette = exp2(log2(saturate((1.0 - sqrt(dot(offset, offset))) / g_VignettoParam.x)) * g_VignettoParam.y);
  if (NIER_DISABLE_VIGNETTE) vignette = 1.0;
  float3 bloom = g_Texture2.Sample(g_Texture2Sampler_s, uv).rgb;
  if (NIER_DISABLE_BLOOM) bloom = 0.0;
  float3 scene = g_Texture0.Sample(g_Texture0Sampler_s, uv).rgb * vignette + bloom;
  // Auto exposure off: fixed 1.0 multiplier instead of the measured scene brightness.
  float3 exposed = scene * (NIER_DISABLE_AUTO_EXPOSURE ? 1.0 : g_AverageBrightnessBuffer[0]);

  // Rational curve x(1 + 2x/3) / (x(1 + 2x/3) + 1); off when auto exposure is disabled.
  float3 factor = exposed * 0.666666687 + 1.0;
  float3 tonemapped = (exposed * factor) / (exposed * factor + 1.0);
  // Game curve off: exposed scene, clipped later by the LUT addressing in SDR modes.
  if (NIER_DISABLE_GAME_TONE_MAP) tonemapped = exposed;
  float3 lut_input = saturate(g_ExposureParam.y > 0.0 ? tonemapped : scene);
  // HDR: address the LUT with a smooth curve of the untonemapped scene instead.
  float3 hdr_source = max(g_ExposureParam.y > 0.0 ? exposed : scene, 0.0);
  float3 hdr_neutral = NierNeutralSDR(hdr_source);
  if (NIER_HDR_ENABLED) lut_input = hdr_neutral;

  // 16x16x16 LUT unwrapped to a 256x16 strip; blue picks the slice. The LUT
  // (tonemaplut_sdr.pso) already contains sRGB encoding and brightness.
  float blue_slice = floor(lut_input.b * 14.9998999);
  float blend = lut_input.b * 15 - blue_slice;
  float2 lut_base = float2(blue_slice * 0.0625 + lut_input.r * 0.05859375, lut_input.g * 0.9375);
  float3 lut_lower = g_Texture1.Sample(g_Texture1Sampler_s, lut_base + float2(0.001953125, 0.03125)).rgb;
  float3 lut_upper = g_Texture1.Sample(g_Texture1Sampler_s, lut_base + float2(0.064453125, 0.03125)).rgb;
  float3 graded = blend * (lut_upper - lut_lower) + lut_lower;
  if (NIER_HDR_ENABLED) {
    graded = renodx::draw::RenderIntermediatePass(
        renodx::draw::ToneMapPass(hdr_source, renodx::color::srgb::DecodeSafe(graded), hdr_neutral));
  } else if (NIER_TONE_MAP_VANILLA) {
    graded = NierVanillaIntermediate(graded);
  }
  return float4(graded, 0);
}
