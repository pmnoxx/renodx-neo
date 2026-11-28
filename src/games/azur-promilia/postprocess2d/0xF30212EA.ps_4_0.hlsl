// Hidden/Lens Render Pipeline/Utils/PostProcess2D
#include "../shared.h"

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[128];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  // Fit highlights into the SDR LUT domain without changing hue. Keep vanilla clipping in Vanilla mode.
  float3 lut_input = max(r0.xyz, 0.f);
  float highlight_scale = 1.f;
  if (RENODX_TONE_MAP_TYPE != 0.f) {
    highlight_scale = max(1.f, max(lut_input.r, max(lut_input.g, lut_input.b)));
  }
  r0.xyz = saturate(lut_input / highlight_scale);
  r0.w = cmp(0 < cb0[121].w);
  if (r0.w != 0) {
    r1.xyz = float3(12.9200001,12.9200001,12.9200001) * r0.xyz;
    r2.xyz = log2(r0.xyz);
    r2.xyz = float3(0.416666657,0.416666657,0.416666657) * r2.xyz;
    r2.xyz = exp2(r2.xyz);
    r2.xyz = r2.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
    r3.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r0.xyz);
    r1.xyz = r3.xyz ? r1.xyz : r2.xyz;
    r2.xyz = cb0[121].zzz * r1.zxy;
    r0.w = floor(r2.x);
    r2.xw = float2(0.5,0.5) * cb0[121].xy;
    r2.yz = r2.yz * cb0[121].xy + r2.xw;
    r2.x = r0.w * cb0[121].y + r2.y;
    r3.xyzw = t2.SampleLevel(s0_s, r2.xz, 0).xyzw;
    r4.x = cb0[121].y;
    r4.y = 0;
    r2.xy = r4.xy + r2.xz;
    r2.xyzw = t2.SampleLevel(s0_s, r2.xy, 0).xyzw;
    r0.w = r1.z * cb0[121].z + -r0.w;
    r2.xyz = r2.xyz + -r3.xyz;
    r2.xyz = r0.www * r2.xyz + r3.xyz;
    r2.xyz = r2.xyz + -r1.xyz;
    r1.xyz = cb0[121].www * r2.xyz + r1.xyz;
    r2.xyz = float3(0.0773993805,0.0773993805,0.0773993805) * r1.xyz;
    r3.xyz = float3(0.0549999997,0.0549999997,0.0549999997) + r1.xyz;
    r3.xyz = float3(0.947867334,0.947867334,0.947867334) * r3.xyz;
    r3.xyz = log2(abs(r3.xyz));
    r3.xyz = float3(2.4000001,2.4000001,2.4000001) * r3.xyz;
    r3.xyz = exp2(r3.xyz);
    r1.xyz = cmp(float3(0.0404499993,0.0404499993,0.0404499993) >= r1.xyz);
    r0.xyz = r1.xyz ? r2.xyz : r3.xyz;
  }
  // Restore HDR headroom after the LUT and before white balance, vignette, and overlays.
  r0.xyz *= highlight_scale;
  r1.xyz = float3(0.0773993805,0.0773993805,0.0773993805) * r0.xyz;
  r2.xyz = float3(0.0549999997,0.0549999997,0.0549999997) + r0.xyz;
  r2.xyz = float3(0.947867334,0.947867334,0.947867334) * r2.xyz;
  r2.xyz = log2(abs(r2.xyz));
  r2.xyz = float3(2.4000001,2.4000001,2.4000001) * r2.xyz;
  r2.xyz = exp2(r2.xyz);
  r0.xyz = cmp(float3(0.0404499993,0.0404499993,0.0404499993) >= r0.xyz);
  r0.xyz = r0.xyz ? r1.xyz : r2.xyz;
  r1.x = dot(float3(0.390404999,0.549941003,0.00892631989), r0.xyz);
  r1.y = dot(float3(0.070841603,0.963172019,0.00135775004), r0.xyz);
  r1.z = dot(float3(0.0231081992,0.128021002,0.936245024), r0.xyz);
  r0.xyz = cb0[119].xyz * r1.xyz;
  r1.x = dot(float3(2.85846996,-1.62879002,-0.0248910002), r0.xyz);
  r1.y = dot(float3(-0.210181996,1.15820003,0.000324280991), r0.xyz);
  r1.z = dot(float3(-0.0418119989,-0.118169002,1.06867003), r0.xyz);
  r0.xyz = float3(12.9200001,12.9200001,12.9200001) * r1.xyz;
  r2.xyz = log2(abs(r1.xyz));
  r2.xyz = float3(0.416666657,0.416666657,0.416666657) * r2.xyz;
  r2.xyz = exp2(r2.xyz);
  r2.xyz = r2.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  r1.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r1.xyz);
  r0.xyz = r1.xyz ? r0.xyz : r2.xyz;
  r0.w = cmp(0 < cb0[127].z);
  if (r0.w != 0) {
    r1.xy = float2(-0.5,-0.5) + v1.xy;
    r0.w = -cb0[127].w + cb0[119].w;
    r0.w = max(0, r0.w);
    r1.z = cb0[127].w + cb0[119].w;
    r1.z = min(1, r1.z);
    r1.x = dot(abs(r1.xy), abs(r1.xy));
    r1.y = r1.z + -r0.w;
    r0.w = r1.x + -r0.w;
    r1.x = 1 / r1.y;
    r0.w = saturate(r1.x * r0.w);
    r1.x = r0.w * -2 + 3;
    r0.w = r0.w * r0.w;
    r0.w = r1.x * r0.w;
    r0.w = cb0[127].z * r0.w;
    r1.xyz = cb0[126].xyz + -r0.xyz;
    r0.xyz = r0.www * r1.xyz + r0.xyz;
  }
  r1.xy = cb0[120].xy * v1.xy;
  r1.xyzw = t1.Sample(s1_s, r1.xy).xyzw;
  r0.w = -0.5 + r1.w;
  r0.w = r0.w + r0.w;
  r1.x = dot(r0.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r1.x = max(0, r1.x);
  r1.x = sqrt(r1.x);
  r1.x = 1 + -r1.x;
  r1.yzw = r0.xyz * r0.www;
  r1.yzw = cb0[120].zzz * r1.yzw;
  o0.xyz = r1.yzw * r1.xxx + r0.xyz;
  o0.w = 1;
  return;
}