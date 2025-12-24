import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        BiotinNutrientRecord,
        CaffeineNutrientRecord,
        CalciumNutrientRecord,
        CholesterolNutrientRecord,
        EnergyNutrientRecord,
        FolateNutrientRecord,
        HealthRecordId,
        IronNutrientRecord,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        MealType,
        MonounsaturatedFatNutrientRecord,
        NiacinNutrientRecord,
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
        sinceV1_1_0,
        DietaryFiberNutrientRecord;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/meal_type_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        BiotinNutrientRecordDto,
        CaffeineNutrientRecordDto,
        CalciumNutrientRecordDto,
        CholesterolNutrientRecordDto,
        DietaryFiberNutrientRecordDto,
        EnergyNutrientRecordDto,
        FolateNutrientRecordDto,
        IronNutrientRecordDto,
        MagnesiumNutrientRecordDto,
        ManganeseNutrientRecordDto,
        MonounsaturatedFatNutrientRecordDto,
        NiacinNutrientRecordDto,
        NutritionRecordDto,
        PantothenicAcidNutrientRecordDto,
        PhosphorusNutrientRecordDto,
        PolyunsaturatedFatNutrientRecordDto,
        PotassiumNutrientRecordDto,
        ProteinNutrientRecordDto,
        RiboflavinNutrientRecordDto,
        SaturatedFatNutrientRecordDto,
        SeleniumNutrientRecordDto,
        SodiumNutrientRecordDto,
        SugarNutrientRecordDto,
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
        ZincNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [NutritionRecord] to [NutritionRecordDto].
@sinceV1_1_0
@internal
extension NutritionRecordToDto on NutritionRecord {
  NutritionRecordDto toDto() {
    return NutritionRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType.toDto(),
      // Energy
      energy: energy?.toDto(),
      // Macronutrients
      protein: protein?.toDto(),
      totalCarbohydrate: totalCarbohydrate?.toDto(),
      totalFat: totalFat?.toDto(),
      saturatedFat: saturatedFat?.toDto(),
      monounsaturatedFat: monounsaturatedFat?.toDto(),
      polyunsaturatedFat: polyunsaturatedFat?.toDto(),
      cholesterol: cholesterol?.toDto(),
      dietaryFiber: dietaryFiber?.toDto(),
      sugar: sugar?.toDto(),
      // Vitamins
      vitaminA: vitaminA?.toDto(),
      vitaminB6: vitaminB6?.toDto(),
      vitaminB12: vitaminB12?.toDto(),
      vitaminC: vitaminC?.toDto(),
      vitaminD: vitaminD?.toDto(),
      vitaminE: vitaminE?.toDto(),
      vitaminK: vitaminK?.toDto(),
      thiamin: thiamin?.toDto(),
      riboflavin: riboflavin?.toDto(),
      niacin: niacin?.toDto(),
      folate: folate?.toDto(),
      biotin: biotin?.toDto(),
      pantothenicAcid: pantothenicAcid?.toDto(),
      // Minerals
      calcium: calcium?.toDto(),
      iron: iron?.toDto(),
      magnesium: magnesium?.toDto(),
      manganese: manganese?.toDto(),
      phosphorus: phosphorus?.toDto(),
      potassium: potassium?.toDto(),
      selenium: selenium?.toDto(),
      sodium: sodium?.toDto(),
      zinc: zinc?.toDto(),
      // Other
      caffeine: caffeine?.toDto(),
    );
  }
}

