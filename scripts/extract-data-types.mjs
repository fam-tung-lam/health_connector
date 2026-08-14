/**
 * Parses the "Supported Health Data Types" tables out of the package README
 * and emits structured JSON consumed by the site's interactive explorers.
 *
 * Run via `npm run site:prepare`; the generated file is committed so the site
 * builds without the parser needing to succeed on every environment.
 */
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const readmePath = resolve(repositoryRoot, "packages/health_connector/README.md");
const outputPath = resolve(repositoryRoot, "webapp/.vitepress/data/health-data-types.json");

const source = readFileSync(readmePath, "utf8");
const region = source
  .split("<!-- #region webapp-supported-data-types -->")[1]
  .split("<!-- #endregion webapp-supported-data-types -->")[0];

const splitRow = (line) =>
  line
    .trim()
    .replace(/^\|/, "")
    .replace(/\|$/, "")
    .split("|")
    .map((cell) => cell.trim());

const isDivider = (line) => /^\|[\s:|-]+\|$/.test(line.trim());

/** `[label](url)` -> `{ label, url }`; plain text -> `{ label }`. */
const parseLink = (cell) => {
  const match = cell.match(/^\[([^\]]+)\]\(([^)]+)\)(.*)$/);
  if (!match) return cell === "-" || cell === "" ? null : { label: cell };
  const note = match[3].trim().replace(/^\((.*)\)$/, "$1");
  return { label: match[1], url: match[2], ...(note ? { note } : {}) };
};

const parseList = (cell) =>
  cell === "-" || cell === ""
    ? []
    : cell
        .split(",")
        .map((entry) => entry.trim())
        .filter(Boolean);

/**
 * "Supported On" cells can carry an OS floor, e.g. `iOS HealthKit (iOS 17+)`.
 * Dropping it would tell a reader the type works on every supported iOS, so the
 * qualifier is preserved and surfaced next to the platform badge.
 */
const parsePlatformNote = (entries, needle) => {
  const entry = entries.find((value) => value.includes(needle));
  const note = entry?.match(/\(([^)]+)\)/);

  return note ? note[1] : null;
};

const dataTypes = [];
const exerciseTypes = [];
let category = "";
let group = "";

const lines = region.split("\n");
for (let index = 0; index < lines.length; index += 1) {
  const line = lines[index];

  const heading = line.match(/^(#{3,5})\s+(.*)$/);
  if (heading) {
    // Strip leading emoji so the site controls its own iconography.
    const title = heading[2].replace(/^[^\p{L}\p{N}]+/u, "").trim();
    if (heading[1].length === 3) {
      category = title;
      group = "";
    } else if (heading[1].length === 4) {
      group = title;
    }
    continue;
  }

  if (!line.trim().startsWith("|")) continue;

  const header = splitRow(line);
  if (!isDivider(lines[index + 1] ?? "")) continue;

  index += 1;
  while (lines[index + 1]?.trim().startsWith("|")) {
    index += 1;
    const cells = splitRow(lines[index]);

    if (header.length === 7) {
      const platforms = parseList(cells[4]);
      dataTypes.push({
        name: cells[0],
        description: cells[1],
        constant: cells[2].replace(/`/g, ""),
        aggregations: parseList(cells[3]),
        android: platforms.some((entry) => entry.includes("Android")),
        ios: platforms.some((entry) => entry.includes("iOS")),
        androidNote: parsePlatformNote(platforms, "Android"),
        iosNote: parsePlatformNote(platforms, "iOS"),
        androidApi: parseLink(cells[5]),
        iosApi: parseLink(cells[6]),
        category,
        group: group || category,
      });
    } else if (header.length === 3 && header[0] === "Exercise Type") {
      const constant = cells[0].replace(/`/g, "");
      exerciseTypes.push({
        constant,
        // `ExerciseType.runningTreadmill` -> `Running Treadmill`
        name: constant
          .replace(/^ExerciseType\./, "")
          .replace(/([a-z0-9])([A-Z])/g, "$1 $2")
          .replace(/^./, (character) => character.toUpperCase()),
        android: cells[1] === "✅",
        ios: cells[2] === "✅",
      });
    }
  }
}

const packageVersion = readFileSync(
  resolve(repositoryRoot, "packages/health_connector/pubspec.yaml"),
  "utf8",
).match(/^version:\s*(\S+)/m)[1];

const categories = [...new Set(dataTypes.map((entry) => entry.category))];
const payload = {
  generatedFrom: "packages/health_connector/README.md",
  packageVersion,
  totals: {
    dataTypes: dataTypes.length,
    exerciseTypes: exerciseTypes.length,
    android: dataTypes.filter((entry) => entry.android).length,
    ios: dataTypes.filter((entry) => entry.ios).length,
    aggregatable: dataTypes.filter((entry) => entry.aggregations.length > 0).length,
  },
  categories,
  dataTypes,
  exerciseTypes,
};

writeFileSync(outputPath, `${JSON.stringify(payload, null, 2)}\n`);
console.log(
  `Extracted ${dataTypes.length} data types and ${exerciseTypes.length} exercise types across ${categories.length} categories.`,
);
