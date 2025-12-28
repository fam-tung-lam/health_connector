import 'package:health_connector/health_connector_internal.dart'
    show CervicalMucusSensationType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension methods for [CervicalMucusSensationType] to provide UI support.
extension CervicalMucusSensationExtension on CervicalMucusSensationType {
  /// Returns a user-friendly display name for this sensation value.
  String get displayName {
    return switch (this) {
      CervicalMucusSensationType.unknown => AppTexts.unknown,
      CervicalMucusSensationType.light => AppTexts.light,
      CervicalMucusSensationType.medium => AppTexts.medium,
      CervicalMucusSensationType.heavy => AppTexts.heavy,
    };
  }
}
