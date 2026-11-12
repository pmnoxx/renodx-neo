"""Compile an HLSL source with fxc and compare its instruction chunk with a reference shader.

Starting point, not a game-specific verifier. Compares only the SHEX/SHDR chunk, so
reflection (RDEF), signatures, debug data and the container hash are ignored.

  python -I compare_shader_code.py --source 0xABCD1234.ps_5_0.hlsl.original \
      --reference game_shader.cso [--profile ps_5_0] [--define NAME=VALUE ...] \
      [--include DIR ...] [--flags /O3] [--fxc PATH] [--diff]

--reference may also be a second .hlsl, compiled with the same settings (rewrite vs backup).
Exit status 0 on an identical instruction chunk, 1 otherwise.
"""
import argparse, difflib, re, struct, subprocess, sys, tempfile
from pathlib import Path

DEFAULT_FXC = r'C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\fxc.exe'


def code_chunk(data: bytes) -> bytes:
    for i in range(struct.unpack_from('<I', data, 28)[0]):
        offset = struct.unpack_from('<I', data, 32 + 4 * i)[0]
        if data[offset:offset + 4] in (b'SHEX', b'SHDR'):
            return data[offset + 8:offset + 8 + struct.unpack_from('<I', data, offset + 4)[0]]
    raise ValueError('no SHEX/SHDR chunk')


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--reference', type=Path, required=True)
    parser.add_argument('--profile', help='default: second dot-separated part of the source name')
    parser.add_argument('--define', action='append', default=[])
    parser.add_argument('--include', action='append', default=[])
    parser.add_argument('--flags', default='/O3', help='space-separated fxc flags')
    parser.add_argument('--fxc', default=DEFAULT_FXC)
    parser.add_argument('--diff', action='store_true', help='print a register-normalized disassembly diff')
    args = parser.parse_args()
    profile = args.profile or args.source.name.split('.')[1]

    with tempfile.TemporaryDirectory() as tmp:
        def build(src: Path, out: Path) -> Path:
            if src.suffix == '.cso':
                return src
            command = [args.fxc, '/nologo', *args.flags.split(), '/T', profile, '/E', 'main']
            for define in args.define:
                command += ['/D', define]
            for include in args.include:
                command += ['/I', include]
            result = subprocess.run([*command, '/Fo', str(out), str(src)], capture_output=True, text=True)
            if result.returncode:
                sys.exit(f'compile failed: {src}\n{result.stdout}{result.stderr}')
            return out

        built = build(args.source, Path(tmp) / 'source.cso')
        reference = build(args.reference, Path(tmp) / 'reference.cso')
        same = code_chunk(built.read_bytes()) == code_chunk(reference.read_bytes())
        print('MATCH' if same else 'DIFF', args.source.name)
        if not same and args.diff:
            def listing(path):
                text = subprocess.run([args.fxc, '/nologo', '/dumpbin', str(path)], capture_output=True, text=True).stdout
                # Drop comments and register names so only real structural differences remain.
                return [re.sub(r'\br\d+\.[xyzw]+', 'r', line) for line in text.splitlines() if line and not line.startswith('//')]
            print('\n'.join(difflib.unified_diff(listing(reference), listing(built), 'reference', 'source', lineterm='', n=1)))
    sys.exit(0 if same else 1)


main()
