/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <intrin.h>
#include <Windows.h>
#include <algorithm>
#include <array>
#include <atomic>
#include <bit>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <cctype>
#include <cstring>
#include <format>
#include <initializer_list>
#include <ranges>
#include <span>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include <MinHook.h>
#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "./executable.hpp"
#include "./lod_distance.hpp"
#include "./overlay.hpp"

// Graphics and start-up tweaks modelled on emoose's Automata-LodMod, for the Steam
// executable with timestamp 6AC89519. Every RVA, byte sequence and formula comes from
// the behavior spec (manual_spec/external/nier_automata_lodmod*.md). Each feature
// validates its own bytes and disables only itself on a mismatch.
namespace nier_automata::graphics_tweaks {

constexpr const char* CONFIG_SECTION = "renodx-nier_automata";

struct CodePatch {
  uintptr_t rva;
  std::vector<uint8_t> original;
  std::vector<uint8_t> replacement;
};

struct FloatSetting {
  const char* label;
  const char* key;
  std::atomic<float>* value;
  float minimum;
  float maximum;
  float game_default;
  const char* tooltip;
};

struct BoolSetting {
  const char* label;
  const char* key;
  std::atomic_bool* value;
  bool experimental;
  const char* tooltip;
};

static std::atomic<float> ao_width = 1.f;
static std::atomic<float> ao_height = 1.f;
static std::atomic<float> shadow_distance_multiplier = 1.f;
static std::atomic<float> shadow_distance_minimum = 0.f;
static std::atomic<float> shadow_distance_maximum = 0.f;
static std::atomic<float> shadow_distance_pss = 0.f;
static std::atomic<float> shadow_filter_bias = 0.f;
static std::atomic<float> shadow_filter_minimum = 0.f;
static std::atomic<float> shadow_filter_maximum = 0.f;
static std::atomic<float> ambient_occlusion_strength = 1.f;
static std::atomic_bool disable_manual_culling = false;
static std::atomic_bool shadow_model_hq = false;
static std::atomic_bool shadow_model_force_all = false;
static std::atomic_bool disable_ambient_occlusion = false;
static std::atomic_bool skip_intro_movies = false;
static std::atomic_bool skip_booting_screens = false;
static std::atomic_bool title_opens_load_game = false;
static uint32_t shadow_resolution = 2048;
static uint32_t communication_screen_resolution = 256;

// Both tables list the live settings first, then the ones that need a restart.
// The shadow sliders come first, then the other live sliders.
constexpr size_t SHADOW_FLOAT_SETTING_COUNT = 7;
constexpr size_t LIVE_FLOAT_SETTING_COUNT = 8;
static const FloatSetting FLOAT_SETTINGS[] = {
    {"Shadow distance multiplier", "ShadowDistanceMultiplier", &shadow_distance_multiplier, 0.f, 10.f, 1.f,
     "Multiplies each scene's shadow distance."},
    {"Shadow distance minimum", "ShadowDistanceMinimum", &shadow_distance_minimum, 0.f, 500.f, 0.f,
     "Raises shorter scene shadow distances to this value. 0 is off; 70 is a good starting value."},
    {"Shadow distance maximum", "ShadowDistanceMaximum", &shadow_distance_maximum, 0.f, 500.f, 0.f,
     "Lowers longer scene shadow distances to this value. 0 is off."},
    {"Shadow distance PSS", "ShadowDistancePSS", &shadow_distance_pss, 0.f, 3000.f, 0.f,
     "Alternative cascade split. Needs a value much larger than the shadow distance, around 1500 in open areas.\n"
     "0 is off. When on, it replaces the scene's farther split distances; multiplier, minimum and maximum\n"
     "then only move the nearest one."},
    {"Shadow filter strength bias", "ShadowFilterStrengthBias", &shadow_filter_bias, -8.f, 8.f, 0.f,
     "Added to each scene's shadow blur strength (usually 4)."},
    {"Shadow filter strength minimum", "ShadowFilterStrengthMinimum", &shadow_filter_minimum, 0.f, 16.f, 0.f,
     "Lowest shadow blur strength. 0 is off."},
    {"Shadow filter strength maximum", "ShadowFilterStrengthMaximum", &shadow_filter_maximum, 0.f, 16.f, 0.f,
     "Highest shadow blur strength. 0 is off."},
    {"Ambient occlusion strength", "AmbientOcclusionStrength", &ambient_occlusion_strength, 0.f, 4.f, 1.f,
     "1 is the game's ambient occlusion. Higher values darken occluded areas more, lower values less; 0 removes it."},
    {"AO width multiplier", "AOMultiplierWidth", &ao_width, 0.1f, 2.f, 1.f,
     "2 renders ambient occlusion at full resolution. May cause fps drop."},
    {"AO height multiplier", "AOMultiplierHeight", &ao_height, 0.1f, 2.f, 1.f,
     "2 renders ambient occlusion at full resolution. May cause fps drop."},
};

constexpr size_t LIVE_BOOL_SETTING_COUNT = 4;
static const BoolSetting BOOL_SETTINGS[] = {
    {"Disable manual culling", "DisableManualCulling", &disable_manual_culling, false,
     "Keeps map models visible that the game hides with scripted triggers.\n"
     "Models named as low-detail stand-ins are still hidden."},
    {"Real-time shadow models", "ShadowModelHQ", &shadow_model_hq, true,
     "Shadows are cast by the visible model, not a static stand-in. Experimental."},
    {"Force shadows on all models", "ShadowModelForceAll", &shadow_model_force_all, true,
     "Lets every model cast shadows. Invisible helper models may cast shadows too, and the model filter list\n"
     "is not applied yet, so some areas can be covered by one large shadow. Experimental.\n"
     "Models loaded before this was first enabled change when their area reloads."},
    {"Disable ambient occlusion", "DisableAmbientOcclusion", &disable_ambient_occlusion, false,
     "Makes the game's final ambient occlusion pass output an unoccluded result.\n"
     "The AO passes before it still run, so this is for comparing the look, not for performance."},
    {"Skip intro movies", "SkipIntroMovies", &skip_intro_movies, false, "Skips the logo movies."},
    {"Skip booting screens", "SkipBootingScreens", &skip_booting_screens, false,
     "Shows a black screen instead of the booting animation until loading completes."},
    {"Title screen opens Load Game", "TitleOpensLoadGame", &title_opens_load_game, false,
     "The title screen goes straight to Load Game; back out of it to reach the main menu."},
};

// Stand-in models whose names the "low"/"lod"/... rule misses; list from Automata-LodMod.
constexpr const char* DEFAULT_CULLING_KEEP_MODELS =
    "g11015_ground:0x1115|buildddddddddddd:0x1214|g10218_ground:0x0318|nolowmap_bg0410_sea:0x1520|"
    "Area1:0x0001|Area2:0x0001|Area3:0x0001|nolowmap_g11517_bigtree_05:0x1517|"
    "g11121_buildings_00:0x1121|g11121_buildings_01:0x1121|g11121_buildings_03:0x1121|"
    "ground_11121:0x1121|enkei1:0x1121|enkei:0x1121|nolowmap_enkei:0x1121";

constexpr uintptr_t PARAM_LOAD_RVA = 0x14C7F0;
constexpr uintptr_t TEXTURE_CREATE_RVA = 0x248160;
constexpr uintptr_t CULL_QUERY_RVA = 0x7F4510;
constexpr uintptr_t CULL_UPDATE_RVA = 0x846680;
constexpr uintptr_t MODEL_SETUP_RVA = 0x84D180;
constexpr uintptr_t SHADOW_CASCADE_RVA = 0x7801E0;
constexpr uintptr_t SHADOW_SIZE_MULTIPLIER_RVA = 0xF513E0;
constexpr uintptr_t OPTION_FLAGS_RVA = 0x1029B00;
constexpr uintptr_t CULL_BYPASS_FLAGS_RVA = 0x1029B9C;
constexpr uintptr_t CULL_DEBUG_FLAGS_RVA = 0x1029BCC;
constexpr uintptr_t CULL_QUERIED_RVA = 0x1250450;
constexpr uintptr_t SHADOW_PARAM_TYPE_RVA = 0xCD8F90;
constexpr std::array<uintptr_t, 3> AO_TEXTURE_RETURN_RVAS = {0x7746DF, 0x77478B, 0x7747F9};

// Argument counts follow the game functions: param load uses three registers, texture
// create reads twelve arguments, model setup eight.
using ParamLoad = uintptr_t (*)(void*, void*, void*);
using TextureCreate = uintptr_t (*)(void*, uint32_t, uint32_t, uintptr_t, uintptr_t, uintptr_t, uintptr_t,
                                    uintptr_t, uintptr_t, uintptr_t, uintptr_t, uintptr_t);
using CullQuery = int (*)(uint32_t, const char*);
using CullUpdate = uintptr_t (*)();
using ModelSetup = int (*)(void*, void*, void*, void*, void*, void*, void*, void*);
using ShadowCascade = uintptr_t (*)(void*, uintptr_t, void*, void*);

static ParamLoad original_param_load = nullptr;
static TextureCreate original_texture_create = nullptr;
static CullQuery original_cull_query = nullptr;
static CullUpdate original_cull_update = nullptr;
static ModelSetup original_model_setup = nullptr;
static ShadowCascade original_shadow_cascade = nullptr;

// cShadowParam fields the settings edit: m_splitPoint[0..3] at +0x14 and m_bokeStrength at +0x34.
struct ShadowValues {
  std::array<float, 4> split_points;
  float filter_strength;
};

struct ForcedModel {
  uint8_t* meshes;
  std::vector<uint32_t> original_flags;
};

constexpr size_t SHADOW_SPLIT_POINTS_OFFSET = 0x14;
constexpr size_t SHADOW_FILTER_STRENGTH_OFFSET = 0x34;
constexpr size_t LOD_BLOCK_OFFSET = 0x390;
constexpr size_t MESH_STRIDE = 0x318;
constexpr size_t MESH_FLAGS_OFFSET = 0x310;

static uintptr_t image_base = 0;
static std::atomic_bool cull_hooks_installed = false;
static bool model_setup_hook_installed = false;
static bool realtime_shadows_applied = false;
static bool forced_shadows_applied = false;
static std::atomic_bool shadow_cascade_hook_installed = false;
// Keyed by LOD block, guarded by lod_distance::lock like the block table it mirrors.
static std::unordered_map<uintptr_t, ForcedModel> forced_models;
// Size multiplier the shadow patch expects the game to have adopted; 0 when unpatched or verified.
static std::atomic_uint32_t unverified_shadow_bits = 0;
// Sorted by name; built once before the cull hooks exist, read-only afterwards.
static std::vector<std::pair<std::string, uint16_t>> soft_filters;
// Appended on the load, overlay and game threads; read by the overlay.
static SRWLOCK failures_lock = SRWLOCK_INIT;
static std::string failures;

static std::vector<uint8_t> Imm32(uint32_t value) {
  return {static_cast<uint8_t>(value), static_cast<uint8_t>(value >> 8), static_cast<uint8_t>(value >> 16),
          static_cast<uint8_t>(value >> 24)};
}

static void ReportFailure(reshade::log::level level, const std::string& message) {
  reshade::log::message(level, ("NieR:Automata graphics tweaks: " + message).c_str());
  AcquireSRWLockExclusive(&failures_lock);
  failures += message + "\n";
  ReleaseSRWLockExclusive(&failures_lock);
}

static bool WriteCode(uintptr_t rva, std::span<const uint8_t> bytes) {
  auto* target = reinterpret_cast<void*>(image_base + rva);
  DWORD old_protection = 0;
  if (!VirtualProtect(target, bytes.size(), PAGE_EXECUTE_READWRITE, &old_protection)) return false;
  std::memcpy(target, bytes.data(), bytes.size());
  FlushInstructionCache(GetCurrentProcess(), target, bytes.size());
  VirtualProtect(target, bytes.size(), old_protection, &old_protection);
  return true;
}

// Applies the patches, or removes them when `apply` is false. All sites are validated
// before any is written, so a feature changes whole or not at all.
static bool ApplyPatches(const char* feature, std::span<const CodePatch> patches, bool apply = true) {
  for (const auto& patch : patches) {
    const auto& expected = (apply ? patch.original : patch.replacement);
    if (std::memcmp(reinterpret_cast<const void*>(image_base + patch.rva), expected.data(), expected.size()) != 0) {
      ReportFailure(reshade::log::level::warning,
                    std::format("{}: unexpected bytes at RVA {:X}; feature not changed.", feature, patch.rva));
      return false;
    }
  }
  for (const auto& patch : patches) {
    const auto& bytes = (apply ? patch.replacement : patch.original);
    if (!WriteCode(patch.rva, bytes)) {
      ReportFailure(reshade::log::level::error,
                    std::format("{}: cannot write code at RVA {:X}.", feature, patch.rva));
      return false;
    }
  }
  reshade::log::message(
      reshade::log::level::info,
      std::format("NieR:Automata graphics tweaks: {} {}.", feature, apply ? "applied" : "removed").c_str());
  return true;
}

static bool InstallHook(const char* feature, uintptr_t rva, std::initializer_list<uint8_t> entry, void* detour,
                        void** original) {
  auto* target = reinterpret_cast<void*>(image_base + rva);
  if (std::memcmp(target, entry.begin(), entry.size()) != 0) {
    ReportFailure(reshade::log::level::warning,
                  std::format("{}: unexpected bytes at RVA {:X}; hook not installed.", feature, rva));
    return false;
  }
  const MH_STATUS init = MH_Initialize();
  if ((init != MH_OK && init != MH_ERROR_ALREADY_INITIALIZED) || MH_CreateHook(target, detour, original) != MH_OK
      || MH_EnableHook(target) != MH_OK) {
    ReportFailure(reshade::log::level::error, std::format("{}: hook installation failed at RVA {:X}.", feature, rva));
    return false;
  }
  // Process-lifetime hook: the game may be inside the detour at any time.
  HMODULE pinned = nullptr;
  GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_PIN,
                     reinterpret_cast<LPCWSTR>(detour), &pinned);
  reshade::log::message(reshade::log::level::info,
                        std::format("NieR:Automata graphics tweaks: {} hook installed at RVA {:X}.", feature, rva).c_str());
  return true;
}

