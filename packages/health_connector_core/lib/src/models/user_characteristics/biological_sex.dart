import 'package:health_connector_core/src/annotations/annotations.dart';

/// Biological sex as reported by Apple Health.
///
/// Unset or unreadable values are represented by null.
///
/// {@category Core API}
@sinceV3_14_0
enum BiologicalSex {
  /// Female.
  female,

  /// Male.
  male,

  /// A value other than female or male.
  other,
}
