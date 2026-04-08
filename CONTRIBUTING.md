# Contributing to Health Connector

Thank you for your interest in contributing to Health Connector! This guide explains how to set up
your development environment, follow project conventions, and submit high-quality contributions.

For major changes, please open an issue first to discuss your proposal before investing time in an
implementation.

---

## Table of contents

1. [Contribution types](#contribution-types)
2. [Requirements checklist](#requirements-checklist)
3. [Environment setup](#environment-setup)
4. [Performing changes](#performing-changes)
5. [Breaking changes policy](#breaking-changes-policy)
6. [Opening a pull request](#opening-a-pull-request)
7. [Maintainer guidelines](#maintainer-guidelines)

---

## Contribution types

| Type | Description | Issue required? |
|---|---|---|
| **Bug report** | Report unexpected behaviour with a reproducible case | No |
| **Bug fix** | Fix a confirmed bug | Recommended |
| **New feature** | Add new health record types, APIs, or platform support | Yes |
| **Documentation** | Improve guides, API docs, or inline comments | No |
| **Refactor** | Improve internals without changing public behaviour | Yes |

### Bug reports

- If you find a bug, please first report it using
  [GitHub Issues](https://github.com/fam-tung-lam/health_connector/issues).
  - Check first whether an open issue already exists; duplicate issues will be closed.

### Bug fixes

- To submit a fix, please read [Opening a pull request](#opening-a-pull-request).
- Indicate on the open issue that you are working on the fix.
- Write `Fixes #xxxx` in your PR body, where `xxxx` is the issue number.
- Include a test that isolates the bug and verifies that it was fixed.

### New features

- If you'd like to add a feature, open a
  [GitHub Issue](https://github.com/fam-tung-lam/health_connector/issues) to discuss it first.
- Wait for feedback from the maintainers before investing significant time on implementation. Some
  enhancements may not align with the project's direction.

### Documentation & miscellaneous

- For documentation or example improvements, open a
  [GitHub Issue](https://github.com/fam-tung-lam/health_connector/issues) to describe your
  proposal, then submit a PR with the changes.

---

## Requirements checklist

Before opening a pull request, verify that every applicable item below is satisfied.

- [ ] Code is formatted (`melos run format:check`)
- [ ] All Dart analysis passes (`melos run analyze:dart:strict`)
- [ ] All Kotlin analysis passes (`melos run analyze:kotlin`)
- [ ] All Swift analysis passes (`melos run analyze:swift`)
- [ ] All tests pass (`melos run test:dart` and `melos run test:kotlin`)
- [ ] New features and bug fixes include tests
- [ ] Public API changes are documented (dartdoc comments)
- [ ] Documentation changes pass markdownlint (`melos run analyze:md`)
- [ ] Pigeon input files modified → generated code is up to date (`melos run pigeon`)
- [ ] PR title follows the [conventional commits](#pr-title-convention) format

---

## Environment setup

Health Connector is a multi-platform Flutter plugin monorepo. The steps below install the exact
toolchain versions pinned by the repository.

### Fork and clone the repository

- [Fork the project](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)
  on GitHub.
- Clone the forked repository to your local development machine:

  ```bash
  git clone git@github.com:<YOUR_GITHUB_USER>/health_connector.git
  ```

### 1. Flutter (via fvm)

The project pins its Flutter version in `.fvmrc`. Use
[Flutter Version Management (fvm)](https://fvm.app) to install and activate it.

```bash
# Install fvm (if not already installed)
dart pub global activate fvm

# Install the pinned Flutter version and link it to this project
fvm install
fvm use

# Verify the active Flutter version
fvm flutter --version
```

Prefix all `flutter` commands in this project with `fvm` (e.g., `fvm flutter test`) or configure
your shell so that `flutter` resolves to the fvm-managed binary.

### 2. Java (via SDKMAN!)

Android builds require the JDK version pinned in `.sdkmanrc`. Use
[SDKMAN!](https://sdkman.io) to install and activate it.

```bash
# Install SDKMAN! (if not already installed — follow https://sdkman.io/install)
curl -s "https://get.sdkman.io" | bash

# In the repository root, activate the pinned JDK
sdk env install   # installs the version from .sdkmanrc
sdk env           # activates it in the current shell

# Verify
java -version
```

### 3. Ruby (via rbenv or rvm)

Ruby is used for iOS tooling (Fastlane and CocoaPods). The pinned version is in `.ruby-version`.

```bash
# Using rbenv
rbenv install   # reads .ruby-version automatically
rbenv local     # activates it for this directory

# Or using rvm
rvm install "$(cat .ruby-version)"
rvm use "$(cat .ruby-version)"

# Verify
ruby --version
```

### 4. Swift Package Manager

The iOS plugin target resolves its Swift dependencies via
[Swift Package Manager (SPM)](https://www.swift.org/documentation/package-manager/). No additional
installation is needed — Xcode bundles SPM. When you open the iOS example project or run an iOS
build, Xcode resolves and fetches Swift packages automatically.

### 5. Melos

This project uses [Melos](https://melos.invertase.dev/getting-started) to manage the monorepo and
its dependencies.

To install Melos, run the following command from your terminal:

```bash
flutter pub global activate melos
```

Next, at the root of your locally cloned repository, bootstrap the project dependencies:

```bash
melos bootstrap
```

The bootstrap command locally links all packages within the monorepo without requiring manual
`dependency_overrides`. This allows all plugins, examples, and tests to build from the local clone.
You should only need to run this command once.

You do not need to run `flutter pub get` once bootstrap has been completed.

---

## Performing changes

### Branch naming

Create a feature branch from `main` using one of the following prefixes:

| Prefix | Use case |
|---|---|
| `feat/` | New feature or capability |
| `fix/` | Bug fix |
| `docs/` | Documentation only |
| `refactor/` | Internal refactoring |
| `chore/` | Tooling, CI, or dependency updates |

Example: `feat/add-blood-glucose-record`

### Commit style

This project uses [Conventional Commits](https://www.conventionalcommits.org). Each commit message
must follow this format:

```text
<type>(<optional scope>): <short description>

[optional body]

[optional footer(s)]
```

Common types: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ci`.

Scopes map to the affected package (e.g., `core`, `hc-android`, `hk-ios`, `lint`, `logger`).

Examples:

```text
feat(core): add BloodGlucose domain model
fix(hc-android): handle null timestamp in StepsRecord mapper
docs: update environment setup in CONTRIBUTING.md
```

### Markdown lint

Markdown files are linted with
[markdownlint](https://github.com/igorshubovych/markdownlint-cli). To check for errors:

```bash
melos run analyze:md
```

Some errors can be fixed automatically:

```bash
melos run format:md
```

### Code generation

This project uses [Pigeon](https://pub.dev/packages/pigeon) to generate type-safe platform channel
code for communication between Dart and native (Kotlin/Swift) code.

The Pigeon input files define the platform API contract:

- `packages/health_connector_hc_android/pigeon/health_connector_hc_android_api.dart`
- `packages/health_connector_hk_ios/pigeon/health_connector_hk_ios_api.dart`

Whenever you modify either input file, regenerate the platform channel code before committing:

```bash
melos run pigeon
```

This regenerates the corresponding `*.g.dart`, `*.g.kt`, and `*.g.swift` files. Generated files are
excluded from linting and must be committed alongside the input file changes.

---

## Breaking changes policy

Health Connector follows [semantic versioning](https://semver.org). Any change that removes or
alters public API in a backwards-incompatible way is a **breaking change** and requires a major
version bump.

### Deprecation process

Before removing a public symbol, deprecate it first and keep it for at least one minor release:

```dart
@Deprecated(
  'Use newMethodName() instead. '
  'This will be removed in v<next-major>.0.0.',
)
void oldMethodName() => newMethodName();
```

- Annotate with `@Deprecated` including the replacement and the removal version.
- Document the deprecation in `CHANGELOG.md` under a `### Deprecated` subsection.
- The removal of the deprecated symbol may only appear in the next major release.

### Android-only APIs

Use the `@supportedOnHealthConnect` annotation for APIs that are only available on Android Health
Connect. Document the platform restriction in the dartdoc comment.

### iOS-only APIs

Use the `@supportedOnAppleHealth` annotation for APIs that are only available on iOS HealthKit.
Document the platform restriction in the dartdoc comment.

---

## Opening a pull request

### PR title convention

PR titles are used to generate the changelog automatically and must follow Conventional Commits:

```text
<type>(<optional scope>): <short imperative description>
```

The description after the `:` should start with a verb in the present tense — think of it as
completing the sentence "This commit will …". For example, "Add support for …" or "Fix bug with …".

Allowed types:

| Type | Use case |
|---|---|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `docs` | Documentation or example update |
| `test` | Test additions or changes |
| `refactor` | Internal refactoring without public API changes |
| `perf` | Performance improvement |
| `build` | Build system or external dependency change |
| `ci` | CI configuration or script change |
| `chore` | Other changes that don't modify source or test files |
| `revert` | Reverts a previous commit |

Examples:

- `feat(core): add BloodGlucose domain model`
- `fix(hc-android): handle null timestamp in StepsRecord mapper`
- `docs: add CONTRIBUTING.md`
- `chore: upgrade Flutter to 3.36.0`

Use `feat!` (no scope) or `feat(scope)!:` (with scope), or add `BREAKING CHANGE:` in the commit footer:

```text
feat(core)!: remove deprecated readRecords overload

BREAKING CHANGE: The two-argument overload of readRecords() has been removed.
Migrate to the named-parameter variant introduced in v2.1.0.
```

### PR body

Your pull request description should answer:

1. **What** changed and **why**
2. **How** to test the change
3. Any platform-specific behaviour or limitations
4. References to related issues (e.g., `Closes #137`)

### Review process

- All CI checks must pass before review.
- At least one maintainer approval is required before merging.
- Address review feedback in new commits; do not force-push during review.
- Once approved, the maintainer will squash-merge the PR.

---

## Maintainer guidelines

### Merging a pull request

- Use **squash merge** for feature branches to keep a linear history on `main`.
- Ensure the squashed commit title follows Conventional Commits (the PR title becomes the squash
  commit message, so verify it is correct before merging).
- Remove all default boilerplate from the merge commit message body.
- If the PR contains breaking changes, copy the migration instructions from the PR description into
  the commit message body so that the release changelog includes them.

### Creating a release

Each package in the monorepo is released independently. Follow these steps:

1. **Remove deprecated symbols** — search the codebase for `@Deprecated` annotations and remove
   any that are marked for removal in the version you intend to release. Open a dedicated PR for
   this cleanup.

2. **Generate changelogs** — use Melos to bump package versions and auto-generate `CHANGELOG.md`
   entries from the commit history:

   ```bash
   melos version -V <package1>:<version> -V <package2>:<version>
   ```

   Review the generated changelogs. For PRs with breaking changes, add migration documentation
   under a `### BREAKING CHANGES` subsection if not already present.

3. **Validate packages (dry run)** — confirm all packages are publishable and versions are correct:

   ```bash
   melos publish
   ```

4. **Publish** — once satisfied with the dry run output:

   ```bash
   melos publish --no-dry-run
   ```

5. **Open a release PR** — create a PR to `main` containing the updated `CHANGELOG.md` and
   `pubspec.yaml` files. After merge, the CD workflow publishes the packages to
   [pub.dev](https://pub.dev).
