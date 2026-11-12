// Original: shader2.dat/filtershadertonemap.pso - main SDR scene tone map: vignette + bloom, auto exposure, rational curve, dual 16^3 LUT blend, sRGB/brightness.
// Readable vanilla baseline, manually checked against original ps_c3daded... assembly.
#include "./shared.h"
cbuffer PSParamBuffer1 : register(b1) {
  float4 g_ExposureParam : packoffset(c0);
  float4 g_Brightness : packoffset(c1);
  float4 g_VignettoParam : packoffset(c2);
}
SamplerState g_Texture0Sampler : register(s0);
SamplerState g_Texture1Sampler : register(s1);
SamplerState g_Texture2Sampler : register(s2);
SamplerState g_Texture3Sampler : register(s3);
Texture2D<float4> g_Texture0 : register(t0);
Texture2D<float4> g_Texture1 : register(t1);
Texture2D<float4> g_Texture2 : register(t2);
Texture2D<float4> g_Texture3 : register(t3);
StructuredBuffer<float> g_AverageBrightnessBuffer : register(t5);

float4 main(float4 position : SV_POSITION, float2 uv : TEXCOORD0) : SV_Target0 {
  float2 offset = uv - 0.5;
  float vignette = exp2(log2(saturate((1.0 - sqrt(dot(offset, offset))) / g_VignettoParam.x)) * g_VignettoParam.y);
  float3 bloom = g_Texture2.Sample(g_Texture2Sampler, uv).rgb;
  float3 scene = g_Texture0.Sample(g_Texture0Sampler, uv).rgb * vignette + bloom;
  float3 exposed = scene * g_AverageBrightnessBuffer[0];
  float3 factor = mad(exposed, 0.666666687, 1.0);
  float3 tonemapped = saturate((exposed * factor) / mad(exposed, factor, 1.0));
  float3 linear_sdr = saturate(g_ExposureParam.y > 0.0 ? tonemapped : scene);
  float3 encoded = saturate(linear_sdr <= 0.00313080009
                               ? linear_sdr * 12.9200001
                               : mad(exp2(log2(linear_sdr) * 0.416666657), 1.05499995, -0.0549999997));
  float blue_slice = floor(encoded.b * 14.9998999);
  float blend = mad(encoded.b, 15.0, -blue_slice);
  float2 lut_base = float2(mad(blue_slice, 0.0625, encoded.r * 0.05859375), encoded.g * 0.9375);
  float2 lower_uv = lut_base + float2(0.001953125, 0.03125);
  float2 upper_uv = lut_base + float2(0.064453125, 0.03125);
  float3 lut0_lower = g_Texture1.Sample(g_Texture1Sampler, lower_uv).rgb;
  float3 lut0 = mad(blend, g_Texture1.Sample(g_Texture1Sampler, upper_uv).rgb - lut0_lower, lut0_lower);
  float3 lut1_lower = g_Texture3.Sample(g_Texture3Sampler, lower_uv).rgb;
  float3 lut1 = mad(blend, g_Texture3.Sample(g_Texture3Sampler, upper_uv).rgb - lut1_lower, lut1_lower);
  float3 graded = mad(g_ExposureParam.z, lut0 - lut1, lut1);
  float3 encoded_sdr = exp2(log2(abs(graded)) * g_Brightness.x);
  if (NIER_TONE_MAP_OFF) return float4(encoded_sdr, 0.0);
  if (NIER_TONE_MAP_VANILLA) return float4(NierVanillaIntermediate(encoded_sdr), 0.0);
  float3 graded_sdr = renodx::color::srgb::DecodeSafe(encoded_sdr);
  // Preserve the vanilla rational curve as the LUT reference. The HDR signal
  // comes from scene + bloom before the SDR curve, never from the final frame.
  float3 untonemapped = max(g_ExposureParam.y > 0.0 ? exposed : scene, 0.0);
  float3 neutral_sdr = untonemapped * (untonemapped * (2.0 / 3.0) + 1.0);
  neutral_sdr /= neutral_sdr + 1.0;
  float3 hdr = renodx::draw::ToneMapPass(untonemapped, graded_sdr, neutral_sdr);
  return float4(renodx::draw::RenderIntermediatePass(hdr), 0.0);
}
