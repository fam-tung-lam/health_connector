import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart' show internal;

/// Represents the operating system platforms supported by the health connector.
@sinceV1_0_0
@internal
enum OperatingSystem {
  /// Apple's iOS operating system.
  iOS,

  /// Google's Android operating system.
  android,
}
