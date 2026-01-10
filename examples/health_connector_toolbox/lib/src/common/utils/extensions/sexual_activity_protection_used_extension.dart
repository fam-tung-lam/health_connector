import 'package:health_connector/health_connector_internal.dart'
    show SexualActivityProtectionUsed;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension methods for [SexualActivityProtectionUsed] to provide
/// UI support.
extension SexualActivityProtectionUsedTypeExtension
    on SexualActivityProtectionUsed {
  /// Returns a user-friendly display name for this protection used value.
  String get displayName {
    return switch (this) {
      SexualActivityProtectionUsed.protected => AppTexts.protected,
      SexualActivityProtectionUsed.unprotected => AppTexts.unprotected,
      SexualActivityProtectionUsed.unknown => AppTexts.unknown,
    };
  }
}
