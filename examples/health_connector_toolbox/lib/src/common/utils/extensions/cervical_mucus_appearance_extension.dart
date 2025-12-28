import 'package:health_connector/health_connector_internal.dart'
    show CervicalMucusAppearanceType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension methods for [CervicalMucusAppearanceType] to provide UI support.
extension CervicalMucusAppearanceExtension on CervicalMucusAppearanceType {
  /// Returns a user-friendly display name for this appearance value.
  String get displayName {
    return switch (this) {
      CervicalMucusAppearanceType.unknown => AppTexts.unknown,
      CervicalMucusAppearanceType.dry => AppTexts.dry,
      CervicalMucusAppearanceType.sticky => AppTexts.sticky,
      CervicalMucusAppearanceType.creamy => AppTexts.creamy,
      CervicalMucusAppearanceType.watery => AppTexts.watery,
      CervicalMucusAppearanceType.eggWhite => AppTexts.eggWhite,
      CervicalMucusAppearanceType.unusual => AppTexts.unusual,
    };
  }
}
