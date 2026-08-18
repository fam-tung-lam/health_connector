# Data Type Verification

This reference owns the evidence that one data type is reachable and truthful on
every declared platform.

## Required behavior

| Surface               | Evidence                                                                                                     |
| --------------------- | ------------------------------------------------------------------------------------------------------------ |
| Core record           | Valid construction, each bound failure, `copyWith`, equality, and record-to-data-type mapping                |
| Core data type        | Stable id, `values` membership, supported platforms, capabilities, permissions, and aggregation unit         |
| Dart mappers          | Every field in `toDto()` and `toDomain()` plus both directions for each enum                                 |
| Dart client or facade | Supported success path and explicit unsupported-platform result                                              |
| Android               | Mapper round trip, handler capabilities, permission mapping, and registry reachability                       |
| iOS                   | Mapper and handler source review, availability gates, registry reachability, and manual native evidence      |
| Documentation         | Public export, dartdoc platform mapping, capabilities, parameters, throws, example when needed, and category |

## Run repository checks

Run from the monorepo root after focused tests:

```bash
melos run format:dart:check
melos run analyze:dart:strict
melos run test:dart
melos run doc:generate
melos run format:kotlin:check
melos run analyze:kotlin
melos run test:kotlin
melos run format:swift:check
melos run analyze:swift
```

Run only the native lanes the data type supports, but always run Dart because
the public core and at least one Dart platform client changed. Report an
unavailable iOS lane rather than treating its absence as success.

Run `melos run pigeon` a second time and inspect `git diff`. It must add no
further generated change beyond the already-reviewed contract outputs. Review
the generated file list for both platforms because the root script regenerates
both even when only one contract changed.

Check every changed `pubspec.yaml`, public package `CHANGELOG.md`, documentation
page, example manifest or plist, and migration note required by the public or
platform change. Do not bump package versions as an incidental feature step;
versioning belongs to the release workflow.

Finish when `git diff --check` passes, no generated file contains a hand edit,
all applicable commands report success, and the handoff distinguishes automated
tests, static native checks, manual native evidence, and unverified behavior.
