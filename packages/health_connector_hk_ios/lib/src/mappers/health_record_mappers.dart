import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        BloodPressureRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DiastolicBloodPressureRecord,
        DistanceRecord,
        Energy,
        FloorsClimbedRecord,
        HealthRecord,
        HealthRecordId,
        HeartRateMeasurement,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        LeanBodyMassRecord,
        Length,
        Mass,
        Numeric,
        Percentage,
        Pressure,
        SleepSessionRecord,
        SleepStageRecord,
        StepRecord,
        SystolicBloodPressureRecord,
        Temperature,
        Volume,
        WeightRecord,
        WheelchairPushesRecord,
        SleepStageType,
        MealType,
        CaffeineNutrientRecord,
        NutritionRecord,
        EnergyNutrientRecord,
        ProteinNutrientRecord,
        TotalCarbohydrateNutrientRecord,
        TotalFatNutrientRecord,
        SaturatedFatNutrientRecord,
        MonounsaturatedFatNutrientRecord,
        PolyunsaturatedFatNutrientRecord,
        CholesterolNutrientRecord,
        DietaryFiberNutrientRecord,
        SugarNutrientRecord,
        CalciumNutrientRecord,
        IronNutrientRecord,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        PhosphorusNutrientRecord,
        PotassiumNutrientRecord,
        SeleniumNutrientRecord,
        SodiumNutrientRecord,
        ZincNutrientRecord,
        VitaminANutrientRecord,
        VitaminB6NutrientRecord,
        VitaminB12NutrientRecord,
        VitaminCNutrientRecord,
        VitaminDNutrientRecord,
        VitaminENutrientRecord,
        VitaminKNutrientRecord,
        ThiaminNutrientRecord,
        RiboflavinNutrientRecord,
        NiacinNutrientRecord,
        FolateNutrientRecord,
        BiotinNutrientRecord,
        PantothenicAcidNutrientRecord;
import 'package:health_connector_hk_ios/src/mappers/blood_pressure_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/meal_type_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/'
    'measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BiotinNutrientRecordDto,
        BloodPressureRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        CaffeineNutrientRecordDto,
        CalciumNutrientRecordDto,
        CholesterolNutrientRecordDto,
        DiastolicBloodPressureRecordDto,
        DietaryFiberNutrientRecordDto,
        DistanceRecordDto,
        EnergyDto,
        EnergyNutrientRecordDto,
        FloorsClimbedRecordDto,
        FolateNutrientRecordDto,
        HealthRecordDto,
        HeartRateMeasurementDto,
        HeartRateMeasurementRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        IronNutrientRecordDto,
        LeanBodyMassRecordDto,
        LengthDto,
        MagnesiumNutrientRecordDto,
        ManganeseNutrientRecordDto,
        MassDto,
        MonounsaturatedFatNutrientRecordDto,
        NiacinNutrientRecordDto,
        NumericDto,
        NutritionRecordDto,
        PantothenicAcidNutrientRecordDto,
        PercentageDto,
        PhosphorusNutrientRecordDto,
        PolyunsaturatedFatNutrientRecordDto,
        PotassiumNutrientRecordDto,
        PressureDto,
        ProteinNutrientRecordDto,
        RiboflavinNutrientRecordDto,
        SaturatedFatNutrientRecordDto,
        SeleniumNutrientRecordDto,
        SleepStageRecordDto,
        SleepStageTypeDto,
        SodiumNutrientRecordDto,
        StepRecordDto,
        SugarNutrientRecordDto,
        SystolicBloodPressureRecordDto,
        TemperatureDto,
        ThiaminNutrientRecordDto,
        TotalCarbohydrateNutrientRecordDto,
        TotalFatNutrientRecordDto,
        VitaminANutrientRecordDto,
        VitaminB12NutrientRecordDto,
        VitaminB6NutrientRecordDto,
        VitaminCNutrientRecordDto,
        VitaminDNutrientRecordDto,
        VitaminENutrientRecordDto,
        VitaminKNutrientRecordDto,
        VolumeDto,
        WeightRecordDto,
        WheelchairPushesRecordDto,
        ZincNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecordId] to [String] for DTO transfer.
@internal
extension HealthRecordIdFromDomainToDto on HealthRecordId {
  String toDto() => value;
}

/// Converts [String] to [HealthRecordId].
@internal
extension HealthRecordIdFromDtoToDomain on String {
  HealthRecordId toDomain() {
    if (this == HealthRecordId.none.value) {
      return HealthRecordId.none;
    }
    return HealthRecordId(this);
  }
}