// The game packs four cascades into a 2x2 atlas; quadrant size, its shift and the buffer
// size multiplier all have to agree.
static std::vector<CodePatch> ShadowResolutionPatches(uint32_t resolution) {
  const uint32_t quadrant = resolution / 2;
  const uint32_t size_multiplier = resolution >> 11;
  std::vector<CodePatch> patches = {
      // mov ecx, size_multiplier; nop
      {0x7727C4,
       {0x8B, 0x0D, 0x16, 0xEC, 0x7D, 0x00},
       {0xB9, static_cast<uint8_t>(size_multiplier), static_cast<uint8_t>(size_multiplier >> 8), 0x00, 0x00, 0x90}},
      // mov eax, ecx: the option-flag overrides that would force 4 keep the multiplier instead.
      {0x7727CE, {0xB8, 0x04, 0x00, 0x00, 0x00}, {0x89, 0xC8, 0x90, 0x90, 0x90}},
  };
  for (const uintptr_t shift_rva : {0x77F937, 0x77F93D, 0x77FB05, 0x77FB0B}) {
    patches.push_back({shift_rva, {0x0A}, {static_cast<uint8_t>(std::countr_zero(quadrant))}});
  }
  for (const uintptr_t size_rva : {0x77F959, 0x77F95F, 0x77FB27, 0x77FB2D, 0x774D61}) {
    patches.push_back({size_rva, Imm32(0x400), Imm32(quadrant)});
  }
  return patches;
}

