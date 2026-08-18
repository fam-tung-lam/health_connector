import { execFileSync, spawnSync } from 'node:child_process';
import { readFile } from 'node:fs/promises';
import { resolve } from 'node:path';

import { assertValidReleaseVersion } from './release-version.mjs';

const publish = process.argv.includes('--push');
const packages = [
  'packages/health_connector_lint',
  'packages/health_connector_logger',
  'packages/health_connector_core',
  'packages/health_connector_hc_android',
  'packages/health_connector_hk_ios',
  'packages/health_connector',
];

if (publish && process.env.GITHUB_ACTIONS === 'true' && process.env.GITHUB_REF !== 'refs/heads/main') {
  throw new Error(`Package releases must run from refs/heads/main, not ${process.env.GITHUB_REF}`);
}

function git(args, options = {}) {
  return execFileSync('git', args, {
    cwd: resolve('.'),
    encoding: 'utf8',
    stdio: options.stdio ?? ['ignore', 'pipe', 'pipe'],
  }).trim();
}

function tagExists(tag) {
  return spawnSync('git', ['show-ref', '--verify', '--quiet', `refs/tags/${tag}`], {
    cwd: resolve('.'),
  }).status === 0;
}

async function packageRelease(packagePath) {
  const pubspec = await readFile(resolve(packagePath, 'pubspec.yaml'), 'utf8');

  function readTopLevelScalar(key) {
    const match = pubspec.match(new RegExp(`^${key}:\\s*['"]?([^'"#\\s]+)['"]?`, 'm'));
    if (!match) {
      throw new Error(`${packagePath}/pubspec.yaml has no top-level ${key} field`);
    }

    return match[1];
  }

  const name = readTopLevelScalar('name');
  const version = assertValidReleaseVersion(
    readTopLevelScalar('version'),
    `${packagePath}/pubspec.yaml version`,
  );
  return { name, packagePath, tag: `${name}-v${version}`, version };
}

git(['rev-parse', '--show-toplevel']);
const releases = await Promise.all(packages.map(packageRelease));
const facadeRelease = releases.find(({ name }) => name === 'health_connector');

if (tagExists(facadeRelease.tag)) {
  console.log(`${facadeRelease.tag} already exists; no coordinated release is required.`);
  process.exit(0);
}

const pending = releases.filter(({ tag }) => !tagExists(tag));

for (const { name, version, tag } of pending) {
  console.log(`${publish ? 'Releasing' : 'Would release'} ${name} ${version} as ${tag}`);
}

if (!publish) {
  console.log('Dry run only. Pass --push to create and push the tags.');
  process.exit(0);
}

for (const { name, version, tag } of pending) {
  git(['tag', '--annotate', tag, '--message', `${name} ${version}`], { stdio: 'inherit' });
  git(['push', 'origin', `refs/tags/${tag}`], { stdio: 'inherit' });
}
