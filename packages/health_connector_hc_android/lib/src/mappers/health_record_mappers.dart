import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        BiotinNutrientRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        CaffeineNutrientRecord,
        CalciumNutrientRecord,
        CholesterolNutrientRecord,
        DietaryFiberNutrientRecord,
        DistanceRecord,
        Energy,
        EnergyNutrientRecord,
        FloorsClimbedRecord,
        FolateNutrientRecord,
        HealthRecord,
        HealthRecordId,
        HeartRateMeasurement,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        IronNutrientRecord,
        LeanBodyMassRecord,
        Length,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        Mass,
        MonounsaturatedFatNutrientRecord,
        NiacinNutrientRecord,
        Numeric,
        NutritionRecord,
        PantothenicAcidNutrientRecord,
        Percentage,
        PhosphorusNutrientRecord,
        PolyunsaturatedFatNutrientRecord,
        PotassiumNutrientRecord,
        ProteinNutrientRecord,
        RiboflavinNutrientRecord,
        SaturatedFatNutrientRecord,
        SeleniumNutrientRecord,
        SleepSessionRecord,
        SleepStage,
        SleepStageRecord,
        SleepStageType,
        SodiumNutrientRecord,
        StepRecord,
        SugarNutrientRecord,
        Temperature,
        ThiaminNutrientRecord,
        TotalCarbohydrateNutrientRecord,
        TotalFatNutrientRecord,
        VitaminANutrientRecord,
        VitaminB6NutrientRecord,
        VitaminB12NutrientRecord,
        VitaminCNutrientRecord,
        VitaminDNutrientRecord,
        VitaminENutrientRecord,
        VitaminKNutrientRecord,
        Volume,
        WeightRecord,
        WheelchairPushesRecord,
        ZincNutrientRecord,
        NutrientHealthRecord,
        BloodPressureRecord,
        SystolicBloodPressureRecord,
        DiastolicBloodPressureRecord,
        Pressure;
import 'package:health_connector_hc_android/src/mappers/blood_pressure_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/meal_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/'
    'measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        DistanceRecordDto,
        EnergyDto,
        FloorsClimbedRecordDto,
        HealthDataTypeDto,
        HealthRecordDto,
        HeartRateMeasurementDto,
        HeartRateSeriesRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        LeanBodyMassRecordDto,
        LengthDto,
        MassDto,
        NumericDto,
        NutritionRecordDto,
        PercentageDto,
        SleepSessionRecordDto,
        SleepStageDto,
        SleepStageTypeDto,
        StepRecordDto,
        TemperatureDto,
        VolumeDto,
        WeightRecordDto,
        WheelchairPushesRecordDto,
        BloodPressureRecordDto,
        SystolicBloodPressureRecordDto,
        DiastolicBloodPressureRecordDto,
        PressureDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecordId] to [String] for DTO transfer.
@internal
extension HealthRecordIdToString on HealthRecordId {
  String toDto() => value;
}