// What the current settings make of a scene's loaded shadow parameters.
static ShadowValues AdjustShadowValues(const ShadowValues& loaded) {
  ShadowValues adjusted = loaded;
  const float bias = shadow_filter_bias.load(std::memory_order_relaxed);
  const float strength_maximum = shadow_filter_maximum.load(std::memory_order_relaxed);
  if (bias != 0.f) adjusted.filter_strength = (std::max)(0.f, loaded.filter_strength + bias);
  adjusted.filter_strength =
      (std::max)(shadow_filter_minimum.load(std::memory_order_relaxed), adjusted.filter_strength);
  if (strength_maximum != 0.f) adjusted.filter_strength = (std::min)(strength_maximum, adjusted.filter_strength);

  const float loaded_distance = loaded.split_points[0];
  const float multiplier = (std::max)(0.f, shadow_distance_multiplier.load(std::memory_order_relaxed));
  const float distance_minimum = shadow_distance_minimum.load(std::memory_order_relaxed);
  const float distance_maximum = shadow_distance_maximum.load(std::memory_order_relaxed);
  const float pss = shadow_distance_pss.load(std::memory_order_relaxed);
  float distance = loaded_distance;
  if (multiplier != 1.f) distance = loaded_distance * multiplier;
  if (distance_minimum > 0.f && distance_minimum > distance) distance = distance_minimum;
  if (distance_maximum > 0.f && distance_maximum < distance) distance = distance_maximum;
  if (distance == loaded_distance && pss == 0.f) return adjusted;
  adjusted.split_points[0] = distance;
  if (pss != 0.f) {
    // Practical split scheme: near 1, far pss, 0.75 logarithmic / 0.25 uniform blend.
    adjusted.split_points[1] = std::pow(pss, 0.5f) * 0.75f + ((pss - 1.f) * 0.5f + 1.f) * 0.25f;
    adjusted.split_points[2] = std::pow(pss, 0.75f) * 0.75f + ((pss - 1.f) * 0.75f + 1.f) * 0.25f;
    adjusted.split_points[3] = 0.f;
  } else if (loaded_distance > 0.f) {
    for (int i = 1; i < 4; ++i) {
      adjusted.split_points[i] = loaded.split_points[i] / loaded_distance * distance;
    }
  }
  return adjusted;
}

