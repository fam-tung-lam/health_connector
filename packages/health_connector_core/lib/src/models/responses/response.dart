import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:meta/meta.dart';

/// Base abstract class for all response types.
///
/// ## Example
///
/// ```dart
/// final class MyResponse extends Response {
///   // Implementation
/// }
/// ```
///
/// @nodoc
@sinceV1_0_0
@internal
@immutable
abstract class Response {
  /// Creates a base response.
  const Response();
}