/// Converts [String] to [HealthRecordId].
@internal
extension StringToHealthRecordId on String {
  HealthRecordId toHealthRecordId() {
    if (this == HealthRecordId.none.value) {
      return HealthRecordId.none;
    }
    return HealthRecordId(this);
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
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          energy: record.energy.toDto() as EnergyDto,
        );
      case final DistanceRecord record:
        return DistanceRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          distance: record.distance.toDto() as LengthDto,
        );
      case final FloorsClimbedRecord record:
        return FloorsClimbedRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          floors: record.floors.toDto() as NumericDto,
        );
      case final HeightRecord record:
        return HeightRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          height: record.height.toDto() as LengthDto,
        );
      case final HydrationRecord record:
        return HydrationRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          volume: record.volume.toDto() as VolumeDto,
        );
      case final LeanBodyMassRecord record:
        return LeanBodyMassRecordDto(
          id: record.id.toDto(),
          time: record.time.millisecondsSinceEpoch,
          zoneOffsetSeconds: record.zoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          mass: record.mass.toDto() as MassDto,
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
      case final StepRecord record:
        return StepRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
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
      case final WheelchairPushesRecord record:
        return WheelchairPushesRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          pushes: record.pushes.toDto() as NumericDto,
        );
      case final HeartRateSeriesRecord record:
        return HeartRateSeriesRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          samples: record.samples.map((s) => s.toDto()).toList(),
        );
      case final SleepSessionRecord record:
        return SleepSessionRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          title: record.title,
          notes: record.notes,
          stages: record.samples.map((s) => s.toDto()).toList(),
        );

      case final NutrientHealthRecord record:
        return _mapNutrientRecordToNutritionRecordDto(record);

      case final NutritionRecord record:
        return NutritionRecordDto(
          id: record.id.toDto(),
          startTime: record.startTime.millisecondsSinceEpoch,
          endTime: record.endTime.millisecondsSinceEpoch,
          healthDataType: HealthDataTypeDto.nutrition,
          startZoneOffsetSeconds: record.startZoneOffsetSeconds,
          endZoneOffsetSeconds: record.endZoneOffsetSeconds,
          metadata: record.metadata.toDto(),
          foodName: record.foodName,
          mealType: record.mealType.toDto(),
          energy: record.energy?.toDto() as EnergyDto?,
          protein: record.protein?.toDto() as MassDto?,
          totalCarbohydrate: record.totalCarbohydrate?.toDto() as MassDto?,
          totalFat: record.totalFat?.toDto() as MassDto?,
          saturatedFat: record.saturatedFat?.toDto() as MassDto?,
          monounsaturatedFat: record.monounsaturatedFat?.toDto() as MassDto?,
          polyunsaturatedFat: record.polyunsaturatedFat?.toDto() as MassDto?,
          cholesterol: record.cholesterol?.toDto() as MassDto?,
          dietaryFiber: record.dietaryFiber?.toDto() as MassDto?,
          sugar: record.sugar?.toDto() as MassDto?,
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
          calcium: record.calcium?.toDto() as MassDto?,
          iron: record.iron?.toDto() as MassDto?,
          magnesium: record.magnesium?.toDto() as MassDto?,
          manganese: record.manganese?.toDto() as MassDto?,
          phosphorus: record.phosphorus?.toDto() as MassDto?,
          potassium: record.potassium?.toDto() as MassDto?,
          selenium: record.selenium?.toDto() as MassDto?,
          sodium: record.sodium?.toDto() as MassDto?,
          zinc: record.zinc?.toDto() as MassDto?,
          caffeine: record.caffeine?.toDto() as MassDto?,
        );

      case final SleepStageRecord _:
        throw UnsupportedError(
          '$SleepStageRecord is not supported on Android. '
          'Use $SleepSessionRecord instead.',
        );
      case final HeartRateMeasurementRecord _:
        throw UnsupportedError(
          '$HeartRateMeasurementRecord is not supported on Android. '
          'Use $HeartRateSeriesRecord instead.',
        );

      // Blood pressure records
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
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          energy: dto.energy.toDomain() as Energy,
        );
      case final DistanceRecordDto dto:
        return DistanceRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          distance: dto.distance.toDomain() as Length,
        );
      case final FloorsClimbedRecordDto dto:
        return FloorsClimbedRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          floors: dto.floors.toDomain() as Numeric,
        );
      case final HeightRecordDto dto:
        return HeightRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          height: dto.height.toDomain() as Length,
        );
      case final HydrationRecordDto dto:
        return HydrationRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          volume: dto.volume.toDomain() as Volume,
        );
      case final LeanBodyMassRecordDto dto:
        return LeanBodyMassRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          mass: dto.mass.toDomain() as Mass,
        );
      case final BodyFatPercentageRecordDto dto:
        return BodyFatPercentageRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          percentage: dto.percentage.toDomain() as Percentage,
        );
      case final BodyTemperatureRecordDto dto:
        return BodyTemperatureRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          temperature: dto.temperature.toDomain() as Temperature,
        );
      case final StepRecordDto dto:
        return StepRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          count: dto.count.toDomain() as Numeric,
        );
      case final WeightRecordDto dto:
        return WeightRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          weight: dto.weight.toDomain() as Mass,
        );
      case final WheelchairPushesRecordDto dto:
        return WheelchairPushesRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          pushes: dto.pushes.toDomain() as Numeric,
        );
      case final HeartRateSeriesRecordDto dto:
        return HeartRateSeriesRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          samples: dto.samples.map((s) => s.toDomain()).toList(),
        );
      case final SleepSessionRecordDto dto:
        return SleepSessionRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          startTime: DateTime.fromMillisecondsSinceEpoch(dto.startTime),
          endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
          startZoneOffsetSeconds: dto.startZoneOffsetSeconds,
          endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          samples: dto.stages.map((s) => s.toDomain()).toList(),
          title: dto.title,
          notes: dto.notes,
        );

      // Unified nutrition record - handles both nutrients and nutrition
      case final NutritionRecordDto dto:
        final id = dto.id?.toHealthRecordId() ?? HealthRecordId.none;
        final time = DateTime.fromMillisecondsSinceEpoch(dto.startTime);
        final zoneOffsetSeconds = dto.startZoneOffsetSeconds;
        final metadata = dto.metadata.toDomain();
        final foodName = dto.foodName;
        final mealType = dto.mealType.toDomain();

        switch (dto.healthDataType) {
          case HealthDataTypeDto.nutrition:
            return NutritionRecord(
              id: id,
              startTime: time,
              endTime: DateTime.fromMillisecondsSinceEpoch(dto.endTime),
              startZoneOffsetSeconds: zoneOffsetSeconds,
              endZoneOffsetSeconds: dto.endZoneOffsetSeconds,
              metadata: metadata,
              foodName: foodName,
              mealType: mealType,
              energy: dto.energy?.toDomain() as Energy?,
              protein: dto.protein?.toDomain() as Mass?,
              totalCarbohydrate: dto.totalCarbohydrate?.toDomain() as Mass?,
              totalFat: dto.totalFat?.toDomain() as Mass?,
              saturatedFat: dto.saturatedFat?.toDomain() as Mass?,
              monounsaturatedFat: dto.monounsaturatedFat?.toDomain() as Mass?,
              polyunsaturatedFat: dto.polyunsaturatedFat?.toDomain() as Mass?,
              cholesterol: dto.cholesterol?.toDomain() as Mass?,
              dietaryFiber: dto.dietaryFiber?.toDomain() as Mass?,
              sugar: dto.sugar?.toDomain() as Mass?,
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
              calcium: dto.calcium?.toDomain() as Mass?,
              iron: dto.iron?.toDomain() as Mass?,
              magnesium: dto.magnesium?.toDomain() as Mass?,
              manganese: dto.manganese?.toDomain() as Mass?,
              phosphorus: dto.phosphorus?.toDomain() as Mass?,
              potassium: dto.potassium?.toDomain() as Mass?,
              selenium: dto.selenium?.toDomain() as Mass?,
              sodium: dto.sodium?.toDomain() as Mass?,
              zinc: dto.zinc?.toDomain() as Mass?,
              caffeine: dto.caffeine?.toDomain() as Mass?,
            );
          case HealthDataTypeDto.energyNutrient:
            return EnergyNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.energy!.toDomain() as Energy,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.caffeine:
            return CaffeineNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.caffeine!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.protein:
            return ProteinNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.protein!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.totalCarbohydrate:
            return TotalCarbohydrateNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.totalCarbohydrate!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.totalFat:
            return TotalFatNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.totalFat!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.saturatedFat:
            return SaturatedFatNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.saturatedFat!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.monounsaturatedFat:
            return MonounsaturatedFatNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.monounsaturatedFat!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.polyunsaturatedFat:
            return PolyunsaturatedFatNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.polyunsaturatedFat!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.cholesterol:
            return CholesterolNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.cholesterol!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.dietaryFiber:
            return DietaryFiberNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.dietaryFiber!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.sugar:
            return SugarNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.sugar!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.vitaminA:
            return VitaminANutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.vitaminA!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.vitaminB6:
            return VitaminB6NutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.vitaminB6!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.vitaminB12:
            return VitaminB12NutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.vitaminB12!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.vitaminC:
            return VitaminCNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.vitaminC!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.vitaminD:
            return VitaminDNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.vitaminD!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.vitaminE:
            return VitaminENutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.vitaminE!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.vitaminK:
            return VitaminKNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.vitaminK!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.thiamin:
            return ThiaminNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.thiamin!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.riboflavin:
            return RiboflavinNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.riboflavin!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.niacin:
            return NiacinNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.niacin!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.folate:
            return FolateNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.folate!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.biotin:
            return BiotinNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.biotin!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.pantothenicAcid:
            return PantothenicAcidNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.pantothenicAcid!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.calcium:
            return CalciumNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.calcium!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.iron:
            return IronNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.iron!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.magnesium:
            return MagnesiumNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.magnesium!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.manganese:
            return ManganeseNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.manganese!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.phosphorus:
            return PhosphorusNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.phosphorus!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.potassium:
            return PotassiumNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.potassium!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.selenium:
            return SeleniumNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.selenium!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.sodium:
            return SodiumNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.sodium!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.zinc:
            return ZincNutrientRecord(
              id: id,
              time: time,
              zoneOffsetSeconds: zoneOffsetSeconds,
              metadata: metadata,
              value: dto.zinc!.toDomain() as Mass,
              foodName: foodName,
              mealType: mealType,
            );
          case HealthDataTypeDto.activeCaloriesBurned:
          case HealthDataTypeDto.distance:
          case HealthDataTypeDto.floorsClimbed:
          case HealthDataTypeDto.steps:
          case HealthDataTypeDto.weight:
          case HealthDataTypeDto.height:
          case HealthDataTypeDto.bodyFatPercentage:
          case HealthDataTypeDto.bodyTemperature:
          case HealthDataTypeDto.leanBodyMass:
          case HealthDataTypeDto.wheelchairPushes:
          case HealthDataTypeDto.hydration:
          case HealthDataTypeDto.heartRateSeriesRecord:
          case HealthDataTypeDto.sleepSession:
          case HealthDataTypeDto.bloodPressure:
          case HealthDataTypeDto.systolicBloodPressure:
          case HealthDataTypeDto.diastolicBloodPressure:
            throw ArgumentError(
              'Unsupported health data type for '
              '`NutritionRecordDto`: ${dto.healthDataType}',
            );
        }

      // Blood pressure records
      case final BloodPressureRecordDto dto:
        return BloodPressureRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
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
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          pressure: dto.pressure.toDomain() as Pressure,
        );
      case final DiastolicBloodPressureRecordDto dto:
        return DiastolicBloodPressureRecord(
          id: dto.id?.toHealthRecordId() ?? HealthRecordId.none,
          time: DateTime.fromMillisecondsSinceEpoch(dto.time),
          zoneOffsetSeconds: dto.zoneOffsetSeconds,
          metadata: dto.metadata.toDomain(),
          pressure: dto.pressure.toDomain() as Pressure,
        );
    }
  }
}

