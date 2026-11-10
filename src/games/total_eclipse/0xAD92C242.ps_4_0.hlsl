// Original asset: adv/sys/compositor_look_right.dx11.pso; CRC32 0xAD92C242.
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  // Original decompiler: r0.x = (int6)g.loop_g;
  // Repair scalar DXBC itof conversion; no loop/count behavior change intended.
  r0.x = (float)g.loop_g;
  r0.y = 1 / r0.x;
  r0.z = cmp(g.rate_g < 0.5);
  if (r0.z != 0) {
    r0.z = g.rate_g + g.rate_g;
    r0.w = -g.rate_g * 2 + 2;
    r0.w = r0.w * v1.x + r0.z;
    r1.y = v1.y;
    r2.xyzw = float4(0,0,0,0);
    r1.z = g.loop_g;
    while (true) {
      r1.w = cmp((int)r1.z < 0);
      if (r1.w != 0) break;
      r1.w = (int)r1.z;
      r1.w = r1.w * r0.y;
      r1.w = r1.w * r0.z;
      r1.w = 0.5 * r1.w;
      r1.x = r0.w * 0.5 + r1.w;
      r3.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r1.xy).xyzw;
      // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
      r3.w = saturate(r3.w);
      r2.xyzw = r3.xyzw + r2.xyzw;
      r1.z = (int)r1.z + -1;
    }
    r1.xyzw = r2.xyzw / r0.xxxx;
  } else {
    r0.x = -0.5 + g.rate_g;
    r0.z = r0.x + r0.x;
    r0.w = 1 + v1.x;
    r2.x = -r0.x * 2 + 1;
    r3.yw = v1.yy;
    r4.xyzw = float4(0,0,0,0);
    r2.y = 0;
    r2.z = g.loop_g;
    while (true) {
      r2.w = cmp((int)r2.z < 0);
      if (r2.w != 0) break;
      r2.w = (int)r2.z;
      r2.w = r2.w * r0.y;
      r2.w = 0.5 * r2.w;
      r5.x = r0.w * 0.5 + r2.w;
      r3.x = r0.x * 2 + r5.x;
      r2.w = r2.w * r2.x;
      r3.z = r0.z * v1.x + -r2.w;
      r5.xy = cmp(r3.xz >= float2(0,0));
      r5.zw = cmp(float2(1,1) >= r3.xz);
      r5.xy = r5.zw ? r5.xy : 0;
      if (r5.x != 0) {
        r6.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r3.xy).xyzw;
        // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
        r6.w = saturate(r6.w);
        r4.xyzw = r6.xyzw + r4.xyzw;
        r2.y = 1 + r2.y;
      }
      if (r5.y != 0) {
        r5.xyzw = texture1_g_Texture.Sample(texture1_g_Sampler_s, r3.zw).xyzw;
        // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
        r5.w = saturate(r5.w);
        r4.xyzw = r5.xyzw + r4.xyzw;
        r2.y = 1 + r2.y;
      }
      r2.z = (int)r2.z + -1;
    }
    r1.xyzw = r4.xyzw / r2.yyyy;
  }
  r0.x = 1 + g.exposure_g;
  r0.x = g.brightness_g * r0.x;
  o0.xyz = r1.xyz * r0.xxx;
  o0.w = g.alpha_g * r1.w;
  // Original output above: o0.w = g.alpha_g * r1.w;
  // Added: restore bounded output alpha for the float target; preserve RGB headroom.
  o0.w = saturate(o0.w);
  return;
}