// Original asset: adv/sys/compositor_convolution_vertical.dx11.pso; CRC32 0x9F18E30D.
// ---- Created with 3Dmigoto v1.3.16 on Tue Nov 10 02:45:24 2026

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

SamplerState texture0_g_Sampler_s : register(s0);
SamplerState texture1_g_Sampler_s : register(s1);
Texture2D<float4> texture0_g_Texture : register(t0);
Texture2D<float4> texture1_g_Texture : register(t1);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : LOCATION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = -g.rate_g * g.rate_g + 1;
  r0.x = 0.100000001 * r0.x;
  r0.yz = float2(-0.5,-0.5) + v1.xy;
  r1.xz = float2(0,0);
  r1.y = 1 + -g.rate_g;
  r0.yz = -r0.yz * r1.xy + v1.xy;
  r2.xyzw = float4(0,0,0,0);
  r0.w = 0.0625;
  while (true) {
    r1.x = cmp(r0.w >= 1);
    if (r1.x != 0) break;
    r1.w = r0.w * r0.x;
    r1.xy = -r1.zw + r0.yz;
    r3.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r1.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
    r3.w = saturate(r3.w);
    r1.x = -r0.w * r0.w + 1;
    r2.xyzw = r3.xyzw * r1.xxxx + r2.xyzw;
    r0.w = 0.0625 + r0.w;
  }
  r0.x = 0.00200000009 * g.time_g;
  r0.x = saturate(max(g.rate_g, r0.x));
  r1.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
  r1.w = saturate(r1.w);
  r2.xyzw = r2.xyzw * float4(0.0984615386,0.0984615386,0.0984615386,0.0984615386) + -r1.xyzw;
  r0.xyzw = r0.xxxx * r2.xyzw + r1.xyzw;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = g.alpha_g * r0.w;
  // Original output above: o0.w = g.alpha_g * r0.w;
  // Added: restore bounded output alpha for the float target; preserve RGB headroom.
  o0.w = saturate(o0.w);
  return;
}