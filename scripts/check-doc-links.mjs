/**
 * Validates internal documentation links, including heading anchors.
 *
 * VitePress checks Markdown links but not the ones passed as props to Vue
 * components (`<NextSteps :links="[...]">`), and it does not check anchors at
 * all — which is where the `·` in a heading silently breaks a deep link.
 *
 * Usage: node scripts/check-doc-links.mjs
 */
import { readdirSync, readFileSync, statSync } from "node:fs";
import { dirname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const docsRoot = resolve(repositoryRoot, "webapp");

const walk = (dir, found = []) => {
  for (const entry of readdirSync(dir)) {
    if (entry.startsWith(".") || entry === "public") continue;

    const full = join(dir, entry);
    if (statSync(full).isDirectory()) walk(full, found);
    else if (entry.endsWith(".md")) found.push(full);
  }
  return found;
};

const files = walk(docsRoot);
const routeOf = (file) =>
  `/${relative(docsRoot, file).replace(/index\.md$/, "").replace(/\.md$/, "")}`;

const pages = new Map(files.map((file) => [routeOf(file), file]));

/** Every anchor VitePress will emit for a page, including explicit `{#id}`. */
const anchorsOf = (file) => {
  const anchors = new Set();

  for (const heading of readFileSync(file, "utf8").matchAll(/^#{2,4} (.+)$/gm)) {
    const explicit = heading[1].match(/\{#([^}]+)\}/);
    if (explicit) anchors.add(explicit[1]);

    anchors.add(
      heading[1]
        .replace(/\{#[^}]+\}/, "")
        .trim()
        .toLowerCase()
        .replace(/[^\w\s-]/g, "")
        .trim()
        .replace(/\s+/g, "-"),
    );
  }

  return anchors;
};

const problems = [];
let checked = 0;

for (const file of files) {
  const source = readFileSync(file, "utf8");
  const at = relative(repositoryRoot, file);

  const links = [
    ...[...source.matchAll(/\]\((\/[^)\s]*)\)/g)].map((match) => match[1]),
    ...[...source.matchAll(/link:\s*'(\/[^']+)'/g)].map((match) => match[1]),
  ];

  for (const link of links) {
    const [route, anchor] = link.split("#");
    if (route.startsWith("/doc/")) continue; // Static assets in public/.

    checked += 1;

    const target = pages.get(route);
    if (!target) {
      problems.push(`${at}  →  ${link}  (no such page)`);
      continue;
    }

    if (anchor && !anchorsOf(target).has(anchor)) {
      problems.push(`${at}  →  ${link}  (no such anchor)`);
    }
  }
}

if (problems.length) {
  console.error(`Found ${problems.length} broken link(s):\n`);
  for (const problem of problems) console.error(`  ${problem}`);
  process.exit(1);
}

console.log(`Checked ${checked} internal links across ${pages.size} pages — all resolve.`);