/// Converts [HeartRateMeasurement] to [HeartRateMeasurementDto].
@internal
extension HeartRateMeasurementDomainToDto on HeartRateMeasurement {
  HeartRateMeasurementDto toDto() {
    return HeartRateMeasurementDto(
      time: time.millisecondsSinceEpoch,
      beatsPerMinute: beatsPerMinute.toDto() as NumericDto,
    );
  }
}

/// Converts [HeartRateMeasurementDto] to [HeartRateMeasurement].
@internal
extension HeartRateMeasurementDtoToDomain on HeartRateMeasurementDto {
  HeartRateMeasurement toDomain() {
    return HeartRateMeasurement(
      time: DateTime.fromMillisecondsSinceEpoch(time),
      beatsPerMinute: beatsPerMinute.toDomain() as Numeric,
    );
  }
}

/// Converts [HealthRecord] to [HealthRecordDto].
@internal
extension HealthRecordToDto on HealthRecord {
  HealthRecordDto toDto() {
    switch (this) {
      case final ActiveCaloriesBurnedRecord record:
        return ActiveCaloriesBurnedRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds:
              record.startZoneOffsetSeconds ?? record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          energy: record.energy.toDto() as EnergyDto,
        );
      case final DistanceRecord record:
        return DistanceRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          distance: record.distance.toDto() as LengthDto,
        );
      case final FloorsClimbedRecord record:
        return FloorsClimbedRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          floors: record.floors.toDto() as NumericDto,
        );
      case final StepRecord record:
        return StepRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          count: record.count.toDto() as NumericDto,
        );
      case final WeightRecord record:
        return WeightRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          weight: record.weight.toDto() as MassDto,
        );
      case final LeanBodyMassRecord record:
        return LeanBodyMassRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          mass: record.mass.toDto() as MassDto,
        );
      case final HeightRecord record:
        return HeightRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          height: record.height.toDto() as LengthDto,
        );
      case final BodyFatPercentageRecord record:
        return BodyFatPercentageRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          percentage: record.percentage.toDto() as PercentageDto,
        );
      case final BodyTemperatureRecord record:
        return BodyTemperatureRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          temperature: record.temperature.toDto() as TemperatureDto,
        );
      case final HydrationRecord record:
        return HydrationRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          volume: record.volume.toDto() as VolumeDto,
        );
      case final WheelchairPushesRecord record:
        return WheelchairPushesRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.startZoneOffsetSeconds,

          metadata: record.metadata.toDto(),
          pushes: record.pushes.toDto() as NumericDto,
        );
      case final HeartRateMeasurementRecord record:
        return HeartRateMeasurementRecordDto(
          id: record.id.toDto(),
          time: record.measurement.time.millisecondsSinceEpoch,
          metadata: record.metadata.toDto(),
          measurement: record.measurement.toDto(),
        );
      case final SleepStageRecord record:
        return SleepStageRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          metadata: metadata.toDto(),
          stageType: record.stageType.toDto(),
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
        );
      // Combined nutrition record (maps to HKCorrelation.food on iOS)
      case final NutritionRecord record:
        return NutritionRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          metadata: record.metadata.toDto(),
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
          // Energy
          energy: record.energy?.toDto() as EnergyDto?,
          // Macronutrients
          protein: record.protein?.toDto() as MassDto?,
          totalCarbohydrate: record.totalCarbohydrate?.toDto() as MassDto?,
          totalFat: record.totalFat?.toDto() as MassDto?,
          saturatedFat: record.saturatedFat?.toDto() as MassDto?,
          monounsaturatedFat: record.monounsaturatedFat?.toDto() as MassDto?,
          polyunsaturatedFat: record.polyunsaturatedFat?.toDto() as MassDto?,
          cholesterol: record.cholesterol?.toDto() as MassDto?,
          dietaryFiber: record.dietaryFiber?.toDto() as MassDto?,
          sugar: record.sugar?.toDto() as MassDto?,
          // Vitamins
          vitaminA: record.vitaminA?.toDto() as MassDto?,
          vitaminB6: record.vitaminB6?.toDto() as MassDto?,
          vitaminB12: record.vitaminB12?.toDto() as MassDto?,
          vitaminC: record.vitaminC?.toDto() as MassDto?,
          vitaminD: record.vitaminD?.toDto() as MassDto?,
          vitaminE: record.vitaminE?.toDto() as MassDto?,
          vitaminK: record.vitaminK?.toDto() as MassDto?,
          thiamin: record.thiamin?.toDto() as MassDto?,
          riboflavin: record.riboflavin?.toDto() as MassDto?,
          niacin: record.niacin?.toDto() as MassDto?,
          folate: record.folate?.toDto() as MassDto?,
          biotin: record.biotin?.toDto() as MassDto?,
          pantothenicAcid: record.pantothenicAcid?.toDto() as MassDto?,
          // Minerals
          calcium: record.calcium?.toDto() as MassDto?,
          iron: record.iron?.toDto() as MassDto?,
          magnesium: record.magnesium?.toDto() as MassDto?,
          manganese: record.manganese?.toDto() as MassDto?,
          phosphorus: record.phosphorus?.toDto() as MassDto?,
          potassium: record.potassium?.toDto() as MassDto?,
          selenium: record.selenium?.toDto() as MassDto?,
          sodium: record.sodium?.toDto() as MassDto?,
          zinc: record.zinc?.toDto() as MassDto?,
          // Other
          caffeine: record.caffeine?.toDto() as MassDto?,
        );

      // MARK: Nutrients - Domain to DTO

      case final EnergyNutrientRecord record:
        return EnergyNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as EnergyDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final CaffeineNutrientRecord record:
        return CaffeineNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final ProteinNutrientRecord record:
        return ProteinNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final TotalCarbohydrateNutrientRecord record:
        return TotalCarbohydrateNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final TotalFatNutrientRecord record:
        return TotalFatNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final SaturatedFatNutrientRecord record:
        return SaturatedFatNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final MonounsaturatedFatNutrientRecord record:
        return MonounsaturatedFatNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final PolyunsaturatedFatNutrientRecord record:
        return PolyunsaturatedFatNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final CholesterolNutrientRecord record:
        return CholesterolNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final DietaryFiberNutrientRecord record:
        return DietaryFiberNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final SugarNutrientRecord record:
        return SugarNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final VitaminANutrientRecord record:
        return VitaminANutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final VitaminB6NutrientRecord record:
        return VitaminB6NutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final VitaminB12NutrientRecord record:
        return VitaminB12NutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final VitaminCNutrientRecord record:
        return VitaminCNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final VitaminDNutrientRecord record:
        return VitaminDNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final VitaminENutrientRecord record:
        return VitaminENutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final VitaminKNutrientRecord record:
        return VitaminKNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );
      case final ThiaminNutrientRecord record:
        return ThiaminNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final RiboflavinNutrientRecord record:
        return RiboflavinNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final NiacinNutrientRecord record:
        return NiacinNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final FolateNutrientRecord record:
        return FolateNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final BiotinNutrientRecord record:
        return BiotinNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final PantothenicAcidNutrientRecord record:
        return PantothenicAcidNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final CalciumNutrientRecord record:
        return CalciumNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final IronNutrientRecord record:
        return IronNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final MagnesiumNutrientRecord record:
        return MagnesiumNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final ManganeseNutrientRecord record:
        return ManganeseNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final PhosphorusNutrientRecord record:
        return PhosphorusNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final PotassiumNutrientRecord record:
        return PotassiumNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final SeleniumNutrientRecord record:
        return SeleniumNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final SodiumNutrientRecord record:
        return SodiumNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );

      case final ZincNutrientRecord record:
        return ZincNutrientRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          value: record.value.toDto() as MassDto,
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
        );
      case final SleepSessionRecord _:
        throw UnsupportedError(
          'SleepSessionRecord is not supported on iOS. '
          'Use SleepStageRecord instead.',
        );
      case final HeartRateSeriesRecord _:
        throw UnsupportedError(
          'HeartRateSeriesRecord is not supported on iOS. '
          'Use HeartRateMeasurementRecord instead.',
        );
      case final BloodPressureRecord record:
        return BloodPressureRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          systolic: record.systolic.toDto() as PressureDto,
          diastolic: record.diastolic.toDto() as PressureDto,
          bodyPosition: record.bodyPosition.toDto(),
          measurementLocation: record.measurementLocation.toDto(),
        );
      case final SystolicBloodPressureRecord record:
        return SystolicBloodPressureRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          pressure: record.pressure.toDto() as PressureDto,
        );
      case final DiastolicBloodPressureRecord record:
        return DiastolicBloodPressureRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          pressure: record.pressure.toDto() as PressureDto,
        );
    }
  }
}

