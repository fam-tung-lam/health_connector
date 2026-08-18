# Dart and Channel Diagnosis

This reference owns the checks from the public facade through the Dart platform
client and committed Pigeon output.

## Trace the request

1. Start at the `HealthConnector` member and its implementation in
   `health_connector_impl.dart`. Confirm platform selection, validation,
   `supportedHealthPlatforms`, and any explicit unsupported branch.
2. Follow the `HealthConnectorPlatformClient` call into
   `HealthConnectorHCClient` or `HealthConnectorHKClient`. Confirm the domain
   request is mapped once and sent to the expected generated API method.
3. Compare the editable platform `pigeon/*_api.dart` declaration with the
   committed `*.g.dart` and native generated file. Diagnose drift without
   running `melos run pigeon`, because that command rewrites tracked files.
4. Trace the response DTO through `toDomain()`. Check timestamps, units, enum
   direction, identifiers, paging fields, and error-code mapping.

Use exhaustive dispatchers as evidence. A missing Dart enum case normally fails
analysis. A missing Swift dispatch case can survive compilation and fail only at
runtime.

## Isolate Dart behavior

Run a single mapper or client test from its package:

```bash
fvm flutter test test/unit_tests/src/mappers/<subject>_test.dart
fvm flutter test test/unit_tests/src/<client>_test.dart
```

The core package uses `test/src/` rather than `test/unit_tests/src/`. Platform
package tests replace the generated API through the client's static
`platformClient` seam; they prove Dart mapping and delegation, not native code.

## Read the public failure

Record the concrete `HealthConnectorException`, its `code`, message, details,
and stack trace. Compare its code with the native DTO. A changed or unknown code
points to a cross-language mapper mismatch. A correct unsupported code points
back to platform support, registry reachability, or capability conformance.

If the Dart test passes but a device fails, the fault is beyond the mocked
Pigeon seam. Continue in the native route instead of adding more Dart mocks.
