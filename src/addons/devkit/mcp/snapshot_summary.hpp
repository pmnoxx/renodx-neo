/*
 * Copyright (C) 2026 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */

#pragma once

#include <cstddef>
#include <cstdint>

#include "../../../utils/mcp/types.hpp"

namespace renodx::addons::devkit::mcp::snapshot_summary {

using json = renodx::utils::mcp::json;

struct SnapshotSummary {
  std::uint32_t device_index = 0u;
  bool snapshot_queued = false;
  bool snapshot_active = false;
  std::size_t captured_draws = 0u;
  std::size_t tracked_shaders = 0u;
  std::size_t resource_usage_entries = 0u;
  std::size_t shader_usage_entries = 0u;
  std::size_t snapshot_rows = 0u;
  bool snapshot_rows_valid = false;
  std::uint32_t requested_frames = 1u;
  std::uint32_t captured_frames = 0u;
  bool record_limit_reached = false;
  std::size_t unknown_screenshots = 0u;
  bool unknown_screenshot_pending = false;
};

// NOLINTNEXTLINE(readability-identifier-naming)
inline void to_json(json& j, const SnapshotSummary& value) {
  j = {
      {"deviceIndex", value.device_index},
      {"snapshotQueued", value.snapshot_queued},
      {"snapshotActive", value.snapshot_active},
      {"capturedDraws", value.captured_draws},
      {"trackedShaders", value.tracked_shaders},
      {"resourceUsageEntries", value.resource_usage_entries},
      {"shaderUsageEntries", value.shader_usage_entries},
      {"snapshotRows", value.snapshot_rows},
      {"snapshotRowsValid", value.snapshot_rows_valid},
      {"requestedFrames", value.requested_frames},
      {"capturedFrames", value.captured_frames},
      {"recordLimitReached", value.record_limit_reached},
      {"unknownScreenshots", value.unknown_screenshots},
      {"unknownScreenshotPending", value.unknown_screenshot_pending},
  };
}

}  // namespace renodx::addons::devkit::mcp::snapshot_summary
