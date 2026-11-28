#include "./shared.h"

// ---- Created with 3Dmigoto v1.4.10 on Fri Nov 27 20:30:25 2026

struct Auto_exposure_output
{
    float tone_mapper_brightness;  // Offset:    0
};

cbuffer colorimetry_VS_PS : register(b0)
{
  float g_brightness : packoffset(c0);
  float g_gamma_output : packoffset(c0.y);
  float g_inv_gamma_output : packoffset(c0.z);
}

cbuffer camera : register(b1)
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

cbuffer lighting_VS_PS : register(b2)
{
  bool g_apply_environment_specular : packoffset(c0);
  float3 sun_direction : packoffset(c0.y);
  float3 sun_colour : packoffset(c1);
  float sun_specular : packoffset(c1.w);
  float3 ambient_cube_lr[2] : packoffset(c2);
  float3 ambient_cube_tb[2] : packoffset(c4);
  float3 ambient_cube_fb[2] : packoffset(c6);
  float3 g_deep_water_colour : packoffset(c8);
  float3 g_shallow_water_colour : packoffset(c9);
  float3 g_sea_bed_light_scatter : packoffset(c10);
  float g_refraction_light_scatter : packoffset(c10.w);
  int g_ssr_enabled : packoffset(c11);
  bool g_gi_enabled : packoffset(c11.y);
  bool g_use_spherical_harmonics : packoffset(c11.z);
  bool g_use_spherical_harmonics_array : packoffset(c11.w);
  float2 g_cloud_shadow_direction : packoffset(c12);
  float g_cloud_shadow_speed : packoffset(c12.z);
  float g_cloud_shadow_scale : packoffset(c12.w);
  float g_cloud_shadow_lerp : packoffset(c13);
  float2 g_noise_uv_shift : packoffset(c13.y);
  bool g_skin_enable : packoffset(c13.w);
  float2 g_skin_curvature_scale_bias : packoffset(c14);
  float2 g_skin_translucency_scale_bias : packoffset(c14.z);
  float3 g_skin_blood_colour : packoffset(c15);
  float4 g_world_bounds : packoffset(c16);
  float4 g_playable_area_bounds : packoffset(c17);
  float g_vegetation_wrap_lighting_bias : packoffset(c18);
  float g_spherical_harmonic_terms : packoffset(c18.y);
  float g_spherical_harmonic_fadeout : packoffset(c18.z);
  float g_ambient_fudge_factor : packoffset(c18.w);
  float g_time_of_day_unary : packoffset(c19);
  float terrain_shadow_softening : packoffset(c19.y);
  float terrain_shadow_bias_depth_threshold : packoffset(c19.z);
  float terrain_shadow_full_bias : packoffset(c19.w);
  uint distortion_blendmode : packoffset(c20);
  float g_irradiance_voxel_size[4] : packoffset(c21);
  float3 g_irradiance_world_offsets[4] : packoffset(c25);
  uint g_debug_lighting : packoffset(c28.w);
  float g_environment_specular_shadow_ratio : packoffset(c29);
  float g_vfx_global_emissive_brightness_multiplier : packoffset(c29.y);
  float g_sun_scale : packoffset(c29.z);
  float g_sun_brightness_factor : packoffset(c29.w);
}

cbuffer tone_mapping : register(b3)
{
  float g_tone_mapping_brightness : packoffset(c0);
  float g_tone_mapping_burn : packoffset(c0.y);
  int g_use_auto_exposure : packoffset(c0.z);
}

cbuffer hdr_to_screen_PS : register(b4)
{
  float4x4 colour_matrix : packoffset(c0);
  float lut_weights[3] : packoffset(c4);
  float overscan : packoffset(c6.y);
  int require_distortion_composition : packoffset(c6.z);
  float near_lut_strength : packoffset(c6.w);
  float far_lut_strength : packoffset(c7);
  float near_lut_distance : packoffset(c7.y);
  float far_lut_distance : packoffset(c7.z);
}

