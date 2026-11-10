// Original asset: adv/sys/compositor_tears19.dx11.pso; CRC32 0x75567A68.
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
Texture2D<float4> texture0_g_Texture : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : LOCATION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, v1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
  r0.w = saturate(r0.w);
  r1.x = cmp(0.899999976 < v1.x);
  if (r1.x != 0) {
    r1.x = v1.x;
  } else {
    r1.y = cmp(0.800000012 < v1.x);
    r1.z = cmp(0.100000001 < g.rate_g);
    r1.y = r1.z ? r1.y : 0;
    if (r1.y != 0) {
      r1.x = 0.100000001 + v1.x;
    } else {
      r1.y = cmp(0.699999988 < v1.x);
      r1.z = cmp(0.200000003 < g.rate_g);
      r1.y = r1.z ? r1.y : 0;
      if (r1.y != 0) {
        r1.x = 0.200000003 + v1.x;
      } else {
        r1.y = cmp(0.600000024 < v1.x);
        r1.z = cmp(0.300000012 < g.rate_g);
        r1.y = r1.z ? r1.y : 0;
        if (r1.y != 0) {
          r1.x = 0.300000012 + v1.x;
        } else {
          r1.y = cmp(0.5 < v1.x);
          r1.z = cmp(0.400000006 < g.rate_g);
          r1.y = r1.z ? r1.y : 0;
          if (r1.y != 0) {
            r1.x = 0.400000006 + v1.x;
          } else {
            r2.xyzw = cmp(float4(0.400000006,0.300000012,0.200000003,0.100000001) < v1.xxxx);
            r3.xyzw = cmp(float4(0.5,0.600000024,0.699999988,0.800000012) < g.rate_g);
            r2.xyzw = r2.xyzw ? r3.xyzw : 0;
            r3.xyzw = float4(0.5,0.600000024,0.699999988,0.800000012) + v1.xxxx;
            r1.y = cmp(0.899999976 < g.rate_g);
            r1.z = 0.899999976 + v1.x;
            r1.w = 10 * g.rate_g;
            r1.w = trunc(r1.w);
            r1.w = r1.w * 0.100000001 + v1.x;
            r1.y = r1.y ? r1.z : r1.w;
            r1.y = r2.w ? r3.w : r1.y;
            r1.y = r2.z ? r3.z : r1.y;
            r1.y = r2.y ? r3.y : r1.y;
            r1.x = r2.x ? r3.x : r1.y;
          }
        }
      }
    }
  }
  r1.y = -0.5 + r1.x;
  r1.y = 0.5 + -abs(r1.y);
  r1.y = cmp(r1.y < 0);
  if (r1.y != 0) discard;
  r1.y = -0.5 + v1.y;
  r1.y = 0.5 + -abs(r1.y);
  r1.y = cmp(r1.y < 0);
  if (r1.y != 0) discard;
  r1.y = 2560 * g.rate_g;
  r1.y = trunc(r1.y);
  r2.yw = v1.yy;
  r3.xyzw = r0.xyzw;
  r1.zw = float2(1,0);
  while (true) {
    r4.x = cmp(r1.w >= r1.y);
    if (r4.x != 0) break;
    r2.x = saturate(r1.w * 0.000781250012 + r1.x);
    r4.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.xy).xyzw;
    // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
    r4.w = saturate(r4.w);
    r4.xyzw = r4.xyzw + r3.xyzw;
    r2.z = saturate(-r1.w * 0.000781250012 + r1.x);
    r5.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r2.zw).xyzw;
    // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
    r5.w = saturate(r5.w);
    r3.xyzw = r5.xyzw + r4.xyzw;
    r1.zw = float2(2,128) + r1.zw;
  }
  r0.xyzw = r3.xyzw / r1.zzzz;
  r1.x = r0.w * 2 + -0.00392156886;
  r1.x = cmp(r1.x < 0);
  if (r1.x != 0) discard;
  o0.xyzw = float4(1,1,1,2) * r0.xyzw;
  // Original output above: o0.xyzw = float4(1,1,1,2) * r0.xyzw;
  // Added: restore bounded output alpha for the float target; preserve RGB headroom.
  o0.w = saturate(o0.w);
  return;
}