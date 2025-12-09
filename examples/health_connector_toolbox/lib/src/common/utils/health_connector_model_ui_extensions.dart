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
        BloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType,
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
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        NutritionHealthDataType,
        EnergyNutrientDataType,
        CaffeineNutrientDataType,
        ProteinNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        SaturatedFatNutrientDataType,
        MonounsaturatedFatNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        SugarNutrientDataType,
        CalciumNutrientDataType,
        IronNutrientDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        PhosphorusNutrientDataType,
        PotassiumNutrientDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        ZincNutrientDataType,
        VitaminANutrientDataType,
        VitaminB6NutrientDataType,
        VitaminB12NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        ThiaminNutrientDataType,
        RiboflavinNutrientDataType,
        NiacinNutrientDataType,
        FolateNutrientDataType,
        BiotinNutrientDataType,
        PantothenicAcidNutrientDataType,
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
      BloodPressureHealthDataType _ => AppTexts.bloodPressure,
      SystolicBloodPressureHealthDataType _ => AppTexts.systolicBloodPressure,
      DiastolicBloodPressureHealthDataType _ => AppTexts.diastolicBloodPressure,
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
      SleepSessionHealthDataType _ => AppTexts.sleepSession,
      SleepStageHealthDataType _ => AppTexts.sleepStageRecord,
      NutritionHealthDataType _ => AppTexts.nutrition,
      EnergyNutrientDataType _ => AppTexts.energy,
      CaffeineNutrientDataType _ => AppTexts.caffeine,
      ProteinNutrientDataType _ => AppTexts.protein,
      TotalCarbohydrateNutrientDataType _ => AppTexts.totalCarbohydrate,
      TotalFatNutrientDataType _ => AppTexts.totalFat,
      SaturatedFatNutrientDataType _ => AppTexts.saturatedFat,
      MonounsaturatedFatNutrientDataType _ => AppTexts.monounsaturatedFat,
      PolyunsaturatedFatNutrientDataType _ => AppTexts.polyunsaturatedFat,
      CholesterolNutrientDataType _ => AppTexts.cholesterol,
      DietaryFiberNutrientDataType _ => AppTexts.dietaryFiber,
      SugarNutrientDataType _ => AppTexts.sugar,
      CalciumNutrientDataType _ => AppTexts.calcium,
      IronNutrientDataType _ => AppTexts.iron,
      MagnesiumNutrientDataType _ => AppTexts.magnesium,
      ManganeseNutrientDataType _ => AppTexts.manganese,
      PhosphorusNutrientDataType _ => AppTexts.phosphorus,
      PotassiumNutrientDataType _ => AppTexts.potassium,
      SeleniumNutrientDataType _ => AppTexts.selenium,
      SodiumNutrientDataType _ => AppTexts.sodium,
      ZincNutrientDataType _ => AppTexts.zinc,
      VitaminANutrientDataType _ => AppTexts.vitaminA,
      VitaminB6NutrientDataType _ => AppTexts.vitaminB6,
      VitaminB12NutrientDataType _ => AppTexts.vitaminB12,
      VitaminCNutrientDataType _ => AppTexts.vitaminC,
      VitaminDNutrientDataType _ => AppTexts.vitaminD,
      VitaminENutrientDataType _ => AppTexts.vitaminE,
      VitaminKNutrientDataType _ => AppTexts.vitaminK,
      ThiaminNutrientDataType _ => AppTexts.thiamin,
      RiboflavinNutrientDataType _ => AppTexts.riboflavin,
      NiacinNutrientDataType _ => AppTexts.niacin,
      FolateNutrientDataType _ => AppTexts.folate,
      BiotinNutrientDataType _ => AppTexts.biotin,
      PantothenicAcidNutrientDataType _ => AppTexts.pantothenicAcid,
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
      BloodPressureHealthDataType _ => AppTexts.bloodPressureDescription,
      SystolicBloodPressureHealthDataType _ =>
        AppTexts.systolicBloodPressureDescription,
      DiastolicBloodPressureHealthDataType _ =>
        AppTexts.diastolicBloodPressureDescription,
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
      SleepSessionHealthDataType _ => AppTexts.sleepSessionDescription,
      SleepStageHealthDataType _ => AppTexts.sleepStageRecordDescription,
      NutritionHealthDataType _ => AppTexts.nutritionDescription,
      EnergyNutrientDataType _ => AppTexts.energyDescription,
      CaffeineNutrientDataType _ => AppTexts.caffeineDescription,
      ProteinNutrientDataType _ => AppTexts.proteinDescription,
      TotalCarbohydrateNutrientDataType _ =>
        AppTexts.totalCarbohydrateDescription,
      TotalFatNutrientDataType _ => AppTexts.totalFatDescription,
      SaturatedFatNutrientDataType _ => AppTexts.saturatedFatDescription,
      MonounsaturatedFatNutrientDataType _ =>
        AppTexts.monounsaturatedFatDescription,
      PolyunsaturatedFatNutrientDataType _ =>
        AppTexts.polyunsaturatedFatDescription,
      CholesterolNutrientDataType _ => AppTexts.cholesterolDescription,
      DietaryFiberNutrientDataType _ => AppTexts.dietaryFiberDescription,
      SugarNutrientDataType _ => AppTexts.sugarDescription,
      CalciumNutrientDataType _ => AppTexts.calciumDescription,
      IronNutrientDataType _ => AppTexts.ironDescription,
      MagnesiumNutrientDataType _ => AppTexts.magnesiumDescription,
      ManganeseNutrientDataType _ => AppTexts.manganeseDescription,
      PhosphorusNutrientDataType _ => AppTexts.phosphorusDescription,
      PotassiumNutrientDataType _ => AppTexts.potassiumDescription,
      SeleniumNutrientDataType _ => AppTexts.seleniumDescription,
      SodiumNutrientDataType _ => AppTexts.sodiumDescription,
      ZincNutrientDataType _ => AppTexts.zincDescription,
      VitaminANutrientDataType _ => AppTexts.vitaminADescription,
      VitaminB6NutrientDataType _ => AppTexts.vitaminB6Description,
      VitaminB12NutrientDataType _ => AppTexts.vitaminB12Description,
      VitaminCNutrientDataType _ => AppTexts.vitaminCDescription,
      VitaminDNutrientDataType _ => AppTexts.vitaminDDescription,
      VitaminENutrientDataType _ => AppTexts.vitaminEDescription,
      VitaminKNutrientDataType _ => AppTexts.vitaminKDescription,
      ThiaminNutrientDataType _ => AppTexts.thiaminDescription,
      RiboflavinNutrientDataType _ => AppTexts.riboflavinDescription,
      NiacinNutrientDataType _ => AppTexts.niacinDescription,
      FolateNutrientDataType _ => AppTexts.folateDescription,
      BiotinNutrientDataType _ => AppTexts.biotinDescription,
      PantothenicAcidNutrientDataType _ => AppTexts.pantothenicAcidDescription,
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
      BloodPressureHealthDataType _ => AppIcons.bloodPressure,
      SystolicBloodPressureHealthDataType _ => AppIcons.bloodPressure,
      DiastolicBloodPressureHealthDataType _ => AppIcons.bloodPressure,
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
      SleepSessionHealthDataType _ => AppIcons.bedtime,
      SleepStageHealthDataType _ => AppIcons.bedtime,
      NutritionHealthDataType _ => AppIcons.fastfood,
      EnergyNutrientDataType _ => AppIcons.localFireDepartment,
      CaffeineNutrientDataType _ => AppIcons.fastfood,
      ProteinNutrientDataType _ => AppIcons.fastfood,
      TotalCarbohydrateNutrientDataType _ => AppIcons.fastfood,
      TotalFatNutrientDataType _ => AppIcons.fastfood,
      SaturatedFatNutrientDataType _ => AppIcons.fastfood,
      MonounsaturatedFatNutrientDataType _ => AppIcons.fastfood,
      PolyunsaturatedFatNutrientDataType _ => AppIcons.fastfood,
      CholesterolNutrientDataType _ => AppIcons.fastfood,
      DietaryFiberNutrientDataType _ => AppIcons.fastfood,
      SugarNutrientDataType _ => AppIcons.fastfood,
      CalciumNutrientDataType _ => AppIcons.fastfood,
      IronNutrientDataType _ => AppIcons.fastfood,
      MagnesiumNutrientDataType _ => AppIcons.fastfood,
      ManganeseNutrientDataType _ => AppIcons.fastfood,
      PhosphorusNutrientDataType _ => AppIcons.fastfood,
      PotassiumNutrientDataType _ => AppIcons.fastfood,
      SeleniumNutrientDataType _ => AppIcons.fastfood,
      SodiumNutrientDataType _ => AppIcons.fastfood,
      ZincNutrientDataType _ => AppIcons.fastfood,
      VitaminANutrientDataType _ => AppIcons.fastfood,
      VitaminB6NutrientDataType _ => AppIcons.fastfood,
      VitaminB12NutrientDataType _ => AppIcons.fastfood,
      VitaminCNutrientDataType _ => AppIcons.fastfood,
      VitaminDNutrientDataType _ => AppIcons.fastfood,
      VitaminENutrientDataType _ => AppIcons.fastfood,
      VitaminKNutrientDataType _ => AppIcons.fastfood,
      ThiaminNutrientDataType _ => AppIcons.fastfood,
      RiboflavinNutrientDataType _ => AppIcons.fastfood,
      NiacinNutrientDataType _ => AppIcons.fastfood,
      FolateNutrientDataType _ => AppIcons.fastfood,
      BiotinNutrientDataType _ => AppIcons.fastfood,
      PantothenicAcidNutrientDataType _ => AppIcons.fastfood,
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
