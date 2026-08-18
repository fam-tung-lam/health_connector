import assert from 'node:assert/strict';
import test from 'node:test';

import {
  assertValidReleaseVersion,
  readInternalDependencies,
  releaseVersionPattern,
} from './release-version.mjs';

const validVersions = [
  '0.0.0',
  '1.2.3',
  '10.20.30',
  '1.2.3-alpha',
  '1.2.3-alpha.1',
  '1.2.3-beta',
  '1.2.3-beta.2',
  '1.2.3-rc',
  '1.2.3-rc.10',
];

const invalidVersions = [
  '1.2',
  'v1.2.3',
  '01.2.3',
  '1.02.3',
  '1.2.03',
  '1.2.3-alpha.01',
  '1.2.3-preview',
  '1.2.3-rc.1.2',
  '1.2.3+build.5',
  '1.2.3-rc.1+build.5',
];

test('release version pattern accepts the project version convention', () => {
  for (const version of validVersions) {
    assert.match(version, releaseVersionPattern);
    assert.equal(assertValidReleaseVersion(version), version);
  }
});

test('release version pattern rejects unsupported versions', () => {
  for (const version of invalidVersions) {
    assert.doesNotMatch(version, releaseVersionPattern);
    assert.throws(() => assertValidReleaseVersion(version), /is invalid/);
  }
});

test('internal dependencies retain the complete prerelease version', () => {
  const dependencies = readInternalDependencies(`
dependencies:
  health_connector_core: ^4.0.0-rc.1
dev_dependencies:
  health_connector_lint: 2.0.0-beta
`);

  assert.deepEqual(
    [...dependencies],
    [
      ['health_connector_core', '4.0.0-rc.1'],
      ['health_connector_lint', '2.0.0-beta'],
    ],
  );
});

test('internal dependencies reject unsupported version constraints', () => {
  for (const constraint of ['^4.0.0+build.5', '^4.0.0-rc.1+build.5', '^4.0.0-preview.1']) {
    assert.throws(
      () =>
        readInternalDependencies(`
dependencies:
  health_connector_core: ${constraint}
`),
      /dependency health_connector_core .* is invalid/,
    );
  }
});