/// Converts [EnergyNutrientRecord] to [EnergyNutrientRecordDto].
@sinceV1_1_0
@internal
extension EnergyNutrientRecordToDto on EnergyNutrientRecord {
  EnergyNutrientRecordDto toDto() {
    return EnergyNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [CaffeineNutrientRecord] to [CaffeineNutrientRecordDto].
@sinceV1_1_0
@internal
extension CaffeineNutrientRecordToDto on CaffeineNutrientRecord {
  CaffeineNutrientRecordDto toDto() {
    return CaffeineNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [ProteinNutrientRecord] to [ProteinNutrientRecordDto].
@sinceV1_1_0
@internal
extension ProteinNutrientRecordToDto on ProteinNutrientRecord {
  ProteinNutrientRecordDto toDto() {
    return ProteinNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [TotalCarbohydrateNutrientRecord] to
/// [TotalCarbohydrateNutrientRecordDto].
@sinceV1_1_0
@internal
extension TotalCarbohydrateNutrientRecordToDto
    on TotalCarbohydrateNutrientRecord {
  TotalCarbohydrateNutrientRecordDto toDto() {
    return TotalCarbohydrateNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [TotalFatNutrientRecord] to [TotalFatNutrientRecordDto].
@sinceV1_1_0
@internal
extension TotalFatNutrientRecordToDto on TotalFatNutrientRecord {
  TotalFatNutrientRecordDto toDto() {
    return TotalFatNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [SaturatedFatNutrientRecord] to [SaturatedFatNutrientRecordDto].
@sinceV1_1_0
@internal
extension SaturatedFatNutrientRecordToDto on SaturatedFatNutrientRecord {
  SaturatedFatNutrientRecordDto toDto() {
    return SaturatedFatNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [MonounsaturatedFatNutrientRecord] to
/// [MonounsaturatedFatNutrientRecordDto].
@sinceV1_1_0
@internal
extension MonounsaturatedFatNutrientRecordToDto
    on MonounsaturatedFatNutrientRecord {
  MonounsaturatedFatNutrientRecordDto toDto() {
    return MonounsaturatedFatNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PolyunsaturatedFatNutrientRecord] to
/// [PolyunsaturatedFatNutrientRecordDto].
@sinceV1_1_0
@internal
extension PolyunsaturatedFatNutrientRecordToDto
    on PolyunsaturatedFatNutrientRecord {
  PolyunsaturatedFatNutrientRecordDto toDto() {
    return PolyunsaturatedFatNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [CholesterolNutrientRecord] to [CholesterolNutrientRecordDto].
@sinceV1_1_0
@internal
extension CholesterolNutrientRecordToDto on CholesterolNutrientRecord {
  CholesterolNutrientRecordDto toDto() {
    return CholesterolNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [DietaryFiberNutrientRecord] to [DietaryFiberNutrientRecordDto].
@sinceV1_1_0
@internal
extension DietaryFiberNutrientRecordToDto on DietaryFiberNutrientRecord {
  DietaryFiberNutrientRecordDto toDto() {
    return DietaryFiberNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [SugarNutrientRecord] to [SugarNutrientRecordDto].
@sinceV1_1_0
@internal
extension SugarNutrientRecordToDto on SugarNutrientRecord {
  SugarNutrientRecordDto toDto() {
    return SugarNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminANutrientRecord] to [VitaminANutrientRecordDto].
@sinceV1_1_0
@internal
extension VitaminANutrientRecordToDto on VitaminANutrientRecord {
  VitaminANutrientRecordDto toDto() {
    return VitaminANutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminB6NutrientRecord] to [VitaminB6NutrientRecordDto].
@sinceV1_1_0
@internal
extension VitaminB6NutrientRecordToDto on VitaminB6NutrientRecord {
  VitaminB6NutrientRecordDto toDto() {
    return VitaminB6NutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminB12NutrientRecord] to [VitaminB12NutrientRecordDto].
@sinceV1_1_0
@internal
extension VitaminB12NutrientRecordToDto on VitaminB12NutrientRecord {
  VitaminB12NutrientRecordDto toDto() {
    return VitaminB12NutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminCNutrientRecord] to [VitaminCNutrientRecordDto].
@sinceV1_1_0
@internal
extension VitaminCNutrientRecordToDto on VitaminCNutrientRecord {
  VitaminCNutrientRecordDto toDto() {
    return VitaminCNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminDNutrientRecord] to [VitaminDNutrientRecordDto].
@sinceV1_1_0
@internal
extension VitaminDNutrientRecordToDto on VitaminDNutrientRecord {
  VitaminDNutrientRecordDto toDto() {
    return VitaminDNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminENutrientRecord] to [VitaminENutrientRecordDto].
@sinceV1_1_0
@internal
extension VitaminENutrientRecordToDto on VitaminENutrientRecord {
  VitaminENutrientRecordDto toDto() {
    return VitaminENutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminKNutrientRecord] to [VitaminKNutrientRecordDto].
@sinceV1_1_0
@internal
extension VitaminKNutrientRecordToDto on VitaminKNutrientRecord {
  VitaminKNutrientRecordDto toDto() {
    return VitaminKNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [ThiaminNutrientRecord] to [ThiaminNutrientRecordDto].
@sinceV1_1_0
@internal
extension ThiaminNutrientRecordToDto on ThiaminNutrientRecord {
  ThiaminNutrientRecordDto toDto() {
    return ThiaminNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [RiboflavinNutrientRecord] to [RiboflavinNutrientRecordDto].
@sinceV1_1_0
@internal
extension RiboflavinNutrientRecordToDto on RiboflavinNutrientRecord {
  RiboflavinNutrientRecordDto toDto() {
    return RiboflavinNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [NiacinNutrientRecord] to [NiacinNutrientRecordDto].
@sinceV1_1_0
@internal
extension NiacinNutrientRecordToDto on NiacinNutrientRecord {
  NiacinNutrientRecordDto toDto() {
    return NiacinNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [FolateNutrientRecord] to [FolateNutrientRecordDto].
@sinceV1_1_0
@internal
extension FolateNutrientRecordToDto on FolateNutrientRecord {
  FolateNutrientRecordDto toDto() {
    return FolateNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [BiotinNutrientRecord] to [BiotinNutrientRecordDto].
@sinceV1_1_0
@internal
extension BiotinNutrientRecordToDto on BiotinNutrientRecord {
  BiotinNutrientRecordDto toDto() {
    return BiotinNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PantothenicAcidNutrientRecord] to
/// [PantothenicAcidNutrientRecordDto].
@sinceV1_1_0
@internal
extension PantothenicAcidNutrientRecordToDto on PantothenicAcidNutrientRecord {
  PantothenicAcidNutrientRecordDto toDto() {
    return PantothenicAcidNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [CalciumNutrientRecord] to [CalciumNutrientRecordDto].
@sinceV1_1_0
@internal
extension CalciumNutrientRecordToDto on CalciumNutrientRecord {
  CalciumNutrientRecordDto toDto() {
    return CalciumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [IronNutrientRecord] to [IronNutrientRecordDto].
@sinceV1_1_0
@internal
extension IronNutrientRecordToDto on IronNutrientRecord {
  IronNutrientRecordDto toDto() {
    return IronNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [MagnesiumNutrientRecord] to [MagnesiumNutrientRecordDto].
@sinceV1_1_0
@internal
extension MagnesiumNutrientRecordToDto on MagnesiumNutrientRecord {
  MagnesiumNutrientRecordDto toDto() {
    return MagnesiumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [ManganeseNutrientRecord] to [ManganeseNutrientRecordDto].
@sinceV1_1_0
@internal
extension ManganeseNutrientRecordToDto on ManganeseNutrientRecord {
  ManganeseNutrientRecordDto toDto() {
    return ManganeseNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PhosphorusNutrientRecord] to [PhosphorusNutrientRecordDto].
@sinceV1_1_0
@internal
extension PhosphorusNutrientRecordToDto on PhosphorusNutrientRecord {
  PhosphorusNutrientRecordDto toDto() {
    return PhosphorusNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PotassiumNutrientRecord] to [PotassiumNutrientRecordDto].
@sinceV1_1_0
@internal
extension PotassiumNutrientRecordToDto on PotassiumNutrientRecord {
  PotassiumNutrientRecordDto toDto() {
    return PotassiumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [SeleniumNutrientRecord] to [SeleniumNutrientRecordDto].
@sinceV1_1_0
@internal
extension SeleniumNutrientRecordToDto on SeleniumNutrientRecord {
  SeleniumNutrientRecordDto toDto() {
    return SeleniumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [SodiumNutrientRecord] to [SodiumNutrientRecordDto].
@sinceV1_1_0
@internal
extension SodiumNutrientRecordToDto on SodiumNutrientRecord {
  SodiumNutrientRecordDto toDto() {
    return SodiumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [ZincNutrientRecord] to [ZincNutrientRecordDto].
@sinceV1_1_0
@internal
extension ZincNutrientRecordToDto on ZincNutrientRecord {
  ZincNutrientRecordDto toDto() {
    return ZincNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [NutritionRecordDto] to [NutritionRecord].
@sinceV1_1_0
@internal
extension NutritionRecordDtoToDomain on NutritionRecordDto {
  NutritionRecord toDomain() {
    return NutritionRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
      // Energy
      energy: energy?.toDomain(),
      // Macronutrients
      protein: protein?.toDomain(),
      totalCarbohydrate: totalCarbohydrate?.toDomain(),
      totalFat: totalFat?.toDomain(),
      saturatedFat: saturatedFat?.toDomain(),
      monounsaturatedFat: monounsaturatedFat?.toDomain(),
      polyunsaturatedFat: polyunsaturatedFat?.toDomain(),
      cholesterol: cholesterol?.toDomain(),
      dietaryFiber: dietaryFiber?.toDomain(),
      sugar: sugar?.toDomain(),
      // Vitamins
      vitaminA: vitaminA?.toDomain(),
      vitaminB6: vitaminB6?.toDomain(),
      vitaminB12: vitaminB12?.toDomain(),
      vitaminC: vitaminC?.toDomain(),
      vitaminD: vitaminD?.toDomain(),
      vitaminE: vitaminE?.toDomain(),
      vitaminK: vitaminK?.toDomain(),
      thiamin: thiamin?.toDomain(),
      riboflavin: riboflavin?.toDomain(),
      niacin: niacin?.toDomain(),
      folate: folate?.toDomain(),
      biotin: biotin?.toDomain(),
      pantothenicAcid: pantothenicAcid?.toDomain(),
      // Minerals
      calcium: calcium?.toDomain(),
      iron: iron?.toDomain(),
      magnesium: magnesium?.toDomain(),
      manganese: manganese?.toDomain(),
      phosphorus: phosphorus?.toDomain(),
      potassium: potassium?.toDomain(),
      selenium: selenium?.toDomain(),
      sodium: sodium?.toDomain(),
      zinc: zinc?.toDomain(),
      // Other
      caffeine: caffeine?.toDomain(),
    );
  }
}

/// Converts [EnergyNutrientRecordDto] to [EnergyNutrientRecord].
@sinceV1_1_0
@internal
extension EnergyNutrientRecordDtoToDomain on EnergyNutrientRecordDto {
  EnergyNutrientRecord toDomain() {
    return EnergyNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [CaffeineNutrientRecordDto] to [CaffeineNutrientRecord].
@sinceV1_1_0
@internal
extension CaffeineNutrientRecordDtoToDomain on CaffeineNutrientRecordDto {
  CaffeineNutrientRecord toDomain() {
    return CaffeineNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [ProteinNutrientRecordDto] to [ProteinNutrientRecord].
@sinceV1_1_0
@internal
extension ProteinNutrientRecordDtoToDomain on ProteinNutrientRecordDto {
  ProteinNutrientRecord toDomain() {
    return ProteinNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [TotalCarbohydrateNutrientRecordDto] to
/// [TotalCarbohydrateNutrientRecord].
@sinceV1_1_0
@internal
extension TotalCarbohydrateNutrientRecordDtoToDomain
    on TotalCarbohydrateNutrientRecordDto {
  TotalCarbohydrateNutrientRecord toDomain() {
    return TotalCarbohydrateNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [TotalFatNutrientRecordDto] to [TotalFatNutrientRecord].
@sinceV1_1_0
@internal
extension TotalFatNutrientRecordDtoToDomain on TotalFatNutrientRecordDto {
  TotalFatNutrientRecord toDomain() {
    return TotalFatNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [SaturatedFatNutrientRecordDto] to [SaturatedFatNutrientRecord].
@sinceV1_1_0
@internal
extension SaturatedFatNutrientRecordDtoToDomain
    on SaturatedFatNutrientRecordDto {
  SaturatedFatNutrientRecord toDomain() {
    return SaturatedFatNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [MonounsaturatedFatNutrientRecordDto] to
/// [MonounsaturatedFatNutrientRecord].
@sinceV1_1_0
@internal
extension MonounsaturatedFatNutrientRecordDtoToDomain
    on MonounsaturatedFatNutrientRecordDto {
  MonounsaturatedFatNutrientRecord toDomain() {
    return MonounsaturatedFatNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [PolyunsaturatedFatNutrientRecordDto] to
/// [PolyunsaturatedFatNutrientRecord].
@sinceV1_1_0
@internal
extension PolyunsaturatedFatNutrientRecordDtoToDomain
    on PolyunsaturatedFatNutrientRecordDto {
  PolyunsaturatedFatNutrientRecord toDomain() {
    return PolyunsaturatedFatNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [CholesterolNutrientRecordDto] to [CholesterolNutrientRecord].
@sinceV1_1_0
@internal
extension CholesterolNutrientRecordDtoToDomain on CholesterolNutrientRecordDto {
  CholesterolNutrientRecord toDomain() {
    return CholesterolNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [DietaryFiberNutrientRecordDto] to [DietaryFiberNutrientRecord].
@sinceV1_1_0
@internal
extension DietaryFiberNutrientRecordDtoToDomain
    on DietaryFiberNutrientRecordDto {
  DietaryFiberNutrientRecord toDomain() {
    return DietaryFiberNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [SugarNutrientRecordDto] to [SugarNutrientRecord].
@sinceV1_1_0
@internal
extension SugarNutrientRecordDtoToDomain on SugarNutrientRecordDto {
  SugarNutrientRecord toDomain() {
    return SugarNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminANutrientRecordDto] to [VitaminANutrientRecord].
@sinceV1_1_0
@internal
extension VitaminANutrientRecordDtoToDomain on VitaminANutrientRecordDto {
  VitaminANutrientRecord toDomain() {
    return VitaminANutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminB6NutrientRecordDto] to [VitaminB6NutrientRecord].
@sinceV1_1_0
@internal
extension VitaminB6NutrientRecordDtoToDomain on VitaminB6NutrientRecordDto {
  VitaminB6NutrientRecord toDomain() {
    return VitaminB6NutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminB12NutrientRecordDto] to [VitaminB12NutrientRecord].
@sinceV1_1_0
@internal
extension VitaminB12NutrientRecordDtoToDomain on VitaminB12NutrientRecordDto {
  VitaminB12NutrientRecord toDomain() {
    return VitaminB12NutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminCNutrientRecordDto] to [VitaminCNutrientRecord].
@sinceV1_1_0
@internal
extension VitaminCNutrientRecordDtoToDomain on VitaminCNutrientRecordDto {
  VitaminCNutrientRecord toDomain() {
    return VitaminCNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminDNutrientRecordDto] to [VitaminDNutrientRecord].
@sinceV1_1_0
@internal
extension VitaminDNutrientRecordDtoToDomain on VitaminDNutrientRecordDto {
  VitaminDNutrientRecord toDomain() {
    return VitaminDNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminENutrientRecordDto] to [VitaminENutrientRecord].
@sinceV1_1_0
@internal
extension VitaminENutrientRecordDtoToDomain on VitaminENutrientRecordDto {
  VitaminENutrientRecord toDomain() {
    return VitaminENutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminKNutrientRecordDto] to [VitaminKNutrientRecord].
@sinceV1_1_0
@internal
extension VitaminKNutrientRecordDtoToDomain on VitaminKNutrientRecordDto {
  VitaminKNutrientRecord toDomain() {
    return VitaminKNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [ThiaminNutrientRecordDto] to [ThiaminNutrientRecord].
@sinceV1_1_0
@internal
extension ThiaminNutrientRecordDtoToDomain on ThiaminNutrientRecordDto {
  ThiaminNutrientRecord toDomain() {
    return ThiaminNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [RiboflavinNutrientRecordDto] to [RiboflavinNutrientRecord].
@sinceV1_1_0
@internal
extension RiboflavinNutrientRecordDtoToDomain on RiboflavinNutrientRecordDto {
  RiboflavinNutrientRecord toDomain() {
    return RiboflavinNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [NiacinNutrientRecordDto] to [NiacinNutrientRecord].
@sinceV1_1_0
@internal
extension NiacinNutrientRecordDtoToDomain on NiacinNutrientRecordDto {
  NiacinNutrientRecord toDomain() {
    return NiacinNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [FolateNutrientRecordDto] to [FolateNutrientRecord].
@sinceV1_1_0
@internal
extension FolateNutrientRecordDtoToDomain on FolateNutrientRecordDto {
  FolateNutrientRecord toDomain() {
    return FolateNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [BiotinNutrientRecordDto] to [BiotinNutrientRecord].
@sinceV1_1_0
@internal
extension BiotinNutrientRecordDtoToDomain on BiotinNutrientRecordDto {
  BiotinNutrientRecord toDomain() {
    return BiotinNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [PantothenicAcidNutrientRecordDto] to
/// [PantothenicAcidNutrientRecord].
@sinceV1_1_0
@internal
extension PantothenicAcidNutrientRecordDtoToDomain
    on PantothenicAcidNutrientRecordDto {
  PantothenicAcidNutrientRecord toDomain() {
    return PantothenicAcidNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [CalciumNutrientRecordDto] to [CalciumNutrientRecord].
@sinceV1_1_0
@internal
extension CalciumNutrientRecordDtoToDomain on CalciumNutrientRecordDto {
  CalciumNutrientRecord toDomain() {
    return CalciumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [IronNutrientRecordDto] to [IronNutrientRecord].
@sinceV1_1_0
@internal
extension IronNutrientRecordDtoToDomain on IronNutrientRecordDto {
  IronNutrientRecord toDomain() {
    return IronNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [MagnesiumNutrientRecordDto] to [MagnesiumNutrientRecord].
@sinceV1_1_0
@internal
extension MagnesiumNutrientRecordDtoToDomain on MagnesiumNutrientRecordDto {
  MagnesiumNutrientRecord toDomain() {
    return MagnesiumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [ManganeseNutrientRecordDto] to [ManganeseNutrientRecord].
@sinceV1_1_0
@internal
extension ManganeseNutrientRecordDtoToDomain on ManganeseNutrientRecordDto {
  ManganeseNutrientRecord toDomain() {
    return ManganeseNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [PhosphorusNutrientRecordDto] to [PhosphorusNutrientRecord].
@sinceV1_1_0
@internal
extension PhosphorusNutrientRecordDtoToDomain on PhosphorusNutrientRecordDto {
  PhosphorusNutrientRecord toDomain() {
    return PhosphorusNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [PotassiumNutrientRecordDto] to [PotassiumNutrientRecord].
@sinceV1_1_0
@internal
extension PotassiumNutrientRecordDtoToDomain on PotassiumNutrientRecordDto {
  PotassiumNutrientRecord toDomain() {
    return PotassiumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [SeleniumNutrientRecordDto] to [SeleniumNutrientRecord].
@sinceV1_1_0
@internal
extension SeleniumNutrientRecordDtoToDomain on SeleniumNutrientRecordDto {
  SeleniumNutrientRecord toDomain() {
    return SeleniumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [SodiumNutrientRecordDto] to [SodiumNutrientRecord].
@sinceV1_1_0
@internal
extension SodiumNutrientRecordDtoToDomain on SodiumNutrientRecordDto {
  SodiumNutrientRecord toDomain() {
    return SodiumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [ZincNutrientRecordDto] to [ZincNutrientRecord].
@sinceV1_1_0
@internal
extension ZincNutrientRecordDtoToDomain on ZincNutrientRecordDto {
  ZincNutrientRecord toDomain() {
    return ZincNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}