static uintptr_t OnParamLoad(void* reader, void* a2, void* object) {
  const uintptr_t result = original_param_load(reader, a2, object);
  if (object == nullptr) return result;
  using GetTypeDescriptor = const uintptr_t* (*)(void*);
  const uintptr_t* descriptor = (*static_cast<GetTypeDescriptor**>(object))[0](object);
  if (descriptor == nullptr) return result;
  // The descriptor starts with a pointer to the type name inside the executable.
  switch (descriptor[0] - image_base) {
    case SHADOW_PARAM_TYPE_RVA: {
      // The shadow resolution patch only works if graphics init ran after it. When the
      // game sized its buffers first, viewports would point outside the real atlas.
      if (const uint32_t expected_bits = unverified_shadow_bits.exchange(0); expected_bits != 0) {
        const uint32_t actual_bits = *reinterpret_cast<const uint32_t*>(image_base + SHADOW_SIZE_MULTIPLIER_RVA);
        if (actual_bits != expected_bits) {
          const bool is_vanilla = actual_bits <= 1 || !std::has_single_bit(actual_bits);
          for (const auto& patch : ShadowResolutionPatches(is_vanilla ? 2048 : (actual_bits << 11))) {
            const auto& bytes = (is_vanilla ? patch.original : patch.replacement);
            WriteCode(patch.rva, bytes);
          }
          ReportFailure(reshade::log::level::error,
                        std::format("Shadow resolution: the game initialised its shadow buffers before the patch "
                                    "(size multiplier {}, expected {}); reverted to match the game.",
                                    actual_bits, expected_bits));
        }
      }

      break;
    }
    default:
      break;
  }
  return result;
}

// Builds one shadow cascade. The shadow system object starts with the current cShadowParam,
// which this function reads directly and copies to the renderer's block. The per-frame
// update (797930) steps area transitions on those same fields before calling this for each
// cascade, so the settings are applied for the duration of the call only and the game's
// own values are put back afterwards.
static uintptr_t OnShadowCascade(void* shadow_system, uintptr_t cascade, void* a3, void* a4) {
  auto* fields = static_cast<uint8_t*>(shadow_system);
  ShadowValues game_values;
  std::memcpy(game_values.split_points.data(), fields + SHADOW_SPLIT_POINTS_OFFSET, sizeof(game_values.split_points));
  std::memcpy(&game_values.filter_strength, fields + SHADOW_FILTER_STRENGTH_OFFSET, sizeof(game_values.filter_strength));
  const ShadowValues adjusted = AdjustShadowValues(game_values);
  if (std::memcmp(&adjusted, &game_values, sizeof(adjusted)) == 0) {
    return original_shadow_cascade(shadow_system, cascade, a3, a4);
  }
  auto write_values = [fields](const ShadowValues& values) {
    std::memcpy(fields + SHADOW_SPLIT_POINTS_OFFSET, values.split_points.data(), sizeof(values.split_points));
    std::memcpy(fields + SHADOW_FILTER_STRENGTH_OFFSET, &values.filter_strength, sizeof(values.filter_strength));
  };
  // The per-frame update repairs a third split point above the fourth before it gets here
  // (797AC1): it doubles the third into the fourth and copies two per-cascade fields along.
  // PSS relies on that by writing a fourth of 0, so the repair is repeated for this call.
  std::array<uint32_t, 2> game_last_cascade_fields;
  std::memcpy(&game_last_cascade_fields[0], fields + 0x30, sizeof(uint32_t));
  std::memcpy(&game_last_cascade_fields[1], fields + 0x40, sizeof(uint32_t));
  ShadowValues applied = adjusted;
  const bool needs_repair = applied.split_points[2] > applied.split_points[3];
  if (needs_repair) {
    applied.split_points[3] = applied.split_points[2] * 2.f;
    std::memcpy(fields + 0x30, fields + 0x2C, sizeof(uint32_t));
    std::memcpy(fields + 0x40, fields + 0x3C, sizeof(uint32_t));
  }
  write_values(applied);
  const uintptr_t result = original_shadow_cascade(shadow_system, cascade, a3, a4);
  write_values(game_values);
  if (needs_repair) {
    std::memcpy(fields + 0x30, &game_last_cascade_fields[0], sizeof(uint32_t));
    std::memcpy(fields + 0x40, &game_last_cascade_fields[1], sizeof(uint32_t));
  }
  return result;
}

