#include "./shared.h"

// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 20:30:25 2026

cbuffer camera : register(b0)
{
  float3 camera_position : packoffset(c0);
  float3 prev_camera_position : packoffset(c1);
  float4x4 view : packoffset(c2);
  float4x4 projection : packoffset(c6);
  float4x4 view_projection : packoffset(c10);
  float4x4 prev_view_projection : packoffset(c14);
  float4x4 inv_view : packoffset(c18);
  float4x4 prev_inv_view : packoffset(c22);
  float4x4 inv_projection : packoffset(c26);
  float4x4 inv_view_projection : packoffset(c30);
  float4 camera_near_far : packoffset(c34);
  float time_in_sec : packoffset(c35);
  float prev_time_in_sec : packoffset(c35.y);
  float real_time_in_sec : packoffset(c35.z);
  float update_time_in_sec : packoffset(c35.w);
  float2 g_inverse_focal_length : packoffset(c36);
  float g_vertical_fov : packoffset(c36.z);
  float g_aspect_ratio : packoffset(c36.w);
  float4 g_screen_size : packoffset(c37);
  float g_vpos_texel_offset : packoffset(c38);
  float4 g_viewport_dimensions : packoffset(c39);
  float2 g_viewport_origin : packoffset(c40);
  float4 g_render_target_dimensions : packoffset(c41);
  float4 g_camera_temp0 : packoffset(c42);
  float4 g_camera_temp1 : packoffset(c43);
  float4 g_camera_temp2 : packoffset(c44);
  float4 g_clip_rect : packoffset(c45);
  float3 g_vr_head_rotation : packoffset(c46);
  int g_num_of_samples : packoffset(c46.w);
  float g_supersampling : packoffset(c47);
  float4 g_mouse_position : packoffset(c48);
  float3 g_frustum_points[8] : packoffset(c49);
  float4 g_frustum_planes[6] : packoffset(c57);
  float g_orthographic : packoffset(c63);
  float g_overlay_lerp : packoffset(c63.y);
  float g_overlay_parchment_lerp : packoffset(c63.z);
  float g_overlay_show_details : packoffset(c63.w);
  float g_amount_shadow_in_far_distance : packoffset(c64);
  float2 g_camera_jitter : packoffset(c64.y);
  float2 g_prev_camera_jitter : packoffset(c65);
  uint g_debug_visualization_flags : packoffset(c65.z);
  bool g_taa_is_enabled : packoffset(c65.w);
}

cbuffer SHARPEN_CONSTANTS : register(b1)
{
  float g_sharpening_strength : packoffset(c0);
}

Texture2D<float3> t_frame : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  out float4 o0 : SV_Target0)
{
  uint4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.zw = uint2(0u,0u);
  r1.xyzw = asuint(float4(-1,-1,-1,-1) + g_render_target_dimensions.xyxy);
  r1.xyzw = (uint4)((int4)(asfloat(r1.xyzw)));
  r2.xy = (uint2)((int2)(v0.xy));
  r3.xyzw = (uint4)(r2.xyxy + uint4(0u,0xffffffffu,0xffffffffu,0u));
  r3.xyzw = (uint4)(max((int4)r3.xyzw, (int4)uint4(0u,0u,0u,0u)));
  r3.xyzw = (uint4)(min((int4)r1.zwxy, (int4)r3.zwxy));
  r0.xy = r3.zw;
  r0.xyz = asuint(t_frame.Load((int3)r0.xyz).xyz);
  r3.zw = uint2(0u,0u);
  r3.xyz = asuint(t_frame.Load((int3)r3.xyz).xyz);
  r0.xyz = asuint(-asfloat(r3.xyz) + -asfloat(r0.xyz));
  r2.zw = uint2(0u,0u);
  r3.xyz = asuint(t_frame.Load((int3)r2.xyz).xyz);
  r2.xyzw = (uint4)(r2.xyxy + uint4(1u,0u,0u,1u));
  r2.xyzw = (uint4)(max((int4)r2.xyzw, (int4)uint4(0u,0u,0u,0u)));
  r1.xyzw = (uint4)(min((int4)r1.zwxy, (int4)r2.zwxy));
  r0.xyz = asuint(mad(asfloat(r3.xyz), float3(5.0,5.0,5.0), asfloat(r0.xyz)));
  r2.xy = r1.zw;
  r2.zw = uint2(0u,0u);
  r2.xyz = asuint(t_frame.Load((int3)r2.xyz).xyz);
  r0.xyz = asuint(-asfloat(r2.xyz) + asfloat(r0.xyz));
  r1.zw = uint2(0u,0u);
  r1.xyz = asuint(t_frame.Load((int3)r1.xyz).xyz);
  r0.xyz = asuint(-asfloat(r1.xyz) + asfloat(r0.xyz));
  r0.xyz = asuint(asfloat(r0.xyz) + -asfloat(r3.xyz));
  o0.xyz = max(0, mad(float3(g_sharpening_strength,g_sharpening_strength,g_sharpening_strength), asfloat(r0.xyz), asfloat(r3.xyz)));
  o0.w = 1;
  return;
}