import 'package:health_connector/health_connector_internal.dart'
    show CervicalMucusSensation;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension methods for [CervicalMucusSensation] to provide UI support.
extension CervicalMucusSensationExtension on CervicalMucusSensation {
  /// Returns a user-friendly display name for this sensation value.
  String get displayName {
    return switch (this) {
      CervicalMucusSensation.unknown => AppTexts.unknown,
      CervicalMucusSensation.light => AppTexts.light,
      CervicalMucusSensation.medium => AppTexts.medium,
      CervicalMucusSensation.heavy => AppTexts.heavy,
    };
  }
}