static uintptr_t OnTextureCreate(void* texture, uint32_t width, uint32_t height, uintptr_t a4, uintptr_t a5,
                                 uintptr_t a6, uintptr_t a7, uintptr_t a8, uintptr_t a9, uintptr_t a10,
                                 uintptr_t a11, uintptr_t a12) {
  const uintptr_t caller = reinterpret_cast<uintptr_t>(_ReturnAddress()) - image_base;
  if (std::ranges::find(AO_TEXTURE_RETURN_RVAS, caller) != AO_TEXTURE_RETURN_RVAS.end()) {
    width = (std::max)(1u, static_cast<uint32_t>(static_cast<float>(width) * ao_width.load()));
    height = (std::max)(1u, static_cast<uint32_t>(static_cast<float>(height) * ao_height.load()));
  }
  return original_texture_create(texture, width, height, a4, a5, a6, a7, a8, a9, a10, a11, a12);
}

// Returns 1 when the map model is hidden by the active culling trigger.
static int OnCullQuery(uint32_t area, const char* name) {
  if (!disable_manual_culling.load(std::memory_order_relaxed) || name == nullptr) {
    return original_cull_query(area, name);
  }
  // The original marks that a query happened; keep that side effect when answering for it.
  auto report_shown = [] {
    *reinterpret_cast<uint32_t*>(image_base + CULL_QUERIED_RVA) = 1;
    return 0;
  };
  if ((*reinterpret_cast<const uint32_t*>(image_base + CULL_BYPASS_FLAGS_RVA) & (1u << 30)) != 0) return report_shown();
  std::array<char, 128> lowered;
  size_t length = 0;
  for (; name[length] != '\0'; ++length) {
    if (length == lowered.size()) return original_cull_query(area, name);
    lowered[length] = (name[length] >= 'A' && name[length] <= 'Z') ? static_cast<char>(name[length] + 32) : name[length];
  }
  const std::string_view lowered_name(lowered.data(), length);
  auto contains = [&lowered_name](std::string_view part) { return lowered_name.find(part) != std::string_view::npos; };

  // Low-detail stand-ins must stay culled or they draw on top of the real geometry.
  // "nolow" marks real geometry, except far variants.
  if (contains("low") || contains("lod") || contains("dummy") || contains("distant") || contains("far")) {
    if (!contains("nolow") || contains("far")) return original_cull_query(area, name);
  }
  // Soft filters name stand-ins the rule above misses; area 0 covers every area.
  const auto [first, last] = std::ranges::equal_range(soft_filters, lowered_name, {},
                                                      &std::pair<std::string, uint16_t>::first);
  for (auto filter = first; filter != last; ++filter) {
    if (filter->second == 0 || filter->second == (area & 0xFFFF)) return original_cull_query(area, name);
  }
  return report_shown();
}

static uintptr_t OnCullUpdate() {
  constexpr uint32_t BIT_28 = 1u << 28;
  constexpr uint32_t BIT_30 = 1u << 30;
  if (!disable_manual_culling.load(std::memory_order_relaxed)
      || (*reinterpret_cast<const uint32_t*>(image_base + CULL_DEBUG_FLAGS_RVA) & BIT_28) == 0) {
    return original_cull_update();
  }
  auto* option_flags = reinterpret_cast<uint32_t*>(image_base + OPTION_FLAGS_RVA);
  const uint32_t saved_flags = *option_flags;
  *option_flags = saved_flags | BIT_30;
  const uintptr_t result = original_cull_update();
  *option_flags = saved_flags;
  return result;
}

// Marks every mesh of the model as a shadow caster and remembers the game's flags so the
// option can be turned off again. Same walk as the game's own flag pass at 197E20.
// The caller holds lod_distance::lock.
static void ForceShadowFlags(uintptr_t lod_block) {
  struct {
    uint8_t* meshes;
    int32_t count;
  } mesh_array = {};
  if (!lod_distance::SafeCopy(&mesh_array, reinterpret_cast<const void*>(lod_block + 0x20), 12)
      || mesh_array.meshes == nullptr || mesh_array.count <= 0 || mesh_array.count > 0x4000) return;
  ForcedModel forced = {.meshes = mesh_array.meshes};
  forced.original_flags.resize(mesh_array.count);
  for (int32_t i = 0; i < mesh_array.count; ++i) {
    uint8_t* flags_address = mesh_array.meshes + i * MESH_STRIDE + MESH_FLAGS_OFFSET;
    uint32_t flags = 0;
    if (!lod_distance::SafeCopy(&flags, flags_address, sizeof(flags))) return;
    forced.original_flags[i] = flags;
    flags |= 1;
    lod_distance::SafeCopy(flags_address, &flags, sizeof(flags));
  }
  forced_models[lod_block] = std::move(forced);
}

// The game marks or clears shadow casting per mesh during model setup, so the override
// has to run after the whole setup.
static int OnModelSetup(void* model, void* a2, void* a3, void* a4, void* a5, void* a6, void* a7, void* a8) {
  const int result = original_model_setup(model, a2, a3, a4, a5, a6, a7, a8);
  if (result == 0 || !shadow_model_force_all.load(std::memory_order_relaxed)) return result;
  AcquireSRWLockExclusive(&lod_distance::lock);
  ForceShadowFlags(reinterpret_cast<uintptr_t>(model) + LOD_BLOCK_OFFSET);
  // Entries of torn-down blocks are only needed until the next restore; drop them in bulk.
  if (forced_models.size() > lod_distance::tables.size() * 2 + 64) {
    std::erase_if(forced_models, [](const auto& entry) { return !lod_distance::tables.contains(entry.first); });
  }
  ReleaseSRWLockExclusive(&lod_distance::lock);
  return result;
}

