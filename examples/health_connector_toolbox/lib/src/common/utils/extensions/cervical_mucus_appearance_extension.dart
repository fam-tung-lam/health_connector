import 'package:health_connector/health_connector_internal.dart'
    show CervicalMucusAppearance;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension methods for [CervicalMucusAppearance] to provide UI support.
extension CervicalMucusAppearanceExtension on CervicalMucusAppearance {
  /// Returns a user-friendly display name for this appearance value.
  String get displayName {
    return switch (this) {
      CervicalMucusAppearance.unknown => AppTexts.unknown,
      CervicalMucusAppearance.dry => AppTexts.dry,
      CervicalMucusAppearance.sticky => AppTexts.sticky,
      CervicalMucusAppearance.creamy => AppTexts.creamy,
      CervicalMucusAppearance.watery => AppTexts.watery,
      CervicalMucusAppearance.eggWhite => AppTexts.eggWhite,
      CervicalMucusAppearance.unusual => AppTexts.unusual,
    };
  }
}
