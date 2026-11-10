#include "./shared.h"
Texture2D<float4> scene : register(t0);
SamplerState scene_sampler : register(s0);
float4 main(float4 position : SV_Position, float2 uv : TEXCOORD0) : SV_Target {
  return renodx::draw::SwapChainPass(scene.Sample(scene_sampler, uv));
}
