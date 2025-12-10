import 'package:health_connector_core/health_connector_core.dart'
    show
        BiotinNutrientRecord,
        CaffeineNutrientRecord,
        CalciumNutrientRecord,
        CholesterolNutrientRecord,
        DietaryFiberNutrientRecord,
        Energy,
        EnergyNutrientRecord,
        FolateNutrientRecord,
        HealthRecordId,
        IronNutrientRecord,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        Mass,
        MonounsaturatedFatNutrientRecord,
        NiacinNutrientRecord,
        NutrientHealthRecord,
        NutritionRecord,
        PantothenicAcidNutrientRecord,
        PhosphorusNutrientRecord,
        PolyunsaturatedFatNutrientRecord,
        PotassiumNutrientRecord,
        ProteinNutrientRecord,
        RiboflavinNutrientRecord,
        SaturatedFatNutrientRecord,
        SeleniumNutrientRecord,
        SodiumNutrientRecord,
        SugarNutrientRecord,
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
        ZincNutrientRecord,
        HealthRecord;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/meal_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show EnergyDto, HealthDataTypeDto, MassDto, NutritionRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [NutrientHealthRecord] to [NutritionRecordDto].
@internal
extension NutrientHealthRecordToDto on NutrientHealthRecord {
  NutritionRecordDto toDto() => _mapNutrientRecordToNutritionRecordDto(this);
}

/// Converts [NutritionRecord] to [NutritionRecordDto].
@internal
extension NutritionRecordToDto on NutritionRecord {
  NutritionRecordDto toDto() {
    return NutritionRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      healthDataType: HealthDataTypeDto.nutrition,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
      energy: energy?.toDto() as EnergyDto?,
      protein: protein?.toDto() as MassDto?,
      totalCarbohydrate: totalCarbohydrate?.toDto() as MassDto?,
      totalFat: totalFat?.toDto() as MassDto?,
      saturatedFat: saturatedFat?.toDto() as MassDto?,
      monounsaturatedFat: monounsaturatedFat?.toDto() as MassDto?,
      polyunsaturatedFat: polyunsaturatedFat?.toDto() as MassDto?,
      cholesterol: cholesterol?.toDto() as MassDto?,
      dietaryFiber: dietaryFiber?.toDto() as MassDto?,
      sugar: sugar?.toDto() as MassDto?,
      vitaminA: vitaminA?.toDto() as MassDto?,
      vitaminB6: vitaminB6?.toDto() as MassDto?,
      vitaminB12: vitaminB12?.toDto() as MassDto?,
      vitaminC: vitaminC?.toDto() as MassDto?,
      vitaminD: vitaminD?.toDto() as MassDto?,
      vitaminE: vitaminE?.toDto() as MassDto?,
      vitaminK: vitaminK?.toDto() as MassDto?,
      thiamin: thiamin?.toDto() as MassDto?,
      riboflavin: riboflavin?.toDto() as MassDto?,
      niacin: niacin?.toDto() as MassDto?,
      folate: folate?.toDto() as MassDto?,
      biotin: biotin?.toDto() as MassDto?,
      pantothenicAcid: pantothenicAcid?.toDto() as MassDto?,
      calcium: calcium?.toDto() as MassDto?,
      iron: iron?.toDto() as MassDto?,
      magnesium: magnesium?.toDto() as MassDto?,
      manganese: manganese?.toDto() as MassDto?,
      phosphorus: phosphorus?.toDto() as MassDto?,
      potassium: potassium?.toDto() as MassDto?,
      selenium: selenium?.toDto() as MassDto?,
      sodium: sodium?.toDto() as MassDto?,
      zinc: zinc?.toDto() as MassDto?,
      caffeine: caffeine?.toDto() as MassDto?,
    );
  }
}

