/**
 * Verifies that every SDK symbol referenced in the documentation's Dart samples
 * actually exists in the packages.
 *
 * This is a spell-check for the API surface, not a compiler: it catches
 * fabricated constructors, renamed members, and stale accessors — the errors
 * that make a copy-pasted sample fail to compile. It cannot catch type errors.
 *
 * Usage: node scripts/check-doc-symbols.mjs
 */
import { readdirSync, readFileSync, statSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");

const walk = (dir, filter, found = []) => {
  for (const entry of readdirSync(dir)) {
    if (entry === "node_modules" || entry.startsWith(".")) continue;

    const full = join(dir, entry);
    if (statSync(full).isDirectory()) walk(full, filter, found);
    else if (filter(entry)) found.push(full);
  }
  return found;
};

// ---------------------------------------------------------------- SDK index --

const dartFiles = walk(
  resolve(repositoryRoot, "packages"),
  (name) => name.endsWith(".dart") && !name.endsWith(".g.dart"),
).filter((path) => path.includes("/lib/"));

const sdkSource = dartFiles.map((path) => readFileSync(path, "utf8")).join("\n");

/** Members declared anywhere in the SDK: constructors, methods, getters, fields, enum values. */
const declaredMembers = new Set();
/** Top-level type names. */
const declaredTypes = new Set();

for (const match of sdkSource.matchAll(
  /(?:^|\s)(?:final |sealed |abstract |base )*(?:class|enum|extension type|mixin)\s+(\w+)/g,
)) {
  declaredTypes.add(match[1]);
}

// `const Mass.kilograms(`, `factory Frequency.perMinute(`, `Mass.grams(`
for (const match of sdkSource.matchAll(/(?:const |factory |static )?(\w+)\.(\w+)\s*\(/g)) {
  declaredMembers.add(`${match[1]}.${match[2]}`);
}

// `double get inKilograms`, `Frequency get rate`, `final Frequency rate;`
for (const match of sdkSource.matchAll(/\bget\s+(\w+)\b/g)) declaredMembers.add(`.${match[1]}`);
for (const match of sdkSource.matchAll(/\b(?:final|const|late)\s+[\w<>?,\s]+\s(\w+)\s*[;=]/g)) {
  declaredMembers.add(`.${match[1]}`);
}
for (const match of sdkSource.matchAll(/\b(?:required\s+)?(?:this|super)\.(\w+)\b/g)) {
  declaredMembers.add(`.${match[1]}`);
}
// Method declarations and enum values.
for (const match of sdkSource.matchAll(/^\s{2,}(?:[\w<>?,\s]+\s)?(\w+)\s*\(/gm)) {
  declaredMembers.add(`.${match[1]}`);
}
for (const match of sdkSource.matchAll(/^\s{2}(\w+),$/gm)) declaredMembers.add(`.${match[1]}`);

// ---------------------------------------------------------- Documentation ---

// Types the docs legitimately reference that are not SDK classes.
const nonSdkTypes = new Set([
  "DateTime", "Duration", "File", "FileMode", "Future", "List", "Map", "Set",
  "String", "int", "double", "bool", "Object", "Iterable", "StateError",
  "LocalTokenStorage", "SharedPreferences", "storage", "localStore", "connector",
  "print", "debugPrint", "response", "result", "record", "records", "session",
  "route", "entry", "e", "r", "x", "log", "logFile", "request", "token",
  "SleepNight", "FileLogProcessor", "operation", "midnight", "start", "page",
]);

const problems = [];
const docFiles = walk(resolve(repositoryRoot, "webapp"), (name) => name.endsWith(".md"));

for (const path of docFiles) {
  const relative = path.replace(`${repositoryRoot}/`, "");
  const source = readFileSync(path, "utf8");

  for (const block of source.matchAll(/```dart\n([\s\S]*?)```/g)) {
    const code = block[1];
    const lineOffset = source.slice(0, block.index).split("\n").length;

    code.split("\n").forEach((rawLine, index) => {
      // Strip comments and string literals; prose inside them is not API usage.
      const line = rawLine.replace(/\/\/.*$/, "").replace(/'[^']*'/g, "''");
      if (!line.trim()) return;

      const at = `${relative}:${lineOffset + index + 1}`;

      // Static/constructor calls: `Mass.fromKilograms(`, `HealthDataType.steps`
      for (const call of line.matchAll(/\b([A-Z]\w+)\.(\w+)\s*\(/g)) {
        const [, type, member] = call;
        if (nonSdkTypes.has(type) || !declaredTypes.has(type)) continue;
        if (!declaredMembers.has(`${type}.${member}`) && !declaredMembers.has(`.${member}`)) {
          problems.push(`${at}  ${type}.${member}(...) — no such member on ${type}`);
        }
      }

      // Enum and static member access: `HealthPermissionsRequestStatus.granted`.
      // Only a qualified reference proves the docs think the type exists.
      for (const ref of line.matchAll(/\b([A-Z]\w{3,})\.(\w+)/g)) {
        const [, type, member] = ref;
        if (nonSdkTypes.has(type) || declaredTypes.has(type)) continue;
        problems.push(`${at}  ${type}.${member} — type not found in SDK`);
      }

      // Types used in a declaration or catch clause: `on FooException catch (e)`.
      for (const ref of line.matchAll(/\bon\s+([A-Z]\w+)\b/g)) {
        const type = ref[1];
        if (nonSdkTypes.has(type) || declaredTypes.has(type)) continue;
        problems.push(`${at}  ${type} — exception type not found in SDK`);
      }
    });
  }
}

const unique = [...new Set(problems)];
if (unique.length) {
  console.error(`Found ${unique.length} suspect symbol reference(s):\n`);
  for (const problem of unique) console.error(`  ${problem}`);
  process.exit(1);
}

console.log(`Checked ${docFiles.length} pages against ${dartFiles.length} SDK files — no unknown symbols.`);
