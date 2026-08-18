export const releaseVersionPattern =
  /^(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)(?:-(?:alpha|beta|rc)(?:\.(?:0|[1-9]\d*))?)?$/;

const releaseVersionConvention =
  'MAJOR.MINOR.PATCH with an optional -alpha, -beta, or -rc suffix and optional .N identifier';

export function assertValidReleaseVersion(version, source = 'Release version') {
  if (!releaseVersionPattern.test(version)) {
    throw new Error(
      `${source} ${JSON.stringify(version)} is invalid; expected ${releaseVersionConvention}, ` +
        'for example 1.2.3 or 1.2.3-rc.1. Build metadata and other prerelease labels are not supported.',
    );
  }

  return version;
}

export function readInternalDependencies(pubspec, source = 'pubspec.yaml') {
  const dependencies = new Map();
  let section = null;

  for (const line of pubspec.split(/\r?\n/)) {
    const topLevelKey = line.match(/^([a-z_]+):(?:\s|$)/)?.[1];
    if (topLevelKey) {
      section = ['dependencies', 'dev_dependencies'].includes(topLevelKey) ? topLevelKey : null;
      continue;
    }

    if (!section) {
      continue;
    }

    const dependency = line.match(/^  (health_connector(?:_[a-z_]+)?):\s*(.*)$/);
    if (!dependency) {
      continue;
    }

    const name = dependency[1];
    const constraint = dependency[2].replace(/\s+#.*$/, '').trim();
    const version = constraint.startsWith('^') ? constraint.slice(1) : constraint;

    assertValidReleaseVersion(version, `${source} dependency ${name}`);
    dependencies.set(name, version);
  }

  return dependencies;
}
