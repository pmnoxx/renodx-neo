// Original assets: adv/sys/compositor_radial_blur_swirl_right_contrast.dx11.pso; CRC32 0xCCD5860B.
// ---- Created with 3Dmigoto v1.3.16 on Tue Nov 10 02:45:25 2026

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
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v1.yx * float2(720,1280) + float2(-360,-640);
  r0.zw = r0.xy * r0.xy;
  r0.z = r0.z + r0.w;
  r0.z = sqrt(r0.z);
  r0.w = min(abs(r0.x), abs(r0.y));
  r1.x = max(abs(r0.x), abs(r0.y));
  r1.x = 1 / r1.x;
  r0.w = r1.x * r0.w;
  r1.x = r0.w * r0.w;
  r1.y = r1.x * 0.0208350997 + -0.0851330012;
  r1.y = r1.x * r1.y + 0.180141002;
  r1.y = r1.x * r1.y + -0.330299497;
  r1.x = r1.x * r1.y + 0.999866009;
  r1.y = r1.x * r0.w;
  r1.z = cmp(abs(r0.y) < abs(r0.x));
  r1.y = r1.y * -2 + 1.57079637;
  r1.y = r1.z ? r1.y : 0;
  r0.w = r0.w * r1.x + r1.y;
  r1.x = cmp(r0.y < -r0.y);
  r1.x = r1.x ? -3.141593 : 0;
  r0.w = r1.x + r0.w;
  r1.x = min(r0.x, r0.y);
  r0.x = max(r0.x, r0.y);
  r0.y = cmp(r1.x < -r1.x);
  r0.x = cmp(r0.x >= -r0.x);
  r0.x = r0.x ? r0.y : 0;
  r0.x = r0.x ? -r0.w : r0.w;
  r0.x = r0.z * 0.0349065885 + r0.x;
  sincos(r0.x, r0.x, r1.x);
  r0.y = r1.x * r0.z + 640;
  r0.x = r0.x * r0.z + 360;
  r0.xy = float2(0.00138888892,0.000781250012) * r0.xy;
  r1.xy = frac(r0.yx);
  r0.xy = float2(-0.5,-0.5) + r1.xy;
  r1.xyzw = float4(0,0,0,0);
  r0.z = 0;
  while (true) {
    r0.w = cmp((int)r0.z >= 16);
    if (r0.w != 0) break;
    r0.w = (int)r0.z;
    r0.w = 0.03125 * r0.w;
    r2.xy = r0.xy * r0.ww + float2(0.5,0.5);
    r2.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r2.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r2.w = saturate(r2.w);
    r1.xyzw = r2.xyzw + r1.xyzw;
    r0.z = (int)r0.z + 1;
  }
  r0.xyzw = float4(0.0625,0.0625,0.0625,0.0625) * r1.xyzw;
  r1.x = g.rate_g * 4 + 1;
  r2.xyzw = r1.xxxx * r0.xyzw;
  r0.xyzw = -r0.xyzw * r1.xxxx + float4(1,1,1,1);
  r0.xyzw = r0.xyzw * g.rate_g + r2.xyzw;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = g.alpha_g * r0.w;
  // Original output above: o0.w = g.alpha_g * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}