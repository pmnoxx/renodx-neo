// Original asset: adv/sys/compositor_tears18.dx11.pso; CRC32 0x99C7904B.
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
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r0.xy = float2(0.5,0.5) + -abs(r0.xy);
  r0.xy = cmp(r0.xy < float2(0,0));
  if (r0.x != 0) discard;
  if (r0.y != 0) discard;
  r0.xy = v1.yx * float2(720,720) + float2(-640,-360);
  r0.z = max(abs(r0.x), abs(r0.y));
  r0.z = 1 / r0.z;
  r0.w = min(abs(r0.x), abs(r0.y));
  r0.z = r0.w * r0.z;
  r0.w = r0.z * r0.z;
  r1.x = r0.w * 0.0208350997 + -0.0851330012;
  r1.x = r0.w * r1.x + 0.180141002;
  r1.x = r0.w * r1.x + -0.330299497;
  r0.w = r0.w * r1.x + 0.999866009;
  r1.x = r0.z * r0.w;
  r1.x = r1.x * -2 + 1.57079637;
  r1.y = cmp(abs(r0.y) < abs(r0.x));
  r1.x = r1.y ? r1.x : 0;
  r0.z = r0.z * r0.w + r1.x;
  r0.w = cmp(r0.y < -r0.y);
  r0.w = r0.w ? -3.141593 : 0;
  r0.z = r0.z + r0.w;
  r0.w = min(r0.x, r0.y);
  r0.w = cmp(r0.w < -r0.w);
  r1.x = max(r0.x, r0.y);
  r0.xy = r0.xy * r0.xy;
  r0.x = r0.x + r0.y;
  r0.x = sqrt(r0.x);
  r0.y = cmp(r1.x >= -r1.x);
  r0.y = r0.y ? r0.w : 0;
  r0.y = r0.y ? -r0.z : r0.z;
  sincos(r0.y, r1.x, r2.x);
  r0.y = -625 * g.time_g;
  r0.y = r0.x * 8 + r0.y;
  r0.y = 0.00153398083 * r0.y;
  r0.y = sin(r0.y);
  r0.y = g.rate_g * r0.y;
  r0.x = r0.y * 4 + r0.x;
  r0.y = r2.x * r0.x + 360;
  r0.x = r1.x * r0.x + 640;
  r0.x = 0.00138888892 * r0.x;
  r1.y = frac(r0.x);
  r0.x = 0.00138888892 * r0.y;
  r1.x = frac(r0.x);
  r0.xyzw = texture0_g_Texture.Sample(texture0_g_Sampler_s, r1.xy).xyzw;
  // Added: restore bounded UNORM scene alpha before filtering/modulation/discard.
  r0.w = saturate(r0.w);
  r1.x = r0.w + r0.w;
  r0.w = -r0.w * 2 + 1;
  o0.xyz = r0.xyz;
  r0.x = 1 + -g.alpha_g;
  r0.x = r0.w * r0.x + r1.x;
  r0.y = -0.00392156886 + r0.x;
  o0.w = r0.x;
  // Original output above: o0.w = r0.x;
  // Added: restore bounded output alpha for the float target; preserve RGB headroom.
  o0.w = saturate(o0.w);
  r0.x = cmp(r0.y < 0);
  if (r0.x != 0) discard;
  return;
}