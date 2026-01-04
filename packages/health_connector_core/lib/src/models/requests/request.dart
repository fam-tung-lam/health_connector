import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart' show immutable, internal;

/// Base abstract class for all request types.
///
/// ## Example
///
/// ```dart
/// final class MyRequest extends Request {
///   // Implementation
/// }
/// ```
@sinceV1_0_0
@internal
@immutable
abstract class Request {
  /// Creates a base request.
  const Request();
}
