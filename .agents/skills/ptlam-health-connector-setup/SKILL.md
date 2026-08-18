---
name: ptlam-health-connector-setup
description:
  Set up or repair a local Health Connector SDK checkout with its pinned
  Flutter, Java, and Ruby toolchains, Melos workspace links, Android tools, and
  macOS-only Swift tools, then prove the available development lanes. Runs only
  when explicitly requested. Use when bootstrapping a clone, repairing missing
  dependencies, or preparing a machine to contribute. Do not use for a runtime
  defect or an already-working checkout's lint failure.
disable-model-invocation: true
---

# PTLam Health Connector Setup

Prepare one Health Connector checkout for Dart, Android, and—on macOS—iOS
development. This workflow may install missing local tools only after the user
has explicitly requested setup and approved downloads outside the checkout.

## Resolve the checkout and lanes

1. Confirm the repository root contains `pubspec.yaml` with
   `name: health_connector_workspace`, `.fvmrc`, `.sdkmanrc`, and
   `.ruby-version`. Stop before changing another checkout.
2. Read those three pin files and the root `pubspec.yaml`; do not copy versions
   from this skill. Record whether the machine will support Dart only, Dart and
   Android, or all three lanes. iOS requires macOS and Xcode.
3. Inspect `git status` and leave existing work untouched. Setup output such as
   `.fvm/`, `.dart_tool/`, and build directories remains uncommitted.

## Install the pinned toolchains

Use an existing tool manager when present. Ask before downloading a missing
manager or changing user-level global packages.

| Lane             | Required checks                                                                       | Configuration owner                       |
| ---------------- | ------------------------------------------------------------------------------------- | ----------------------------------------- |
| Dart and Flutter | `fvm --version`, `fvm flutter --version`                                              | `.fvmrc`                                  |
| Workspace        | `melos --version`                                                                     | `dev_dependencies` in root `pubspec.yaml` |
| Android          | `java -version`                                                                       | `.sdkmanrc`                               |
| iOS              | `xcodebuild -version`, `ruby --version`, `swiftlint version`, `swiftformat --version` | Xcode plus `.ruby-version`                |
| Documentation    | `node --version`, `npm --version`                                                     | `package.json` and lockfile               |

Install and activate the project Flutter SDK:

```bash
fvm install
fvm use
fvm flutter --version
```

If Melos is unavailable after Flutter is active, install it with the pinned Dart
toolchain, then verify the executable:

```bash
fvm dart pub global activate melos
melos --version
```

For Android, use SDKMAN to install and activate the `.sdkmanrc` candidate:

```bash
sdk env install
sdk env
java -version
```

For iOS, activate the Ruby version through the machine's existing rbenv or RVM
installation. Install SwiftLint and SwiftFormat through the machine's existing
package manager, then verify both versions. Do not claim the iOS lane on a
non-macOS host.

## Bootstrap the workspace

Run from the repository root:

```bash
melos bootstrap
```

Done when Melos links every workspace package without adding
`dependency_overrides` to member packages. For documentation work, also run
`npm ci`; it installs the exact VitePress dependency graph from
`package-lock.json`.

## Prove each available lane

Run the strongest lane the machine supports:

```bash
melos run format:dart:check
melos run analyze:dart:strict
melos run test:dart
melos run format:kotlin:check
melos run analyze:kotlin
melos run test:kotlin
melos run format:swift:check
melos run analyze:swift
```

Skip Kotlin only when Android is outside the requested setup. Skip Swift only
when the host cannot run it. Report each skipped lane and its missing
prerequisite.

Finish when bootstrap succeeds, every requested available lane passes its
checks, `git status` contains no unexpected tracked change, and the handoff
names versions, commands, failures, and unsupported lanes.
