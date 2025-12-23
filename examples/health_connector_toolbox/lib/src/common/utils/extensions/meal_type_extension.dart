import 'package:health_connector/health_connector.dart' show MealType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension providing display names for [MealType] enum values.
extension MealTypeDisplayName on MealType {
  /// Returns the localized display name for this meal type.
  String get displayName {
    return switch (this) {
      MealType.unknown => AppTexts.unknown,
      MealType.breakfast => AppTexts.mealTypeBreakfast,
      MealType.lunch => AppTexts.mealTypeLunch,
      MealType.dinner => AppTexts.mealTypeDinner,
      MealType.snack => AppTexts.mealTypeSnack,
    };
  }
}
