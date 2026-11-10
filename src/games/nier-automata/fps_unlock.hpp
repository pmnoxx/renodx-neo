/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <Windows.h>
#include <array>
#include <atomic>
#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <stdexcept>
#include <thread>

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "../../utils/minhook.hpp"

namespace nier_automata::fps_unlock {

// Independently derived from the installed Steam executable's disassembly.
// These RVAs are specific to this build.
constexpr uint32_t EXE_TIMESTAMP = 0x6AC89519;
constexpr uint32_t EXE_IMAGE_SIZE = 0x18BE000;
constexpr uintptr_t WAIT_BRANCH_RVA = 0x24A2B5;
constexpr uintptr_t UPDATE_TIMER_RVA = 0x14BEA0;
constexpr uintptr_t GAME_TIMER_RVA = 0x102A260;
constexpr uintptr_t FORCED_STEP_RVA = 0xF80404;
constexpr std::array<uint8_t, 6> ORIGINAL_WAIT = {0x0F, 0x85, 0x0B, 0x01, 0x00, 0x00};
// Keep the original destination and instruction end address: NOP; JMP rel32.
constexpr std::array<uint8_t, 6> SKIP_WAIT = {0x90, 0xE9, 0x0B, 0x01, 0x00, 0x00};
constexpr std::array<uint8_t, 14> TIMER_ENTRY = {
    0x48, 0x89, 0x5C, 0x24, 0x10, 0x57, 0x48, 0x83, 0xEC, 0x30, 0x48, 0x8B, 0xD9, 0x0F};

using UpdateTimer = void (*)(void*, uint32_t, float);
static UpdateTimer original_update_timer = nullptr;
static uintptr_t image_base = 0;
static bool startup_enabled = false;
static std::atomic_bool installed = false;
static std::atomic_bool requested = false;
static std::atomic_int target_fps = 120;
static std::atomic<float> observed_fps = 0.f;
static std::atomic<float> simulation_step = 1.f;
static const char* status = "Disabled at startup";

void OnUpdateTimer(void* timer, uint32_t advance, float fixed_step) {
  if (reinterpret_cast<uintptr_t>(timer) != image_base + GAME_TIMER_RVA) {
    original_update_timer(timer, advance, fixed_step);
    return;
  }

  const bool unlock = requested.load(std::memory_order_relaxed) && advance != 0;
  static uint32_t samples = 0;
  if (samples == 0) reshade::log::message(reshade::log::level::info, "NieR:Automata FPS: entered main timer hook.");
  const int limit = (unlock ? target_fps.load(std::memory_order_relaxed) : 60);
  using Clock = std::chrono::steady_clock;
  static auto previous = Clock::time_point{};
  auto now = Clock::now();
  if (previous != Clock::time_point{}) {
    const auto deadline = previous + std::chrono::nanoseconds(1'000'000'000 / limit);
    if (now + std::chrono::milliseconds(2) < deadline) {
      std::this_thread::sleep_until(deadline - std::chrono::milliseconds(1));
    }
    do {
      now = Clock::now();
      if (now >= deadline) break;
      YieldProcessor();
    } while (true);
    const float elapsed = std::chrono::duration<float>(now - previous).count();
    if (elapsed > 0.f) observed_fps.store(1.f / elapsed, std::memory_order_relaxed);
  }
  previous = now;

  original_update_timer(timer, advance, fixed_step);
  auto* data = static_cast<uint8_t*>(timer);
  float raw_milliseconds, ticks_per_millisecond, forced_step, step;
  std::memcpy(&raw_milliseconds, data + 0xBC, sizeof(float));
  std::memcpy(&ticks_per_millisecond, data + 0xB8, sizeof(float));
  std::memcpy(&forced_step, reinterpret_cast<void*>(image_base + FORCED_STEP_RVA), sizeof(float));
  std::memcpy(&step, data + 0xB0, sizeof(float));
  // The engine computes raw elapsed milliseconds at +BC, multiplies by +B8,
  // then clamps +B0 to [1,2]. Replace only its destructive lower bound,
  // for the main game timer; keep forced steps and low-FPS behavior intact.
  const float fractional_step = raw_milliseconds * ticks_per_millisecond;
  if (unlock && forced_step <= 0.f && std::isfinite(fractional_step)
      && fractional_step > 0.f && fractional_step < 1.f) {
    step = fractional_step;
    std::memcpy(data + 0xB0, &step, sizeof(float));
  }
  simulation_step.store(step, std::memory_order_relaxed);
  if (++samples == 1 || samples % 600 == 0) {
    char message[256];
    std::snprintf(message, sizeof(message),
                  "NieR:Automata FPS: updates=%.2f step=%.5f raw=%.6f rate=%.3f advance=%u forced=%.3f unlock=%u",
                  observed_fps.load(), step, raw_milliseconds, ticks_per_millisecond, advance, forced_step, unsigned(unlock));
    reshade::log::message(reshade::log::level::info, message);
  }
}

void Initialize(uintptr_t base) {
  if (!startup_enabled || installed.load(std::memory_order_acquire)) return;
  image_base = base;
  reshade::log::message(reshade::log::level::info, "NieR:Automata FPS: initializing independent unlocker.");
  const auto* dos = reinterpret_cast<const IMAGE_DOS_HEADER*>(base);
  const auto* nt = reinterpret_cast<const IMAGE_NT_HEADERS*>(base + dos->e_lfanew);
  // The image identity and separate code/data-reference anchors must all match.
  constexpr std::array<uint8_t, 7> TIMER_OBJECT = {0x48, 0x8D, 0x0D, 0x03, 0xB4, 0x8C, 0x00};
  if (nt->FileHeader.TimeDateStamp != EXE_TIMESTAMP || nt->OptionalHeader.SizeOfImage != EXE_IMAGE_SIZE
      || std::memcmp(reinterpret_cast<void*>(base + WAIT_BRANCH_RVA), ORIGINAL_WAIT.data(), ORIGINAL_WAIT.size()) != 0
      || std::memcmp(reinterpret_cast<void*>(base + UPDATE_TIMER_RVA), TIMER_ENTRY.data(), TIMER_ENTRY.size()) != 0
      || std::memcmp(reinterpret_cast<void*>(base + 0x75EE56), TIMER_OBJECT.data(), TIMER_OBJECT.size()) != 0) {
    status = "Unsupported executable or conflicting patch; FPS unlock not installed";
    reshade::log::message(reshade::log::level::warning, status);
    return;
  }

  const renodx::utils::minhook::Function hook = {
      reinterpret_cast<UpdateTimer>(base + UPDATE_TIMER_RVA), &OnUpdateTimer, &original_update_timer};
  bool initialized = false;
  bool created = false;
  try {
    renodx::utils::minhook::Initialize();
    initialized = true;
    renodx::utils::minhook::Create(hook);
    created = true;
    reshade::log::message(reshade::log::level::info, "NieR:Automata FPS: timer trampoline created.");
    // This owner has process lifetime. Prevent hot-unload while the engine can
    // still be inside the callback/trampoline; changing startup mode needs restart.
    HMODULE pinned = nullptr;
    if (!GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_PIN,
                            reinterpret_cast<LPCWSTR>(&OnUpdateTimer), &pinned)) {
      throw std::runtime_error("NieR:Automata FPS unlock: cannot pin addon");
    }
    DWORD old_protection = 0;
    auto* branch = reinterpret_cast<void*>(base + WAIT_BRANCH_RVA);
    if (!VirtualProtect(branch, SKIP_WAIT.size(), PAGE_EXECUTE_READWRITE, &old_protection)) {
      throw std::runtime_error("NieR:Automata FPS unlock: cannot protect limiter branch");
    }
    // init_device runs before the engine enters its render wait loop. The timer
    // hook is enabled first, so a failed installation leaves the native wait.
    try {
      renodx::utils::minhook::Enable(hook);
    } catch (...) {
      DWORD ignored;
      VirtualProtect(branch, SKIP_WAIT.size(), old_protection, &ignored);
      throw;
    }
    std::memcpy(branch, SKIP_WAIT.data(), SKIP_WAIT.size());
    FlushInstructionCache(GetCurrentProcess(), branch, SKIP_WAIT.size());
    DWORD ignored;
    VirtualProtect(branch, SKIP_WAIT.size(), old_protection, &ignored);
    installed.store(true, std::memory_order_release);
    status = "Installed (Steam build 6AC89519); experimental";
    reshade::log::message(reshade::log::level::info, "NieR:Automata: independent FPS unlock installed.");
  } catch (const std::exception& error) {
    if (created) renodx::utils::minhook::Remove(hook);
    if (initialized) renodx::utils::minhook::Uninitialize();
    status = "FPS unlock installation failed; see ReShade.log";
    reshade::log::message(reshade::log::level::error, error.what());
  }
}

void OnOverlay() {
  ImGui::Separator();
  bool enabled = requested.load(std::memory_order_relaxed);
  if (ImGui::Checkbox("Unlock FPS (experimental)", &enabled)) {
    requested.store(enabled, std::memory_order_relaxed);
    reshade::set_config_value(nullptr, "renodx-nier_automata", "UnlockFPS", uint32_t(enabled));
  }
  int limit = target_fps.load(std::memory_order_relaxed);
  if (ImGui::SliderInt("Gameplay FPS target", &limit, 60, 360)) {
    target_fps.store(limit, std::memory_order_relaxed);
    reshade::set_config_value(nullptr, "renodx-nier_automata", "FPSLimit", uint32_t(limit));
  }
  ImGui::TextUnformatted(status);
  if (!startup_enabled && enabled) ImGui::TextUnformatted("Restart the game to install the unlocker.");
  if (installed.load(std::memory_order_acquire)) {
    ImGui::Text("Game updates: %.1f FPS; simulation step: %.3f", observed_fps.load(), simulation_step.load());
    ImGui::TextWrapped("Turn Unlock FPS off for a 60 FPS safety cap during timing-sensitive scenes. Higher FPS can affect scripts and menus.");
  }
}

}  // namespace nier_automata::fps_unlock