static const std::vector<CodePatch> REALTIME_SHADOW_PATCHES = {
    // Visible meshes cast shadows even when a shadow-only model exists...
    {0x848319, {0x75, 0x34}, {0x90, 0x90}},
    // ...and shadow-only meshes are never submitted, so nothing is drawn twice.
    {0x84822D, {0x0F, 0x85}, {0x90, 0xE9}},
};
// The per-mesh "does not cast shadows" field is ignored.
static const std::vector<CodePatch> FORCED_SHADOW_PATCHES = {{0x8482FA, {0x75, 0x53}, {0x90, 0x90}}};

// Models are tracked through the LOD block hooks, so those are installed as well.
static bool EnableForcedShadows() {
  if (!ApplyPatches("Force shadows on all models", FORCED_SHADOW_PATCHES)) return false;
  if (!model_setup_hook_installed) {
    model_setup_hook_installed =
        InstallHook("Force shadows on all models", MODEL_SETUP_RVA,
                    {0x4C, 0x8B, 0xDC, 0x41, 0x54, 0x41, 0x56, 0x41, 0x57, 0x48, 0x83, 0xEC, 0x40, 0x49, 0xC7, 0x43},
                    reinterpret_cast<void*>(&OnModelSetup), reinterpret_cast<void**>(&original_model_setup));
  }
  lod_distance::Install();
  return true;
}

static void InstallShadowCascadeHook() {
  if (shadow_cascade_hook_installed.exchange(true)) return;
  InstallHook("Shadow parameters", SHADOW_CASCADE_RVA,
              {0x48, 0x8B, 0xC4, 0x55, 0x56, 0x57, 0x41, 0x54, 0x41, 0x55, 0x41, 0x56, 0x41, 0x57, 0x48, 0x8D},
              reinterpret_cast<void*>(&OnShadowCascade), reinterpret_cast<void**>(&original_shadow_cascade));
}

static void InstallCullHooks() {
  if (cull_hooks_installed.exchange(true)) return;
  const std::initializer_list<uint8_t> update_entry = {0x48, 0x83, 0xEC, 0x28, 0xF7, 0x05, 0x72, 0x34,
                                                       0x7E, 0x00, 0x00, 0x00, 0x00, 0x40, 0x74, 0x09};
  if (std::memcmp(reinterpret_cast<const void*>(image_base + CULL_UPDATE_RVA), update_entry.begin(),
                  update_entry.size()) != 0) {
    ReportFailure(reshade::log::level::warning, "Manual culling: unexpected bytes at RVA 846680; hooks not installed.");
    return;
  }
  if (InstallHook("Manual culling", CULL_QUERY_RVA,
                  {0x48, 0x89, 0x5C, 0x24, 0x08, 0x48, 0x89, 0x74, 0x24, 0x10, 0x57, 0x48, 0x83, 0xEC, 0x20, 0x83},
                  reinterpret_cast<void*>(&OnCullQuery), reinterpret_cast<void**>(&original_cull_query))) {
    InstallHook("Manual culling", CULL_UPDATE_RVA, update_entry, reinterpret_cast<void*>(&OnCullUpdate),
                reinterpret_cast<void**>(&original_cull_update));
  }
}

