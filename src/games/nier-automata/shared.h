#ifndef NIER_AUTOMATA_SHARED_H_
#define NIER_AUTOMATA_SHARED_H_
struct ShaderInjectData {
  float peak_white_nits;
  float diffuse_white_nits;
  float graphics_white_nits;
  float exposure;
  float tone_map_type;
  float highlights;
  float shadows;
  float contrast;
  float saturation;
  float gamma_correction;
};
#ifndef __cplusplus
cbuffer shader_injection : register(b13) {
  ShaderInjectData shader_injection : packoffset(c0);
}
#define RENODX_PEAK_WHITE_NITS shader_injection.peak_white_nits
#define RENODX_DIFFUSE_WHITE_NITS shader_injection.diffuse_white_nits
#define RENODX_GRAPHICS_WHITE_NITS shader_injection.graphics_white_nits
#define RENODX_TONE_MAP_EXPOSURE shader_injection.exposure
#define RENODX_TONE_MAP_TYPE shader_injection.tone_map_type
#define RENODX_TONE_MAP_HIGHLIGHTS shader_injection.highlights
#define RENODX_TONE_MAP_SHADOWS shader_injection.shadows
#define RENODX_TONE_MAP_CONTRAST shader_injection.contrast
#define RENODX_TONE_MAP_SATURATION shader_injection.saturation
#define RENODX_GAMMA_CORRECTION shader_injection.gamma_correction
#define RENODX_INTERMEDIATE_ENCODING 1.f
#define RENODX_SWAP_CHAIN_DECODING 1.f
#define RENODX_SWAP_CHAIN_ENCODING 4.f
#define RENODX_SWAP_CHAIN_ENCODING_COLOR_SPACE 1.f
#define RENODX_RENO_DRT_TONE_MAP_METHOD renodx::tonemap::renodrt::config::tone_map_method::REINHARD
#include "../../shaders/renodx.hlsl"
#endif
#endif
