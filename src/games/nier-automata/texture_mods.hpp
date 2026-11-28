/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <Windows.h>

#include <intrin.h>
#include <nmmintrin.h>
#include <shellapi.h>
#include <algorithm>
#include <atomic>
#include <cstdint>
#include <cstring>
#include <cwchar>
#include <filesystem>
#include <format>
#include <fstream>
#include <map>
#include <memory>
#include <mutex>
#include <shared_mutex>
#include <string>
#include <system_error>
#include <unordered_map>
#include <vector>

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "./overlay.hpp"

#include "../../utils/platform.hpp"

// Clang only permits SSE4.2 intrinsics inside functions that opt in to the feature.
#if defined(__clang__)
#define NIER_AUTOMATA_TARGET_SSE42 __attribute__((target("sse4.2")))
#else
#define NIER_AUTOMATA_TARGET_SSE42
#endif

namespace nier_automata::texture_mods {

// Texture mods that can be switched while the game runs; no game file is modified.
// Each subfolder of Mods (next to the game executable) is one mod. Any <HASH>.dds inside
// it, at any depth, replaces the texture whose top mip level has that CRC32C, which is
// the naming used by texture mods published for FAR (Fix Automata Resolution), so those
// can be extracted into a subfolder as they are. Independent implementation.
//
// The game's own texture is left untouched. A replacement texture is created beside it
// and substituted whenever the game binds one of the original's shader resource views,
// so enabling or disabling a mod only changes which view gets bound.
constexpr const char* CONFIG_SECTION = "renodx-nier_automata-texture-mods";

struct Mod {
  std::string name;
  bool enabled = true;
  std::map<uint32_t, std::filesystem::path> files;
};

struct View {
  uint64_t handle = 0;
  reshade::api::resource_view_desc desc;
  uint64_t replacement = 0;
};

struct Texture {
  uint32_t hash = 0;
  reshade::api::format format = reshade::api::format::unknown;
  std::filesystem::path source;
  uint64_t replacement = 0;
  std::vector<View> views;
};

struct State {
  std::shared_mutex mutex;
  std::vector<Mod> mods;
  std::unordered_map<uint32_t, std::filesystem::path> active_files;
  std::unordered_map<uint64_t, Texture> textures;
  std::unordered_map<uint64_t, uint64_t> view_resources;
  std::unordered_map<uint64_t, uint64_t> view_replacements;
};
static State state;
static std::atomic_size_t active_view_count = 0;
static bool hashing_supported = false;
// Carries the hash from create_resource to the init_resource that follows on the same
// thread. Trivially constructible on purpose: loader threads that predate this module
// never run dynamic thread-local initializers.
static thread_local bool pending = false;
static thread_local uint32_t pending_hash = 0;

static std::filesystem::path GetDirectory() {
  return renodx::utils::platform::GetCurrentProcessPath().parent_path() / "Mods";
}

static reshade::api::resource CreateReplacement(reshade::api::device* device, const std::filesystem::path& path,
                                                reshade::api::format original_format) {
  const auto reject = [&](const char* reason) {
    const auto name = path.filename().u8string();
    reshade::log::message(
        reshade::log::level::warning,
        std::format("NieR:Automata texture mods: {} ignored: {}", std::string(name.begin(), name.end()), reason).c_str());
    return reshade::api::resource{0};
  };
  std::ifstream stream(path, std::ios::binary | std::ios::ate);
  const std::streamoff stream_size = stream.tellg();
  constexpr size_t DDS_HEADER_SIZE = 128;
  constexpr size_t DX10_HEADER_SIZE = 20;
  if (!stream || stream_size < static_cast<std::streamoff>(DDS_HEADER_SIZE)) return reject("cannot read file");
  const auto file_size = static_cast<size_t>(stream_size);
  const auto file = std::make_unique<uint8_t[]>(file_size);
  stream.seekg(0);
  if (!stream.read(reinterpret_cast<char*>(file.get()), stream_size)) return reject("cannot read file");
  const auto read32 = [&](size_t offset) {
    uint32_t value;
    std::memcpy(&value, file.get() + offset, sizeof(value));
    return value;
  };
  if (read32(0) != MAKEFOURCC('D', 'D', 'S', ' ') || read32(4) != 124) return reject("not a DDS file");

  size_t data_offset = DDS_HEADER_SIZE;
  auto format = reshade::api::format::unknown;
  switch (read32(84)) {
    case MAKEFOURCC('D', 'X', 'T', '1'):
      format = reshade::api::format::bc1_unorm;
      break;
    case MAKEFOURCC('D', 'X', 'T', '2'):
    case MAKEFOURCC('D', 'X', 'T', '3'):
      format = reshade::api::format::bc2_unorm;
      break;
    case MAKEFOURCC('D', 'X', 'T', '4'):
    case MAKEFOURCC('D', 'X', 'T', '5'):
      format = reshade::api::format::bc3_unorm;
      break;
    case MAKEFOURCC('A', 'T', 'I', '1'):
    case MAKEFOURCC('B', 'C', '4', 'U'):
      format = reshade::api::format::bc4_unorm;
      break;
    case MAKEFOURCC('A', 'T', 'I', '2'):
    case MAKEFOURCC('B', 'C', '5', 'U'):
      format = reshade::api::format::bc5_unorm;
      break;
    case MAKEFOURCC('D', 'X', '1', '0'): {
      constexpr uint32_t DIMENSION_TEXTURE2D = 3;
      constexpr uint32_t MISC_TEXTURECUBE = 4;
      data_offset += DX10_HEADER_SIZE;
      if (file_size >= data_offset && read32(DDS_HEADER_SIZE + 4) == DIMENSION_TEXTURE2D
          && (read32(DDS_HEADER_SIZE + 8) & MISC_TEXTURECUBE) == 0 && read32(DDS_HEADER_SIZE + 12) == 1) {
        // DXGI_FORMAT and reshade::api::format share numeric values.
        format = static_cast<reshade::api::format>(read32(DDS_HEADER_SIZE));
      }
      break;
    }
    case 0: {
      const uint32_t red_mask = read32(92);
      const uint32_t alpha_mask = read32(104);
      if (read32(88) != 32) break;
      if (red_mask == 0x000000FFu) {
        format = reshade::api::format::r8g8b8a8_unorm;
      } else if (red_mask == 0x00FF0000u) {
        format = (alpha_mask != 0 ? reshade::api::format::b8g8r8a8_unorm : reshade::api::format::b8g8r8x8_unorm);
      }
      break;
    }
    default:
      break;
  }
  const uint32_t width = read32(16);
  const uint32_t height = read32(12);
  constexpr uint32_t MAX_TEXTURE_SIZE = 16384;
  const bool block_compressed = reshade::api::format_slice_pitch(format, 1, 4) == 1;
  if (reshade::api::format_row_pitch(format, 1) == 0) return reject("unsupported pixel format");
  if (width == 0 || height == 0 || width > MAX_TEXTURE_SIZE || height > MAX_TEXTURE_SIZE
      || (block_compressed && (width % 4 != 0 || height % 4 != 0))) {
    return reject("unsupported dimensions");
  }

  // Legacy DDS headers cannot express sRGB or typeless storage; follow the game's
  // texture so views made for it keep their color space.
  if (reshade::api::format_to_default_typed(original_format) != original_format) {
    format = reshade::api::format_to_typeless(format);
  } else if (reshade::api::format_to_default_typed(original_format, 0) != original_format) {
    format = reshade::api::format_to_default_typed(format, 1);
  }

  std::vector<reshade::api::subresource_data> levels;
  const uint32_t file_levels = std::max(read32(28), 1u);
  size_t level_offset = data_offset;
  for (uint32_t level_width = width, level_height = height; levels.size() < file_levels;
       level_width = std::max(level_width / 2, 1u), level_height = std::max(level_height / 2, 1u)) {
    const uint32_t row_pitch = reshade::api::format_row_pitch(format, level_width);
    const uint32_t slice_pitch = reshade::api::format_slice_pitch(format, row_pitch, level_height);
    if (level_offset + slice_pitch > file_size) break;
    levels.push_back({.data = file.get() + level_offset, .row_pitch = row_pitch, .slice_pitch = slice_pitch});
    level_offset += slice_pitch;
  }
  if (levels.empty()) return reject("truncated pixel data");

  reshade::api::resource replacement = {0};
  if (!device->create_resource(
          reshade::api::resource_desc(width, height, 1, static_cast<uint16_t>(levels.size()), format, 1,
                                      reshade::api::memory_heap::gpu_only, reshade::api::resource_usage::shader_resource),
          levels.data(), reshade::api::resource_usage::shader_resource, &replacement)) {
    return reject("texture creation failed");
  }
  return replacement;
}

// The game's view is typed and sized for the texture it created; fit it to the replacement.
static reshade::api::resource_view CreateReplacementView(reshade::api::device* device, reshade::api::resource replacement,
                                                         reshade::api::resource_view_desc desc) {
  const auto texture = device->get_resource_desc(replacement).texture;
  if (desc.format != reshade::api::format::unknown) {
    const bool typeless = reshade::api::format_to_default_typed(texture.format) != texture.format;
    const bool srgb_view = reshade::api::format_to_default_typed(desc.format, 0) != desc.format;
    desc.format =
        (typeless ? reshade::api::format_to_default_typed(texture.format, (srgb_view ? 1 : 0)) : texture.format);
  }
  desc.texture.first_level = std::min<uint32_t>(desc.texture.first_level, texture.levels - 1u);
  if (desc.texture.level_count != UINT32_MAX) {
    desc.texture.level_count = std::min<uint32_t>(desc.texture.level_count, texture.levels - desc.texture.first_level);
  }
  reshade::api::resource_view view = {0};
  if (!device->create_resource_view(replacement, reshade::api::resource_usage::shader_resource, desc, &view)) {
    reshade::log::message(reshade::log::level::warning, "NieR:Automata texture mods: replacement view creation failed.");
  }
  return view;
}

// Brings every loaded texture in line with the enabled mods.
static void Apply(reshade::api::device* device) {
  struct Change {
    uint64_t resource = 0;
    reshade::api::format format = reshade::api::format::unknown;
    std::filesystem::path source;
    uint64_t replacement = 0;
    std::vector<View> views;
  };
  std::vector<Change> changes;
  {
    const std::unique_lock lock(state.mutex);
    state.active_files.clear();
    for (const auto& mod : state.mods) {
      if (!mod.enabled) continue;
      for (const auto& [hash, path] : mod.files) {
        if (!state.active_files.try_emplace(hash, path).second) {
          reshade::log::message(
              reshade::log::level::warning,
              std::format("NieR:Automata texture mods: {:08X} from \"{}\" ignored, an earlier mod replaces it",
                          hash, mod.name)
                  .c_str());
        }
      }
    }
    for (const auto& [resource, texture] : state.textures) {
      const auto file = state.active_files.find(texture.hash);
      const auto source = (file == state.active_files.end() ? std::filesystem::path() : file->second);
      if (source == texture.source) continue;
      changes.push_back({.resource = resource, .format = texture.format, .source = source, .views = texture.views});
    }
  }

  // Files are read and GPU objects created without the lock; rendering keeps binding meanwhile.
  for (auto& change : changes) {
    if (!change.source.empty()) {
      change.replacement = CreateReplacement(device, change.source, change.format).handle;
    }
    for (auto& view : change.views) {
      view.replacement = 0;
      if (change.replacement != 0) {
        view.replacement = CreateReplacementView(device, {change.replacement}, view.desc).handle;
      }
    }
  }

  std::vector<uint64_t> retired_views;
  std::vector<uint64_t> retired_resources;
  {
    const std::unique_lock lock(state.mutex);
    for (auto& change : changes) {
      const auto found = state.textures.find(change.resource);
      if (found != state.textures.end()) {
        auto& texture = found->second;
        retired_resources.push_back(texture.replacement);
        texture.replacement = change.replacement;
        texture.source = change.source;
        change.replacement = 0;
        for (auto& view : texture.views) {
          retired_views.push_back(view.replacement);
          view.replacement = 0;
          const auto created = std::ranges::find(change.views, view.handle, &View::handle);
          if (created != change.views.end()) {
            view.replacement = created->replacement;
            created->replacement = 0;
          }
          if (view.replacement != 0) {
            state.view_replacements[view.handle] = view.replacement;
          } else {
            state.view_replacements.erase(view.handle);
          }
        }
      }
      // Whatever was not adopted belongs to a texture or view the game released meanwhile.
      retired_resources.push_back(change.replacement);
      for (const auto& view : change.views) {
        retired_views.push_back(view.replacement);
      }
    }
    active_view_count.store(state.view_replacements.size());
  }
  for (const uint64_t view : retired_views) {
    if (view != 0) device->destroy_resource_view({view});
  }
  for (const uint64_t resource : retired_resources) {
    if (resource != 0) device->destroy_resource({resource});
  }
  if (!changes.empty()) {
    reshade::log::message(
        reshade::log::level::info,
        std::format("NieR:Automata texture mods: updated {} loaded texture(s)", changes.size()).c_str());
  }
}

static void Scan(reshade::api::device* device) {
  int cpu_info[4] = {};
  __cpuid(cpu_info, 1);
  hashing_supported = (cpu_info[2] & (1 << 20)) != 0;
  const auto directory = GetDirectory();
  const auto to_utf8 = [](const std::filesystem::path& path) {
    const auto text = path.u8string();
    return std::string(text.begin(), text.end());
  };
  // Keyed by folder name so the same mod wins a conflict on every launch.
  std::map<std::string, Mod> mods;
  size_t file_count = 0;
  std::error_code error;
  for (std::filesystem::recursive_directory_iterator
           entry(directory, std::filesystem::directory_options::skip_permission_denied, error),
       end;
       !error && entry != end; entry.increment(error)) {
    const auto relative_path = entry->path().lexically_relative(directory);
    const bool top_level = !relative_path.has_parent_path();
    if (top_level && !entry->is_directory(error)) continue;
    const auto name = to_utf8(*relative_path.begin());
    auto& mod = mods[name];
    if (top_level) {
      mod.name = name;
      uint32_t enabled = 1;
      reshade::get_config_value(nullptr, CONFIG_SECTION, name.c_str(), enabled);
      mod.enabled = enabled != 0;
      continue;
    }
    const std::wstring stem = entry->path().stem().native();
    wchar_t* parsed_end = nullptr;
    const uint32_t hash = std::wcstoul(stem.c_str(), &parsed_end, 16);
    if (stem.size() != 8 || parsed_end != stem.c_str() + stem.size()
        || _wcsicmp(entry->path().extension().c_str(), L".dds") != 0) {
      continue;
    }
    if (mod.files.try_emplace(hash, entry->path()).second) {
      ++file_count;
    }
  }
  reshade::log::message(
      reshade::log::level::info,
      std::format("NieR:Automata texture mods: {} mod folder(s), {} replacement file(s) in {}",
                  mods.size(), file_count, to_utf8(directory))
          .c_str());
  {
    const std::unique_lock lock(state.mutex);
    state.mods.clear();
    for (auto& [name, mod] : mods) {
      state.mods.push_back(std::move(mod));
    }
  }
  Apply(device);
}

NIER_AUTOMATA_TARGET_SSE42
static bool OnCreateResource(reshade::api::device* device, reshade::api::resource_desc& desc,
                             reshade::api::subresource_data* initial_data, reshade::api::resource_usage usage) {
  // A failed creation never reaches init_resource; forget its hash here.
  pending = false;
  if (!hashing_supported || initial_data == nullptr || initial_data[0].data == nullptr
      || desc.type != reshade::api::resource_type::texture_2d || desc.texture.depth_or_layers != 1
      || desc.texture.samples != 1) {
    return false;
  }
  const uint32_t row_bytes = reshade::api::format_row_pitch(desc.texture.format, desc.texture.width);
  if (row_bytes == 0) return false;
  const uint32_t rows = reshade::api::format_slice_pitch(desc.texture.format, row_bytes, desc.texture.height) / row_bytes;

  // Row padding has undefined contents, so only the meaningful bytes of each row are
  // hashed. Tightly packed data is a single run.
  const bool tightly_packed = initial_data[0].row_pitch == row_bytes;
  const size_t run_bytes = (tightly_packed ? size_t{row_bytes} * rows : row_bytes);
  const uint32_t run_count = (tightly_packed ? 1 : rows);
  const auto* run = static_cast<const uint8_t*>(initial_data[0].data);
  uint64_t crc = 0xFFFFFFFFu;
  for (uint32_t i = 0; i < run_count; ++i, run += initial_data[0].row_pitch) {
    const uint8_t* bytes = run;
    size_t remaining = run_bytes;
    for (; remaining >= 8; remaining -= 8, bytes += 8) {
      uint64_t word;
      std::memcpy(&word, bytes, sizeof(word));
      crc = _mm_crc32_u64(crc, word);
    }
    for (; remaining != 0; --remaining, ++bytes) {
      crc = _mm_crc32_u8(static_cast<uint32_t>(crc), *bytes);
    }
  }
  pending_hash = ~static_cast<uint32_t>(crc);
  pending = true;
  return false;
}

static void OnInitResource(reshade::api::device* device, const reshade::api::resource_desc& desc,
                           const reshade::api::subresource_data* initial_data, reshade::api::resource_usage usage,
                           reshade::api::resource resource) {
  if (!pending) return;
  pending = false;
  Texture texture = {.hash = pending_hash, .format = desc.texture.format};
  {
    const std::shared_lock lock(state.mutex);
    const auto file = state.active_files.find(texture.hash);
    if (file != state.active_files.end()) {
      texture.source = file->second;
    }
  }
  if (!texture.source.empty()) {
    texture.replacement = CreateReplacement(device, texture.source, texture.format).handle;
    if (texture.replacement != 0) {
      reshade::log::message(
          reshade::log::level::info,
          std::format("NieR:Automata texture mods: replacing {:08X} ({}x{})", texture.hash, desc.texture.width,
                      desc.texture.height)
              .c_str());
    }
  }
  const std::unique_lock lock(state.mutex);
  state.textures[resource.handle] = std::move(texture);
}

static void OnInitResourceView(reshade::api::device* device, reshade::api::resource resource,
                               reshade::api::resource_usage usage_type, const reshade::api::resource_view_desc& desc,
                               reshade::api::resource_view view) {
  if (usage_type != reshade::api::resource_usage::shader_resource) return;
  uint64_t replacement = 0;
  {
    const std::shared_lock lock(state.mutex);
    const auto texture = state.textures.find(resource.handle);
    if (texture == state.textures.end()) return;
    replacement = texture->second.replacement;
  }
  uint64_t replacement_view = 0;
  if (replacement != 0) {
    replacement_view = CreateReplacementView(device, {replacement}, desc).handle;
  }
  {
    const std::unique_lock lock(state.mutex);
    const auto texture = state.textures.find(resource.handle);
    // Unchanged replacement: no mod was toggled while the view was being created.
    if (texture != state.textures.end() && texture->second.replacement == replacement) {
      texture->second.views.push_back({.handle = view.handle, .desc = desc, .replacement = replacement_view});
      state.view_resources[view.handle] = resource.handle;
      if (replacement_view != 0) {
        state.view_replacements[view.handle] = replacement_view;
        active_view_count.store(state.view_replacements.size());
      }
      return;
    }
  }
  if (replacement_view != 0) device->destroy_resource_view({replacement_view});
}

static void OnDestroyResourceView(reshade::api::device* device, reshade::api::resource_view view) {
  uint64_t replacement_view = 0;
  {
    const std::unique_lock lock(state.mutex);
    const auto resource = state.view_resources.find(view.handle);
    if (resource == state.view_resources.end()) return;
    if (const auto texture = state.textures.find(resource->second); texture != state.textures.end()) {
      std::erase_if(texture->second.views, [&](const View& tracked) { return tracked.handle == view.handle; });
    }
    state.view_resources.erase(resource);
    if (const auto replacement = state.view_replacements.find(view.handle);
        replacement != state.view_replacements.end()) {
      replacement_view = replacement->second;
      state.view_replacements.erase(replacement);
      active_view_count.store(state.view_replacements.size());
    }
  }
  if (replacement_view != 0) device->destroy_resource_view({replacement_view});
}

static void OnDestroyResource(reshade::api::device* device, reshade::api::resource resource) {
  Texture released;
  {
    const std::unique_lock lock(state.mutex);
    const auto texture = state.textures.find(resource.handle);
    if (texture == state.textures.end()) return;
    released = std::move(texture->second);
    state.textures.erase(texture);
    // The game can release a texture before its views.
    for (const auto& view : released.views) {
      state.view_resources.erase(view.handle);
      state.view_replacements.erase(view.handle);
    }
    active_view_count.store(state.view_replacements.size());
  }
  for (const auto& view : released.views) {
    if (view.replacement != 0) device->destroy_resource_view({view.replacement});
  }
  if (released.replacement != 0) device->destroy_resource({released.replacement});
}

// ReShade reports a bind after forwarding it, so pushing again here overrides the slot.
// Must be registered after other handlers that push whole updates of their own.
static void OnPushDescriptors(reshade::api::command_list* cmd_list, reshade::api::shader_stage stages,
                              reshade::api::pipeline_layout layout, uint32_t layout_param,
                              const reshade::api::descriptor_table_update& update) {
  if (active_view_count.load(std::memory_order_relaxed) == 0
      || update.type != reshade::api::descriptor_type::texture_shader_resource_view) {
    return;
  }
  const auto* views = static_cast<const reshade::api::resource_view*>(update.descriptors);
  // Held across the push so a replacement cannot be destroyed before the context references it.
  const std::shared_lock lock(state.mutex);
  for (uint32_t i = 0; i < update.count; ++i) {
    const auto replacement = state.view_replacements.find(views[i].handle);
    if (replacement == state.view_replacements.end()) continue;
    const reshade::api::resource_view replacement_view = {replacement->second};
    cmd_list->push_descriptors(
        stages, layout, layout_param,
        {.binding = update.binding + i, .count = 1, .type = update.type, .descriptors = &replacement_view});
  }
}

static void OnOverlay(reshade::api::device* device) {
  if (!ImGui::CollapsingHeader("Texture mods", ImGuiTreeNodeFlags_DefaultOpen)) return;
  ImGui::TextWrapped(
      "Each subfolder of the Mods folder next to the game executable is one texture mod (<HASH>.dds files at any "
      "depth). Ticking or unticking a mod takes effect immediately.");
  if (!hashing_supported) {
    ImGui::TextUnformatted("Unavailable: this CPU lacks SSE4.2.");
    return;
  }
  if (ImGui::Button("Open Mods folder")) {
    const auto directory = GetDirectory();
    std::error_code error;
    std::filesystem::create_directories(directory, error);
    ShellExecuteW(nullptr, L"open", directory.c_str(), nullptr, nullptr, SW_SHOWNORMAL);
  }
  if (ImGui::IsItemHovered()) {
    ImGui::SetTooltip("Opens the Mods folder in Explorer, creating it if needed. Add one subfolder per mod.");
  }
  ImGui::SameLine();
  if (ImGui::Button("Rescan")) {
    Scan(device);
  }
  if (ImGui::IsItemHovered()) {
    ImGui::SetTooltip("Picks up added, removed or changed mod folders and applies them to loaded textures.");
  }

  struct Row {
    std::string name;
    bool enabled;
    size_t file_count;
  };
  std::vector<Row> rows;
  size_t replaced_count = 0;
  {
    const std::shared_lock lock(state.mutex);
    for (const auto& mod : state.mods) {
      rows.push_back({.name = mod.name, .enabled = mod.enabled, .file_count = mod.files.size()});
    }
    for (const auto& [resource, texture] : state.textures) {
      if (texture.replacement != 0) {
        ++replaced_count;
      }
    }
  }
  for (auto& row : rows) {
    ImGui::BeginDisabled(row.file_count == 0);
    bool toggled = ImGui::Checkbox(row.name.c_str(), &row.enabled);
    ImGui::EndDisabled();
    ImGui::SameLine();
    if (row.file_count == 0) {
      ImGui::TextDisabled("no <HASH>.dds files (not a texture mod)");
    } else {
      ImGui::TextDisabled("%zu texture(s)", row.file_count);
    }
    toggled |= overlay::ResetToDefault(row.name.c_str(), &row.enabled, true);
    if (!toggled) continue;
    reshade::set_config_value(nullptr, CONFIG_SECTION, row.name.c_str(), uint32_t(row.enabled));
    {
      const std::unique_lock lock(state.mutex);
      const auto mod = std::ranges::find(state.mods, row.name, &Mod::name);
      if (mod != state.mods.end()) {
        mod->enabled = row.enabled;
      }
    }
    Apply(device);
  }
  ImGui::Text("Loaded textures currently replaced: %zu", replaced_count);
}

}  // namespace nier_automata::texture_mods