// Called once from init_device, after lod_distance::Initialize. Restart-only features are
// applied here; live features install their hook here or on first use from the overlay.
static void Initialize(uintptr_t base) {
  if (image_base != 0) return;
  image_base = base;

  for (const auto& setting : FLOAT_SETTINGS) {
    float value = setting.game_default;
    reshade::get_config_value(nullptr, CONFIG_SECTION, setting.key, value);
    // Written so that NaN falls back to the default as well.
    if (!(value >= setting.minimum && value <= setting.maximum)) value = setting.game_default;
    setting.value->store(value);
  }
  for (const auto& setting : BOOL_SETTINGS) {
    uint32_t value = 0;
    reshade::get_config_value(nullptr, CONFIG_SECTION, setting.key, value);
    setting.value->store(value != 0);
  }
  reshade::get_config_value(nullptr, CONFIG_SECTION, "ShadowResolution", shadow_resolution);
  if (!std::has_single_bit(shadow_resolution) || shadow_resolution < 2048 || shadow_resolution > 16384) {
    shadow_resolution = 2048;
  }
  reshade::get_config_value(nullptr, CONFIG_SECTION, "CommunicationScreenResolution", communication_screen_resolution);
  if (!std::has_single_bit(communication_screen_resolution) || communication_screen_resolution < 256
      || communication_screen_resolution > 2048) {
    communication_screen_resolution = 256;
  }
  if (!executable::GetStatus().supported) return;

  // Map models that keep the game's own culling, as "name:area|name:area" (area 0 = every
  // area). The default is written out on first run so the list can be edited in the config.
  std::array<char, 8192> filter_list = {};
  size_t filter_list_size = filter_list.size();
  if (!reshade::get_config_value(nullptr, CONFIG_SECTION, "ManualCullingKeepModels", filter_list.data(),
                                 &filter_list_size)) {
    std::strncpy(filter_list.data(), DEFAULT_CULLING_KEEP_MODELS, filter_list.size() - 1);
    reshade::set_config_value(nullptr, CONFIG_SECTION, "ManualCullingKeepModels", DEFAULT_CULLING_KEEP_MODELS);
  }
  for (const auto entry_range : std::string_view(filter_list.data()) | std::views::split('|')) {
    const std::string_view entry(entry_range.begin(), entry_range.end());
    const size_t separator = entry.find(':');
    if (separator == std::string_view::npos || separator == 0) continue;
    std::string name(entry.substr(0, separator));
    std::ranges::transform(name, name.begin(), [](unsigned char character) { return std::tolower(character); });
    soft_filters.emplace_back(
        std::move(name), static_cast<uint16_t>(std::strtoul(std::string(entry.substr(separator + 1)).c_str(), nullptr, 0)));
  }
  std::ranges::sort(soft_filters);

  if (shadow_resolution != 2048 && ApplyPatches("Shadow resolution", ShadowResolutionPatches(shadow_resolution))) {
    unverified_shadow_bits.store(shadow_resolution >> 11);
  }
  if (communication_screen_resolution != 256) {
    ApplyPatches("Communication screen resolution",
                 std::vector<CodePatch>{
                     {0x772998, Imm32(0x100), Imm32(communication_screen_resolution)},
                     {0x77541C, Imm32(0x100), Imm32(communication_screen_resolution)},
                 });
  }
  if (skip_intro_movies.load()) {
    // jne taken when the movie opened; falling through marks the movie finished.
    ApplyPatches("Skip intro movies", std::vector<CodePatch>{{0x7610B6, {0x75, 0x17}, {0x90, 0x90}}});
  }
  if (skip_booting_screens.load()) {
    ApplyPatches("Skip booting screens",
                 std::vector<CodePatch>{
                     // The booting sound call, then both animation states become "finished".
                     {0x97CC99, {0xE8, 0xD2, 0x98, 0xEE, 0xFF}, {0x90, 0x90, 0x90, 0x90, 0x90}},
                     {0x97CCBC, Imm32(2), Imm32(3)},
                     {0x97CCD1, Imm32(1), Imm32(3)},
                 });
  }
  if (title_opens_load_game.load()) {
    ApplyPatches("Title screen opens Load Game",
                 std::vector<CodePatch>{
                     // or dword [rax+58h], 40000000h -> mov dword [rbx+28h], 1
                     {0x990E4F, {0x81, 0x48, 0x58, 0x00, 0x00, 0x00, 0x40}, {0xC7, 0x43, 0x28, 0x01, 0x00, 0x00, 0x00}},
                     {0x990E5F, Imm32(4), Imm32(8)},
                     {0x990FD6, {0x75, 0x07}, {0x90, 0x90}},
                     {0x990FDB, Imm32(3), Imm32(4)},
                 });
  }
  if (shadow_model_hq.load()) {
    realtime_shadows_applied = ApplyPatches("Real-time shadow models", REALTIME_SHADOW_PATCHES);
  }
  if (shadow_model_force_all.load()) forced_shadows_applied = EnableForcedShadows();
  if (ao_width.load() != 1.f || ao_height.load() != 1.f) {
    const bool call_sites_intact = std::ranges::all_of(AO_TEXTURE_RETURN_RVAS, [](uintptr_t return_rva) {
      return *reinterpret_cast<const uint8_t*>(image_base + return_rva - 5) == 0xE8;
    });
    if (call_sites_intact) {
      InstallHook("AO resolution", TEXTURE_CREATE_RVA, {0x40, 0x57, 0x48, 0x81, 0xEC, 0x80, 0x00, 0x00, 0x00},
                  reinterpret_cast<void*>(&OnTextureCreate), reinterpret_cast<void**>(&original_texture_create));
    } else {
      ReportFailure(reshade::log::level::warning, "AO resolution: unexpected bytes at a call site; hook not installed.");
    }
  }
  const bool shadow_settings_changed =
      std::ranges::any_of(std::span(FLOAT_SETTINGS).first(SHADOW_FLOAT_SETTING_COUNT),
                          [](const FloatSetting& setting) { return setting.value->load() != setting.game_default; });
  if (shadow_settings_changed) InstallShadowCascadeHook();
  // The scene parameter loader is hooked only to check the shadow resolution patch.
  if (unverified_shadow_bits.load() != 0) {
    InstallHook("Shadow resolution check", PARAM_LOAD_RVA,
                {0x40, 0x53, 0x57, 0x41, 0x54, 0x41, 0x55, 0x41, 0x56, 0x41, 0x57, 0x48, 0x81, 0xEC, 0xA8, 0x00},
                reinterpret_cast<void*>(&OnParamLoad), reinterpret_cast<void**>(&original_param_load));
  }
  if (disable_manual_culling.load()) InstallCullHooks();
}

