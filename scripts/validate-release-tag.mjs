import { readFile } from 'node:fs/promises';
import { resolve } from 'node:path';

import { assertValidReleaseVersion } from './release-version.mjs';

const [packagePath, releaseTag] = process.argv.slice(2);

if (!packagePath || !releaseTag) {
  throw new Error(
    'Usage: node scripts/validate-release-tag.mjs <package-path> <release-tag>',
  );
}

const pubspec = await readFile(resolve(packagePath, 'pubspec.yaml'), 'utf8');

function readTopLevelScalar(key) {
  const match = pubspec.match(new RegExp(`^${key}:\\s*['"]?([^'"#\\s]+)['"]?`, 'm'));
  if (!match) {
    throw new Error(`pubspec.yaml has no top-level ${key} field`);
  }

  return match[1];
}

const packageName = readTopLevelScalar('name');
const packageVersion = assertValidReleaseVersion(
  readTopLevelScalar('version'),
  `${packagePath}/pubspec.yaml version`,
);
const expectedTag = `${packageName}-v${packageVersion}`;

if (releaseTag.startsWith(`${packageName}-v`)) {
  assertValidReleaseVersion(
    releaseTag.slice(`${packageName}-v`.length),
    `Release tag ${releaseTag} version`,
  );
}

if (releaseTag !== expectedTag) {
  throw new Error(
    `Release tag ${releaseTag} does not match ${packageName} version ${packageVersion}; expected ${expectedTag}`,
  );
}

console.log(`${releaseTag} matches ${packagePath}/pubspec.yaml`);
