/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <Windows.h>
#include <array>
#include <cstdint>
#include <cstring>

#include "../../utils/hash.hpp"

namespace nier_automata::executable {

constexpr uint32_t SUPPORTED_CRC32 = 0x6751080E;

struct Status {
  uint32_t crc32 = 0;
  bool readable = false;
  bool supported = false;
};

const Status& GetStatus() {
  // Hash the file once before installing hooks. Loaded image bytes can already
  // contain relocations, ReShade hooks and our own process-lifetime patches.
  static const Status status = [] {
    std::array<wchar_t, 32768> path = {};
    const DWORD length = GetModuleFileNameW(nullptr, path.data(), static_cast<DWORD>(path.size()));
    if (length == 0 || length >= path.size()) return Status{};
    const HANDLE file = CreateFileW(path.data(), GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_DELETE,
                                    nullptr, OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, nullptr);
    if (file == INVALID_HANDLE_VALUE) return Status{};

    std::array<uint8_t, 65536> buffer;
    uint32_t crc = 0xFFFFFFFFu;
    DWORD bytes_read = 0;
    while (ReadFile(file, buffer.data(), static_cast<DWORD>(buffer.size()), &bytes_read, nullptr)) {
      if (bytes_read == 0) {
        CloseHandle(file);
        crc = renodx::utils::hash::FinalizeCRC32(crc);
        return Status{.crc32 = crc, .readable = true, .supported = crc == SUPPORTED_CRC32};
      }
      crc = renodx::utils::hash::UpdateCRC32(crc, buffer.data(), bytes_read);
    }
    CloseHandle(file);
    return Status{};
  }();
  return status;
}

// Current target of a named import of the game executable, or nullptr. Looked up by name
// because ReShade and mod loaders can already have redirected the entry.
inline void* FindImport(const char* dll, const char* name) {
  const auto base = reinterpret_cast<uintptr_t>(GetModuleHandleW(nullptr));
  const auto* nt = reinterpret_cast<const IMAGE_NT_HEADERS*>(
      base + reinterpret_cast<const IMAGE_DOS_HEADER*>(base)->e_lfanew);
  auto* imports = reinterpret_cast<const IMAGE_IMPORT_DESCRIPTOR*>(
      base + nt->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress);
  for (; imports->Name != 0; ++imports) {
    if (_stricmp(reinterpret_cast<const char*>(base + imports->Name), dll) != 0
        || imports->OriginalFirstThunk == 0) continue;
    auto* names = reinterpret_cast<const IMAGE_THUNK_DATA*>(base + imports->OriginalFirstThunk);
    auto* addresses = reinterpret_cast<const IMAGE_THUNK_DATA*>(base + imports->FirstThunk);
    for (; names->u1.AddressOfData != 0; ++names, ++addresses) {
      if (IMAGE_SNAP_BY_ORDINAL(names->u1.Ordinal)) continue;
      if (std::strcmp(reinterpret_cast<const IMAGE_IMPORT_BY_NAME*>(base + names->u1.AddressOfData)->Name, name) == 0) {
        return reinterpret_cast<void*>(addresses->u1.Function);
      }
    }
  }
  return nullptr;
}

}  // namespace nier_automata::executable
