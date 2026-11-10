Texture2D<float4> scene : register(t0);

float4 main(float4 position : SV_POSITION, float2 uv : TEXCOORD0) : SV_TARGET {
  // Scene artwork is gamma encoded. Restore UNORM storage for CPU thumbnails.
  return saturate(scene.Load(int3(uint2(position.xy), 0)));
}
