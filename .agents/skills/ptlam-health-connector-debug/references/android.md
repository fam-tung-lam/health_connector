# Android Diagnosis

This reference owns evidence gathering inside the Kotlin and Health Connect
path.

Trace one operation through `HealthConnectorHCAndroidPlugin`,
`HealthConnectorClient`, the applicable service or registry, the record handler,
its mapper, and `HealthConnectClient`. Inspect the structured log tag and
operation at each boundary; the first missing success record narrows the fault.

| Failure                                | Evidence to collect                                                              |
| -------------------------------------- | -------------------------------------------------------------------------------- |
| Platform unavailable                   | `HealthConnectClient.getSdkStatus`, installed Health Connect version, device API |
| Permission not declared                | Host app's merged manifest and mapped `android.permission.health.*` string       |
| Permission request fails or hangs      | Attached activity type, activity lifecycle, and activity-result completion       |
| Unsupported record                     | `HealthDataTypeDto`, registry entry, and required handler capability interface   |
| Invalid argument from valid Dart input | DTO-to-Health-Connect mapper and handler failure wrapper                         |
| Field disappears on old devices        | Stored SDK-extension support flag and mapper gate                                |
| Cancellation becomes unknown error     | Ordering of `CancellationException` before a generic catch                       |

The host activity must be a `ComponentActivity`; the example uses
`FlutterFragmentActivity`. A null activity during detachment or configuration
change is expected state and must become a classified configuration failure.

Run native tests only through:

```bash
melos run test:kotlin
```

For a single class, pass a Gradle test filter from the example app only after
resolving its exact fully qualified test name. The plugin module alone lacks the
Flutter embedding supplied by the example build.

Prefer the existing `FakeHealthConnectClient` evidence over a new mock. Confirm
that the handler's injected dispatcher is controlled by the test and that the
global logger and mocks are reset between cases.
