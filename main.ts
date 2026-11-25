import { copyFileSync, existsSync, mkdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const outDir = process.env.MAKEFUN_OUTPUT_DIR;
if (!outDir) {
  console.error("MAKEFUN_OUTPUT_DIR is not set");
  process.exit(1);
}

const source = join(dirname(fileURLToPath(import.meta.url)), "entry.png");
if (!existsSync(source)) {
  console.error(`entry.png not found: ${source}`);
  process.exit(1);
}

mkdirSync(outDir, { recursive: true });
copyFileSync(source, join(outDir, "entry.png"));
console.log(`copied entry.png to ${join(outDir, "entry.png")}`);
