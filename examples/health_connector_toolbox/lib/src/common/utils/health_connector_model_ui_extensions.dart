import 'package:flutter/material.dart' hide Velocity;
import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregationMetric,
        DeviceType,
        HealthDataPermission,
        HealthDataPermissionAccessType,
        HealthDataType,
        HealthPlatform,
        HealthPlatformFeature,
        HealthPlatformFeatureReadHealthDataHistory,
        HealthPlatformFeatureReadHealthDataInBackground,
        HealthPlatformFeatureStatus,
        Energy,
        Length,
        Mass,
        MeasurementUnit,
        Numeric,
        Percentage,
        PermissionStatus,
        RecordingMethod,
        ActiveCaloriesBurnedHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        DistanceHealthDataType,
        FloorsClimbedHealthDataType,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        LeanBodyMassHealthDataType,
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        BloodGlucose,
        Power,
        Pressure,
        Temperature,
        Velocity,
        Volume;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [HealthPlatformFeature] to provide UI-related properties.
extension HealthPlatformFeatureUI on HealthPlatformFeature {
  /// Returns the display name for this feature.
  String get displayName {
    return switch (this) {
      HealthPlatformFeatureReadHealthDataHistory _ =>
        AppTexts.readHealthDataHistory,
      HealthPlatformFeatureReadHealthDataInBackground _ =>
        AppTexts.readHealthDataInBackground,
    };
  }
}

/// Extension on [HealthPlatformFeatureStatus] to provide UI-related properties.
extension HealthPlatformFeatureStatusUI on HealthPlatformFeatureStatus {
  /// Returns the display name for this feature status.
  String get displayName {
    return switch (this) {
      HealthPlatformFeatureStatus.available => AppTexts.available,
      HealthPlatformFeatureStatus.unavailable => AppTexts.unavailable,
    };
  }
}

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

/// Extension to provide UI-related properties.
extension HealthDataPermissionAccessTypeUI on HealthDataPermissionAccessType {
  /// Returns the display name for this access type.
  String get displayName {
    return switch (this) {
      HealthDataPermissionAccessType.read => AppTexts.read,
      HealthDataPermissionAccessType.write => AppTexts.write,
    };
  }
}

/// Extension on [HealthDataPermission] to provide UI-related properties.
extension HealthDataPermissionUI on HealthDataPermission {
  /// Returns the display name for this permission.
  ///
  /// Combines the data type display name with the access type.
  String get displayName {
    return '${dataType.displayName} - ${accessType.displayName}';
  }
}

/// Extension on [HealthDataType] to provide UI-related properties.
///
/// This extension provides convenient methods to get the display name,
/// description, and icon for each health data type based on the app's
/// design system.
extension HealthDataTypeUI on HealthDataType {
  /// Returns the display name for this health data type.
  ///
  /// This name should be used in UI elements.
  String get displayName {
    return switch (this) {
      StepsHealthDataType _ => AppTexts.steps,
      WeightHealthDataType _ => AppTexts.weight,
      HeightHealthDataType _ => AppTexts.height,
      BodyFatPercentageHealthDataType _ => AppTexts.bodyFatPercentage,
      LeanBodyMassHealthDataType _ => AppTexts.leanBodyMass,
      BodyTemperatureHealthDataType _ => AppTexts.bodyTemperature,
      DistanceHealthDataType _ => AppTexts.distance,
      ActiveCaloriesBurnedHealthDataType _ => AppTexts.activeCaloriesBurned,
      FloorsClimbedHealthDataType _ => AppTexts.floorsClimbed,
      WheelchairPushesHealthDataType _ => AppTexts.wheelchairPushes,
      HydrationHealthDataType _ => AppTexts.hydration,
      HeartRateMeasurementRecordHealthDataType _ => AppTexts.heartRate,
      HeartRateSeriesRecordHealthDataType _ => AppTexts.heartRate,
    };
  }

  /// Returns a description for this health data type.
  ///
  /// This description provides additional context about what the data type
  /// represents and is suitable for subtitle text or tooltips.
  String get description {
    return switch (this) {
      StepsHealthDataType _ => AppTexts.stepsDescription,
      WeightHealthDataType _ => AppTexts.weightDescription,
      HeightHealthDataType _ => AppTexts.heightDescription,
      BodyFatPercentageHealthDataType _ =>
        AppTexts.bodyFatPercentageDescription,
      LeanBodyMassHealthDataType _ => AppTexts.leanBodyMassDescription,
      BodyTemperatureHealthDataType _ => AppTexts.bodyTemperatureDescription,
      DistanceHealthDataType _ => AppTexts.distanceDescription,
      ActiveCaloriesBurnedHealthDataType _ =>
        AppTexts.activeCaloriesBurnedDescription,
      FloorsClimbedHealthDataType _ => AppTexts.floorsClimbedDescription,
      WheelchairPushesHealthDataType _ => AppTexts.wheelchairPushesDescription,
      HydrationHealthDataType _ => AppTexts.hydrationDescription,
      HeartRateMeasurementRecordHealthDataType _ =>
        AppTexts.heartRateRecordDescription,
      HeartRateSeriesRecordHealthDataType _ =>
        AppTexts.heartRateSeriesRecordDescription,
    };
  }

