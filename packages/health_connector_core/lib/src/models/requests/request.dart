import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:meta/meta.dart';

/// Base abstract class for all request types.
///
/// ## Example
///
/// ```dart
/// final class MyRequest extends Request {
///   // Implementation
/// }
/// ```
///
/// @nodoc
@sinceV1_0_0
@internal
@immutable
abstract class Request {
  /// Creates a base request.
  const Request();
}
