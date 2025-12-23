import 'package:health_connector/health_connector.dart' show PermissionStatus;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [PermissionStatus] to provide UI-related properties.
extension PermissionStatusUI on PermissionStatus {
  /// Returns the display name for this status.
  String get displayName {
    return switch (this) {
      PermissionStatus.granted => AppTexts.granted,
      PermissionStatus.denied => AppTexts.denied,
      PermissionStatus.unknown => AppTexts.unknown,
    };
  }
}
