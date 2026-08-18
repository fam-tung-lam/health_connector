# iOS Diagnosis

This reference owns evidence gathering inside the Swift and HealthKit path.

Trace one operation through `HealthConnectorHkIosPlugin`, the
`HealthConnectorClient` actor, the applicable service or registry, the record
handler, its mapper, and `HKHealthStore`.

| Failure                         | Evidence to collect                                                                        |
| ------------------------------- | ------------------------------------------------------------------------------------------ |
| Client creation fails           | `HKHealthStore.isHealthDataAvailable()` and both non-empty usage-description keys          |
| Read authorization is `unknown` | Confirm access type is read; this is the required HealthKit result                         |
| Unsupported record              | OS availability gate, `HealthDataTypeDto` mapping, registry entry, and capability protocol |
| Wrong value or unit             | Record mapper in both directions and the HealthKit unit passed to `doubleValue(for:)`      |
| Unexpected `UNKNOWN_ERROR`      | Original `HKError`, `NSError` domain/code, and the mapper's `@unknown default` branch      |
| Flutter serialization crash     | Every asynchronous plugin path must use `complete(_:with:)` on the main queue              |
| Native logs missing             | Plugin initialization, enabled flag, reverse Pigeon API, and main-thread delivery          |

An empty query cannot distinguish no data from denied read permission. Do not
use it as authorization evidence.

The Swift package currently has no effective native test target and CI runs
SwiftLint without a native test step. `melos run analyze:swift` and
`melos run format:swift:check` provide static evidence only. Use a real device
or a correctly configured simulator/Xcode test for HealthKit behavior and say
which one was used.

If a generated public protocol exposes an internal DTO, inspect the output of
the repository's Swift post-processor. The correction belongs in the script or
Pigeon source, never as a hand-edit to `*.g.swift`.
