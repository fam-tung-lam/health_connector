# Dart Test Conventions

This reference owns Dart test placement, imports, fixtures, and local double
mechanics in Health Connector.

| Package                       | Mirrored source root   | Shared fixtures          |
| ----------------------------- | ---------------------- | ------------------------ |
| `health_connector_core`       | `test/src/`            | `test/utils/`            |
| `health_connector`            | `test/unit_tests/src/` | `test/unit_tests/utils/` |
| `health_connector_hc_android` | `test/unit_tests/src/` | `test/unit_tests/utils/` |
| `health_connector_hk_ios`     | `test/unit_tests/src/` | `test/unit_tests/utils/` |
| `health_connector_logger`     | `test/unit_tests/src/` | `test/utils/`            |

Name a file `<subject>_test.dart` and mirror its `lib/src/` path. Use
`package:test/test.dart` in core, facade, and logger tests. Platform-package
tests use `package:flutter_test/flutter_test.dart` because channel types need
the Flutter binding.

Reuse the package's `fake_data.dart` instead of creating per-file constants. The
mapper suites use `parameterized_test` for exhaustive enum and measurement-unit
tables. Platform-client suites use Mocktail at the generated API seam and
register their non-primitive fallback DTOs in `setUpAll`.

Reset mutable static seams in `setUp`, not `setUpAll`. The established seams
replace the platform client behind the facade or the generated Pigeon API behind
one Dart platform client. Call `TestWidgetsFlutterBinding.ensureInitialized()`
when an `EventChannel` or another binding-owned type is involved.

Mapper tests compare DTO fields because generated DTOs have no domain value
equality. Domain record tests may compare whole values.

Run a focused file with `fvm flutter test <path>`, then run
`melos run test:dart` from the monorepo root.