static void OnOverlay() {
  if (!ImGui::CollapsingHeader("Graphics tweaks")) return;

  auto draw_float = [](const FloatSetting& setting) {
    float value = setting.value->load(std::memory_order_relaxed);
    bool changed = ImGui::SliderFloat(setting.label, &value, setting.minimum, setting.maximum, "%.2f",
                                      ImGuiSliderFlags_AlwaysClamp);
    if (ImGui::IsItemHovered()) ImGui::SetTooltip("%s", setting.tooltip);
    changed |= overlay::ResetToDefault(setting.key, &value, setting.game_default);
    if (changed) {
      setting.value->store(value, std::memory_order_relaxed);
      reshade::set_config_value(nullptr, CONFIG_SECTION, setting.key, value);
    }
    return changed;
  };
  auto draw_bool = [](const BoolSetting& setting) {
    bool value = setting.value->load(std::memory_order_relaxed);
    if (setting.experimental) ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.f, 0.35f, 0.35f, 1.f));
    bool changed = ImGui::Checkbox(setting.label, &value);
    if (setting.experimental) ImGui::PopStyleColor();
    if (ImGui::IsItemHovered()) ImGui::SetTooltip("%s", setting.tooltip);
    changed |= overlay::ResetToDefault(setting.key, &value, false);
    if (changed) {
      setting.value->store(value, std::memory_order_relaxed);
      reshade::set_config_value(nullptr, CONFIG_SECTION, setting.key, uint32_t(value));
    }
    return changed;
  };
  // Power-of-two sizes; the combo index is the exponent above the smallest size.
  auto draw_resolution = [](const char* label, const char* key, const char* items, uint32_t smallest,
                            uint32_t* resolution, const char* tooltip) {
    int index = std::countr_zero(*resolution) - std::countr_zero(smallest);
    bool changed = ImGui::Combo(label, &index, items);
    if (ImGui::IsItemHovered()) ImGui::SetTooltip("%s", tooltip);
    // The smallest size is the game's own.
    changed |= overlay::ResetToDefault(key, &index, 0);
    if (changed) {
      *resolution = smallest << index;
      reshade::set_config_value(nullptr, CONFIG_SECTION, key, *resolution);
    }
  };

  const bool supported = executable::GetStatus().supported;
  ImGui::SeparatorText("Live");
  lod_distance::OnOverlay();
  for (size_t i = 0; i < LIVE_FLOAT_SETTING_COUNT; ++i) {
    if (draw_float(FLOAT_SETTINGS[i]) && supported && i < SHADOW_FLOAT_SETTING_COUNT) InstallShadowCascadeHook();
  }
  for (size_t i = 0; i < LIVE_BOOL_SETTING_COUNT; ++i) {
    const auto& setting = BOOL_SETTINGS[i];
    if (!draw_bool(setting) || !supported) continue;
    const bool enabled = setting.value->load();
    if (setting.value == &disable_manual_culling) {
      if (enabled) InstallCullHooks();
    } else if (setting.value == &shadow_model_hq) {
      if (enabled != realtime_shadows_applied
          && ApplyPatches("Real-time shadow models", REALTIME_SHADOW_PATCHES, enabled)) {
        realtime_shadows_applied = enabled;
      }
    } else if (setting.value == &shadow_model_force_all) {
      if (enabled && !forced_shadows_applied && EnableForcedShadows()) {
        forced_shadows_applied = true;
        AcquireSRWLockExclusive(&lod_distance::lock);
        for (const auto& [lod_block, table] : lod_distance::tables) {
          ForceShadowFlags(lod_block);
        }
        ReleaseSRWLockExclusive(&lod_distance::lock);
      } else if (!enabled && forced_shadows_applied
                 && ApplyPatches("Force shadows on all models", FORCED_SHADOW_PATCHES, false)) {
        forced_shadows_applied = false;
        // Give every still-loaded model its own shadow-caster bit back.
        AcquireSRWLockExclusive(&lod_distance::lock);
        for (const auto& [lod_block, forced] : forced_models) {
          struct {
            uint8_t* meshes;
            int32_t count;
          } mesh_array = {};
          if (!lod_distance::tables.contains(lod_block)
              || !lod_distance::SafeCopy(&mesh_array, reinterpret_cast<const void*>(lod_block + 0x20), 12)
              || mesh_array.meshes != forced.meshes
              || mesh_array.count != static_cast<int32_t>(forced.original_flags.size())) continue;
          for (int32_t mesh = 0; mesh < mesh_array.count; ++mesh) {
            uint8_t* flags_address = mesh_array.meshes + mesh * MESH_STRIDE + MESH_FLAGS_OFFSET;
            uint32_t flags = 0;
            if (!lod_distance::SafeCopy(&flags, flags_address, sizeof(flags))) break;
            flags = (flags & ~1u) | (forced.original_flags[mesh] & 1u);
            lod_distance::SafeCopy(flags_address, &flags, sizeof(flags));
          }
        }
        forced_models.clear();
        ReleaseSRWLockExclusive(&lod_distance::lock);
      }
    }
    // Disable ambient occlusion needs nothing here: the shader replacement reads the flag.
  }

  ImGui::SeparatorText("Requires restart");
  for (size_t i = LIVE_FLOAT_SETTING_COUNT; i < std::size(FLOAT_SETTINGS); ++i) {
    draw_float(FLOAT_SETTINGS[i]);
  }
  draw_resolution("Shadow resolution", "ShadowResolution", "2048\0" "4096\0" "8192\0" "16384\0", 2048,
                  &shadow_resolution,
                  "Size of the shadow atlas. Sharper shadows; higher values need more GPU memory.");
  draw_resolution("Communication screen resolution", "CommunicationScreenResolution",
                  "256\0" "512\0" "1024\0" "2048\0", 256, &communication_screen_resolution,
                  "Size of the pod communication screen render target.");
  for (size_t i = LIVE_BOOL_SETTING_COUNT; i < std::size(BOOL_SETTINGS); ++i) {
    draw_bool(BOOL_SETTINGS[i]);
  }
  AcquireSRWLockShared(&failures_lock);
  if (!failures.empty()) {
    ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.f, 0.25f, 0.25f, 1.f));
    ImGui::TextWrapped("%s", failures.c_str());
    ImGui::PopStyleColor();
  }
  ReleaseSRWLockShared(&failures_lock);
}

}  // namespace nier_automata::graphics_tweaks
