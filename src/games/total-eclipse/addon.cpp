/*
 * Copyright (C) 2024 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */

#define ImTextureID ImU64

#define DEBUG_LEVEL_0

#include <atomic>
#include <cstdio>
#include <cstring>
#include <array>
#include <Windows.h>

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include <embed/shaders.h>

#include "../../mods/shader.hpp"
#include "../../mods/swapchain.hpp"
#include "../../utils/settings.hpp"
#include "../../utils/render.hpp"
#include "../../utils/resource_upgrade.hpp"
#include "../../utils/detour.hpp"
#include "./shared.h"

namespace {

renodx::mods::shader::CustomShaders custom_shaders = {
    // Keep extracted game filenames and all known aliases beside each hash when entries change.
    CustomShaderEntry(0x1880F22A),  // erc_nospfx.dll, embedded DXBC at file offset 0x718e10 (artwork/UI composite).
    CustomShaderEntry(0x5C733846),  // adv/sys/compositor_crossfade.dx11.pso; compositor_retrospective.dx11.pso
    CustomShaderEntry(0x18F1647D),  // adv/sys/compositor_whitein.dx11.pso; compositor_retrospective_flashback.dx11.pso
    CustomShaderEntry(0xA4BA7C88),  // adv/sys/compositor_pattern.dx11.pso
    CustomShaderEntry(0x5E79C239),  // adv/sys/compositor_look_up.dx11.pso
    CustomShaderEntry(0x71C2DC46),  // adv/sys/compositor_look_down.dx11.pso
    CustomShaderEntry(0x7D673404),  // adv/sys/compositor_look_left.dx11.pso
    CustomShaderEntry(0xAD92C242),  // adv/sys/compositor_look_right.dx11.pso
    CustomShaderEntry(0x1FB156BF),  // adv/sys/compositor_convolution_horizontal.dx11.pso
    CustomShaderEntry(0x9F18E30D),  // adv/sys/compositor_convolution_vertical.dx11.pso
    CustomShaderEntry(0x73B46598),  // adv/sys/compositor_tears14.dx11.pso
    CustomShaderEntry(0x99C7904B),  // adv/sys/compositor_tears18.dx11.pso
    CustomShaderEntry(0x75567A68),  // adv/sys/compositor_tears19.dx11.pso
    CustomShaderEntry(0xA5FA10A3),  // adv/sys/compositor_stretch_horizontal.dx11.pso
    CustomShaderEntry(0x04AFA939),  // adv/sys/compositor_zoomout_no_blur.dx11.pso
    CustomShaderEntry(0x07F13C43),  // adv/sys/compositor_tears15.dx11.pso
    CustomShaderEntry(0x0E91610A),  // adv/sys/compositor_radial_blur_zoominout.dx11.pso
    CustomShaderEntry(0x1029028D),  // adv/sys/compositor_invert_colorFade.dx11.pso
    CustomShaderEntry(0x1389025F),  // adv/sys/compositor_stretchout_vertical.dx11.pso
    CustomShaderEntry(0x161F92EF),  // adv/sys/compositor_dizzy_fade.dx11.pso
    CustomShaderEntry(0x19150AD5),  // adv/sys/compositor_h_raster.dx11.pso
    CustomShaderEntry(0x1A36008E),  // adv/sys/compositor_radial_blur_zoomin_swirl.dx11.pso
    CustomShaderEntry(0x1E04407C),  // adv/sys/compositor_sidewipe_stretchout_horizontal.dx11.pso
    CustomShaderEntry(0x24D4BE6B),  // adv/sys/compositor_contrast.dx11.pso
    CustomShaderEntry(0x2520FAD7),  // adv/sys/compositor_mosaicinout.dx11.pso
    CustomShaderEntry(0x25526F4A),  // adv/sys/compositor_shake_rotate.dx11.pso
    CustomShaderEntry(0x276424E0),  // adv/sys/compositor_stretch_vertical_FadeOut.dx11.pso
    CustomShaderEntry(0x27DC036C),  // adv/sys/compositor_curtain_from_bottom.dx11.pso
    CustomShaderEntry(0x29BE542C),  // adv/sys/compositor_swirl_left.dx11.pso; adv/sys/compositor_swirl_right.dx11.pso
    CustomShaderEntry(0x2B3D2CF0),  // adv/sys/compositor_shake_shift.dx11.pso
    CustomShaderEntry(0x2C4EA2A1),  // adv/sys/compositor_tears12.dx11.pso
    CustomShaderEntry(0x329DE360),  // adv/sys/compositor_zoominout_no_blur_and_invert.dx11.pso
    CustomShaderEntry(0x348A8420),  // adv/sys/compositor_dizzy.dx11.pso
    CustomShaderEntry(0x35D8646E),  // adv/sys/compositor_radial_blur_zoomout.dx11.pso
    CustomShaderEntry(0x35E850D4),  // adv/sys/compositor_dizzy_blur.dx11.pso
    CustomShaderEntry(0x383C56B6),  // adv/sys/compositor_tears6.dx11.pso
    CustomShaderEntry(0x3874E438),  // adv/sys/compositor_tears16.dx11.pso
    CustomShaderEntry(0x4277601B),  // adv/sys/compositor_swirl_right_revers.dx11.pso
    CustomShaderEntry(0x46E67DEA),  // adv/sys/compositor_radial_blur_zoomin_curtain.dx11.pso
    CustomShaderEntry(0x52B00108),  // adv/sys/compositor_look_up_radial_blur_zoomin_first.dx11.pso
    CustomShaderEntry(0x5348A8A6),  // adv/sys/compositor_radial_blur_zoomin_reentry.dx11.pso
    CustomShaderEntry(0x561BC426),  // adv/sys/compositor_radial_blur_zoomin_first.dx11.pso
    CustomShaderEntry(0x588E6AAC),  // adv/sys/compositor_tears10.dx11.pso
    CustomShaderEntry(0x5A5D4D49),  // adv/sys/compositor_radial_blur_zoomin_end.dx11.pso
    CustomShaderEntry(0x5D55845F),  // adv/sys/compositor_zoomout.dx11.pso
    CustomShaderEntry(0x60CC7F67),  // adv/sys/compositor_tears5.dx11.pso
    CustomShaderEntry(0x61E19493),  // adv/sys/compositor_radial_blur_zoomin.dx11.pso
    CustomShaderEntry(0x6687142B),  // adv/sys/compositor_stretchout_horizontal_end.dx11.pso
    CustomShaderEntry(0x66BA614E),  // adv/sys/compositor_mosaicout.dx11.pso
    CustomShaderEntry(0x675085E0),  // adv/sys/compositor_mosaicin.dx11.pso
    CustomShaderEntry(0x67F1FCAC),  // adv/sys/compositor_tears2.dx11.pso
    CustomShaderEntry(0x7161B923),  // adv/sys/compositor_invert_color.dx11.pso
    CustomShaderEntry(0x71A54AE8),  // adv/sys/compositor_radial_blur_zoomin_susanoh.dx11.pso
    CustomShaderEntry(0x72FC4F87),  // adv/sys/compositor_swirl_left_retrospective.dx11.pso; adv/sys/compositor_swirl_right_retrospective.dx11.pso
    CustomShaderEntry(0x79FAA200),  // adv/sys/compositor_stretchout_horizontal.dx11.pso
    CustomShaderEntry(0x8C46DCFF),  // adv/sys/compositor_curtain_from_right.dx11.pso
    CustomShaderEntry(0x918F75F6),  // adv/sys/compositor_contrast_stretchout.dx11.pso
    CustomShaderEntry(0x91929AE5),  // adv/sys/compositor_radial_blur_zoomin_yokohama.dx11.pso
    CustomShaderEntry(0x9257B8C7),  // adv/sys/compositor_radial_blur_zoomin_first_end.dx11.pso
    CustomShaderEntry(0x95565630),  // adv/sys/compositor_curtain_from_top.dx11.pso
    CustomShaderEntry(0x9AC31DB1),  // adv/sys/compositor_sidewipe_blur_zoomin.dx11.pso
    CustomShaderEntry(0x9D0D3AFE),  // adv/sys/compositor_look_up_stretchout_horizontal.dx11.pso
    CustomShaderEntry(0x9E1FC3EE),  // adv/sys/compositor_stretch_vertical.dx11.pso
    CustomShaderEntry(0x9FF90EE8),  // adv/sys/compositor_ripple.dx11.pso
    CustomShaderEntry(0xA1501C1B),  // adv/sys/compositor_shake_shift_and_stretchout.dx11.pso
    CustomShaderEntry(0xA2AACCC0),  // adv/sys/compositor_tears17.dx11.pso; adv/sys/compositor_tears4.dx11.pso
    CustomShaderEntry(0xA2F65173),  // adv/sys/compositor_fadeout.dx11.pso
    CustomShaderEntry(0xA4753468),  // adv/sys/compositor_invert_end.dx11.pso
    CustomShaderEntry(0xA5A2BF96),  // adv/sys/compositor_battered.dx11.pso
    CustomShaderEntry(0xA6EAF5F0),  // adv/sys/compositor_wave_horizontal.dx11.pso
    CustomShaderEntry(0xAA991EFE),  // adv/sys/compositor_fade.dx11.pso
    CustomShaderEntry(0xB155454D),  // adv/sys/compositor_tears1.dx11.pso
    CustomShaderEntry(0xB2ABF833),  // adv/sys/compositor_look_up_radial_blur_zoomin_first2.dx11.pso
    CustomShaderEntry(0xB6F4B7F0),  // adv/sys/compositor_stretch_bottom.dx11.pso
    CustomShaderEntry(0xC36673BF),  // adv/sys/compositor_tears3.dx11.pso
    CustomShaderEntry(0xC3721F7D),  // adv/sys/compositor_stretch_horizontal_and_sidewipe.dx11.pso
    CustomShaderEntry(0xC3AD5E55),  // adv/sys/compositor_dizzy_stretchout_horizontal.dx11.pso
    CustomShaderEntry(0xC7A42D87),  // adv/sys/compositor_invert_shake_rotate.dx11.pso
    CustomShaderEntry(0xC98A879E),  // adv/sys/compositor_tears8.dx11.pso
    CustomShaderEntry(0xCCD5860B),  // adv/sys/compositor_radial_blur_swirl_right_contrast.dx11.pso
    CustomShaderEntry(0xD7A870F1),  // adv/sys/compositor_stretchout_horizontal2.dx11.pso
    CustomShaderEntry(0xE0AFEA57),  // adv/sys/compositor_curtain_from_left.dx11.pso
    CustomShaderEntry(0xE32DEE89),  // adv/sys/compositor_swirl_left_invert.dx11.pso; adv/sys/compositor_swirl_right_invert.dx11.pso
    CustomShaderEntry(0xE6E7B55C),  // adv/sys/compositor_flash.dx11.pso
    CustomShaderEntry(0xE80E0A36),  // adv/sys/compositor_sidewipe_from_right.dx11.pso
    CustomShaderEntry(0xE9455CB7),  // adv/sys/compositor_tears11.dx11.pso
    CustomShaderEntry(0xECFC1A66),  // adv/sys/compositor_mosaicin_black.dx11.pso
    CustomShaderEntry(0xED7256D4),  // adv/sys/compositor_zoominout_no_blur.dx11.pso
    CustomShaderEntry(0xEE086F61),  // adv/sys/compositor_tears7.dx11.pso
    CustomShaderEntry(0xF05F86D4),  // adv/sys/compositor_tears9.dx11.pso
    CustomShaderEntry(0xF187CA72),  // adv/sys/compositor_zoomin.dx11.pso
    CustomShaderEntry(0xF1EDCFC2),  // adv/sys/compositor_radial_blur_zoomin_first_end2.dx11.pso
    CustomShaderEntry(0xFBB63119),  // adv/sys/compositor_swirl_right_contrast.dx11.pso
    CustomShaderEntry(0xFC167D88),  // adv/sys/compositor_tears13.dx11.pso
};

ShaderInjectData shader_injection;

// Total Eclipse's scenario target resize is an engine-internal operation. Keep
// the executable version checks beside the hooks; unsupported builds stay native.
using BindTarget = void (*)(uintptr_t scene, uintptr_t texture);
using DrawScreen = void (*)(uintptr_t screen);
using DestroyScene = void (*)(uintptr_t scene);
using ResizeScreen = void (*)(uintptr_t screen, int width, int height);
BindTarget bind_target_original = nullptr;
DrawScreen draw_screen_original = nullptr;
DestroyScene destroy_scene_original = nullptr;
ResizeScreen resize_screen = nullptr;
std::atomic<int> resolution_mode{0}; // 0 native, 1 4K, 2 monitor.
float resolution_setting = 0.f;
std::atomic<uintptr_t> bound_scene{0};
std::atomic<bool> resolution_hooks_checked{false};
std::atomic<uint64_t> screen_size{0};
std::atomic<uint64_t> applied_size{0};
struct ResolutionOverride {
  uintptr_t scene = 0;
  uintptr_t screen = 0;
  uintptr_t texture = 0;
  uint64_t native_size = 0;
};
ResolutionOverride resolution_override; // Owned by the game's render thread.
HMODULE addon_module = nullptr;

constexpr uint64_t PackSize(int width, int height) {
  return static_cast<uint64_t>(static_cast<uint32_t>(width))
         | (static_cast<uint64_t>(static_cast<uint32_t>(height)) << 32);
}
constexpr int SizeWidth(uint64_t size) { return static_cast<int>(size & 0xffffffffu); }
constexpr int SizeHeight(uint64_t size) { return static_cast<int>(size >> 32); }

template <typename T>
bool SafeRead(uintptr_t address, T& value) {
  __try {
    std::memcpy(&value, reinterpret_cast<const void*>(address), sizeof(T));
    return true;
  } __except (EXCEPTION_EXECUTE_HANDLER) {
    return false;
  }
}

void BindTargetDetour(uintptr_t scene, uintptr_t texture) {
  bind_target_original(scene, texture);
  bound_scene.store(scene);
}

void DestroySceneDetour(uintptr_t scene) {
  uintptr_t expected = scene;
  bound_scene.compare_exchange_strong(expected, 0);
  if (resolution_override.scene == scene) {
    resolution_override = {};
    applied_size.store(0);
  }
  destroy_scene_original(scene);
}

void DrawScreenDetour(uintptr_t screen) {
  uintptr_t scene_target = 0;
  uintptr_t current_target = 0;
  int width = 0;
  int height = 0;
  if (SafeRead(screen + 0xf8, current_target) && current_target
      && (resolution_override.scene = bound_scene.load()) != 0
      && SafeRead(resolution_override.scene + 0x498, scene_target)
      && current_target == scene_target
      && SafeRead(screen + 0x11c, width) && SafeRead(screen + 0x120, height)
      && width > 0 && width <= 8192 && height > 0 && height <= 8192) {
    const bool owns_override = resolution_override.screen == screen
                               && resolution_override.texture == current_target;
    if (!owns_override) resolution_override = {resolution_override.scene, screen, current_target, PackSize(width, height)};
    const int mode = resolution_mode.load();
    const uint64_t desired = mode == 1 ? PackSize(3840, 2160)
                            : mode == 2 && screen_size.load() != 0 ? screen_size.load()
                            : mode == 0 && owns_override ? resolution_override.native_size
                                                        : PackSize(width, height);
    if (PackSize(width, height) != desired) {
      resize_screen(screen, SizeWidth(desired), SizeHeight(desired));
      uintptr_t replacement = 0;
      if (SafeRead(screen + 0xf8, replacement) && replacement) {
        bind_target_original(resolution_override.scene, replacement);
        resolution_override.texture = replacement;
        applied_size.store(desired);
      }
    } else {
      applied_size.store(desired);
    }
    if (mode == 0) resolution_override = {};
  }
  draw_screen_original(screen);
}

bool CheckSignature(uintptr_t base, uintptr_t rva, const unsigned char* expected, size_t count) {
  unsigned char actual[16]{};
  return count <= sizeof(actual)
         && ReadProcessMemory(GetCurrentProcess(), reinterpret_cast<const void*>(base + rva), actual, count, nullptr)
         && std::memcmp(actual, expected, count) == 0;
}

void InstallResolutionHooks() {
#ifdef _WIN64
  const uintptr_t base = reinterpret_cast<uintptr_t>(GetModuleHandleW(nullptr));
  const auto* dos = reinterpret_cast<const IMAGE_DOS_HEADER*>(base);
  const auto* nt = reinterpret_cast<const IMAGE_NT_HEADERS*>(base + dos->e_lfanew);
  constexpr unsigned char bind[] = {0x40, 0x53, 0x48, 0x81, 0xec, 0x90, 0, 0, 0};
  constexpr unsigned char draw[] = {0x40, 0x55, 0x57, 0x41, 0x54, 0x48, 0x8d, 0x6c, 0x24, 0xd0};
  constexpr unsigned char resize[] = {0x48, 0x89, 0x5c, 0x24, 0x10, 0x55, 0x48, 0x8d, 0x6c, 0x24, 0xa9};
  constexpr unsigned char destroy[] = {0x48, 0x89, 0x4c, 0x24, 0x08, 0x55, 0x53, 0x56, 0x57, 0x41, 0x56};
  if (nt->FileHeader.TimeDateStamp != 0x62ce6d6a || nt->OptionalHeader.SizeOfImage != 0xf17000
      || !CheckSignature(base, 0x3aabc0, bind, sizeof(bind)) || !CheckSignature(base, 0x40f7f0, draw, sizeof(draw))
      || !CheckSignature(base, 0x410500, resize, sizeof(resize)) || !CheckSignature(base, 0x37b4f0, destroy, sizeof(destroy))) {
    reshade::log::message(reshade::log::level::warning, "Total Eclipse resolution: unsupported executable; using native scene resolution.");
    return;
  }
  HMODULE pinned_module = nullptr;
  if (!GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_PIN,
                          reinterpret_cast<LPCWSTR>(addon_module), &pinned_module)) return;
  resize_screen = reinterpret_cast<ResizeScreen>(base + 0x410500);
  const std::array hooks = {
      renodx::utils::detour::Function(&bind_target_original, &BindTargetDetour),
      renodx::utils::detour::Function(&destroy_scene_original, &DestroySceneDetour),
      renodx::utils::detour::Function(&draw_screen_original, &DrawScreenDetour),
  };
  // Detours expects each original pointer to start at its target address.
  bind_target_original = reinterpret_cast<BindTarget>(base + 0x3aabc0);
  destroy_scene_original = reinterpret_cast<DestroyScene>(base + 0x37b4f0);
  draw_screen_original = reinterpret_cast<DrawScreen>(base + 0x40f7f0);
  try {
    renodx::utils::detour::Install(hooks);
    reshade::log::message(reshade::log::level::info, "Total Eclipse resolution hooks installed.");
  } catch (const std::exception& error) {
    reshade::log::message(reshade::log::level::error, error.what());
  }
#endif
}

