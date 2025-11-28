import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart' show immutable, internal, mustBeOverridden;

/// Base abstract class for all request types.
///
/// This class provides a common interface for all request objects in the
/// health connector API. All request classes should extend this base class.
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

  @override
  @mustBeOverridden
  String toString();
}
