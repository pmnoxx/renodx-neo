/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */

#define ImTextureID ImU64
#define DEBUG_LEVEL_0

#include <dxgi1_6.h>
#include <intrin.h>
#include <Windows.h>
#include <wrl/client.h>
#include <algorithm>
#include <atomic>
#include <cstdint>
#include <cstring>
#include <exception>
#include <filesystem>
#include <string>

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include <embed/shaders.h>
#include "../../mods/shader.hpp"
#include "../../mods/swapchain.hpp"
#include "./fps_unlock.hpp"
#include "./shared.h"

#include "../../utils/iat_hook.hpp"
#include "../../utils/platform.hpp"
#include "../../utils/vtable.hpp"

namespace {

decltype(&CreateDXGIFactory) original_create_dxgi_factory = nullptr;
using GetOutputDesc = HRESULT(STDMETHODCALLTYPE*)(IDXGIOutput6*, DXGI_OUTPUT_DESC1*);
GetOutputDesc original_get_output_desc = nullptr;
renodx::utils::vtable::Slot<GetOutputDesc> output_desc_hook;
uintptr_t game_begin = 0;
uintptr_t game_end = 0;
std::atomic_uint32_t hidden_hdr_queries = 0;
HMODULE addon_module = nullptr;
std::string addon_version;
bool disable_camera_motion_blur = false;
ShaderInjectData shader_injection = {1000.f, 203.f, 203.f, 1.f, 3.f, 1.f, 1.f, 1.f, 1.f, 0.f};

bool OnReplaceCameraMotionVectors(reshade::api::command_list*) {
  return disable_camera_motion_blur;
}

renodx::mods::shader::CustomShaders custom_shaders = {
    CustomShaderEntry(0x7FB4ADA1),
    CustomShaderEntry(0x644BD65C),
    CustomShaderEntry(0xA0D17E10),
    CustomShaderEntry(0x74B83FF7),
    CustomShaderEntry(0x83C6596C),
    CustomShaderEntry(0x96F799BE),
    CustomShaderEntryCallback(0x83015F55, OnReplaceCameraMotionVectors),
};

HRESULT STDMETHODCALLTYPE OnGetOutputDesc(IDXGIOutput6* output, DXGI_OUTPUT_DESC1* desc) {
  const uintptr_t caller = reinterpret_cast<uintptr_t>(_ReturnAddress());
  const HRESULT result = original_get_output_desc(output, desc);
  if (SUCCEEDED(result) && desc != nullptr && caller >= game_begin && caller < game_end) {
    desc->ColorSpace = DXGI_COLOR_SPACE_RGB_FULL_G22_NONE_P709;
    desc->BitsPerColor = 8;
    if (hidden_hdr_queries.fetch_add(1, std::memory_order_relaxed) == 0) {
      reshade::log::message(reshade::log::level::info,
                            "NieR:Automata: hid native HDR in game IDXGIOutput6::GetDesc1 query.");
    }
  }
  return result;
}

HRESULT WINAPI OnCreateDXGIFactory(REFIID iid, void** factory) {
  const HRESULT result = original_create_dxgi_factory(iid, factory);
  if (FAILED(result) || factory == nullptr || *factory == nullptr || output_desc_hook.installed_address != nullptr) return result;
  Microsoft::WRL::ComPtr<IDXGIFactory> dxgi_factory;
  if (FAILED(static_cast<IUnknown*>(*factory)->QueryInterface(IID_PPV_ARGS(&dxgi_factory)))) return result;
  Microsoft::WRL::ComPtr<IDXGIAdapter> adapter;
  Microsoft::WRL::ComPtr<IDXGIOutput> output;
  Microsoft::WRL::ComPtr<IDXGIOutput6> output6;
  if (SUCCEEDED(dxgi_factory->EnumAdapters(0, &adapter))
      && SUCCEEDED(adapter->EnumOutputs(0, &output)) && SUCCEEDED(output.As(&output6))) {
    output_desc_hook = {
        .object = output6.Get(),
        .index = 27,
        .original = &original_get_output_desc,
        .replacement = &OnGetOutputDesc,
    };
    try {
      renodx::utils::vtable::Install(&output_desc_hook);
      reshade::log::message(reshade::log::level::info, "NieR:Automata: output HDR detection hook installed.");
    } catch (const std::exception& error) {
      reshade::log::message(reshade::log::level::error, error.what());
    }
  }
  return result;
}

void OnInitDevice(reshade::api::device* device) {
  // Normal addon loading misses the game's display query. Configure the next
  // launch after ReShade has loaded its INI, preserving other early-load addons.
  wchar_t module_path[MAX_PATH] = {};
  if (const DWORD length = GetModuleFileNameW(addon_module, module_path, MAX_PATH);
      length != 0 && length < MAX_PATH) {
    addon_version = renodx::utils::platform::GetFileVersion(module_path);
    const auto addon_file = std::filesystem::path(module_path).filename().string();
    size_t entries_size = 0;
    reshade::get_config_value(nullptr, "ADDON", "LoadFromDllMain", nullptr, &entries_size);
    std::string entries(entries_size, '\0');
    if (entries_size == 0 || reshade::get_config_value(nullptr, "ADDON", "LoadFromDllMain", entries.data(), &entries_size)) {
      bool found = false;
      size_t offset = 0;
      while (offset < entries.size() && entries[offset] != '\0') {
        const auto end = entries.find('\0', offset);
        if (end == std::string::npos) break;
        if (_stricmp(std::filesystem::path(entries.substr(offset, end - offset)).filename().string().c_str(), addon_file.c_str()) == 0) {
          found = true;
          break;
        }
        offset = end + 1;
      }
      if (!found) {
        entries.resize(offset);
        entries.append(addon_file);
        entries.push_back('\0');
        reshade::set_config_value(nullptr, "ADDON", "LoadFromDllMain", entries.c_str(), entries.size());
        reshade::log::message(reshade::log::level::warning,
                              "NieR:Automata: configured automatic early loading. Restart the game to activate native HDR suppression.");
      }
    } else {
      reshade::log::message(reshade::log::level::error, "NieR:Automata: could not read early-load addon configuration.");
    }
  } else {
    reshade::log::message(reshade::log::level::error, "NieR:Automata: could not resolve addon filename for automatic early loading.");
  }
  if (device->get_api() != reshade::api::device_api::d3d11) {
    reshade::log::message(reshade::log::level::warning, "NieR:Automata: expected a D3D11 rendering device.");
  }
  if (device->get_api() == reshade::api::device_api::d3d11) {
    // Early LoadFromDllMain runs before ReShade finishes loading the INI.
    // Read optional FPS settings when the rendering device is initialized.
    if (!nier_automata::fps_unlock::installed.load()) {
      uint32_t enabled = 1;
      reshade::get_config_value(nullptr, "renodx-nier_automata", "UnlockFPS", enabled);
      nier_automata::fps_unlock::startup_enabled = enabled != 0;
      nier_automata::fps_unlock::requested.store(enabled != 0);
      enabled = 60;
      reshade::get_config_value(nullptr, "renodx-nier_automata", "FPSLimit", enabled);
      nier_automata::fps_unlock::target_fps.store(static_cast<int>(std::clamp(enabled, 60u, 360u)));
      reshade::log::message(reshade::log::level::info,
                            nier_automata::fps_unlock::startup_enabled
                                ? "NieR:Automata FPS: startup configuration enabled."
                                : "NieR:Automata FPS: startup configuration disabled.");
    }
    nier_automata::fps_unlock::Initialize(game_begin);
  }
}

void OnOverlay(reshade::api::effect_runtime*) {
  ImGui::TextUnformatted("NieR:Automata HDR development");
  ImGui::Text("Version: %s", (addon_version.empty() ? "unknown" : addon_version.c_str()));
  ImGui::TextUnformatted("Compiled: " __DATE__ " " __TIME__);
  ImGui::Text("Hidden native HDR queries: %u", hidden_hdr_queries.load(std::memory_order_relaxed));
  if (hidden_hdr_queries.load(std::memory_order_relaxed) == 0) {
    ImGui::TextWrapped("Restart the game to activate native HDR suppression. Early loading is configured automatically.");
  }
  if (ImGui::CollapsingHeader("Basic", ImGuiTreeNodeFlags_DefaultOpen)) {
    if (ImGui::SliderFloat("Peak brightness (nits)", &shader_injection.peak_white_nits, 203.f, 4000.f)) {
      reshade::set_config_value(nullptr, "renodx-nier_automata", "PeakWhiteNits", shader_injection.peak_white_nits);
    }
    if (ImGui::SliderFloat("Scene white (nits)", &shader_injection.diffuse_white_nits, 80.f, 400.f)) {
      reshade::set_config_value(nullptr, "renodx-nier_automata", "SceneWhiteNits", shader_injection.diffuse_white_nits);
    }
    if (ImGui::SliderFloat("UI white (nits)", &shader_injection.graphics_white_nits, 80.f, 400.f)) {
      reshade::set_config_value(nullptr, "renodx-nier_automata", "UIWhiteNits", shader_injection.graphics_white_nits);
    }
    static constexpr const char* tone_map_types[] = {"Vanilla", "None", "ACES", "RenoDRT"};
    int tone_map_type = static_cast<int>(shader_injection.tone_map_type);
    if (ImGui::Combo("Tone mapper", &tone_map_type, tone_map_types, IM_ARRAYSIZE(tone_map_types))) {
      shader_injection.tone_map_type = static_cast<float>(tone_map_type);
      reshade::set_config_value(nullptr, "renodx-nier_automata", "ToneMapType", shader_injection.tone_map_type);
    }
    bool gamma_correction = shader_injection.gamma_correction != 0.f;
    if (ImGui::Checkbox("Gamma correction (2.2)", &gamma_correction)) {
      shader_injection.gamma_correction = gamma_correction ? 1.f : 0.f;
      reshade::set_config_value(nullptr, "renodx-nier_automata", "GammaCorrection", shader_injection.gamma_correction);
    }
    if (ImGui::SliderFloat("Exposure", &shader_injection.exposure, 0.f, 4.f, "%.2f")) {
      reshade::set_config_value(nullptr, "renodx-nier_automata", "Exposure", shader_injection.exposure);
    }
  }
  if (ImGui::CollapsingHeader("Advanced color grading", ImGuiTreeNodeFlags_DefaultOpen)) {
    if (ImGui::SliderFloat("Highlights", &shader_injection.highlights, 0.f, 2.f, "%.2f")) {
      reshade::set_config_value(nullptr, "renodx-nier_automata", "Highlights", shader_injection.highlights);
    }
    if (ImGui::SliderFloat("Shadows", &shader_injection.shadows, 0.f, 2.f, "%.2f")) {
      reshade::set_config_value(nullptr, "renodx-nier_automata", "Shadows", shader_injection.shadows);
    }
    if (ImGui::SliderFloat("Contrast", &shader_injection.contrast, 0.f, 2.f, "%.2f")) {
      reshade::set_config_value(nullptr, "renodx-nier_automata", "Contrast", shader_injection.contrast);
    }
    if (ImGui::SliderFloat("Saturation", &shader_injection.saturation, 0.f, 2.f, "%.2f")) {
      reshade::set_config_value(nullptr, "renodx-nier_automata", "Saturation", shader_injection.saturation);
    }
  }
  nier_automata::fps_unlock::OnOverlay();
  if (ImGui::Checkbox("Disable camera motion blur", &disable_camera_motion_blur)) {
    reshade::set_config_value(
        nullptr, "renodx-nier_automata", "DisableCameraMotionBlur", uint32_t(disable_camera_motion_blur));
  }
  ImGui::Separator();
  ImGui::TextUnformatted("Miscellaneous");
  if (ImGui::Button("Buy me a Ko-Fi")) {
    renodx::utils::platform::LaunchURL("https://ko-fi.com/shortfuse");
  }
}

}  // namespace

