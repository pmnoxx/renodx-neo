// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 09 13:09:55 2026

cbuffer _Unif_g_0 : register(b1)
{

  struct
  {
    float4 pos_g;
    float rate_g;
    float time_g;
    float alpha_g;
    float exposure_g;
    float brightness_g;
    float value_g;
    int loop_g;
    float power_g;
  } g : packoffset(c0);

}

SamplerState texture1_g_Sampler_s : register(s1);
Texture2D<float4> texture1_g_Texture : register(t1);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : LOCATION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 1 + g.exposure_g;
  r0.x = g.brightness_g * r0.x;
  r1.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, v1.xy).xyzw;
  // Preserve the original UNORM alpha behavior with float scene targets.
  r1.w = saturate(r1.w);
  r1.xyzw = float4(-1,-1,-1,-1) + r1.xyzw;
  r1.xyzw = g.rate_g * r1.xyzw + float4(1,1,1,1);
  o0.xyz = r1.xyz * r0.xxx;
  o0.w = saturate(g.alpha_g * r1.w);
  return;
}