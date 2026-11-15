/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <Windows.h>
#include <array>
#include <cstdint>

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

}  // namespace nier_automata::executable
