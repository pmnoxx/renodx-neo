/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <Windows.h>

#include <shellapi.h>
#include <algorithm>
#include <array>
#include <atomic>
#include <cstdint>
#include <cstring>
#include <cwchar>
#include <filesystem>
#include <format>
#include <fstream>
#include <map>
#include <set>
#include <string>
#include <string_view>
#include <system_error>
#include <vector>

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "./executable.hpp"
#include "./overlay.hpp"

#include "../../utils/iat_hook.hpp"
#include "../../utils/platform.hpp"

// Replacement cutscene movies, such as AI-upscaled 4K packs. Each <name>.usm in the movie
// folder next to the game executable is opened in place of data\movie\<name>.usm; no game
// file is modified. The game sizes its movie heaps for 1920x1080, so larger movies also
// need those heaps enlarged before the game creates them (as Automata-LodMod's
// MovieMultiplier did). Only MPEG video is handled; the game has no H.264 decoder.
namespace nier_automata::movie_mods {

constexpr const char* CONFIG_SECTION = "renodx-nier_automata";
constexpr uint32_t GAME_MOVIE_PIXELS = 1920 * 1080;
constexpr uint32_t MAXIMUM_BUFFER_MULTIPLIER = 16;
// Heap handle of "FILE ROOT"; non-zero once the game's heap setup (86B970) has run.
constexpr uintptr_t FILE_ROOT_HEAP_RVA = 0x13FC4B0;

// `mov edx, size` instructions in the heap setup, in address order. A multiplier m changes each size to
// original + growth * (m - 1): the movie heaps scale, their parents grow by the same amount.
struct HeapSize {
  uintptr_t rva;
  uint32_t original;
  uint32_t growth;
};
constexpr std::array<HeapSize, 4> HEAP_SIZES = {{
    {.rva = 0x86BA05, .original = 0x21EA0000, .growth = 0x03FC0000},  // FILE ROOT, parent of MOVIE FILE
    {.rva = 0x86BA2B, .original = 0xBACC0000, .growth = 0x01E00000},  // TEXTURE ROOT, parent of MOVIE VRAM
    {.rva = 0x86BE47, .original = 0x03FC0000, .growth = 0x03FC0000},  // MOVIE FILE
    {.rva = 0x86C0AF, .original = 0x01E00000, .growth = 0x01E00000},  // MOVIE VRAM
}};

struct OpenedMovie {
  uint32_t open_count = 0;
  bool replaced = false;
};

static std::atomic_bool enabled = true;
// Written once by Initialize before the file hooks exist, read-only afterwards.
static std::filesystem::path directory;
static std::set<std::wstring> replacements;
static uint32_t largest_width = 0;
static uint32_t largest_height = 0;
static uint32_t required_buffer_multiplier = 1;
static uint32_t applied_buffer_multiplier = 1;
// Why the buffers are smaller than required; shown while replacements are held back.
static const char* buffer_problem =
    "Larger movie buffers are set up when the game starts. Restart the game to load the replacement movies.";
// Lower-case file name of every .usm the game opened, on any thread.
static SRWLOCK opened_lock = SRWLOCK_INIT;
static std::map<std::wstring, OpenedMovie> opened;
static decltype(&CreateFileW) original_create_file_w = nullptr;
static decltype(&CreateFileA) original_create_file_a = nullptr;

// Frame size from the MPEG sequence header of the first video chunk; {0, 0} when the file
// is not a USM with MPEG video.
static std::array<uint32_t, 2> ReadVideoSize(const std::filesystem::path& path) {
  std::ifstream stream(path, std::ios::binary);
  std::array<uint8_t, 16> chunk = {};
  std::streamoff position = 0;
  // Header and metadata chunks precede the first video payload.
  for (int i = 0; i < 4096; ++i) {
    if (!stream.seekg(position).read(reinterpret_cast<char*>(chunk.data()), chunk.size())) break;
    const uint32_t chunk_size = (chunk[4] << 24) | (chunk[5] << 16) | (chunk[6] << 8) | chunk[7];
    constexpr uint8_t PAYLOAD_TYPE_STREAM = 0;
    if (std::memcmp(chunk.data(), "@SFV", 4) == 0 && (chunk[15] & 3) == PAYLOAD_TYPE_STREAM) {
      std::array<uint8_t, 7> payload = {};
      if (!stream.seekg(position + 8 + chunk[9]).read(reinterpret_cast<char*>(payload.data()), payload.size())) break;
      constexpr std::array<uint8_t, 4> SEQUENCE_HEADER = {0x00, 0x00, 0x01, 0xB3};
      if (std::memcmp(payload.data(), SEQUENCE_HEADER.data(), SEQUENCE_HEADER.size()) != 0) break;
      return {static_cast<uint32_t>((payload[4] << 4) | (payload[5] >> 4)),
              static_cast<uint32_t>(((payload[5] & 0x0F) << 8) | payload[6])};
    }
    position += 8 + static_cast<std::streamoff>(chunk_size);
  }
  return {0, 0};
}

// Records that the game opened a movie and opens its replacement when there is one.
// Returns INVALID_HANDLE_VALUE when the game's own file should be opened.
static HANDLE OpenReplacement(std::wstring path, DWORD access, DWORD share_mode, LPSECURITY_ATTRIBUTES security,
                              DWORD disposition, DWORD flags, HANDLE template_file) {
  std::ranges::replace(path, L'/', L'\\');
  CharLowerBuffW(path.data(), static_cast<DWORD>(path.size()));
  // No separator gives npos + 1 == 0: the whole path is the name.
  const size_t name_start = path.rfind(L'\\') + 1;
  const std::wstring name = path.substr(name_start);
  const std::wstring_view folder(path.data(), name_start);
  const bool replace = enabled.load(std::memory_order_relaxed)
                       && required_buffer_multiplier <= applied_buffer_multiplier
                       && (folder == L"data\\movie\\" || folder.ends_with(L"\\data\\movie\\"))
                       && replacements.contains(name);
  HANDLE file = INVALID_HANDLE_VALUE;
  if (replace) {
    file = CreateFileW((directory / name).c_str(), access, share_mode, security, disposition, flags, template_file);
  }
  AcquireSRWLockExclusive(&opened_lock);
  auto& movie = opened[name];
  const bool first_open = movie.open_count == 0;
  ++movie.open_count;
  movie.replaced = file != INVALID_HANDLE_VALUE;
  ReleaseSRWLockExclusive(&opened_lock);
  if (first_open) {
    const auto display_name = std::filesystem::path(name).u8string();
    reshade::log::message(
        reshade::log::level::info,
        std::format("NieR:Automata movie mods: game opened {} ({}).",
                    std::string(display_name.begin(), display_name.end()),
                    file != INVALID_HANDLE_VALUE ? "replaced" : "game file")
            .c_str());
  }
  return file;
}

static HANDLE WINAPI OnCreateFileW(LPCWSTR path, DWORD access, DWORD share_mode, LPSECURITY_ATTRIBUTES security,
                                   DWORD disposition, DWORD flags, HANDLE template_file) {
  if (path != nullptr) {
    const size_t length = std::wcslen(path);
    if (length > 4 && _wcsicmp(path + length - 4, L".usm") == 0) {
      const HANDLE file = OpenReplacement(path, access, share_mode, security, disposition, flags, template_file);
      if (file != INVALID_HANDLE_VALUE) return file;
    }
  }
  return original_create_file_w(path, access, share_mode, security, disposition, flags, template_file);
}

static HANDLE WINAPI OnCreateFileA(LPCSTR path, DWORD access, DWORD share_mode, LPSECURITY_ATTRIBUTES security,
                                   DWORD disposition, DWORD flags, HANDLE template_file) {
  if (path != nullptr) {
    const size_t length = std::strlen(path);
    if (length > 4 && _stricmp(path + length - 4, ".usm") == 0) {
      std::wstring wide_path(length, L'\0');
      wide_path.resize(MultiByteToWideChar(CP_ACP, 0, path, static_cast<int>(length), wide_path.data(),
                                           static_cast<int>(wide_path.size())));
      const HANDLE file =
          OpenReplacement(std::move(wide_path), access, share_mode, security, disposition, flags, template_file);
      if (file != INVALID_HANDLE_VALUE) return file;
    }
  }
  return original_create_file_a(path, access, share_mode, security, disposition, flags, template_file);
}

// Called from DllMain: the heap sizes have to change before the game's heap setup runs,
// which is earlier than device creation.
static void Initialize(uintptr_t image_base) {
  uint32_t enabled_value = 1;
  reshade::get_config_value(nullptr, CONFIG_SECTION, "ReplacementMovies", enabled_value);
  enabled.store(enabled_value != 0);

  directory = renodx::utils::platform::GetCurrentProcessPath().parent_path() / "movie";
  std::error_code error;
  for (const auto& entry : std::filesystem::directory_iterator(directory, error)) {
    if (!entry.is_regular_file(error) || _wcsicmp(entry.path().extension().c_str(), L".usm") != 0) continue;
    std::wstring name = entry.path().filename().wstring();
    CharLowerBuffW(name.data(), static_cast<DWORD>(name.size()));
    const auto [width, height] = ReadVideoSize(entry.path());
    if (width == 0) {
      const auto display_name = entry.path().filename().u8string();
      reshade::log::message(
          reshade::log::level::warning,
          std::format("NieR:Automata movie mods: {} has no MPEG video header; the game may fail to play it.",
                      std::string(display_name.begin(), display_name.end()))
              .c_str());
    }
    if (width * height > largest_width * largest_height) {
      largest_width = width;
      largest_height = height;
    }
    replacements.insert(std::move(name));
  }
  required_buffer_multiplier = std::clamp(
      (largest_width * largest_height + GAME_MOVIE_PIXELS - 1) / GAME_MOVIE_PIXELS, 1u, MAXIMUM_BUFFER_MULTIPLIER);

  if (enabled.load() && required_buffer_multiplier > 1) {
    const bool code_matches = std::ranges::all_of(HEAP_SIZES, [image_base](const HeapSize& size) {
      const auto* instruction = reinterpret_cast<const uint8_t*>(image_base + size.rva);
      constexpr uint8_t MOV_EDX_IMM32 = 0xBA;
      return instruction[0] == MOV_EDX_IMM32 && std::memcmp(instruction + 1, &size.original, sizeof(uint32_t)) == 0;
    });
    if (!executable::GetStatus().supported) {
      buffer_problem = "Movie buffers cannot be enlarged on this executable version.";
    } else if (*reinterpret_cast<const uintptr_t*>(image_base + FILE_ROOT_HEAP_RVA) != 0) {
      buffer_problem = "The game created its movie buffers before the addon was loaded.";
    } else if (!code_matches) {
      buffer_problem = "Movie buffers not enlarged: unexpected code in the game's heap setup.";
    } else {
      // A partial change would leave a parent heap too small for its movie heap, so the
      // whole range (the table is in address order) is unlocked before any size is written.
      auto* first = reinterpret_cast<uint8_t*>(image_base + HEAP_SIZES.front().rva);
      const size_t span = HEAP_SIZES.back().rva + 5 - HEAP_SIZES.front().rva;
      DWORD old_protection = 0;
      if (VirtualProtect(first, span, PAGE_EXECUTE_READWRITE, &old_protection)) {
        for (const auto& size : HEAP_SIZES) {
          const uint32_t enlarged = size.original + size.growth * (required_buffer_multiplier - 1);
          std::memcpy(reinterpret_cast<void*>(image_base + size.rva + 1), &enlarged, sizeof(enlarged));
        }
        FlushInstructionCache(GetCurrentProcess(), first, span);
        VirtualProtect(first, span, old_protection, &old_protection);
        applied_buffer_multiplier = required_buffer_multiplier;
      } else {
        buffer_problem = "Movie buffers not enlarged: the game's code could not be written.";
      }
    }
    if (applied_buffer_multiplier < required_buffer_multiplier) {
      reshade::log::message(reshade::log::level::warning,
                            std::format("NieR:Automata movie mods: {} Replacement movies are not loaded.", buffer_problem)
                                .c_str());
    }
  }

  // Installed even without replacements so the overlay can show which movies the game opens.
  renodx::utils::iat_hook::PatchIAT(
      "kernel32.dll", executable::FindImport("kernel32.dll", "CreateFileW"), reinterpret_cast<void*>(&OnCreateFileW),
      reinterpret_cast<void**>(&original_create_file_w), "CreateFileW");
  renodx::utils::iat_hook::PatchIAT(
      "kernel32.dll", executable::FindImport("kernel32.dll", "CreateFileA"), reinterpret_cast<void*>(&OnCreateFileA),
      reinterpret_cast<void**>(&original_create_file_a), "CreateFileA");
  reshade::log::message(
      reshade::log::level::info,
      std::format("NieR:Automata movie mods: {} replacement movie(s), largest {}x{}, movie buffers {}x.",
                  replacements.size(), largest_width, largest_height, applied_buffer_multiplier)
          .c_str());
}

// Hot unload only: restores the executable's imports while the game keeps running.
static void Shutdown() {
  if (original_create_file_w != nullptr) {
    renodx::utils::iat_hook::UnpatchIAT("kernel32.dll", reinterpret_cast<void*>(&OnCreateFileW),
                                        reinterpret_cast<void*>(original_create_file_w), "CreateFileW");
  }
  if (original_create_file_a != nullptr) {
    renodx::utils::iat_hook::UnpatchIAT("kernel32.dll", reinterpret_cast<void*>(&OnCreateFileA),
                                        reinterpret_cast<void*>(original_create_file_a), "CreateFileA");
  }
}

static void OnOverlay() {
  if (!ImGui::CollapsingHeader("Movie mods", ImGuiTreeNodeFlags_DefaultOpen)) return;
  ImGui::TextWrapped(
      "Movies (.usm) in the movie folder next to the game executable are played in place of the game's "
      "data\\movie files of the same name. No game file is modified.");
  bool load_replacements = enabled.load(std::memory_order_relaxed);
  bool changed = ImGui::Checkbox("Load replacement movies", &load_replacements);
  if (ImGui::IsItemHovered()) {
    ImGui::SetTooltip("Applies to movies the game opens from now on.\n"
                      "Movies larger than 1920x1080 need larger movie buffers, which are set up at game start.");
  }
  changed |= overlay::ResetToDefault("ReplacementMovies", &load_replacements, true);
  if (changed) {
    enabled.store(load_replacements, std::memory_order_relaxed);
    reshade::set_config_value(nullptr, CONFIG_SECTION, "ReplacementMovies", uint32_t(load_replacements));
  }
  ImGui::SameLine();
  if (ImGui::Button("Open movie folder")) {
    std::error_code error;
    std::filesystem::create_directories(directory, error);
    ShellExecuteW(nullptr, L"open", directory.c_str(), nullptr, nullptr, SW_SHOWNORMAL);
  }
  if (ImGui::IsItemHovered()) {
    ImGui::SetTooltip("Opens the movie folder in Explorer, creating it if needed. Added movies are found at game start.");
  }

  if (largest_width == 0) {
    ImGui::Text("Replacement movies found: %zu", replacements.size());
  } else {
    ImGui::Text("Replacement movies found: %zu (largest %ux%u)", replacements.size(), largest_width, largest_height);
  }
  if (required_buffer_multiplier > applied_buffer_multiplier) {
    if (load_replacements) {
      ImGui::PushStyleColor(ImGuiCol_Text, ImVec4(1.f, 0.35f, 0.35f, 1.f));
      ImGui::TextWrapped("%s Replacement movies are not loaded (%ux movie buffers needed).", buffer_problem,
                         required_buffer_multiplier);
      ImGui::PopStyleColor();
    }
  } else if (applied_buffer_multiplier > 1) {
    ImGui::Text("Movie buffers: %ux the game's size", applied_buffer_multiplier);
  }

  struct Row {
    std::string name;
    OpenedMovie movie;
  };
  std::vector<Row> rows;
  size_t replaced_count = 0;
  AcquireSRWLockExclusive(&opened_lock);
  for (const auto& [name, movie] : opened) {
    const auto display_name = std::filesystem::path(name).u8string();
    rows.push_back({.name = std::string(display_name.begin(), display_name.end()), .movie = movie});
    if (movie.replaced) {
      ++replaced_count;
    }
  }
  ReleaseSRWLockExclusive(&opened_lock);
  ImGui::Text("Movies opened by the game this session: %zu (%zu replaced)", rows.size(), replaced_count);
  if (!rows.empty() && ImGui::TreeNode("Opened movies")) {
    for (const auto& row : rows) {
      ImGui::TextUnformatted(row.name.c_str());
      ImGui::SameLine();
      const char* source = (row.movie.replaced ? "replaced" : "game file");
      ImGui::TextDisabled("%s, opened %u time(s)", source, row.movie.open_count);
    }
    ImGui::TreePop();
  }
}

}  // namespace nier_automata::movie_mods
