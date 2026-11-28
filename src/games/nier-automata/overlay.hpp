/*
 * Copyright (C) 2026
 * SPDX-License-Identifier: MIT
 */
#pragma once

#include <deps/imgui/imgui.h>

#include "../../utils/icons.hpp"

namespace nier_automata::overlay {

// Call right after a setting's widget and tooltip. Draws an undo button on the same line
// while the value differs from its default; a click restores the default and returns true
// so the caller can run its usual change handling.
template <typename T>
bool ResetToDefault(const char* id, T* value, const T& default_value) {
  if (*value == default_value) return false;
  ImGui::SameLine();
  ImGui::PushID(id);
  const bool clicked = ImGui::Button(renodx::utils::icons::View(renodx::utils::icons::UNDO));
  ImGui::PopID();
  if (ImGui::IsItemHovered()) {
    ImGui::SetTooltip("Reset to default");
  }
  if (clicked) {
    *value = default_value;
  }
  return clicked;
}

}  // namespace nier_automata::overlay
