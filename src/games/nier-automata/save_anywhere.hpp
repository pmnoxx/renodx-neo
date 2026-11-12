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

#include <MinHook.h>
#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

namespace nier_automata::save_anywhere {

// Derived from the installed Steam executable (timestamp 6AC89519).
// CAN_SAVE_RVA returns nonzero when the game currently permits saving. Every save
// entry point (pause menu Save/Load "Save", map and terminal menus) calls it next to
// its other checks; it rejects saving while game-state flags at 0x141029B00..B34
// (including the debugSaveMask bit) or an area check forbid it.
constexpr uint32_t EXE_TIMESTAMP = 0x6AC89519;
constexpr uintptr_t CAN_SAVE_RVA = 0x9CA540;
constexpr std::array<uint8_t, 14> CAN_SAVE_ENTRY = {
    0x48, 0x83, 0xEC, 0x38, 0xF7, 0x05, 0xB2, 0xF5, 0x65, 0x00, 0x00, 0x10, 0x00, 0x00};
// The scenario script also gates saving through the named "@SAVE" state object.
// Its state test compares the object's hashed value with the "allowed" hash; all
// callers pass SAVE_STATE_RVA. Overriding the test leaves the scripted state intact.
constexpr uintptr_t SAVE_STATE_TEST_RVA = 0x38C8C0;
constexpr uintptr_t SAVE_STATE_RVA = 0xFC4C50;
constexpr std::array<uint8_t, 11> SAVE_STATE_TEST_ENTRY = {
    0x81, 0x79, 0x08, 0x9E, 0x45, 0xBC, 0x6F, 0x0F, 0x94, 0xC0, 0xC3};

using CanSave = int (*)();
using SaveStateTest = bool (*)(const void*);
static CanSave original_can_save = nullptr;
static SaveStateTest original_save_state_test = nullptr;
static uintptr_t image_base = 0;
static std::atomic_bool enabled = false;
static std::atomic_bool installed = false;
static const char* status = "Off";

int OnCanSave() {
  return enabled.load(std::memory_order_relaxed) ? 1 : original_can_save();
}

bool OnSaveStateTest(const void* state) {
  return (enabled.load(std::memory_order_relaxed)
          && reinterpret_cast<uintptr_t>(state) == image_base + SAVE_STATE_RVA)
         || original_save_state_test(state);
}

// Installed on first use only, so the game stays unmodified while the option is off.
void Install() {
  if (installed.load(std::memory_order_acquire) || image_base == 0) return;
  const auto* dos = reinterpret_cast<const IMAGE_DOS_HEADER*>(image_base);
  const auto* nt = reinterpret_cast<const IMAGE_NT_HEADERS*>(image_base + dos->e_lfanew);
  auto* target = reinterpret_cast<void*>(image_base + CAN_SAVE_RVA);
  auto* state_test = reinterpret_cast<void*>(image_base + SAVE_STATE_TEST_RVA);
  if (nt->FileHeader.TimeDateStamp != EXE_TIMESTAMP
      || std::memcmp(target, CAN_SAVE_ENTRY.data(), CAN_SAVE_ENTRY.size()) != 0
      || std::memcmp(state_test, SAVE_STATE_TEST_ENTRY.data(), SAVE_STATE_TEST_ENTRY.size()) != 0) {
    status = "Unsupported executable or conflicting patch; not installed";
    reshade::log::message(reshade::log::level::warning, "NieR:Automata save anywhere: unsupported executable.");
    return;
  }
  // The FPS unlocker may already own MinHook initialization; share it.
  const MH_STATUS init = MH_Initialize();
  if ((init != MH_OK && init != MH_ERROR_ALREADY_INITIALIZED)
      || MH_CreateHook(target, reinterpret_cast<void*>(&OnCanSave), reinterpret_cast<void**>(&original_can_save)) != MH_OK
      || MH_CreateHook(state_test, reinterpret_cast<void*>(&OnSaveStateTest),
                       reinterpret_cast<void**>(&original_save_state_test)) != MH_OK
      || MH_EnableHook(target) != MH_OK || MH_EnableHook(state_test) != MH_OK) {
    status = "Hook installation failed; see ReShade.log";
    reshade::log::message(reshade::log::level::error, "NieR:Automata save anywhere: hook installation failed.");
    return;
  }
  // Process-lifetime hook: the game may be inside the callback at any time.
  HMODULE pinned = nullptr;
  GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_PIN,
                     reinterpret_cast<LPCWSTR>(&OnCanSave), &pinned);
  installed.store(true, std::memory_order_release);
  status = "Installed (Steam build 6AC89519)";
  reshade::log::message(reshade::log::level::info, "NieR:Automata save anywhere: installed.");
}

void Initialize(uintptr_t base) {
  image_base = base;
  if (enabled.load()) Install();
}

void OnOverlay() {
  bool value = enabled.load(std::memory_order_relaxed);
  ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.f, 0.35f, 0.35f, 1.f));
  const bool changed = ImGui::Checkbox("Save anywhere (testing)", &value);
  ImGui::PopStyleColor();
  if (changed) {
    enabled.store(value, std::memory_order_relaxed);
    reshade::set_config_value(nullptr, "renodx-nier_automata", "SaveAnywhere", uint32_t(value));
    if (value) Install();
  }
  if (ImGui::IsItemHovered()) {
    ImGui::SetTooltip(
        "Enables Save in the pause menu wherever the game normally greys it out.\n"
        "Saving during scripted events or boss fights can produce a save that resumes in a broken state.\n"
        "Use a separate save slot and back up your saves.");
  }
  if (value) ImGui::TextUnformatted(status);
}

}  // namespace nier_automata::save_anywhere
