import 'package:health_connector/health_connector_internal.dart'
    show SexualActivityProtectionUsedType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension methods for [SexualActivityProtectionUsedType] to provide
/// UI support.
extension SexualActivityProtectionUsedTypeExtension
    on SexualActivityProtectionUsedType {
  /// Returns a user-friendly display name for this protection used value.
  String get displayName {
    return switch (this) {
      SexualActivityProtectionUsedType.protected => AppTexts.protected,
      SexualActivityProtectionUsedType.unprotected => AppTexts.unprotected,
      SexualActivityProtectionUsedType.unknown => AppTexts.unknown,
    };
  }
}
