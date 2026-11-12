// Original: shader2.dat/casshadersharpen.cso - AMD FidelityFX CAS, sharpen only (no scaling).
// Readable rewrite following AMD's public ffx_cas.h CasFilter (green-channel amplitude,
// fast approximations); compiles to the game bytecode (verify_rewrite.py).
#include "./shared.h"
cbuffer cb : register(b0) { uint4 const0 : packoffset(c0); uint4 const1 : packoffset(c1); }
Texture2D<float4> InputTexture : register(t0);
RWTexture2D<float4> OutputTexture : register(u0);

// ffx_a.h approximations on float bit patterns. Do not replace with rcp/sqrt.
float APrxLoRcp(float x) { return asfloat(0x7ef07ebbu - asuint(x)); }
float APrxLoSqrt(float x) { return asfloat((asuint(x) >> 1) + 0x1fbc4639u); }
float APrxMedRcp(float x) { float r = asfloat(0x7ef19fffu - asuint(x)); return r * mad(-r, x, 2.0); }
float AMin3(float x, float y, float z) { return min(x, min(y, z)); }
float AMax3(float x, float y, float z) { return max(x, max(y, z)); }

float3 CasLoad(int2 p) { return InputTexture.Load(int3(p, 0)).rgb; }

// 3x3 cross around the pixel:  . b .
//                              d e f
//                              . h .
float3 CasSharpen(uint2 ip) {
  int2 sp = int2(ip);
  float3 b = CasLoad(sp + int2(0, -1));
  float3 d = CasLoad(sp + int2(-1, 0));
  float3 e = CasLoad(sp);
  float3 f = CasLoad(sp + int2(1, 0));
  float3 h = CasLoad(sp + int2(0, 1));

  // Soft min/max of green; amplitude is high where there is headroom to sharpen.
  float mn = AMin3(AMin3(d.g, e.g, f.g), b.g, h.g);
  float mx = AMax3(AMax3(d.g, e.g, f.g), b.g, h.g);
  float amp = APrxLoSqrt(saturate(min(mn, 1.0 - mx) * APrxLoRcp(mx)));

  // Negative lobe: const1.x is the peak (-1/lerp(8, 5, sharpness)).
  float w = amp * asfloat(const1.x);
  float rcp_weight = APrxMedRcp(1.0 + 4.0 * w);
  float3 sharpened = (b * w + d * w + f * w + h * w + e) * rcp_weight;
  if (NIER_TONE_MAP_OFF) return saturate(sharpened);
  if (NIER_TONE_MAP_VANILLA) return clamp(sharpened, 0.0, NierSdrWhiteIntermediate());
  // HDR: the amplitude is already zero above SDR white; drop only the final clamp.
  return max(0.0, sharpened);
}

void Filter(uint2 pos) {
  OutputTexture[pos] = float4(CasSharpen(pos), 1);
}

// ffx_a.h ARmp8x8: 64 lanes -> 8x8 tile in a swizzled order.
uint2 ARmp8x8(uint a) { return uint2((a >> 1) & 7u, ((a >> 3) & ~1u) | (a & 1u)); }

// Each 64-thread group covers a 16x16 tile as four 8x8 quadrants.
[numthreads(64, 1, 1)]
void main(uint3 groupID : SV_GroupID, uint3 localID : SV_GroupThreadID) {
  uint2 gxy = ARmp8x8(localID.x) + uint2(groupID.x << 4u, groupID.y << 4u);
  Filter(gxy);
  gxy.x += 8u;
  Filter(gxy);
  gxy.y += 8u;
  Filter(gxy);
  gxy.x -= 8u;
  Filter(gxy);
}