/// Converts [HealthRecordDto] to [HealthRecord].
@internal
extension HealthRecordDtoToDomain on HealthRecordDto {
  HealthRecord toDomain() {
    switch (this) {
      case final ActiveCaloriesBurnedRecordDto dto:
        return ActiveCaloriesBurnedRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          energy: dto.energy.toDomain() as Energy,
        );
      case final DistanceRecordDto dto:
        return DistanceRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          distance: dto.distance.toDomain() as Length,
        );
      case final FloorsClimbedRecordDto dto:
        return FloorsClimbedRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          floors: dto.floors.toDomain() as Numeric,
        );
      case final StepRecordDto dto:
        return StepRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          count: dto.count.toDomain() as Numeric,
        );
      case final WeightRecordDto dto:
        return WeightRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          weight: dto.weight.toDomain() as Mass,
        );
      case final LeanBodyMassRecordDto dto:
        return LeanBodyMassRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          mass: dto.mass.toDomain() as Mass,
        );
      case final HeightRecordDto dto:
        return HeightRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          height: dto.height.toDomain() as Length,
        );
      case final BodyFatPercentageRecordDto dto:
        return BodyFatPercentageRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          percentage: dto.percentage.toDomain() as Percentage,
        );
      case final BodyTemperatureRecordDto dto:
        return BodyTemperatureRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          temperature: dto.temperature.toDomain() as Temperature,
        );
      case final HydrationRecordDto dto:
        return HydrationRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          volume: dto.volume.toDomain() as Volume,
        );
      case final WheelchairPushesRecordDto dto:
        return WheelchairPushesRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.zoneOffsetSeconds,
          endZoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          pushes: dto.pushes.toDomain() as Numeric,
        );
      case final HeartRateMeasurementRecordDto dto:
        return HeartRateMeasurementRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          metadata: dto.metadata.toDomain(),
          measurement: dto.measurement.toDomain(),
        );
      case final SleepStageRecordDto dto:
        return SleepStageRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          metadata: dto.metadata.toDomain(),
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          stageType: dto.stageType.toDomain(),
        );

      // MARK: Combined Nutrition Record - DTO to Domain

      case final NutritionRecordDto dto:
        return NutritionRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
          // Energy
          energy: dto.energy?.toDomain() as Energy?,
          // Macronutrients
          protein: dto.protein?.toDomain() as Mass?,
          totalCarbohydrate: dto.totalCarbohydrate?.toDomain() as Mass?,
          totalFat: dto.totalFat?.toDomain() as Mass?,
          saturatedFat: dto.saturatedFat?.toDomain() as Mass?,
          monounsaturatedFat: dto.monounsaturatedFat?.toDomain() as Mass?,
          polyunsaturatedFat: dto.polyunsaturatedFat?.toDomain() as Mass?,
          cholesterol: dto.cholesterol?.toDomain() as Mass?,
          dietaryFiber: dto.dietaryFiber?.toDomain() as Mass?,
          sugar: dto.sugar?.toDomain() as Mass?,
          // Vitamins
          vitaminA: dto.vitaminA?.toDomain() as Mass?,
          vitaminB6: dto.vitaminB6?.toDomain() as Mass?,
          vitaminB12: dto.vitaminB12?.toDomain() as Mass?,
          vitaminC: dto.vitaminC?.toDomain() as Mass?,
          vitaminD: dto.vitaminD?.toDomain() as Mass?,
          vitaminE: dto.vitaminE?.toDomain() as Mass?,
          vitaminK: dto.vitaminK?.toDomain() as Mass?,
          thiamin: dto.thiamin?.toDomain() as Mass?,
          riboflavin: dto.riboflavin?.toDomain() as Mass?,
          niacin: dto.niacin?.toDomain() as Mass?,
          folate: dto.folate?.toDomain() as Mass?,
          biotin: dto.biotin?.toDomain() as Mass?,
          pantothenicAcid: dto.pantothenicAcid?.toDomain() as Mass?,
          // Minerals
          calcium: dto.calcium?.toDomain() as Mass?,
          iron: dto.iron?.toDomain() as Mass?,
          magnesium: dto.magnesium?.toDomain() as Mass?,
          manganese: dto.manganese?.toDomain() as Mass?,
          phosphorus: dto.phosphorus?.toDomain() as Mass?,
          potassium: dto.potassium?.toDomain() as Mass?,
          selenium: dto.selenium?.toDomain() as Mass?,
          sodium: dto.sodium?.toDomain() as Mass?,
          zinc: dto.zinc?.toDomain() as Mass?,
          // Other
          caffeine: dto.caffeine?.toDomain() as Mass?,
        );

      // MARK: Nutrients - DTO to Domain

      case final EnergyNutrientRecordDto dto:
        return EnergyNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Energy,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final CaffeineNutrientRecordDto dto:
        return CaffeineNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final ProteinNutrientRecordDto dto:
        return ProteinNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final TotalCarbohydrateNutrientRecordDto dto:
        return TotalCarbohydrateNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final TotalFatNutrientRecordDto dto:
        return TotalFatNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final SaturatedFatNutrientRecordDto dto:
        return SaturatedFatNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final MonounsaturatedFatNutrientRecordDto dto:
        return MonounsaturatedFatNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final PolyunsaturatedFatNutrientRecordDto dto:
        return PolyunsaturatedFatNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final CholesterolNutrientRecordDto dto:
        return CholesterolNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final DietaryFiberNutrientRecordDto dto:
        return DietaryFiberNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final SugarNutrientRecordDto dto:
        return SugarNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final VitaminANutrientRecordDto dto:
        return VitaminANutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final VitaminB6NutrientRecordDto dto:
        return VitaminB6NutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final VitaminB12NutrientRecordDto dto:
        return VitaminB12NutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final VitaminCNutrientRecordDto dto:
        return VitaminCNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final VitaminDNutrientRecordDto dto:
        return VitaminDNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final VitaminENutrientRecordDto dto:
        return VitaminENutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final VitaminKNutrientRecordDto dto:
        return VitaminKNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final ThiaminNutrientRecordDto dto:
        return ThiaminNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final RiboflavinNutrientRecordDto dto:
        return RiboflavinNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final NiacinNutrientRecordDto dto:
        return NiacinNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final FolateNutrientRecordDto dto:
        return FolateNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final BiotinNutrientRecordDto dto:
        return BiotinNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final PantothenicAcidNutrientRecordDto dto:
        return PantothenicAcidNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final CalciumNutrientRecordDto dto:
        return CalciumNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final IronNutrientRecordDto dto:
        return IronNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final MagnesiumNutrientRecordDto dto:
        return MagnesiumNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final ManganeseNutrientRecordDto dto:
        return ManganeseNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final PhosphorusNutrientRecordDto dto:
        return PhosphorusNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final PotassiumNutrientRecordDto dto:
        return PotassiumNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final SeleniumNutrientRecordDto dto:
        return SeleniumNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final SodiumNutrientRecordDto dto:
        return SodiumNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final ZincNutrientRecordDto dto:
        return ZincNutrientRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          value: dto.value.toDomain() as Mass,
          foodName: dto.foodName,
          mealType: dto.mealType?.toDomain() ?? MealType.unknown,
        );

      case final BloodPressureRecordDto dto:
        return BloodPressureRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          systolic: dto.systolic.toDomain() as Pressure,
          diastolic: dto.diastolic.toDomain() as Pressure,
          bodyPosition: dto.bodyPosition.toDomain(),
          measurementLocation: dto.measurementLocation.toDomain(),
        );

      case final SystolicBloodPressureRecordDto dto:
        return SystolicBloodPressureRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          pressure: dto.pressure.toDomain() as Pressure,
        );

      case final DiastolicBloodPressureRecordDto dto:
        return DiastolicBloodPressureRecord(
          id: dto.id?.toDomain() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          pressure: dto.pressure.toDomain() as Pressure,
        );
    }
  }
}

