import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// UI extensions for [HealthDataTypeCategory].
extension HealthDataTypeCategoryUiExtension on HealthDataTypeCategory {
  /// Returns the localized display name for the category.
  String get displayName {
    return switch (this) {
      HealthDataTypeCategory.activity => AppTexts.activityCategory,
      HealthDataTypeCategory.bodyMeasurement =>
        AppTexts.bodyMeasurementCategory,
      HealthDataTypeCategory.clinical => AppTexts.clinicalCategory,
      HealthDataTypeCategory.mentalHealth => AppTexts.mentalHealthCategory,
      HealthDataTypeCategory.mobility => AppTexts.mobilityCategory,
      HealthDataTypeCategory.nutrition => AppTexts.nutritionCategory,
      HealthDataTypeCategory.reproductiveHealth =>
        AppTexts.reproductiveHealthCategory,
      HealthDataTypeCategory.sleep => AppTexts.sleepCategory,
      HealthDataTypeCategory.vitals => AppTexts.vitalsCategory,
    };
  }

  /// Returns the icon for the category.
  IconData get icon {
    return switch (this) {
      HealthDataTypeCategory.activity => Icons.directions_run,
      HealthDataTypeCategory.bodyMeasurement => Icons.accessibility_new,
      HealthDataTypeCategory.clinical => Icons.medical_services,
      HealthDataTypeCategory.mentalHealth => Icons.psychology,
      HealthDataTypeCategory.mobility => Icons.assist_walker,
      HealthDataTypeCategory.nutrition => Icons.restaurant,
      HealthDataTypeCategory.reproductiveHealth => Icons.favorite,
      HealthDataTypeCategory.sleep => Icons.bedtime,
      HealthDataTypeCategory.vitals => Icons.monitor_heart,
    };
  }
}