SamplerState g_hdr_rgb_texture_sampler_s : register(s0);
SamplerState g_hdr_rgb_bloom_texture_sampler_s : register(s1);
SamplerState distortion_sampler_s : register(s2);
SamplerState lut_sampler_s : register(s3);
Texture2D<float4> gbuffer_channel_3_texture : register(t0);
Texture2D<float4> gbuffer_channel_4_texture : register(t1);
Texture2D<float4> g_hdr_rgb_texture : register(t2);
Texture2D<float4> g_hdr_rgb_bloom_texture : register(t3);
StructuredBuffer<Auto_exposure_output> g_auto_exposure_input_buffer : register(t4);
Texture2D<float4> distortion_texture : register(t5);
Texture3D<float4> lut_texture_1 : register(t6);
Texture3D<float4> lut_texture_2 : register(t7);
Texture3D<float4> lut_texture_3 : register(t8);
Texture3D<float4> lut_secondary_texture_1 : register(t9);
Texture3D<float4> lut_secondary_texture_2 : register(t10);
Texture3D<float4> lut_secondary_texture_3 : register(t11);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  uint4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = asuint(g_screen_size.zw * v0.xy);
  r0.zw = asuint(overscan * asfloat(r0.xy));
  r1.xy = asuint(overscan * g_screen_size.zw);
  r1.zw = asuint(float2(0.5,0.5) * asfloat(r1.xy));
  r0.xy = asuint(mad(asfloat(r0.xy), float2(overscan,overscan), -(asfloat(r1.zw))));
  r2.xyzw = asuint(distortion_texture.SampleLevel(distortion_sampler_s, asfloat(r0.xy), 0).xyzw);
  r1.zw = asuint(mad(asfloat(r2.ww), -(asfloat(r2.xy)), asfloat(r2.xy)));
  r1.zw = asuint(mad(asfloat(r1.zw), float2(0.0199999996,0.0199999996), asfloat(r0.xy)));
  r3.x = (uint)-(int)((uint)(distortion_blendmode) == 1u);
  r3.y = (uint)-(int)(asfloat(r2.z) < 0.00100000005);
  r2.z = (r3.y != 0) ? 0x3f800000u : r2.z;
  r2.xy = asuint(asfloat(r2.xy) / asfloat(r2.zz));
  r2.z = asuint(1 + -asfloat(r2.w));
  r2.xy = asuint(asfloat(r2.zz) * asfloat(r2.xy));
  r2.xy = asuint(mad(asfloat(r2.ww), -(asfloat(r2.xy)), asfloat(r2.xy)));
  r2.xy = asuint(mad(asfloat(r2.xy), float2(0.0199999996,0.0199999996), asfloat(r0.xy)));
  r0.xy = (r3.xx != 0) ? r2.xy : r0.xy;
  r0.xy = (uint2((uint)(distortion_blendmode),(uint)(distortion_blendmode)) != 0) ? r0.xy : r1.zw;
  r0.xy = asuint(mad(asfloat(r1.xy), float2(0.5,0.5), asfloat(r0.xy)));
  r0.xy = (uint2((uint)(require_distortion_composition),(uint)(require_distortion_composition)) != 0) ? r0.xy : r0.zw;
  r1.xyz = asuint(g_hdr_rgb_texture.SampleLevel(g_hdr_rgb_texture_sampler_s, asfloat(r0.xy), 0).xyz);
  r2.xyz = asuint(g_hdr_rgb_bloom_texture.SampleLevel(g_hdr_rgb_bloom_texture_sampler_s, asfloat(r0.xy), 0).xyz);
  r1.xyz = asuint(asfloat(r2.xyz) + asfloat(r1.xyz));
  r0.z = asuint(g_auto_exposure_input_buffer[0].tone_mapper_brightness);
  r0.z = ((uint)(g_use_auto_exposure) != 0) ? r0.z : asuint(g_tone_mapping_brightness);
  r0.w = asuint(dot(asfloat(r1.xyz), float3(0.212599993,0.715200007,0.0722000003)));
  r1.w = (uint)-(int)(asfloat(r0.w) == 0.0);
  r0.z = asuint(asfloat(r0.z) * asfloat(r0.z));
  float3 untonemapped = g_brightness * asfloat(r0.z) * asfloat(r1.xyz);
  r2.x = asuint(asfloat(r0.z) * asfloat(r0.w));
  r2.y = asuint(1 / g_tone_mapping_burn);
  r2.y = asuint(-0.999000013 + asfloat(r2.y));
  r2.y = asuint(asfloat(r2.x) / asfloat(r2.y));
  r2.y = asuint(1 + asfloat(r2.y));
  r2.x = asuint(asfloat(r2.x) * asfloat(r2.y));
  r0.z = asuint(mad(asfloat(r0.z), asfloat(r0.w), 1.0));
  r0.z = asuint(asfloat(r2.x) / asfloat(r0.z));
  r1.xyz = asuint(asfloat(r1.xyz) * asfloat(r0.zzz));
  r2.xyz = asuint(asfloat(r1.xyz) / asfloat(r0.www));
  r2.w = 0x3f800000u;
  r1.xyzw = (r1.wwww != 0) ? uint4(0u,0u,0u,0u) : r2.xyzw;
  uiDest = 0;
  gbuffer_channel_4_texture.GetDimensions(0u, uiDest.x, uiDest.y, uiDest.w);
  r0.zw = (uint2)(uiDest.xy);
  r2.xy = asuint((float2)r0.zw);
  r2.xy = asuint(asfloat(r2.xy) * asfloat(r0.xy));
  r2.xy = asuint(floor(asfloat(r2.xy)));
  r2.xy = (uint2)((int2)(asfloat(r2.xy)));
  r0.zw = (uint2)(r0.zw + uint2(0xffffffffu,0xffffffffu));
  r2.xy = (uint2)(max((int2)r2.xy, (int2)uint2(0u,0u)));
  r2.xy = (uint2)(min((int2)r0.zw, (int2)r2.xy));
  float3 neutral_sdr = saturate(g_brightness * asfloat(r1.xyz));
  r3.xyz = asuint(neutral_sdr);
  r3.xyz = asuint(log2(asfloat(r3.xyz)));
  r3.xyz = asuint(g_inv_gamma_output * asfloat(r3.xyz));
  r3.xyz = asuint(exp2(asfloat(r3.xyz)));
  r3.w = 0x3f800000u;
  r4.x = asuint(dot(asfloat(r3.xyzw), colour_matrix._m00_m10_m20_m30));
  r4.y = asuint(dot(asfloat(r3.xyzw), colour_matrix._m01_m11_m21_m31));
  r4.z = asuint(dot(asfloat(r3.xyzw), colour_matrix._m02_m12_m22_m32));
  r2.zw = uint2(0u,0u);
  r0.z = asuint(gbuffer_channel_3_texture.Load((int3)r2.xyw).w);
  r0.z = asuint(255 * asfloat(r0.z));
  r0.z = asuint(round(asfloat(r0.z)));
  r0.z = (uint)((uint)(asfloat(r0.z)));
  r3.xyz = asuint(lut_texture_1.SampleLevel(lut_sampler_s, asfloat(r4.xyz), 0).xyz);
  r5.xyz = asuint(lut_texture_2.SampleLevel(lut_sampler_s, asfloat(r4.xyz), 0).xyz);
  r5.xyz = asuint(lut_weights[1] * asfloat(r5.xyz));
  r3.xyz = asuint(mad(asfloat(r3.xyz), float3(lut_weights[0],lut_weights[0],lut_weights[0]), asfloat(r5.xyz)));
  r5.xyz = asuint(lut_texture_3.SampleLevel(lut_sampler_s, asfloat(r4.xyz), 0).xyz);
  r1.xyz = asuint(mad(asfloat(r5.xyz), float3(lut_weights[2],lut_weights[2],lut_weights[2]), asfloat(r3.xyz)));
  r0.z = (uint)(r0.z & 2u);
  if (r0.z != 0) {
    r2.z = asuint(gbuffer_channel_4_texture.Load((int3)r2.xyz).x);
    r2.xy = asuint(mad(asfloat(r0.xy), float2(2.0,-2.0), float2(-1.0,1.0)));
    r2.w = 0x3f800000u;
    r0.x = asuint(dot(asfloat(r2.xyzw), inv_view_projection._m00_m10_m20_m30));
    r0.y = asuint(dot(asfloat(r2.xyzw), inv_view_projection._m01_m11_m21_m31));
    r0.z = asuint(dot(asfloat(r2.xyzw), inv_view_projection._m02_m12_m22_m32));
    r0.w = asuint(dot(asfloat(r2.xyzw), inv_view_projection._m03_m13_m23_m33));
    r0.xyz = asuint(asfloat(r0.xyz) / asfloat(r0.www));
    r0.xyz = asuint(-camera_position.xyz + asfloat(r0.xyz));
  { precise float lengthSquared = dot(asfloat(r0.xyz), asfloat(r0.xyz)); r0.x = asuint(lengthSquared); }
    r0.x = asuint(sqrt(asfloat(r0.x)));
    r0.y = asuint(far_lut_distance + -near_lut_distance);
    r0.x = asuint(-near_lut_distance + asfloat(r0.x));
    r0.y = asuint(1 / asfloat(r0.y));
    r0.x = asuint(saturate(asfloat(r0.x) * asfloat(r0.y)));
    r0.y = asuint(mad(asfloat(r0.x), -2.0, 3.0));
    r0.x = asuint(asfloat(r0.x) * asfloat(r0.x));
    r0.x = asuint(asfloat(r0.y) * asfloat(r0.x));
    r0.y = asuint(far_lut_strength + -near_lut_strength);
    r0.x = asuint(mad(asfloat(r0.x), asfloat(r0.y), near_lut_strength));
    r0.yzw = asuint(lut_secondary_texture_1.SampleLevel(lut_sampler_s, asfloat(r4.xyz), 0).xyz);
    r2.xyz = asuint(lut_secondary_texture_2.SampleLevel(lut_sampler_s, asfloat(r4.xyz), 0).xyz);
    r2.xyz = asuint(lut_weights[1] * asfloat(r2.xyz));
    r0.yzw = asuint(mad(asfloat(r0.yzw), float3(lut_weights[0],lut_weights[0],lut_weights[0]), asfloat(r2.xyz)));
    r2.xyz = asuint(lut_secondary_texture_3.SampleLevel(lut_sampler_s, asfloat(r4.xyz), 0).xyz);
    r0.yzw = asuint(mad(asfloat(r2.xyz), float3(lut_weights[2],lut_weights[2],lut_weights[2]), asfloat(r0.yzw)));
    r0.yzw = asuint(asfloat(r0.yzw) + -asfloat(r1.xyz));
    r1.xyz = asuint(mad(asfloat(r0.xxx), asfloat(r0.yzw), asfloat(r1.xyz)));
  }
  o0.xyzw = asfloat(r1.xyzw);
  // Game output is display-encoded with 1/g_inv_gamma_output; work in linear from here.
  float3 graded_sdr = renodx::color::gamma::DecodeSafe(o0.rgb, 1.f / g_inv_gamma_output);
  if (RENODX_TONE_MAP_TYPE == 0.f) {
    o0.rgb = saturate(graded_sdr);
  } else {
    o0.rgb = renodx::draw::ToneMapPass(untonemapped, graded_sdr, neutral_sdr);
  }
  o0.rgb = renodx::draw::RenderIntermediatePass(o0.rgb);
  return;
}