// The World in One Day — 24 November 2026.
//
// This program writes the entry image. The poster itself is a fixed asset:
// entry.png (a 1024x1024 newspaper front page built from the 24 November
// 2026 news digest) lives next to this file in the repo. All this program
// does is copy that image into the output directory the harness provides.
//
// The output directory comes from MAKEFUN_OUTPUT_DIR. When the variable is
// not set, the program writes to /output, the directory the harness uses by
// default. The copy is byte-for-byte, so running it twice writes the same
// bytes twice.

import { copyFileSync, mkdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const source = join(here, 'entry.png');

const outDir = process.env.MAKEFUN_OUTPUT_DIR ?? '/output';
mkdirSync(outDir, { recursive: true });
copyFileSync(source, join(outDir, 'entry.png'));
