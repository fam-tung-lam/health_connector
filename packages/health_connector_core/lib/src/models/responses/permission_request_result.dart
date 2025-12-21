import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show Permission, PermissionStatus;
import 'package:health_connector_core/src/models/responses/response.dart'
    show Response;
import 'package:meta/meta.dart' show immutable;

/// Represents the result of a single permission request.
@sinceV1_0_0
@immutable
final class PermissionRequestResult extends Response {
  /// Creates a permission request result.
  ///
  /// Both [permission] and [status] are required and represent the permission
  /// that was requested and its resulting status.
  const PermissionRequestResult({
    required this.permission,
    required this.status,
  });

  /// The permission that was requested.
  final Permission permission;

  /// The status of the permission after the request.
  ///
  /// This indicates whether the permission was granted, denied, or if the
  /// status is unknown (common for read permissions on iOS).
  final PermissionStatus status;
}
