---
name: readable-shader-rewrite
description: "Rewrite 3Dmigoto-decompiled or register-style (r0.xyzw) game shaders into readable, human-named HLSL and prove the rewrite compiles to the game's exact original bytecode (SHEX/SHDR match) with fxc. Use when cleaning up decompiled shaders, recovering original shader names, reconstructing compute shaders such as AMD FidelityFX CAS, verifying a patched shader still reduces to the vanilla binary in an Off/vanilla mode, or keeping .beforerewrite backups."
argument-hint: "shader hash/file, the original game bytecode (.cso) or its archive, and whether a patched mod version exists"
---

# Readable Shader Rewrite

Turn decompiler output into readable HLSL without changing behavior, and prove it by recompiling to the **game's own bytecode**. Use [scripts/compare_shader_code.py](scripts/compare_shader_code.py) for every comparison.

Boundaries: this skill changes readability only. For HDR math in the rewritten shader, hand off to `handle-sdr-tonemap-lut`; for proving which pass or resource matters, use `swapchain-resource-analysis`.

## What can and cannot be recovered

- Check the DXBC chunk list first. Shipped game shaders usually contain only `RDEF`, `ISGN`, `OSGN`, `SHEX`/`SHDR` and `STAT`. Without `SDBG`/`SPDB` there is no source text, and local variable names are lost for good.
- `RDEF` keeps cbuffer, member, texture, sampler and UAV names; signatures keep semantics. Use those names exactly. Name locals by role (`scene`, `bloom`, `exposed`, `lut_input`).
- Game archives often keep the original file names. Locate each shader by CRC32 (the ReShade/RenoDX hash is the CRC32 of the complete bytecode) inside the archive's name table, e.g. `filtershadertonemap.pso`. Record the original name in a `// Original:` first line.
- Recognize public middleware before reverse engineering. Bit-pattern constants such as `0x7ef07ebb`, `0x1fbc4639` and `0x7ef19fff` are AMD `ffx_a.h` approximations, which identifies FidelityFX CAS. Writing the rewrite in AMD's `ffx_cas.h` structure matched the game binary on the first attempt.

## Match target

- Compare against the **original game bytecode**, not against a recompile of the decompile. Decompiler output often does not recompile to the game binary, while a natural rewrite does. Making a rewrite reproduce decompiler quirks moves it further from the original.
- Compare only the `SHEX`/`SHDR` chunk; RDEF/STAT/container-hash bytes are irrelevant to behavior.
- Find the game's compile flags from the binary: `dcl_globalFlags refactoringAllowed` means it was compiled without `/Gec`. `/O0`–`/O3` and fxc versions 10.0.17763–10.0.26100 behaved identically for these shaders. `/Gis` did not match.
- Keep a backup of the starting file as `<name>.beforerewrite` before editing.

## Rewrite technique

1. Rewrite the **unpatched** original first and get an exact match.
2. Express the math naturally (`float3`, named values, `smoothstep`, small helpers). fxc normalizes most of it, including inlined functions, `smoothstep(0.25, 1.0, x)` written as a single call, and helpers used twice.
3. When it differs, run the script with `--diff`; its listing drops register names, so only real structural differences remain. Usual fixes:
   - **Operand order** of commutative multiply-adds: `a * b + 1` versus `b * a + 1`, or `scene * k` versus `k * scene`. Try both.
   - **Load/sample order**: the binary samples in source order. For example, bloom was sampled before the scene texture.
   - **Statement order** changes vector packing. A value used both through a swizzle (LUT `bbrg` addressing) and as `rgb` was widened to 4 lanes until its LUT lookup was moved before the next use.
   - **Declaration order** of cbuffers must follow the binary's `dcl_constantbuffer` order.
   - **Precomputed reciprocals** (`div 1/x` then `mul`) mean the source wrote `1.0 / x` explicitly.
   - **Incremental coordinates** (`x += 8; y += 8; x -= 8`) produce different constants from fixed offsets.
4. Brute-force a few equivalent forms with a small script when a single instruction resists; keep the readable form that matches.

## Patched mod shaders

- Write the patched shader as the matched rewrite plus the mod's changes, with every change behind mode macros. In NieR, `shared.h` defines `NIER_TONE_MAP_OFF` and related macros. A verify-only define such as `NIER_VERIFY_MODE=1` turns them into compile-time constants.
- Required proof: the patched file compiled with the Off/vanilla constant gives the **game's exact bytecode**. This also proves the Off mode runs the original code.
- For HDR modes, compare the rewrite against the `.beforerewrite` copy built with the same forced mode. Shared RenoDX code such as `ToneMapPass` can be scheduled differently for equivalent inputs, so temporarily replace it with a cheap probe that keeps every input observable, e.g. `a * 1.5 + b * 2.5 + c * 3.5`. Then require the same opcode multiset. Treat any remaining difference as unproven and review it by hand.

## Done when

- Every rewritten original matches the game instruction chunk, and every patched shader matches it in Off mode.
- `.beforerewrite` backups exist, and the addon target builds.
- The verifier command used is recorded in the mod README or task notes.