extern "C" __declspec(dllexport) constexpr const char* NAME = "RenoDX for NieR:Automata";
extern "C" __declspec(dllexport) constexpr const char* DESCRIPTION =
    "NieR:Automata SDR renderer upgraded to HDR with native HDR detection bypass.";

BOOL APIENTRY DllMain(HMODULE module, DWORD reason, LPVOID reserved) {
  switch (reason) {
    case DLL_PROCESS_ATTACH: {
      if (!reshade::register_addon(module)) return FALSE;
      addon_module = module;
      uint32_t enabled = 0;
      reshade::get_config_value(nullptr, "renodx-nier_automata", "DisableCameraMotionBlur", enabled);
      disable_camera_motion_blur = enabled != 0;
      reshade::get_config_value(nullptr, "renodx-nier_automata", "PeakWhiteNits", shader_injection.peak_white_nits);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "SceneWhiteNits", shader_injection.diffuse_white_nits);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "UIWhiteNits", shader_injection.graphics_white_nits);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "ToneMapType", shader_injection.tone_map_type);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "GammaCorrection", shader_injection.gamma_correction);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "Exposure", shader_injection.exposure);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "Highlights", shader_injection.highlights);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "Shadows", shader_injection.shadows);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "Contrast", shader_injection.contrast);
      reshade::get_config_value(nullptr, "renodx-nier_automata", "Saturation", shader_injection.saturation);
      game_begin = reinterpret_cast<uintptr_t>(GetModuleHandleW(nullptr));
      const auto* dos = reinterpret_cast<const IMAGE_DOS_HEADER*>(game_begin);
      const auto* nt = reinterpret_cast<const IMAGE_NT_HEADERS*>(game_begin + dos->e_lfanew);
      game_end = game_begin + nt->OptionalHeader.SizeOfImage;
      void* factory_import = nullptr;
      auto* imports = reinterpret_cast<const IMAGE_IMPORT_DESCRIPTOR*>(
          game_begin + nt->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress);
      for (; imports->Name != 0; ++imports) {
        if (_stricmp(reinterpret_cast<const char*>(game_begin + imports->Name), "dxgi.dll") != 0
            || imports->OriginalFirstThunk == 0) continue;
        auto* names = reinterpret_cast<const IMAGE_THUNK_DATA*>(game_begin + imports->OriginalFirstThunk);
        auto* addresses = reinterpret_cast<const IMAGE_THUNK_DATA*>(game_begin + imports->FirstThunk);
        for (; names->u1.AddressOfData != 0; ++names, ++addresses) {
          if (IMAGE_SNAP_BY_ORDINAL(names->u1.Ordinal)) continue;
          const auto* import = reinterpret_cast<const IMAGE_IMPORT_BY_NAME*>(game_begin + names->u1.AddressOfData);
          if (std::strcmp(import->Name, "CreateDXGIFactory") == 0) {
            // ReShade can already have redirected the executable import to its own entry point.
            factory_import = reinterpret_cast<void*>(addresses->u1.Function);
            break;
          }
        }
      }
      // Install before the game creates its factory and queries output capabilities.
      if (factory_import == nullptr || !renodx::utils::iat_hook::PatchIAT("dxgi.dll", factory_import, reinterpret_cast<void*>(&OnCreateDXGIFactory), reinterpret_cast<void**>(&original_create_dxgi_factory), "CreateDXGIFactory")) {
        reshade::log::message(reshade::log::level::error,
                              "NieR:Automata: native HDR bypass installation failed; addon not activated.");
        reshade::unregister_addon(module);
        return FALSE;
      }
      renodx::mods::shader::force_pipeline_cloning = true;
      renodx::mods::shader::expected_constant_buffer_space = 50;
      renodx::mods::shader::expected_constant_buffer_index = 13;
      renodx::mods::shader::allow_multiple_push_constants = true;
      renodx::mods::swapchain::expected_constant_buffer_index = 13;
      renodx::mods::swapchain::expected_constant_buffer_space = 50;
      renodx::mods::swapchain::use_resource_cloning = true;
      // MSAA resolves into a shader-readable texture without render-target usage.
      // Keep that full-resolution destination in the same FP16 family as its source.
      renodx::mods::swapchain::resource_upgrade_infos.push_back({
          .old_format = reshade::api::format::r8g8b8a8_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .use_resource_view_cloning = true,
          .usage_include = reshade::api::resource_usage::render_target | reshade::api::resource_usage::resolve_dest,
          .name = "NieR:Automata output composite and MSAA resolve",
      });
      renodx::mods::swapchain::swap_chain_proxy_shaders = {
          {reshade::api::device_api::d3d11, {
                                                .vertex_shader = __swap_chain_proxy_vertex_shader_dx11,
                                                .pixel_shader = __swap_chain_proxy_pixel_shader_dx11,
                                            }},
      };
      renodx::mods::swapchain::SetUseHDR10(true);
      reshade::register_event<reshade::addon_event::init_device>(OnInitDevice);
      reshade::register_overlay("NieR:Automata", OnOverlay);
      break;
    }
    case DLL_PROCESS_DETACH:
      if (reserved == nullptr && original_create_dxgi_factory != nullptr) {
        // On process termination the executable is retiring; avoid changing its IAT then.
        renodx::utils::iat_hook::UnpatchIAT(
            "dxgi.dll", reinterpret_cast<void*>(&OnCreateDXGIFactory),
            reinterpret_cast<void*>(original_create_dxgi_factory), "CreateDXGIFactory");
        if (output_desc_hook.installed_address != nullptr) {
          try {
            renodx::utils::vtable::Uninstall(&output_desc_hook);
          } catch (const std::exception& error) {
            reshade::log::message(reshade::log::level::error, error.what());
          }
        }
      }
      reshade::unregister_event<reshade::addon_event::init_device>(OnInitDevice);
      reshade::unregister_overlay("NieR:Automata", OnOverlay);
      reshade::unregister_addon(module);
      break;
  }
  renodx::mods::swapchain::Use(reason, &shader_injection);
  renodx::mods::shader::Use(reason, custom_shaders, &shader_injection);
  return TRUE;
}
