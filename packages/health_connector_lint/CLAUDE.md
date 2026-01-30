# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Package Purpose

`health_connector_lint` provides shared Dart analysis options and lint rules for all packages in the
Health Connector monorepo. It contains no Dart code—only YAML configuration.

## Directory Structure

```text
lib/
└── analysis_options.yaml   # Main lint rules (imported by other packages)
analysis_options.yaml       # Package-level analysis options
pubspec.yaml
CHANGELOG.md
README.md
```

Other packages consume these rules via:

```yaml
include: package:health_connector_lint/analysis_options.yaml
```

## Key Configuration

- **Base**: Extends `package:lints/core.yaml`
- **Strict mode**: `strict-casts`, `strict-inference`, `strict-raw-types` enabled
- **Promoted to errors**: `dead_code`, `unused_local_variable`, `unused_import`
- **Excludes**: `*.g.dart`, `generated_plugin_registrant.dart` (Pigeon/build_runner output)

## Commands

```bash
# From this package
fvm dart analyze

# From monorepo root (applies to all packages)
melos run analyze:dart:strict
```

## Modifying Lint Rules

Edit `lib/analysis_options.yaml` to add/remove rules. Changes apply to all packages in the monorepo
after they run `dart pub get`.
