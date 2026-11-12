/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <Windows.h>
#include <array>
#include <atomic>
#include <cstdint>
#include <cstring>
#include <unordered_map>

#include <MinHook.h>
#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

namespace nier_automata::lod_distance {

// Derived from the installed Steam executable (timestamp 6AC89519).
// Every model owns an LOD block: +0x60 float* rates, +0x68 count (WMB LOD count + 1),
// +0x6C cull threshold. Rate i is the screen-size ratio below which the model drops
// from LOD i to LOD i+1 (the last entry hides it when UseLostLOD is set). Defaults come
// from objReadInfo.bxm DistRate0-3 or per-class code (0.7/0.2/0.1/0.03) after setup.
// Verified in game: dividing the rates keeps full-detail meshes much farther away.
constexpr uint32_t EXE_TIMESTAMP = 0x6AC89519;
constexpr uintptr_t LOD_SETUP_RVA = 0x1951B0;
constexpr uintptr_t LOD_TEARDOWN_RVA = 0x1948A0;
constexpr std::array<uint8_t, 16> LOD_SETUP_ENTRY = {
    0x48, 0x8B, 0xC4, 0x57, 0x41, 0x54, 0x41, 0x55, 0x41, 0x56, 0x41, 0x57, 0x48, 0x83, 0xEC, 0x40};
constexpr std::array<uint8_t, 15> LOD_TEARDOWN_ENTRY = {
    0x40, 0x57, 0x48, 0x83, 0xEC, 0x30, 0x48, 0xC7, 0x44, 0x24, 0x20, 0xFE, 0xFF, 0xFF, 0xFF};
constexpr int MAX_RATES = 8;

struct Table {
  float* rates;
  std::array<float, MAX_RATES> original;
  std::array<float, MAX_RATES> written;
};

using LodSetup = int (*)(void*, void*, void*, void*, void*);
using LodTeardown = void (*)(void*);
static LodSetup original_setup = nullptr;
static LodTeardown original_teardown = nullptr;
static uintptr_t image_base = 0;
static SRWLOCK lock = SRWLOCK_INIT;
static std::unordered_map<uintptr_t, Table> tables;
static std::atomic<float> multiplier = 1.f;
static std::atomic_bool installed = false;
static const char* status = "Off";

// Model blocks can be released in bulk on area unload; never fault on a stale entry.
bool SafeCopy(void* destination, const void* source, size_t size) {
  __try {
    std::memcpy(destination, source, size);
    return true;
  } __except (EXCEPTION_EXECUTE_HANDLER) {
    return false;
  }
}

// The lock is held across the game call so Tick never touches a block mid-(re)allocation.
int OnLodSetup(void* model, void* a2, void* a3, void* a4, void* a5) {
  AcquireSRWLockExclusive(&lock);
  const int result = original_setup(model, a2, a3, a4, a5);
  tables.erase(reinterpret_cast<uintptr_t>(model));
  if (result != 0) {
    Table table = {};
    std::memcpy(&table.rates, static_cast<uint8_t*>(model) + 0x60, sizeof(table.rates));
    table.original.fill(-1.f);
    table.written.fill(-1.f);
    tables.emplace(reinterpret_cast<uintptr_t>(model), table);
  }
  ReleaseSRWLockExclusive(&lock);
  return result;
}

void OnLodTeardown(void* model) {
  AcquireSRWLockExclusive(&lock);
  tables.erase(reinterpret_cast<uintptr_t>(model));
  original_teardown(model);
  ReleaseSRWLockExclusive(&lock);
}

// Rates are written by object code after setup and may be rewritten later; any value
// that differs from the last scaled write is a new game value and becomes the original.
void Tick() {
  if (!installed.load(std::memory_order_acquire)) return;
  const float scale = multiplier.load(std::memory_order_relaxed);
  AcquireSRWLockExclusive(&lock);
  for (auto it = tables.begin(); it != tables.end();) {
    struct {
      float* rates;
      int32_t count;
    } block;
    std::array<float, MAX_RATES> current;
    const auto* model = reinterpret_cast<const uint8_t*>(it->first);
    if (!SafeCopy(&block, model + 0x60, sizeof(block)) || block.rates != it->second.rates
        || block.count < 1 || block.count > MAX_RATES
        || !SafeCopy(current.data(), block.rates, block.count * sizeof(float))) {
      it = tables.erase(it);
      continue;
    }
    Table& table = it->second;
    bool changed = false;
    for (int i = 0; i < block.count; ++i) {
      if (current[i] != table.written[i]) table.original[i] = current[i];
      table.written[i] = table.original[i] > 0.f ? table.original[i] / scale : table.original[i];
      changed |= current[i] != table.written[i];
    }
    if (changed && !SafeCopy(block.rates, table.written.data(), block.count * sizeof(float))) {
      it = tables.erase(it);
      continue;
    }
    ++it;
  }
  ReleaseSRWLockExclusive(&lock);
}

// Installed only when the multiplier leaves vanilla; models set up earlier keep
// vanilla LODs until the area reloads.
void Install() {
  if (installed.load(std::memory_order_acquire) || image_base == 0) return;
  const auto* dos = reinterpret_cast<const IMAGE_DOS_HEADER*>(image_base);
  const auto* nt = reinterpret_cast<const IMAGE_NT_HEADERS*>(image_base + dos->e_lfanew);
  auto* setup = reinterpret_cast<void*>(image_base + LOD_SETUP_RVA);
  auto* teardown = reinterpret_cast<void*>(image_base + LOD_TEARDOWN_RVA);
  if (nt->FileHeader.TimeDateStamp != EXE_TIMESTAMP
      || std::memcmp(setup, LOD_SETUP_ENTRY.data(), LOD_SETUP_ENTRY.size()) != 0
      || std::memcmp(teardown, LOD_TEARDOWN_ENTRY.data(), LOD_TEARDOWN_ENTRY.size()) != 0) {
    status = "Unsupported executable or conflicting patch; not installed";
    reshade::log::message(reshade::log::level::warning, "NieR:Automata LOD distance: unsupported executable.");
    return;
  }
  const MH_STATUS init = MH_Initialize();
  if ((init != MH_OK && init != MH_ERROR_ALREADY_INITIALIZED)
      || MH_CreateHook(setup, reinterpret_cast<void*>(&OnLodSetup), reinterpret_cast<void**>(&original_setup)) != MH_OK
      || MH_CreateHook(teardown, reinterpret_cast<void*>(&OnLodTeardown), reinterpret_cast<void**>(&original_teardown)) != MH_OK
      || MH_EnableHook(setup) != MH_OK || MH_EnableHook(teardown) != MH_OK) {
    status = "Hook installation failed; see ReShade.log";
    reshade::log::message(reshade::log::level::error, "NieR:Automata LOD distance: hook installation failed.");
    return;
  }
  HMODULE pinned = nullptr;
  GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_PIN,
                     reinterpret_cast<LPCWSTR>(&OnLodSetup), &pinned);
  installed.store(true, std::memory_order_release);
  status = "Installed (Steam build 6AC89519)";
  reshade::log::message(reshade::log::level::info, "NieR:Automata LOD distance: installed.");
}

void Initialize(uintptr_t base) {
  image_base = base;
  if (multiplier.load() > 1.f) Install();
}

void OnOverlay() {
  float value = multiplier.load(std::memory_order_relaxed);
  if (ImGui::SliderFloat("LOD distance", &value, 1.f, 20.f, "%.1fx")) {
    multiplier.store(value, std::memory_order_relaxed);
    reshade::set_config_value(nullptr, "renodx-nier_automata", "LODDistance", value);
    if (value > 1.f) Install();
  }
  if (ImGui::IsItemHovered()) {
    ImGui::SetTooltip(
        "Keeps full-detail models (bushes, props, buildings) out to this many times the game's LOD distance.\n"
        "1.0x is vanilla. Higher values cost GPU time. Models loaded before the first change\n"
        "keep vanilla LODs until the area reloads.");
  }
  if (value > 1.f) ImGui::Text("%s; tracked models: %zu", status, tables.size());
}

}  // namespace nier_automata::lod_distance