  /// Returns the icon for this health data type.
  ///
  /// This icon should be used consistently across the app to represent
  /// the health data type in UI elements.
  IconData get icon {
    return switch (this) {
      StepsHealthDataType _ => AppIcons.directionsWalk,
      WeightHealthDataType _ => AppIcons.monitorWeight,
      HeightHealthDataType _ => AppIcons.height,
      BodyFatPercentageHealthDataType _ => AppIcons.percent,
      LeanBodyMassHealthDataType _ => AppIcons.monitorWeight,
      BodyTemperatureHealthDataType _ => AppIcons.temperature,
      DistanceHealthDataType _ => AppIcons.straighten,
      ActiveCaloriesBurnedHealthDataType _ => AppIcons.localFireDepartment,
      FloorsClimbedHealthDataType _ => AppIcons.stairs,
      WheelchairPushesHealthDataType _ => AppIcons.accessible,
      HydrationHealthDataType _ => AppIcons.volume,
      HeartRateMeasurementRecordHealthDataType _ => AppIcons.favorite,
      HeartRateSeriesRecordHealthDataType _ => AppIcons.favorite,
    };
  }
}

/// Extension on [RecordingMethod] to provide UI-related properties.
extension RecordingMethodUI on RecordingMethod {
  /// Returns the display name for this recording method.
  String get displayName {
    return switch (this) {
      RecordingMethod.manualEntry => AppTexts.manualEntry,
      RecordingMethod.automaticallyRecorded => AppTexts.automaticallyRecorded,
      RecordingMethod.activelyRecorded => AppTexts.activelyRecorded,
      RecordingMethod.unknown => AppTexts.unknown,
    };
  }

  /// Returns the icon for this recording method.
  IconData get icon {
    return switch (this) {
      RecordingMethod.manualEntry => AppIcons.edit,
      RecordingMethod.automaticallyRecorded => AppIcons.autoAwesome,
      RecordingMethod.activelyRecorded => AppIcons.fitnessCenter,
      RecordingMethod.unknown => AppIcons.helpOutline,
    };
  }
}

/// Extension on [DeviceType] to provide UI-related properties.
extension DeviceTypeUI on DeviceType {
  /// Returns the display name for this device type.
  String get displayName {
    return switch (this) {
      DeviceType.phone => AppTexts.phone,
      DeviceType.watch => AppTexts.watch,
      DeviceType.fitnessBand => AppTexts.fitnessBand,
      DeviceType.ring => AppTexts.ring,
      DeviceType.scale => AppTexts.scale,
      DeviceType.chestStrap => AppTexts.chestStrap,
      DeviceType.headMounted => AppTexts.headMounted,
      DeviceType.smartDisplay => AppTexts.smartDisplay,
      DeviceType.unknown => AppTexts.unknown,
    };
  }

  /// Returns the icon for this device type.
  IconData get icon {
    return switch (this) {
      DeviceType.phone => AppIcons.phone,
      DeviceType.watch => AppIcons.watch,
      DeviceType.fitnessBand => AppIcons.fitnessBand,
      DeviceType.ring => AppIcons.ring,
      DeviceType.scale => AppIcons.scale,
      DeviceType.chestStrap => AppIcons.chestStrap,
      DeviceType.headMounted => AppIcons.headMounted,
      DeviceType.smartDisplay => AppIcons.smartDisplay,
      DeviceType.unknown => AppIcons.helpOutline,
    };
  }
}

/// Extension on [AggregationMetric] to provide UI-related properties.
extension AggregationMetricUI on AggregationMetric {
  /// Returns the display name for this aggregation metric.
  String get displayName {
    return switch (this) {
      AggregationMetric.sum => AppTexts.sum,
      AggregationMetric.avg => AppTexts.average,
      AggregationMetric.min => AppTexts.minimum,
      AggregationMetric.max => AppTexts.maximum,
      AggregationMetric.count => AppTexts.count,
    };
  }

  /// Returns the icon for this aggregation metric.
  IconData get icon {
    return switch (this) {
      AggregationMetric.sum => AppIcons.sum,
      AggregationMetric.avg => AppIcons.avg,
      AggregationMetric.min => AppIcons.min,
      AggregationMetric.max => AppIcons.max,
      AggregationMetric.count => AppIcons.count,
    };
  }
}

/// Extension on [MeasurementUnit] to provide UI-related properties.
extension MeasurementUnitUI on MeasurementUnit {
  /// Returns the display name for this measurement unit.
  String get displayName {
    return switch (this) {
      Mass _ => AppTexts.mass,
      Numeric _ => AppTexts.numeric,
      Percentage _ => AppTexts.percentage,
      Length _ => AppTexts.length,
      Energy _ => AppTexts.energy,
      BloodGlucose _ => AppTexts.bloodGlucose,
      Power _ => AppTexts.power,
      Pressure _ => AppTexts.pressure,
      Temperature _ => AppTexts.temperature,
      Velocity _ => AppTexts.velocity,
      Volume _ => AppTexts.volume,
    };
  }

  /// Returns the icon for this measurement unit.
  IconData get icon {
    return switch (this) {
      Mass _ => AppIcons.mass,
      Numeric _ => AppIcons.numeric,
      Percentage _ => AppIcons.percent,
      Length _ => AppIcons.length,
      Energy _ => AppIcons.energy,
      BloodGlucose _ => AppIcons.bloodGlucose,
      Power _ => AppIcons.power,
      Pressure _ => AppIcons.pressure,
      Temperature _ => AppIcons.temperature,
      Velocity _ => AppIcons.velocity,
      Volume _ => AppIcons.volume,
    };
  }
}

/// Extension on [HealthPlatform] to provide UI-related properties.
extension HealthPlatformUI on HealthPlatform {
  /// Returns the display name for this health platform.
  String get displayName {
    return switch (this) {
      HealthPlatform.appleHealth => AppTexts.appleHealth,
      HealthPlatform.healthConnect => AppTexts.healthConnect,
    };
  }

  /// Returns the icon for this health platform.
  IconData get icon {
    return switch (this) {
      HealthPlatform.appleHealth => AppIcons.apple,
      HealthPlatform.healthConnect => AppIcons.android,
    };
  }
}