/// Converts [HeartRateMeasurement] to [HeartRateMeasurementDto].
@internal
extension HeartRateMeasurementDtoMapper on HeartRateMeasurement {
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

extension SleepStageDomainToDto on SleepStage {
  SleepStageDto toDto() {
    return SleepStageDto(
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      stage: stageType.toDto(),
    );
  }
}

extension SleepStageDtoToDomain on SleepStageDto {
  SleepStage toDomain() {
    return SleepStage(
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      stageType: stage.toDomain(),
    );
  }
}

/// Maps individual nutrient domain record to [NutritionRecordDto].
NutritionRecordDto _mapNutrientRecordToNutritionRecordDto(
  NutrientHealthRecord record,
) {
  final valueDto = record.value.toDto();
  final baseParams = (
    id: record.id.toDto(),
    startTime: record.time.millisecondsSinceEpoch,

    // Small interval for instant records
    endTime: record.time.millisecondsSinceEpoch + 10,
    startZoneOffsetSeconds: record.zoneOffsetSeconds,
    endZoneOffsetSeconds: record.zoneOffsetSeconds,
    metadata: record.metadata.toDto(),
    foodName: record.foodName,
    mealType: record.mealType.toDto(),
  );

  switch (record) {
    case final EnergyNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.energyNutrient,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        energy: valueDto as EnergyDto,
      );
    case final CaffeineNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.caffeine,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        caffeine: valueDto as MassDto,
      );
    case final ProteinNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.protein,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        protein: valueDto as MassDto,
      );
    case final TotalCarbohydrateNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.totalCarbohydrate,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        totalCarbohydrate: valueDto as MassDto,
      );
    case final TotalFatNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.totalFat,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        totalFat: valueDto as MassDto,
      );
    case final SaturatedFatNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.saturatedFat,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        saturatedFat: valueDto as MassDto,
      );
    case final MonounsaturatedFatNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.monounsaturatedFat,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        monounsaturatedFat: valueDto as MassDto,
      );
    case final PolyunsaturatedFatNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.polyunsaturatedFat,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        polyunsaturatedFat: valueDto as MassDto,
      );
    case final CholesterolNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.cholesterol,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        cholesterol: valueDto as MassDto,
      );
    case final DietaryFiberNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.dietaryFiber,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        dietaryFiber: valueDto as MassDto,
      );
    case final SugarNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.sugar,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        sugar: valueDto as MassDto,
      );
    case final VitaminANutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.vitaminA,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        vitaminA: valueDto as MassDto,
      );
    case final VitaminB6NutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.vitaminB6,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        vitaminB6: valueDto as MassDto,
      );
    case final VitaminB12NutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.vitaminB12,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        vitaminB12: valueDto as MassDto,
      );
    case final VitaminCNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.vitaminC,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        vitaminC: valueDto as MassDto,
      );
    case final VitaminDNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.vitaminD,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        vitaminD: valueDto as MassDto,
      );
    case final VitaminENutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.vitaminE,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        vitaminE: valueDto as MassDto,
      );
    case final VitaminKNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.vitaminK,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        vitaminK: valueDto as MassDto,
      );
    case final ThiaminNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.thiamin,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        thiamin: valueDto as MassDto,
      );
    case final RiboflavinNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.riboflavin,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        riboflavin: valueDto as MassDto,
      );
    case final NiacinNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.niacin,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        niacin: valueDto as MassDto,
      );
    case final FolateNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.folate,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        folate: valueDto as MassDto,
      );
    case final BiotinNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.biotin,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        biotin: valueDto as MassDto,
      );
    case final PantothenicAcidNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.pantothenicAcid,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        pantothenicAcid: valueDto as MassDto,
      );
    case final CalciumNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.calcium,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        calcium: valueDto as MassDto,
      );
    case final IronNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.iron,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        iron: valueDto as MassDto,
      );
    case final MagnesiumNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.magnesium,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        magnesium: valueDto as MassDto,
      );
    case final ManganeseNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.manganese,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        manganese: valueDto as MassDto,
      );
    case final PhosphorusNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.phosphorus,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        phosphorus: valueDto as MassDto,
      );
    case final PotassiumNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.potassium,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        potassium: valueDto as MassDto,
      );
    case final SeleniumNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.selenium,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        selenium: valueDto as MassDto,
      );
    case final SodiumNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.sodium,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        sodium: valueDto as MassDto,
      );
    case final ZincNutrientRecord _:
      return NutritionRecordDto(
        id: baseParams.id,
        startTime: baseParams.startTime,
        endTime: baseParams.endTime,
        healthDataType: HealthDataTypeDto.zinc,
        startZoneOffsetSeconds: baseParams.startZoneOffsetSeconds,
        endZoneOffsetSeconds: baseParams.endZoneOffsetSeconds,
        metadata: baseParams.metadata,
        foodName: baseParams.foodName,
        mealType: baseParams.mealType,
        zinc: valueDto as MassDto,
      );
  }
}
