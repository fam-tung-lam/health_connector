/// Script to synchronize version between platform implementation packages
/// and the health_connector facade package.
///
/// This script is run as part of the Melos `preCommit` hook during versioning.
/// It ensures that when platform packages (health_connector_hk_ios,
/// health_connector_hc_android, health_connector_core) are bumped, the facade
/// package (health_connector) receives the same major.minor version.
///
/// Usage: dart run scripts/sync_facade_version.dart
library;

import 'dart:io';

// Packages that drive the facade version
const platformPackages = [
  'health_connector_core',
  'health_connector_hk_ios',
  'health_connector_hc_android',
];

const facadePackage = 'health_connector';
const packagesDir = 'packages';

void main() async {
  print('🔄 Synchronizing facade version with platform packages...');

  final facadePubspecPath = '$packagesDir/$facadePackage/pubspec.yaml';
  final facadePubspec = File(facadePubspecPath);

  if (!facadePubspec.existsSync()) {
    print('❌ Facade pubspec not found at $facadePubspecPath');
    exit(1);
  }

  // Read all versions
  final versions = <String, Version>{};

  for (final package in platformPackages) {
    final pubspecPath = '$packagesDir/$package/pubspec.yaml';
    final pubspec = File(pubspecPath);

    if (!pubspec.existsSync()) {
      print('⚠️ Package $package not found, skipping...');
      continue;
    }

    final content = pubspec.readAsStringSync();
    final version = _parseVersion(content);
    if (version != null) {
      versions[package] = version;
      print('📦 $package: $version');
    }
  }

  if (versions.isEmpty) {
    print('⚠️ No platform package versions found, skipping synchronization.');
    return;
  }

  // Find the maximum version
  final maxVersion = versions.values.reduce(
    (a, b) => a.compareTo(b) >= 0 ? a : b,
  );
  print('📊 Max platform version: $maxVersion');

  // Read facade version
  final facadeContent = facadePubspec.readAsStringSync();
  final facadeVersion = _parseVersion(facadeContent);

  if (facadeVersion == null) {
    print('❌ Could not parse facade version');
    exit(1);
  }

  print('📦 $facadePackage: $facadeVersion');

  // Check if facade needs to be updated to match max version's major.minor
  if (facadeVersion.major < maxVersion.major ||
      (facadeVersion.major == maxVersion.major &&
          facadeVersion.minor < maxVersion.minor)) {
    // Update facade to max version's major.minor.0
    final newFacadeVersion = Version(maxVersion.major, maxVersion.minor, 0);
    print(
      '⬆️ Updating $facadePackage from $facadeVersion to $newFacadeVersion',
    );

    // Update pubspec.yaml
    final versionPattern = RegExp(r'^version:\s*[\d.]+', multiLine: true);
    final updatedContent = facadeContent.replaceFirst(
      versionPattern,
      'version: $newFacadeVersion',
    );

    facadePubspec.writeAsStringSync(updatedContent);
    print('✅ Updated $facadePubspecPath');

    // Stage the change
    final result = Process.runSync('git', ['add', facadePubspecPath]);
    if (result.exitCode != 0) {
      print('❌ Failed to stage changes: ${result.stderr}');
      exit(1);
    }
    print('✅ Staged changes for commit');
  } else if (facadeVersion.major == maxVersion.major &&
      facadeVersion.minor == maxVersion.minor) {
    print('✅ Facade version already matches platform packages (major.minor)');
  } else {
    print('✅ Facade version is ahead of platform packages, no update needed');
  }
}

/// Parses version string from pubspec.yaml content
Version? _parseVersion(String content) {
  final versionPattern = RegExp(r'^version:\s*([\d.]+)', multiLine: true);
  final match = versionPattern.firstMatch(content);
  if (match == null) return null;

  final versionString = match.group(1)!;
  final parts = versionString.split('.').map(int.tryParse).toList();

  if (parts.length < 3 || parts.any((p) => p == null)) return null;

  return Version(parts[0]!, parts[1]!, parts[2]!);
}

/// Simple semantic version representation
class Version implements Comparable<Version> {
  final int major;
  final int minor;
  final int patch;

  Version(this.major, this.minor, this.patch);

  @override
  int compareTo(Version other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }

  @override
  String toString() => '$major.$minor.$patch';
}