/// Converts [NutritionRecordDto] to domain nutrition records.
@internal
extension NutritionRecordDtoToDomain on NutritionRecordDto {
  HealthRecord toDomain() {
    final id = this.id?.toHealthRecordId() ?? HealthRecordId.none;
    final time = DateTime.fromMillisecondsSinceEpoch(startTime);
    final zoneOffsetSeconds = startZoneOffsetSeconds;
    final metadata = this.metadata.toDomain();
    final foodName = this.foodName;
    final mealType = this.mealType.toDomain();

    switch (healthDataType) {
      case HealthDataTypeDto.nutrition:
        return NutritionRecord(
          id: id,
          startTime: time,
          endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
          startZoneOffsetSeconds: zoneOffsetSeconds,
          endZoneOffsetSeconds: endZoneOffsetSeconds,
          metadata: metadata,
          foodName: foodName,
          mealType: mealType,
          energy: energy?.toDomain() as Energy?,
          protein: protein?.toDomain() as Mass?,
          totalCarbohydrate: totalCarbohydrate?.toDomain() as Mass?,
          totalFat: totalFat?.toDomain() as Mass?,
          saturatedFat: saturatedFat?.toDomain() as Mass?,
          monounsaturatedFat: monounsaturatedFat?.toDomain() as Mass?,
          polyunsaturatedFat: polyunsaturatedFat?.toDomain() as Mass?,
          cholesterol: cholesterol?.toDomain() as Mass?,
          dietaryFiber: dietaryFiber?.toDomain() as Mass?,
          sugar: sugar?.toDomain() as Mass?,
          vitaminA: vitaminA?.toDomain() as Mass?,
          vitaminB6: vitaminB6?.toDomain() as Mass?,
          vitaminB12: vitaminB12?.toDomain() as Mass?,
          vitaminC: vitaminC?.toDomain() as Mass?,
          vitaminD: vitaminD?.toDomain() as Mass?,
          vitaminE: vitaminE?.toDomain() as Mass?,
          vitaminK: vitaminK?.toDomain() as Mass?,
          thiamin: thiamin?.toDomain() as Mass?,
          riboflavin: riboflavin?.toDomain() as Mass?,
          niacin: niacin?.toDomain() as Mass?,
          folate: folate?.toDomain() as Mass?,
          biotin: biotin?.toDomain() as Mass?,
          pantothenicAcid: pantothenicAcid?.toDomain() as Mass?,
          calcium: calcium?.toDomain() as Mass?,
          iron: iron?.toDomain() as Mass?,
          magnesium: magnesium?.toDomain() as Mass?,
          manganese: manganese?.toDomain() as Mass?,
          phosphorus: phosphorus?.toDomain() as Mass?,
          potassium: potassium?.toDomain() as Mass?,
          selenium: selenium?.toDomain() as Mass?,
          sodium: sodium?.toDomain() as Mass?,
          zinc: zinc?.toDomain() as Mass?,
          caffeine: caffeine?.toDomain() as Mass?,
        );
      case HealthDataTypeDto.energyNutrient:
        return EnergyNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: energy!.toDomain() as Energy,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.caffeine:
        return CaffeineNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: caffeine!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.protein:
        return ProteinNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: protein!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.totalCarbohydrate:
        return TotalCarbohydrateNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: totalCarbohydrate!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.totalFat:
        return TotalFatNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: totalFat!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.saturatedFat:
        return SaturatedFatNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: saturatedFat!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.monounsaturatedFat:
        return MonounsaturatedFatNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: monounsaturatedFat!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.polyunsaturatedFat:
        return PolyunsaturatedFatNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: polyunsaturatedFat!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.cholesterol:
        return CholesterolNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: cholesterol!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.dietaryFiber:
        return DietaryFiberNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: dietaryFiber!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.sugar:
        return SugarNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: sugar!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.vitaminA:
        return VitaminANutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: vitaminA!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.vitaminB6:
        return VitaminB6NutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: vitaminB6!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.vitaminB12:
        return VitaminB12NutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: vitaminB12!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.vitaminC:
        return VitaminCNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: vitaminC!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.vitaminD:
        return VitaminDNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: vitaminD!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.vitaminE:
        return VitaminENutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: vitaminE!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.vitaminK:
        return VitaminKNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: vitaminK!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.thiamin:
        return ThiaminNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: thiamin!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.riboflavin:
        return RiboflavinNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: riboflavin!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.niacin:
        return NiacinNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: niacin!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.folate:
        return FolateNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: folate!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.biotin:
        return BiotinNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: biotin!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.pantothenicAcid:
        return PantothenicAcidNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: pantothenicAcid!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.calcium:
        return CalciumNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: calcium!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.iron:
        return IronNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: iron!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.magnesium:
        return MagnesiumNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: magnesium!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.manganese:
        return ManganeseNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: manganese!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.phosphorus:
        return PhosphorusNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: phosphorus!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.potassium:
        return PotassiumNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: potassium!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.selenium:
        return SeleniumNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: selenium!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.sodium:
        return SodiumNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: sodium!.toDomain() as Mass,
          foodName: foodName,
          mealType: mealType,
        );
      case HealthDataTypeDto.zinc:
        return ZincNutrientRecord(
          id: id,
          time: time,
          zoneOffsetSeconds: zoneOffsetSeconds,
          metadata: metadata,
          value: zinc!.toDomain() as Mass,
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
        throw ArgumentError('Invalid DTO for $NutritionRecordDto: $this');
    }
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
