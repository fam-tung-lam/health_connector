import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart' show immutable, internal;

/// Base abstract class for all response types.
///
/// ## Example
///
/// ```dart
/// final class MyResponse extends Response {
///   // Implementation
/// }
/// ```
@sinceV1_0_0
@internal
@immutable
abstract class Response {
  /// Creates a base response.
  const Response();
}
