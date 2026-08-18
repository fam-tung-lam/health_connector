import { readFile } from 'node:fs/promises';
import { resolve } from 'node:path';

import { readInternalDependencies } from './release-version.mjs';

const [packagePath] = process.argv.slice(2);
const maxAttempts = Number(process.env.PUB_DEPENDENCY_ATTEMPTS ?? 700);
const retryDelayMs = Number(process.env.PUB_DEPENDENCY_RETRY_MS ?? 30_000);
const retryableStatuses = new Set([408, 425, 429]);

if (!packagePath) {
  throw new Error('Usage: node scripts/wait-for-pub-dependencies.mjs <package-path>');
}

const pubspec = await readFile(resolve(packagePath, 'pubspec.yaml'), 'utf8');
const internalDependencies = readInternalDependencies(
  pubspec,
  `${packagePath}/pubspec.yaml`,
);

async function isPublished(name, version) {
  let response;

  try {
    response = await fetch(`https://pub.dev/api/packages/${name}/versions/${version}`);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    console.warn(`pub.dev lookup failed for ${name} ${version}: ${message}; retrying`);
    return false;
  }

  if (response.ok) {
    return true;
  }

  if (response.status === 404) {
    return false;
  }

  if (retryableStatuses.has(response.status) || response.status >= 500) {
    console.warn(`pub.dev returned ${response.status} while checking ${name} ${version}; retrying`);
    return false;
  }

  throw new Error(`pub.dev returned ${response.status} while checking ${name} ${version}`);
}

function wait(delayMs) {
  return new Promise((resolvePromise) => setTimeout(resolvePromise, delayMs));
}

for (let attempt = 1; attempt <= maxAttempts; attempt += 1) {
  const pending = [];

  for (const [name, version] of internalDependencies) {
    if (!(await isPublished(name, version))) {
      pending.push(`${name} ${version}`);
    }
  }

  if (pending.length === 0) {
    console.log(`All internal dependencies for ${packagePath} are available on pub.dev.`);
    process.exit(0);
  }

  if (attempt === maxAttempts) {
    throw new Error(`Timed out waiting for pub.dev dependencies: ${pending.join(', ')}`);
  }

  console.log(`Waiting for ${pending.join(', ')} (${attempt}/${maxAttempts})`);
  await wait(retryDelayMs);
}
