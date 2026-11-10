#ifndef NIER_AUTOMATA_TONEMAP_HLSLI
#define NIER_AUTOMATA_TONEMAP_HLSLI
#include "./shared.h"

// Smooth bounded LUT reference from the game's rational tone curve. The real
// HDR scene remains separate; never address an SDR LUT with clipped HDR RGB.
float3 NierNeutralSDR(float3 scene) {
  float3 numerator = scene * mad(scene, 0.666666687, 1.0);
  return numerator / (numerator + 1.0);
}
#endif
