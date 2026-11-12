// Original: shader.dat/filtershadercameravelocity.pso - camera-motion velocity buffer for motion blur.
float4 main(float4 position : SV_POSITION, float2 uv : TEXCOORD0) : SV_Target0 {
  return float4(0.5, 0.5, 0.0, 0.0);
}