float current_settings_mode = 0;

renodx::utils::settings::Settings settings = {
    new renodx::utils::settings::Setting{
        .key = "SceneResolution",
        .binding = &resolution_setting,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Scene Resolution",
        .section = "Display Output",
        .tooltip = "Render scenario scenes at native, 4K, or the current monitor resolution. Artwork and video retain their source resolution.",
        .labels = {"Native", "3840 x 2160", "Monitor size"},
        .max = 2.f,
    },
    new renodx::utils::settings::Setting{
        .key = "SettingsMode",
        .binding = &current_settings_mode,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .can_reset = false,
        .label = "Settings Mode",
        .labels = {"Simple", "Intermediate", "Advanced"},
        .is_global = true,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapType",
        .binding = &shader_injection.tone_map_type,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 3.f,
        .can_reset = true,
        .label = "Tone Mapper",
        .section = "Tone Mapping",
        .tooltip = "Sets the tone mapper type",
        .labels = {"Vanilla", "None", "ACES", "RenoDRT"},
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapPeakNits",
        .binding = &shader_injection.peak_white_nits,
        .default_value = 1000.f,
        .can_reset = false,
        .label = "Peak Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of peak white in nits",
        .min = 48.f,
        .max = 4000.f,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapGameNits",
        .binding = &shader_injection.diffuse_white_nits,
        .default_value = 203.f,
        .label = "Game Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of 100% white in nits",
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapUINits",
        .binding = &shader_injection.graphics_white_nits,
        .default_value = 203.f,
        .label = "UI Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the brightness of UI and HUD elements in nits",
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "GammaCorrection",
        .binding = &shader_injection.gamma_correction,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "Gamma Correction",
        .section = "Tone Mapping",
        .tooltip = "Emulates a display EOTF.",
        .labels = {"Off", "2.2", "BT.1886"},
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapScaling",
        .binding = &shader_injection.tone_map_per_channel,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Scaling",
        .section = "Tone Mapping",
        .tooltip = "Luminance scales colors consistently while per-channel saturates and blows out sooner",
        .labels = {"Luminance", "Per Channel"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapWorkingColorSpace",
        .binding = &shader_injection.tone_map_working_color_space,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Working Color Space",
        .section = "Tone Mapping",
        .labels = {"BT709", "BT2020", "AP1"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueProcessor",
        .binding = &shader_injection.tone_map_hue_processor,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Hue Processor",
        .section = "Tone Mapping",
        .tooltip = "Selects hue processor",
        .labels = {"OKLab", "ICtCp", "darkTable UCS"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueCorrection",
        .binding = &shader_injection.tone_map_hue_correction,
        .default_value = 100.f,
        .label = "Hue Correction",
        .section = "Tone Mapping",
        .tooltip = "Hue retention strength.",
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueShift",
        .binding = &shader_injection.tone_map_hue_shift,
        .default_value = 50.f,
        .label = "Hue Shift",
        .section = "Tone Mapping",
        .tooltip = "Hue-shift emulation strength.",
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapClampColorSpace",
        .binding = &shader_injection.tone_map_clamp_color_space,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Clamp Color Space",
        .section = "Tone Mapping",
        .tooltip = "Hue-shift emulation strength.",
        .labels = {"None", "BT709", "BT2020", "AP1"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value - 1.f; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapClampPeak",
        .binding = &shader_injection.tone_map_clamp_peak,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Clamp Peak",
        .section = "Tone Mapping",
        .tooltip = "Hue-shift emulation strength.",
        .labels = {"None", "BT709", "BT2020", "AP1"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value - 1.f; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeExposure",
        .binding = &shader_injection.tone_map_exposure,
        .default_value = 1.f,
        .label = "Exposure",
        .section = "Color Grading",
        .max = 2.f,
        .format = "%.2f",
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeHighlights",
        .binding = &shader_injection.tone_map_highlights,
        .default_value = 50.f,
        .label = "Highlights",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeShadows",
        .binding = &shader_injection.tone_map_shadows,
        .default_value = 50.f,
        .label = "Shadows",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeContrast",
        .binding = &shader_injection.tone_map_contrast,
        .default_value = 50.f,
        .label = "Contrast",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeSaturation",
        .binding = &shader_injection.tone_map_saturation,
        .default_value = 50.f,
        .label = "Saturation",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeHighlightSaturation",
        .binding = &shader_injection.tone_map_highlight_saturation,
        .default_value = 50.f,
        .label = "Highlight Saturation",
        .section = "Color Grading",
        .tooltip = "Adds or removes highlight color.",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeBlowout",
        .binding = &shader_injection.tone_map_blowout,
        .default_value = 0.f,
        .label = "Blowout",
        .section = "Color Grading",
        .tooltip = "Controls highlight desaturation due to overexposure.",
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeFlare",
        .binding = &shader_injection.tone_map_flare,
        .default_value = 0.f,
        .label = "Flare",
        .section = "Color Grading",
        .tooltip = "Flare/Glare Compensation",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type == 3; },
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeScene",
        .binding = &shader_injection.color_grade_strength,
        .default_value = 100.f,
        .label = "Scene Grading",
        .section = "Color Grading",
        .tooltip = "Scene grading as applied by the game",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type > 0; },
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainCustomColorSpace",
        .binding = &shader_injection.swap_chain_custom_color_space,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Custom Color Space",
        .section = "Display Output",
        .tooltip = "Selects output color space"
                   "\nUS Modern for BT.709 D65."
                   "\nJPN Modern for BT.709 D93."
                   "\nUS CRT for BT.601 (NTSC-U)."
                   "\nJPN CRT for BT.601 ARIB-TR-B9 D93 (NTSC-J)."
                   "\nDefault: US CRT",
        .labels = {
            "US Modern",
            "JPN Modern",
            "US CRT",
            "JPN CRT",
        },
        .is_visible = []() { return settings[0]->GetValue() >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "IntermediateDecoding",
        .binding = &shader_injection.intermediate_encoding,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Intermediate Encoding",
        .section = "Display Output",
        .labels = {"Auto", "None", "SRGB", "2.2", "2.4"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) {
            if (value == 0) return shader_injection.gamma_correction + 1.f;
            return value - 1.f; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainDecoding",
        .binding = &shader_injection.swap_chain_decoding,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Swapchain Decoding",
        .section = "Display Output",
        .labels = {"Auto", "None", "SRGB", "2.2", "2.4"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) {
            if (value == 0) return 1.f;  // The game composites sRGB artwork in gamma space.
            return value - 1.f; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainGammaCorrection",
        .binding = &shader_injection.swap_chain_gamma_correction,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Gamma Correction",
        .section = "Display Output",
        .labels = {"None", "2.2", "2.4"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainClampColorSpace",
        .binding = &shader_injection.swap_chain_clamp_color_space,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 2.f,
        .label = "Clamp Color Space",
        .section = "Display Output",
        .labels = {"None", "BT709", "BT2020", "AP1"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value - 1.f; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
};

const std::unordered_map<std::string, reshade::api::format> UPGRADE_TARGETS = {
    {"R8G8B8A8_TYPELESS", reshade::api::format::r8g8b8a8_typeless},
    {"B8G8R8A8_TYPELESS", reshade::api::format::b8g8r8a8_typeless},
    {"R8G8B8A8_UNORM", reshade::api::format::r8g8b8a8_unorm},
    {"B8G8R8A8_UNORM", reshade::api::format::b8g8r8a8_unorm},
    {"R8G8B8A8_SNORM", reshade::api::format::r8g8b8a8_snorm},
    {"R8G8B8A8_UNORM_SRGB", reshade::api::format::r8g8b8a8_unorm_srgb},
    {"B8G8R8A8_UNORM_SRGB", reshade::api::format::b8g8r8a8_unorm_srgb},
    {"R10G10B10A2_TYPELESS", reshade::api::format::r10g10b10a2_typeless},
    {"R10G10B10A2_UNORM", reshade::api::format::r10g10b10a2_unorm},
    {"B10G10R10A2_UNORM", reshade::api::format::b10g10r10a2_unorm},
    {"R11G11B10_FLOAT", reshade::api::format::r11g11b10_float},
    {"R16G16B16A16_TYPELESS", reshade::api::format::r16g16b16a16_typeless},
};

void OnPresetOff() {
  //   renodx::utils::settings::UpdateSetting("toneMapType", 0.f);
  //   renodx::utils::settings::UpdateSetting("toneMapPeakNits", 203.f);
  //   renodx::utils::settings::UpdateSetting("toneMapGameNits", 203.f);
  //   renodx::utils::settings::UpdateSetting("toneMapUINits", 203.f);
  //   renodx::utils::settings::UpdateSetting("toneMapGammaCorrection", 0);
  //   renodx::utils::settings::UpdateSetting("colorGradeExposure", 1.f);
  //   renodx::utils::settings::UpdateSetting("colorGradeHighlights", 50.f);
  //   renodx::utils::settings::UpdateSetting("colorGradeShadows", 50.f);
  //   renodx::utils::settings::UpdateSetting("colorGradeContrast", 50.f);
  //   renodx::utils::settings::UpdateSetting("colorGradeSaturation", 50.f);
  //   renodx::utils::settings::UpdateSetting("colorGradeLUTStrength", 100.f);
  //   renodx::utils::settings::UpdateSetting("colorGradeLUTScaling", 0.f);
}

const auto UPGRADE_TYPE_NONE = 0.f;
const auto UPGRADE_TYPE_OUTPUT_SIZE = 1.f;
const auto UPGRADE_TYPE_OUTPUT_RATIO = 2.f;
const auto UPGRADE_TYPE_ANY = 3.f;

void OnPresent(reshade::api::command_queue* queue,
               reshade::api::swapchain* swapchain,
               const reshade::api::rect* source_rect,
               const reshade::api::rect* dest_rect,
               uint32_t dirty_rect_count,
               const reshade::api::rect* dirty_rects) {
  resolution_mode.store(static_cast<int>(resolution_setting));
  if (!resolution_hooks_checked.exchange(true)) InstallResolutionHooks();
  if (swapchain != nullptr && swapchain->get_hwnd() != nullptr) {
    MONITORINFO monitor{sizeof(monitor)};
    if (GetMonitorInfoW(MonitorFromWindow(static_cast<HWND>(swapchain->get_hwnd()), MONITOR_DEFAULTTONEAREST), &monitor)) {
      const int width = monitor.rcMonitor.right - monitor.rcMonitor.left;
      const int height = monitor.rcMonitor.bottom - monitor.rcMonitor.top;
      if (width > 0 && width <= 8192 && height > 0 && height <= 8192) screen_size.store(PackSize(width, height));
    }
  }
  auto* device = queue->get_device();
  if (device->get_api() == reshade::api::device_api::opengl) {
    shader_injection.custom_flip_uv_y = 1.f;
  }
}

bool initialized = false;

bool RestoreThumbnailSource(reshade::api::command_list* cmd_list, const reshade::api::resource& source,
                            const reshade::api::resource& destination) {
  auto* device = cmd_list->get_device();
  const auto destination_desc = device->get_resource_desc(destination);
  if (destination_desc.heap == reshade::api::memory_heap::gpu_only
      || destination_desc.texture.format != reshade::api::format::r8g8b8a8_unorm) return false;
  const auto source_desc = device->get_resource_desc(source);
  if (source_desc.texture.format != reshade::api::format::r8g8b8a8_unorm
      || (source_desc.usage & reshade::api::resource_usage::render_target) == reshade::api::resource_usage::undefined) return false;
  const auto clone = renodx::utils::resource::upgrade::GetResourceClone(source, {.allow_create = false});
  if (clone.handle == 0u) return false;

  // The CPU capture still expects RGBA8. Refresh the original from the active float clone on demand.
  renodx::utils::render::RenderPass pass;
  pass.render_target_slots.resources = {source};
  pass.shader_resource_slots.resources = {clone};
  pass.pipeline_subobjects.vertex_shader = __swap_chain_proxy_vertex_shader_dx11;
  pass.pipeline_subobjects.pixel_shader = __save_thumbnail_pixel_shader_dx11;
  pass.render_target_load_op = reshade::api::render_pass_load_op::discard;
  const bool restored = pass.Render(cmd_list);
  pass.DestroyAll(cmd_list);
  reshade::log::message(reshade::log::level::info,
                        restored ? "Total Eclipse thumbnail SDR source restored" : "Total Eclipse thumbnail conversion failed");
  return restored;
}

bool OnCopyResource(reshade::api::command_list* cmd_list, reshade::api::resource source, reshade::api::resource destination) {
  if (RestoreThumbnailSource(cmd_list, source, destination)) {
    cmd_list->copy_resource(source, destination);
    return true;
  }
  static std::atomic_uint logged_copies = 0;
  const auto source_desc = cmd_list->get_device()->get_resource_desc(source);
  const auto destination_desc = cmd_list->get_device()->get_resource_desc(destination);
  if (destination_desc.heap == reshade::api::memory_heap::gpu_only
      && logged_copies.fetch_add(1, std::memory_order_relaxed) >= 8) return false;
  char message[256];
  std::snprintf(message, sizeof(message),
                "Total Eclipse copy: source=0x%llx format=%u %ux%u -> destination=0x%llx format=%u %ux%u heap=%u",
                source.handle, static_cast<unsigned>(source_desc.texture.format), source_desc.texture.width, source_desc.texture.height,
                destination.handle, static_cast<unsigned>(destination_desc.texture.format), destination_desc.texture.width, destination_desc.texture.height,
                static_cast<unsigned>(destination_desc.heap));
  reshade::log::message(reshade::log::level::info, message);
  return false;
}

bool OnCopyTextureRegion(reshade::api::command_list* cmd_list, reshade::api::resource source,
                         uint32_t source_subresource, const reshade::api::subresource_box* source_box,
                         reshade::api::resource destination, uint32_t destination_subresource,
                         const reshade::api::subresource_box* destination_box, reshade::api::filter_mode filter) {
  if (!RestoreThumbnailSource(cmd_list, source, destination)) return false;
  cmd_list->copy_texture_region(source, source_subresource, source_box,
                                destination, destination_subresource, destination_box, filter);
  return true;
}

void KeepCpuUploadedTextureOriginal(reshade::api::device* device, const reshade::api::resource& resource) {
  std::vector<uint64_t> views;
  renodx::utils::resource::UpdateResourceInfo(resource, [&](renodx::utils::resource::ResourceInfo* info) {
    if (info->device != device || info->destroyed || info->is_clone || !info->clone_enabled) return;
    if (info->clone_target == nullptr || info->clone_target->name != "Total Eclipse scene") return;
    // CPU uploads update the SDR original, never its float clone (notably tda_thumb).
    info->clone_enabled = false;
    info->clone_can_deactivate = false;
    views.assign(info->resource_view_handles.begin(), info->resource_view_handles.end());
  });
  renodx::utils::resource::upgrade::UpdateResourceViewsCloneState(views, false, false);
}

bool OnUpdateTextureRegion(reshade::api::device* device, const reshade::api::subresource_data& data,
                           reshade::api::resource destination, uint32_t subresource,
                           const reshade::api::subresource_box* box) {
  KeepCpuUploadedTextureOriginal(device, destination);
  return false;
}

void OnMapTextureRegion(reshade::api::device* device, reshade::api::resource resource, uint32_t subresource,
                        const reshade::api::subresource_box* box, reshade::api::map_access access,
                        reshade::api::subresource_data* data) {
  if (access != reshade::api::map_access::read_only) {
    KeepCpuUploadedTextureOriginal(device, resource);
  }
  if (access != reshade::api::map_access::read_only && access != reshade::api::map_access::read_write) return;
  const auto desc = device->get_resource_desc(resource);
  char message[256];
  std::snprintf(message, sizeof(message), "Total Eclipse read map: resource=0x%llx format=%u %ux%u heap=%u pitch=%u",
                resource.handle, static_cast<unsigned>(desc.texture.format), desc.texture.width, desc.texture.height,
                static_cast<unsigned>(desc.heap), data->row_pitch);
  reshade::log::message(reshade::log::level::info, message);
}

}  // namespace

extern "C" __declspec(dllexport) constexpr const char* NAME = "RenoDX";
extern "C" __declspec(dllexport) constexpr const char* DESCRIPTION = "RenoDX for Muv-Luv Alternative Total Eclipse";

BOOL APIENTRY DllMain(HMODULE h_module, DWORD fdw_reason, LPVOID lpv_reserved) {
  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH: {
      addon_module = h_module;
      // Display Commander's DXGI proxy exposes registration exports but is not a full ReShade API provider.
      HMODULE modules[1024];
      DWORD module_bytes = 0;
      HMODULE reshade_module = nullptr;
      if (!K32EnumProcessModules(GetCurrentProcess(), modules, sizeof(modules), &module_bytes)) return FALSE;
      for (DWORD i = 0; i < module_bytes / sizeof(HMODULE) && i < 1024; ++i) {
        if (GetProcAddress(modules[i], "ReShadeRegisterAddon") != nullptr
            && GetProcAddress(modules[i], "ReShadeUnregisterAddon") != nullptr
            && GetProcAddress(modules[i], "ReShadeGetImGuiFunctionTable") != nullptr
            && GetProcAddress(modules[i], "GetDisplayCommanderState") == nullptr) {
          reshade_module = modules[i];
          break;
        }
      }
      if (reshade_module == nullptr || !reshade::register_addon(h_module, reshade_module)) return FALSE;
      reshade::register_event<reshade::addon_event::present>(OnPresent);

      if (!initialized) {
        renodx::mods::shader::force_pipeline_cloning = true;
        renodx::mods::shader::expected_constant_buffer_space = 50;
        renodx::mods::shader::expected_constant_buffer_index = 13;
        renodx::mods::shader::allow_multiple_push_constants = true;

        renodx::mods::swapchain::expected_constant_buffer_index = 13;
        renodx::mods::swapchain::expected_constant_buffer_space = 50;
        renodx::mods::swapchain::use_resource_cloning = true;
        // The game draws into a separate output-sized texture before copying to the swapchain.
        // Clone that source too, so the final copy reaches the float swapchain clone used by the HDR proxy.
        renodx::mods::swapchain::resource_upgrade_infos.push_back({
            .old_format = reshade::api::format::r10g10b10a2_unorm,
            .new_format = reshade::api::format::r16g16b16a16_float,
            .ignore_size = true,
            .use_resource_view_cloning = true,
            .usage_include = reshade::api::resource_usage::render_target,
            .name = "Total Eclipse composite",
        });
        renodx::mods::swapchain::resource_upgrade_infos.push_back({
            .old_format = reshade::api::format::r8g8b8a8_unorm,
            .new_format = reshade::api::format::r16g16b16a16_float,
            .ignore_size = true,
            .use_resource_view_cloning = true,
            .usage_include = reshade::api::resource_usage::render_target,
            .name = "Total Eclipse scene",
        });
        renodx::mods::swapchain::swap_chain_proxy_shaders = {
            {
                reshade::api::device_api::d3d11,
                {
                    .vertex_shader = __swap_chain_proxy_vertex_shader_dx11,
                    .pixel_shader = __swap_chain_proxy_pixel_shader_dx11,
                },
            },
            {
                reshade::api::device_api::d3d12,
                {
                    .vertex_shader = __swap_chain_proxy_vertex_shader_dx12,
                    .pixel_shader = __swap_chain_proxy_pixel_shader_dx12,
                },
            },
        };

        {
          auto* setting = new renodx::utils::settings::Setting{
              .key = "SwapChainForceBorderless",
              .value_type = renodx::utils::settings::SettingValueType::INTEGER,
              .default_value = 0.f,
              .label = "Force Borderless",
              .section = "Display Output",
              .tooltip = "Forces fullscreen to be borderless for proper HDR",
              .labels = {
                  "Disabled",
                  "Enabled",
              },
              .on_change_value = [](float previous, float current) { renodx::mods::swapchain::force_borderless = (current == 1.f); },
              .is_global = true,
              .is_visible = []() { return current_settings_mode >= 2; },
          };
          renodx::utils::settings::LoadSetting(renodx::utils::settings::global_name, setting);
          renodx::mods::swapchain::force_borderless = (setting->GetValue() == 1.f);
          settings.push_back(setting);
        }

        {
          auto* setting = new renodx::utils::settings::Setting{
              .key = "SwapChainPreventFullscreen",
              .value_type = renodx::utils::settings::SettingValueType::INTEGER,
              .default_value = 0.f,
              .label = "Prevent Fullscreen",
              .section = "Display Output",
              .tooltip = "Prevent exclusive fullscreen for proper HDR",
              .labels = {
                  "Disabled",
                  "Enabled",
              },
              .on_change_value = [](float previous, float current) { renodx::mods::swapchain::prevent_full_screen = (current == 1.f); },
              .is_global = true,
              .is_visible = []() { return current_settings_mode >= 2; },
          };
          renodx::utils::settings::LoadSetting(renodx::utils::settings::global_name, setting);
          renodx::mods::swapchain::prevent_full_screen = (setting->GetValue() == 1.f);
          settings.push_back(setting);
        }

        {
          auto* setting = new renodx::utils::settings::Setting{
              .key = "SwapChainEncoding",
              .binding = &shader_injection.swap_chain_encoding,
              .value_type = renodx::utils::settings::SettingValueType::INTEGER,
              .default_value = 4.f,
              .label = "Encoding",
              .section = "Display Output",
              .labels = {"None", "SRGB", "2.2", "2.4", "HDR10", "scRGB"},
              .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
              .on_change_value = [](float previous, float current) {
                bool is_hdr10 = current == 4;
                shader_injection.swap_chain_encoding_color_space = (is_hdr10 ? 1.f : 0.f);
                // return void
              },
              .is_global = true,
              .is_visible = []() { return current_settings_mode >= 2; },
          };
          renodx::utils::settings::LoadSetting(renodx::utils::settings::global_name, setting);
          bool is_hdr10 = setting->GetValue() == 4;
          renodx::mods::swapchain::SetUseHDR10(is_hdr10);
          renodx::mods::swapchain::use_resize_buffer = setting->GetValue() < 4;
          shader_injection.swap_chain_encoding_color_space = is_hdr10 ? 1.f : 0.f;
          settings.push_back(setting);
        }

        {
          auto* setting = new renodx::utils::settings::Setting{
              .key = "SwapChainDeviceProxy",
              .value_type = renodx::utils::settings::SettingValueType::INTEGER,
              .default_value = 0.f,
              .label = "Use Display Proxy",
              .section = "Display Proxy",
              .labels = {"Off", "On"},
              .is_global = true,
              .is_visible = []() { return current_settings_mode >= 2; },
          };
          renodx::utils::settings::LoadSetting(renodx::utils::settings::global_name, setting);
          bool use_device_proxy = setting->GetValue() == 1.f;
          renodx::mods::swapchain::use_device_proxy = use_device_proxy;
          renodx::mods::swapchain::set_color_space = !use_device_proxy;
          if (use_device_proxy) {
            // The present callback is also used to install the scenario-resolution hook.
          } else {
            shader_injection.custom_flip_uv_y = 0.f;
          }
          settings.push_back(setting);
        }

        {
          auto* setting = new renodx::utils::settings::Setting{
              .key = "SwapChainDeviceProxyBaseWaitIdle",
              .value_type = renodx::utils::settings::SettingValueType::INTEGER,
              .default_value = 0.f,
              .label = "Base Wait Idle",
              .section = "Display Proxy",
              .labels = {"Off", "On"},
              .is_global = true,
              .is_visible = []() { return current_settings_mode >= 2; },
          };
          renodx::utils::settings::LoadSetting(renodx::utils::settings::global_name, setting);
          bool use_device_proxy =
              renodx::mods::swapchain::device_proxy_wait_idle_source = (setting->GetValue() == 1.f);
          settings.push_back(setting);
        }

        {
          auto* setting = new renodx::utils::settings::Setting{
              .key = "SwapChainDeviceProxyProxyWaitIdle",
              .value_type = renodx::utils::settings::SettingValueType::INTEGER,
              .default_value = 0.f,
              .label = "Proxy Wait Idle",
              .section = "Display Proxy",
              .labels = {"Off", "On"},
              .is_global = true,
              .is_visible = []() { return current_settings_mode >= 2; },
          };
          renodx::utils::settings::LoadSetting(renodx::utils::settings::global_name, setting);
          bool use_device_proxy =
              renodx::mods::swapchain::device_proxy_wait_idle_destination = (setting->GetValue() == 1.f);
          settings.push_back(setting);
        }

        for (const auto& [key, format] : UPGRADE_TARGETS) {
          auto* setting = new renodx::utils::settings::Setting{
              .key = "Upgrade_" + key,
              .value_type = renodx::utils::settings::SettingValueType::INTEGER,
              .default_value = 0.f,
              .label = key,
              .section = "Resource Upgrades",
              .labels = {
                  "Off",
                  "Output size",
                  "Output ratio",
                  "Any size",
              },
              .is_global = true,
              .is_visible = []() { return settings[0]->GetValue() >= 2; },
          };
          renodx::utils::settings::LoadSetting(renodx::utils::settings::global_name, setting);
          settings.push_back(setting);

          auto value = setting->GetValue();
          if (value > 0) {
            renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
                .old_format = format,
                .new_format = reshade::api::format::r16g16b16a16_float,
                .ignore_size = (value == UPGRADE_TYPE_ANY),
                .use_resource_view_cloning = true,
                .aspect_ratio = static_cast<float>((value == UPGRADE_TYPE_OUTPUT_RATIO)
                                                       ? renodx::mods::swapchain::SwapChainUpgradeTarget::BACK_BUFFER
                                                       : renodx::mods::swapchain::SwapChainUpgradeTarget::ANY),
                .usage_include = reshade::api::resource_usage::render_target,
            });
            std::stringstream s;
            s << "Applying user resource upgrade for ";
            s << format << ": " << value;
            reshade::log::message(reshade::log::level::info, s.str().c_str());
          }
        }

        initialized = true;
      }

      break;
    }
    case DLL_PROCESS_DETACH:
      reshade::unregister_event<reshade::addon_event::present>(OnPresent);
      reshade::unregister_addon(h_module);
      break;
  }

  renodx::utils::settings::Use(fdw_reason, &settings, &OnPresetOff);
  if (fdw_reason == DLL_PROCESS_ATTACH) {
    reshade::register_event<reshade::addon_event::copy_resource>(OnCopyResource);
    reshade::register_event<reshade::addon_event::copy_texture_region>(OnCopyTextureRegion);
    reshade::register_event<reshade::addon_event::map_texture_region>(OnMapTextureRegion);
    reshade::register_event<reshade::addon_event::update_texture_region>(OnUpdateTextureRegion);
  } else if (fdw_reason == DLL_PROCESS_DETACH) {
    reshade::unregister_event<reshade::addon_event::copy_resource>(OnCopyResource);
    reshade::unregister_event<reshade::addon_event::copy_texture_region>(OnCopyTextureRegion);
    reshade::unregister_event<reshade::addon_event::map_texture_region>(OnMapTextureRegion);
    reshade::unregister_event<reshade::addon_event::update_texture_region>(OnUpdateTextureRegion);
  }
  renodx::mods::swapchain::Use(fdw_reason, &shader_injection);
  renodx::mods::shader::Use(fdw_reason, custom_shaders, &shader_injection);

  return TRUE;
}
