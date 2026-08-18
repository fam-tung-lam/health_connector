---
name: ptlam-health-connector-debug
description:
  Diagnose Health Connector SDK failures by reproducing the narrowest Dart,
  Pigeon, Android Health Connect, or iOS HealthKit path and tracing logs, error
  codes, generated contracts, handlers, permissions, and platform prerequisites
  to one failing boundary. Use when a call throws, returns the wrong record or
  status, hangs, crashes, loses native logs, or behaves differently across
  platforms. Do not use for toolchain bootstrap, style checks, or a review of an
  otherwise-working changeset.
---

# PTLam Health Connector Debugging

Diagnose one failing Health Connector behavior and return an evidence-backed
root cause, failing boundary, and smallest corrective direction. Keep diagnosis
read-only. Apply a fix only when the user separately asks for one.

## Required skills

### `ptlam-health-connector-architecture`

**Reason:** Supplies the package, channel, native-layer, and platform-boundary model needed to locate a failure without duplicating architecture.

**Instructions:** Read and apply ptlam-health-connector-architecture first.
Let it own package boundaries, call paths, Pigeon ownership, native
layers, failure translation, concurrency, and platform constraints.
Use this skill only to gather runtime evidence, isolate the failing
boundary, and report the diagnosis.

Read [ptlam-health-connector-architecture](skills/ptlam-health-connector-architecture/SKILL.md).

## First moves

1. Capture the operation, platform, OS version, device or simulator, data type,
   expected result, actual result, public exception and code, and the smallest
   reproduction. Done when the failure is repeatable or the missing evidence is
   explicit.
2. Run the narrowest existing test or example path. Use a package-local
   `fvm flutter test <path>` for Dart and `melos run test:kotlin` for Kotlin;
   the Kotlin task must run through the example app. Done when one command or
   user action demonstrates the symptom.
3. Enable both Dart and native structured logs in the reproducing app:

   ```dart
   const config = HealthConnectorConfig(
     loggerConfig: HealthConnectorLoggerConfig(
       enableNativeLogging: true,
       logProcessors: [DeveloperLogProcessor()],
     ),
   );
   final connector = await HealthConnector.create(config);
   ```

   Preserve logs around the first failing operation. Do not add health values,
   record identifiers, or user-owned timestamps to diagnostic output.

4. Trace the call and response through
   [Dart and the channel](references/dart-and-channel.md), then read the
   applicable [Android](references/android.md) or [iOS](references/ios.md)
   route. Stop at the first layer whose input is correct and output, completion,
   or failure mapping is wrong.

## Match the symptom

| Symptom                                                 | First boundary to inspect                                                                                |
| ------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `create()` reports unavailable or update required       | Platform-status call and native client creation                                                          |
| `PERMISSION_NOT_DECLARED`                               | Host `AndroidManifest.xml` or iOS usage descriptions                                                     |
| A read permission is always `unknown` on iOS            | Expected HealthKit privacy behavior, not a denial heuristic                                              |
| `UNSUPPORTED_OPERATION` for a supported type            | Dart `supportedHealthPlatforms`, Pigeon enum, native registry, then capability conformance               |
| Wrong fields or units                                   | Domain-to-DTO mapper, native mapper, then reverse path                                                   |
| A new DTO or method is absent after editing Pigeon      | Contract and committed generated files are out of step                                                   |
| Native logs never reach Dart                            | Logger config, native enabled flag, and reverse Pigeon API setup                                         |
| Android test cannot resolve Flutter classes             | Test was run in the plugin module instead of through the example app                                     |
| iOS `EXC_BAD_ACCESS` near Flutter channel serialization | An asynchronous completion bypassed the main-thread helper                                               |
| A call hangs                                            | Missing callback/completion, cancelled scope or task, detached activity, or unresolved permission result |

## Return the diagnosis

Report the reproduction, observed evidence, last correct boundary, first wrong
boundary, root cause or leading hypothesis, and one discriminating next check
when evidence is incomplete. Separate source findings from runtime findings.

Finish when the report explains why the symptom appears on the named platform,
accounts for the public error or missing completion, and states which checks
were unavailable. Do not describe a guessed fix as verified.
