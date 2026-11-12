// Original: shader2.dat/filtershadertonemap_hdr.pso - native HDR renderer scene tone map, two outputs.
#include "./tonemap.hlsli"
// Readable rewrite of the 3Dmigoto decompile; compiles to the game bytecode (verify_rewrite.py).

cbuffer PSParamBuffer1 : register(b1)
{
  float4 g_ExposureParam : packoffset(c0);
  float4 g_Brightness : packoffset(c1);
  float4 g_VignettoParam : packoffset(c2);
}

SamplerState g_Texture0Sampler_s : register(s0);
SamplerState g_Texture1Sampler_s : register(s1);
SamplerState g_Texture2Sampler_s : register(s2);
SamplerState g_Texture3Sampler_s : register(s3);
Texture2D<float4> g_Texture0 : register(t0);
Texture2D<float4> g_Texture1 : register(t1);
Texture2D<float4> g_Texture2 : register(t2);
Texture2D<float4> g_Texture3 : register(t3);
StructuredBuffer<float> g_AverageBrightnessBuffer : register(t5);

// 16x16x16 LUT unwrapped to a 256x16 strip; blue picks the slice. color is in [0, 1].
float3 SampleLut(Texture2D<float4> lut, SamplerState lut_sampler, float3 color) {
  float blue_slice = floor(color.b * 14.9998999);
  float blend = color.b * 15 - blue_slice;
  float2 lut_base = float2(blue_slice * 0.0625 + color.r * 0.05859375, color.g * 0.9375);
  float3 lut_lower = lut.Sample(lut_sampler, lut_base + float2(0.001953125, 0.03125)).rgb;
  float3 lut_upper = lut.Sample(lut_sampler, lut_base + float2(0.064453125, 0.03125)).rgb;
  return blend * (lut_upper - lut_lower) + lut_lower;
}

void main(float4 position : SV_POSITION0, float2 uv : TEXCOORD0,
          out float4 o0 : SV_Target0, out float4 o1 : SV_Target1) {
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
  float3 mapped = g_ExposureParam.y > 0.0 ? tonemapped : scene;
  // HDR: untonemapped versions of both targets' inputs, through a smooth curve for the LUTs.
  float3 hdr_primary = max(g_ExposureParam.y > 0.0 ? exposed : scene, 0.0);
  float3 neutral_primary = NierNeutralSDR(hdr_primary);
  float3 hdr_source = max(g_ExposureParam.y > 0.0 ? lerp(exposed, scene, 0.2) : scene, 0.0);
  float3 hdr_neutral = NierNeutralSDR(hdr_source);
  float3 lut1_input = NIER_HDR_ENABLED ? neutral_primary : mapped;

  // Target 0: mapped scene through LUT 1 (encoded).
  o0 = float4(SampleLut(g_Texture1, g_Texture1Sampler_s, saturate(lut1_input)), 0);

  // Keep 20% of the unmapped scene.
  float3 mixed = (scene - mapped) * 0.2 + mapped;
  float3 luma_source = mixed;
  if (NIER_HDR_ENABLED) mixed = hdr_neutral;

  // Target 1: mixed scene through LUT 3 (linear, tonemaplut_hdr.pso), fading back
  // to the mixed scene as luminance goes from 0.25 to 1.
  float3 graded = SampleLut(g_Texture3, g_Texture3Sampler_s, saturate(mixed));
  float highlight = smoothstep(0.25, 1.0, dot(luma_source, float3(0.298911989, 0.586610973, 0.114478)));
  o1 = float4(highlight * (mixed - graded) + graded, 0);

  if (NIER_HDR_ENABLED) {
    o0.rgb = renodx::draw::RenderIntermediatePass(
        renodx::draw::ToneMapPass(hdr_primary, renodx::color::srgb::DecodeSafe(o0.rgb), neutral_primary));
    // Target 1 is linear (tonemaplut_hdr.pso, E686AF98 target 1).
    o1.rgb = renodx::draw::ToneMapPass(hdr_source, o1.rgb, hdr_neutral);
  } else if (NIER_TONE_MAP_VANILLA) {
    o0.rgb = NierVanillaIntermediate(o0.rgb);
    o1.rgb = saturate(o1.rgb);
  }
}
