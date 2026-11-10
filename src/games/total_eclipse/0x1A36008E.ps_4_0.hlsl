// Original assets: adv/sys/compositor_radial_blur_zoomin_swirl.dx11.pso; CRC32 0x1A36008E.
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 0.125 * g.rate_g;
  r0.yz = float2(0.5,0.5) + -v1.yx;
  r0.w = dot(r0.yz, r0.yz);
  r1.x = sqrt(r0.w);
  r0.w = rsqrt(r0.w);
  r2.xyzw = r0.zyzy * r0.wwww;
  r3.xyzw = float4(0,0,0,0);
  r0.w = 0;
  while (true) {
    r1.y = (int)r0.w;
    r1.z = cmp(r1.y >= 8);
    if (r1.z != 0) break;
    r0.w = (int)r0.w + 1;
    r1.z = (int)r0.w;
    r1.z = r1.z * r0.x;
    r1.z = r1.z * r1.x;
    r1.z = g.power_g * r1.z;
    r1.z = 0.015625 * r1.z;
    r4.xyzw = r2.xyzw * r1.zzzz;
    r1.y = r1.y * r0.x;
    r1.yz = r1.yy * r0.yz;
    r1.yz = g.power_g * r1.yz;
    r1.yz = r1.yz * float2(0.119999997,0.119999997) + v1.yx;
    r1.yz = r1.yz * float2(720,1280) + float2(-360,-640);
    r5.xy = r1.yz * r1.yz;
    r1.w = r5.x + r5.y;
    r1.w = sqrt(r1.w);
    r5.x = min(abs(r1.y), abs(r1.z));
    r5.y = max(abs(r1.y), abs(r1.z));
    r5.y = 1 / r5.y;
    r5.x = r5.x * r5.y;
    r5.y = r5.x * r5.x;
    r5.z = r5.y * 0.0208350997 + -0.0851330012;
    r5.z = r5.y * r5.z + 0.180141002;
    r5.z = r5.y * r5.z + -0.330299497;
    r5.y = r5.y * r5.z + 0.999866009;
    r5.z = r5.x * r5.y;
    r5.w = cmp(abs(r1.z) < abs(r1.y));
    r5.z = r5.z * -2 + 1.57079637;
    r5.z = r5.w ? r5.z : 0;
    r5.x = r5.x * r5.y + r5.z;
    r5.y = cmp(r1.z < -r1.z);
    r5.y = r5.y ? -3.141593 : 0;
    r5.x = r5.x + r5.y;
    r5.y = min(r1.y, r1.z);
    r1.y = max(r1.y, r1.z);
    r1.z = cmp(r5.y < -r5.y);
    r1.y = cmp(r1.y >= -r1.y);
    r1.y = r1.y ? r1.z : 0;
    r1.y = r1.y ? -r5.x : r5.x;
    r1.y = r1.w * 0.0349065885 + r1.y;
    sincos(r1.y, r5.x, r6.x);
    r1.y = r6.x * r1.w + 640;
    r1.z = r5.x * r1.w + 360;
    r1.yz = float2(0.000781250012,0.00138888892) * r1.yz;
    r5.xyzw = frac(r1.yzyz);
    r6.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r5.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r6.w = saturate(r6.w);
    r4.xyzw = r4.xyzw * float4(3,3,6,6) + r5.xyzw;
    r5.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r4.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r5.w = saturate(r5.w);
    r5.xyzw = float4(0.200000003,0.200000003,0.200000003,0.200000003) * r5.xyzw;
    r4.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r4.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
    r4.w = saturate(r4.w);
    r5.xyzw = r6.xyzw * float4(0.699999988,0.699999988,0.699999988,0.699999988) + r5.xyzw;
    r4.xyzw = r4.xyzw * float4(0.100000001,0.100000001,0.100000001,0.100000001) + r5.xyzw;
    r3.xyzw = r4.xyzw + r3.xyzw;
  }
  r0.xyz = float3(0.125,0.125,0.125) * r3.xyz;
  r0.w = g.alpha_g * r3.w;
  r1.x = 1 + g.exposure_g;
  r1.x = g.brightness_g * r1.x;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = 0.125 * r0.w;
  // Original output above: o0.w = 0.125 * r0.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}