extension SleepStageTypeDomainToDto on SleepStageType {
  SleepStageTypeDto toDto() {
    return switch (this) {
      SleepStageType.unknown => SleepStageTypeDto.unknown,
      SleepStageType.awake => SleepStageTypeDto.awake,
      SleepStageType.sleeping => SleepStageTypeDto.sleeping,
      SleepStageType.outOfBed => SleepStageTypeDto.outOfBed,
      SleepStageType.light => SleepStageTypeDto.light,
      SleepStageType.deep => SleepStageTypeDto.deep,
      SleepStageType.rem => SleepStageTypeDto.rem,
      SleepStageType.inBed => SleepStageTypeDto.inBed,
    };
  }
}

extension SleepStageTypeDtoToDomain on SleepStageTypeDto {
  SleepStageType toDomain() {
    return switch (this) {
      SleepStageTypeDto.unknown => SleepStageType.unknown,
      SleepStageTypeDto.awake => SleepStageType.awake,
      SleepStageTypeDto.sleeping => SleepStageType.sleeping,
      SleepStageTypeDto.outOfBed => SleepStageType.outOfBed,
      SleepStageTypeDto.light => SleepStageType.light,
      SleepStageTypeDto.deep => SleepStageType.deep,
      SleepStageTypeDto.rem => SleepStageType.rem,
      SleepStageTypeDto.inBed => SleepStageType.inBed,
    };
  }
}
