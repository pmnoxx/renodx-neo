// Clamp sampled alpha to retain UNORM blend semantics; preserve HDR RGB.
// ---- Created with 3Dmigoto v1.3.16 on Tue Nov 10 02:47:35 2026
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s7_s : register(s7);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

cbuffer cb10 : register(b10)
{
  float4 cb10[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 0.5 + v0.z;
  r0.x = (int)r0.x;
  if (r0.x == 0) {
    r1.xyzw = t0.Sample(s4_s, v0.xy).xyzw;
    r1.w = saturate(r1.w);
    r1.xyzw = v1.wxyz * r1.wxyz;
    r2.xyz = r1.yzw;
  } else {
    r0.y = cmp((int)r0.x == 1);
    if (r0.y != 0) {
      r3.xyzw = t1.Sample(s5_s, v0.xy).xyzw;
      r3.w = saturate(r3.w);
      r1.xyzw = v1.wxyz * r3.wxyz;
      r2.xyz = r1.yzw;
    } else {
      r0.y = cmp((int)r0.x == 2);
      if (r0.y != 0) {
        r3.xyzw = t2.Sample(s6_s, v0.xy).xyzw;
        r3.w = saturate(r3.w);
        r1.xyzw = v1.wxyz * r3.wxyz;
        r2.xyz = r1.yzw;
      } else {
        r0.x = cmp((int)r0.x == 3);
        if (r0.x != 0) {
          r0.xyzw = t3.Sample(s7_s, v0.xy).xyzw;
          r0.w = saturate(r0.w);
          r1.xyzw = v1.wxyz * r0.wxyz;
          r2.xyz = r1.yzw;
        } else {
          r2.xyz = v1.xyz;
          r1.x = v1.w;
        }
      }
    }
  }
  r0.x = cb10[7].z * r1.x;
  r0.x = cmp(r0.x < cb10[7].x);
  if (r0.x != 0) discard;
  r2.w = 1;
  o0.x = dot(cb10[4].xyzw, r2.xyzw);
  o0.y = dot(cb10[5].xyzw, r2.xyzw);
  o0.z = dot(cb10[6].xyzw, r2.xyzw);
  o0.w = saturate(r1.x * cb10[7].z + cb10[7].y);
  return;
}

