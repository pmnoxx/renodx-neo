#include "./shared.h"
Texture2D<float4> scene : register(t0);
SamplerState scene_sampler : register(s0);
float4 main(float4 position : SV_Position, float2 uv : TEXCOORD0) : SV_Target {
  float4 color = scene.Sample(scene_sampler, uv);
  if (NIER_TONE_MAP_VANILLA) color.rgb = clamp(color.rgb, 0.0, NierSdrWhiteIntermediate());
  return renodx::draw::SwapChainPass(color);
}
