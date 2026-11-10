// Original assets: adv/sys/compositor_look_up_radial_blur_zoomin_first.dx11.pso; CRC32 0x52B00108.
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(g.rate_g < 0.5);
  if (r0.x != 0) {
    r0.x = g.rate_g + g.rate_g;
    r0.y = 1 + -g.rate_g;
    r1.xz = v1.xx;
    r2.xyzw = float4(0,0,0,0);
    r0.z = 8;
    while (true) {
      r0.w = cmp((int)r0.z < 0);
      if (r0.w != 0) break;
      r0.w = (int)r0.z;
      r0.w = r0.w * r0.x;
      r0.w = 0.0625 * r0.w;
      r1.yw = r0.yy * v1.yy + -r0.ww;
      r3.xyzw = float4(0.5,0,0.5,0) + -r1.zwzw;
      r0.w = dot(r3.zw, r3.zw);
      r4.x = sqrt(r0.w);
      r0.w = rsqrt(r0.w);
      r5.xyzw = r3.zwzw * r0.wwww;
      r6.xyzw = float4(0,0,0,0);
      r0.w = 0;
      while (true) {
        r4.y = (int)r0.w;
        r4.z = cmp(r4.y >= 8);
        if (r4.z != 0) break;
        r0.w = (int)r0.w + 1;
        r4.z = (int)r0.w;
        r4.z = r4.z * r4.x;
        r4.z = g.power_g * r4.z;
        r4.z = 0.001953125 * r4.z;
        r7.xyzw = r5.xyzw * r4.zzzz;
        r4.y = 0.125 * r4.y;
        r8.xyzw = r4.yyyy * r3.xyzw;
        r8.xyzw = g.power_g * r8.xyzw;
        r8.xyzw = r8.xyzw * float4(0.119999997,0.119999997,0.119999997,0.119999997) + r1.xyzw;
        r9.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r8.zw).xyzw;
        // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
        r9.w = saturate(r9.w);
        r7.xyzw = r7.xyzw * float4(3,3,6,6) + r8.xyzw;
        r8.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r7.xy).xyzw;
        // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
        r8.w = saturate(r8.w);
        r8.xyzw = float4(0.200000003,0.200000003,0.200000003,0.200000003) * r8.xyzw;
        r7.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r7.zw).xyzw;
        // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
        r7.w = saturate(r7.w);
        r8.xyzw = r9.xyzw * float4(0.699999988,0.699999988,0.699999988,0.699999988) + r8.xyzw;
        r7.xyzw = r7.xyzw * float4(0.100000001,0.100000001,0.100000001,0.100000001) + r8.xyzw;
        r6.xyzw = r7.xyzw + r6.xyzw;
      }
      r3.xyzw = r6.xyzw * float4(0.125,0.125,0.125,0.125) + -r2.xyzw;
      r2.xyzw = r3.xyzw * float4(0.300000012,0.300000012,0.300000012,0.300000012) + r2.xyzw;
      r0.z = (int)r0.z + -1;
    }
  } else {
    r0.x = -0.5 + g.rate_g;
    r0.y = r0.x + r0.x;
    r0.zw = r0.xx * float2(2,2) + float2(1,-2);
    r0.x = -r0.x * 2 + 1;
    r0.z = r0.z * v1.y + r0.x;
    r1.xz = v1.xx;
    r3.x = v1.x;
    r4.xyzw = float4(0,0,0,0);
    r5.xyzw = float4(0,0,0,0);
    r3.z = 8;
    while (true) {
      r3.w = cmp((int)r3.z < 0);
      if (r3.w != 0) break;
      r3.w = (int)r3.z;
      r3.w = 0.0625 * r3.w;
      r1.yw = v1.yy * float2(0.5,0.5) + -r3.ww;
      r6.xyzw = float4(0.5,0,0.5,0) + -r1.zwzw;
      r7.x = dot(r6.zw, r6.zw);
      r7.y = sqrt(r7.x);
      r7.x = rsqrt(r7.x);
      r8.xyzw = r7.xxxx * r6.zwzw;
      r9.xyzw = float4(0,0,0,0);
      r7.x = 0;
      while (true) {
        r7.z = (int)r7.x;
        r7.w = cmp(r7.z >= 8);
        if (r7.w != 0) break;
        r7.x = (int)r7.x + 1;
        r7.w = (int)r7.x;
        r7.w = r7.w * r7.y;
        r7.w = g.power_g * r7.w;
        r7.w = 0.001953125 * r7.w;
        r10.xyzw = r8.xyzw * r7.wwww;
        r7.z = 0.125 * r7.z;
        r11.xyzw = r7.zzzz * r6.xyzw;
        r11.xyzw = g.power_g * r11.xyzw;
        r11.xyzw = r11.xyzw * float4(0.119999997,0.119999997,0.119999997,0.119999997) + r1.xyzw;
        r12.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r11.zw).xyzw;
        // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
        r12.w = saturate(r12.w);
        r10.xyzw = r10.xyzw * float4(3,3,6,6) + r11.xyzw;
        r11.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r10.xy).xyzw;
        // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
        r11.w = saturate(r11.w);
        r11.xyzw = float4(0.200000003,0.200000003,0.200000003,0.200000003) * r11.xyzw;
        r10.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r10.zw).xyzw;
        // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
        r10.w = saturate(r10.w);
        r11.xyzw = r12.xyzw * float4(0.699999988,0.699999988,0.699999988,0.699999988) + r11.xyzw;
        r10.xyzw = r10.xyzw * float4(0.100000001,0.100000001,0.100000001,0.100000001) + r11.xyzw;
        r9.xyzw = r10.xyzw + r9.xyzw;
      }
      r6.xyzw = r9.xyzw * float4(0.125,0.125,0.125,0.125) + -r4.xyzw;
      r4.xyzw = r6.xyzw * float4(0.300000012,0.300000012,0.300000012,0.300000012) + r4.xyzw;
      r1.y = r3.w * r0.x;
      r3.y = r0.z * 0.5 + r1.y;
      r6.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r3.xy).xyzw;
      // Added: restore bounded UNORM scene alpha before effect math; preserve sampled RGB.
      r6.w = saturate(r6.w);
      r6.xyzw = r6.xyzw + -r5.xyzw;
      r5.xyzw = r6.xyzw * float4(0.300000012,0.300000012,0.300000012,0.300000012) + r5.xyzw;
      r3.z = (int)r3.z + -1;
    }
    r0.x = -r0.y * r0.w;
    r1.xyzw = r5.xyzw + -r4.xyzw;
    r2.xyzw = r0.xxxx * r1.xyzw + r4.xyzw;
  }
  r0.x = 1 + g.exposure_g;
  r0.x = g.brightness_g * r0.x;
  o0.xyz = r2.xyz * r0.xxx;
  o0.w = g.alpha_g * r2.w;
  // Original output above: o0.w = g.alpha_g * r2.w;
  // Added: bound float-target output alpha; retain original RGB, masks and discard expressions.
  o0.w = saturate(o0.w);
  return;
}