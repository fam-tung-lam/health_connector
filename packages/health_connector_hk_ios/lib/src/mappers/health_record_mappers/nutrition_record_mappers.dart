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
        ZincNutrientRecord;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/meal_type_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show
        BiotinNutrientRecordDto,
        CaffeineNutrientRecordDto,
        CalciumNutrientRecordDto,
        CholesterolNutrientRecordDto,
        DietaryFiberNutrientRecordDto,
        EnergyDto,
        EnergyNutrientRecordDto,
        FolateNutrientRecordDto,
        IronNutrientRecordDto,
        MagnesiumNutrientRecordDto,
        ManganeseNutrientRecordDto,
        MassDto,
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

// MARK: Combined Nutrition Record - Domain to DTO

/// Converts [NutritionRecord] to [NutritionRecordDto].
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
      energy: energy?.toDto() as EnergyDto?,
      // Macronutrients
      protein: protein?.toDto() as MassDto?,
      totalCarbohydrate: totalCarbohydrate?.toDto() as MassDto?,
      totalFat: totalFat?.toDto() as MassDto?,
      saturatedFat: saturatedFat?.toDto() as MassDto?,
      monounsaturatedFat: monounsaturatedFat?.toDto() as MassDto?,
      polyunsaturatedFat: polyunsaturatedFat?.toDto() as MassDto?,
      cholesterol: cholesterol?.toDto() as MassDto?,
      dietaryFiber: dietaryFiber?.toDto() as MassDto?,
      sugar: sugar?.toDto() as MassDto?,
      // Vitamins
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
      // Minerals
      calcium: calcium?.toDto() as MassDto?,
      iron: iron?.toDto() as MassDto?,
      magnesium: magnesium?.toDto() as MassDto?,
      manganese: manganese?.toDto() as MassDto?,
      phosphorus: phosphorus?.toDto() as MassDto?,
      potassium: potassium?.toDto() as MassDto?,
      selenium: selenium?.toDto() as MassDto?,
      sodium: sodium?.toDto() as MassDto?,
      zinc: zinc?.toDto() as MassDto?,
      // Other
      caffeine: caffeine?.toDto() as MassDto?,
    );
  }
}

// MARK: Nutrients - Domain to DTO

/// Converts [EnergyNutrientRecord] to [EnergyNutrientRecordDto].
@internal
extension EnergyNutrientRecordToDto on EnergyNutrientRecord {
  EnergyNutrientRecordDto toDto() {
    return EnergyNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as EnergyDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [CaffeineNutrientRecord] to [CaffeineNutrientRecordDto].
@internal
extension CaffeineNutrientRecordToDto on CaffeineNutrientRecord {
  CaffeineNutrientRecordDto toDto() {
    return CaffeineNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [ProteinNutrientRecord] to [ProteinNutrientRecordDto].
@internal
extension ProteinNutrientRecordToDto on ProteinNutrientRecord {
  ProteinNutrientRecordDto toDto() {
    return ProteinNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [TotalCarbohydrateNutrientRecord] to
/// [TotalCarbohydrateNutrientRecordDto].
@internal
extension TotalCarbohydrateNutrientRecordToDto
    on TotalCarbohydrateNutrientRecord {
  TotalCarbohydrateNutrientRecordDto toDto() {
    return TotalCarbohydrateNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [TotalFatNutrientRecord] to [TotalFatNutrientRecordDto].
@internal
extension TotalFatNutrientRecordToDto on TotalFatNutrientRecord {
  TotalFatNutrientRecordDto toDto() {
    return TotalFatNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [SaturatedFatNutrientRecord] to [SaturatedFatNutrientRecordDto].
@internal
extension SaturatedFatNutrientRecordToDto on SaturatedFatNutrientRecord {
  SaturatedFatNutrientRecordDto toDto() {
    return SaturatedFatNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [MonounsaturatedFatNutrientRecord] to
/// [MonounsaturatedFatNutrientRecordDto].
@internal
extension MonounsaturatedFatNutrientRecordToDto
    on MonounsaturatedFatNutrientRecord {
  MonounsaturatedFatNutrientRecordDto toDto() {
    return MonounsaturatedFatNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PolyunsaturatedFatNutrientRecord] to
/// [PolyunsaturatedFatNutrientRecordDto].
@internal
extension PolyunsaturatedFatNutrientRecordToDto
    on PolyunsaturatedFatNutrientRecord {
  PolyunsaturatedFatNutrientRecordDto toDto() {
    return PolyunsaturatedFatNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [CholesterolNutrientRecord] to [CholesterolNutrientRecordDto].
@internal
extension CholesterolNutrientRecordToDto on CholesterolNutrientRecord {
  CholesterolNutrientRecordDto toDto() {
    return CholesterolNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [DietaryFiberNutrientRecord] to [DietaryFiberNutrientRecordDto].
@internal
extension DietaryFiberNutrientRecordToDto on DietaryFiberNutrientRecord {
  DietaryFiberNutrientRecordDto toDto() {
    return DietaryFiberNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [SugarNutrientRecord] to [SugarNutrientRecordDto].
@internal
extension SugarNutrientRecordToDto on SugarNutrientRecord {
  SugarNutrientRecordDto toDto() {
    return SugarNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminANutrientRecord] to [VitaminANutrientRecordDto].
@internal
extension VitaminANutrientRecordToDto on VitaminANutrientRecord {
  VitaminANutrientRecordDto toDto() {
    return VitaminANutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminB6NutrientRecord] to [VitaminB6NutrientRecordDto].
@internal
extension VitaminB6NutrientRecordToDto on VitaminB6NutrientRecord {
  VitaminB6NutrientRecordDto toDto() {
    return VitaminB6NutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminB12NutrientRecord] to [VitaminB12NutrientRecordDto].
@internal
extension VitaminB12NutrientRecordToDto on VitaminB12NutrientRecord {
  VitaminB12NutrientRecordDto toDto() {
    return VitaminB12NutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminCNutrientRecord] to [VitaminCNutrientRecordDto].
@internal
extension VitaminCNutrientRecordToDto on VitaminCNutrientRecord {
  VitaminCNutrientRecordDto toDto() {
    return VitaminCNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminDNutrientRecord] to [VitaminDNutrientRecordDto].
@internal
extension VitaminDNutrientRecordToDto on VitaminDNutrientRecord {
  VitaminDNutrientRecordDto toDto() {
    return VitaminDNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminENutrientRecord] to [VitaminENutrientRecordDto].
@internal
extension VitaminENutrientRecordToDto on VitaminENutrientRecord {
  VitaminENutrientRecordDto toDto() {
    return VitaminENutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [VitaminKNutrientRecord] to [VitaminKNutrientRecordDto].
@internal
extension VitaminKNutrientRecordToDto on VitaminKNutrientRecord {
  VitaminKNutrientRecordDto toDto() {
    return VitaminKNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [ThiaminNutrientRecord] to [ThiaminNutrientRecordDto].
@internal
extension ThiaminNutrientRecordToDto on ThiaminNutrientRecord {
  ThiaminNutrientRecordDto toDto() {
    return ThiaminNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [RiboflavinNutrientRecord] to [RiboflavinNutrientRecordDto].
@internal
extension RiboflavinNutrientRecordToDto on RiboflavinNutrientRecord {
  RiboflavinNutrientRecordDto toDto() {
    return RiboflavinNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [NiacinNutrientRecord] to [NiacinNutrientRecordDto].
@internal
extension NiacinNutrientRecordToDto on NiacinNutrientRecord {
  NiacinNutrientRecordDto toDto() {
    return NiacinNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [FolateNutrientRecord] to [FolateNutrientRecordDto].
@internal
extension FolateNutrientRecordToDto on FolateNutrientRecord {
  FolateNutrientRecordDto toDto() {
    return FolateNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [BiotinNutrientRecord] to [BiotinNutrientRecordDto].
@internal
extension BiotinNutrientRecordToDto on BiotinNutrientRecord {
  BiotinNutrientRecordDto toDto() {
    return BiotinNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PantothenicAcidNutrientRecord] to
/// [PantothenicAcidNutrientRecordDto].
@internal
extension PantothenicAcidNutrientRecordToDto on PantothenicAcidNutrientRecord {
  PantothenicAcidNutrientRecordDto toDto() {
    return PantothenicAcidNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [CalciumNutrientRecord] to [CalciumNutrientRecordDto].
@internal
extension CalciumNutrientRecordToDto on CalciumNutrientRecord {
  CalciumNutrientRecordDto toDto() {
    return CalciumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [IronNutrientRecord] to [IronNutrientRecordDto].
@internal
extension IronNutrientRecordToDto on IronNutrientRecord {
  IronNutrientRecordDto toDto() {
    return IronNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [MagnesiumNutrientRecord] to [MagnesiumNutrientRecordDto].
@internal
extension MagnesiumNutrientRecordToDto on MagnesiumNutrientRecord {
  MagnesiumNutrientRecordDto toDto() {
    return MagnesiumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [ManganeseNutrientRecord] to [ManganeseNutrientRecordDto].
@internal
extension ManganeseNutrientRecordToDto on ManganeseNutrientRecord {
  ManganeseNutrientRecordDto toDto() {
    return ManganeseNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PhosphorusNutrientRecord] to [PhosphorusNutrientRecordDto].
@internal
extension PhosphorusNutrientRecordToDto on PhosphorusNutrientRecord {
  PhosphorusNutrientRecordDto toDto() {
    return PhosphorusNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PotassiumNutrientRecord] to [PotassiumNutrientRecordDto].
@internal
extension PotassiumNutrientRecordToDto on PotassiumNutrientRecord {
  PotassiumNutrientRecordDto toDto() {
    return PotassiumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [SeleniumNutrientRecord] to [SeleniumNutrientRecordDto].
@internal
extension SeleniumNutrientRecordToDto on SeleniumNutrientRecord {
  SeleniumNutrientRecordDto toDto() {
    return SeleniumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [SodiumNutrientRecord] to [SodiumNutrientRecordDto].
@internal
extension SodiumNutrientRecordToDto on SodiumNutrientRecord {
  SodiumNutrientRecordDto toDto() {
    return SodiumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [ZincNutrientRecord] to [ZincNutrientRecordDto].
@internal
extension ZincNutrientRecordToDto on ZincNutrientRecord {
  ZincNutrientRecordDto toDto() {
    return ZincNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto() as MassDto,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

// MARK: Combined Nutrition Record - DTO to Domain

/// Converts [NutritionRecordDto] to [NutritionRecord].
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
      energy: energy?.toDomain() as Energy?,
      // Macronutrients
      protein: protein?.toDomain() as Mass?,
      totalCarbohydrate: totalCarbohydrate?.toDomain() as Mass?,
      totalFat: totalFat?.toDomain() as Mass?,
      saturatedFat: saturatedFat?.toDomain() as Mass?,
      monounsaturatedFat: monounsaturatedFat?.toDomain() as Mass?,
      polyunsaturatedFat: polyunsaturatedFat?.toDomain() as Mass?,
      cholesterol: cholesterol?.toDomain() as Mass?,
      dietaryFiber: dietaryFiber?.toDomain() as Mass?,
      sugar: sugar?.toDomain() as Mass?,
      // Vitamins
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
      // Minerals
      calcium: calcium?.toDomain() as Mass?,
      iron: iron?.toDomain() as Mass?,
      magnesium: magnesium?.toDomain() as Mass?,
      manganese: manganese?.toDomain() as Mass?,
      phosphorus: phosphorus?.toDomain() as Mass?,
      potassium: potassium?.toDomain() as Mass?,
      selenium: selenium?.toDomain() as Mass?,
      sodium: sodium?.toDomain() as Mass?,
      zinc: zinc?.toDomain() as Mass?,
      // Other
      caffeine: caffeine?.toDomain() as Mass?,
    );
  }
}

// MARK: Nutrients - DTO to Domain

/// Converts [EnergyNutrientRecordDto] to [EnergyNutrientRecord].
@internal
extension EnergyNutrientRecordDtoToDomain on EnergyNutrientRecordDto {
  EnergyNutrientRecord toDomain() {
    return EnergyNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Energy,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [CaffeineNutrientRecordDto] to [CaffeineNutrientRecord].
@internal
extension CaffeineNutrientRecordDtoToDomain on CaffeineNutrientRecordDto {
  CaffeineNutrientRecord toDomain() {
    return CaffeineNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [ProteinNutrientRecordDto] to [ProteinNutrientRecord].
@internal
extension ProteinNutrientRecordDtoToDomain on ProteinNutrientRecordDto {
  ProteinNutrientRecord toDomain() {
    return ProteinNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [TotalCarbohydrateNutrientRecordDto] to
/// [TotalCarbohydrateNutrientRecord].
@internal
extension TotalCarbohydrateNutrientRecordDtoToDomain
    on TotalCarbohydrateNutrientRecordDto {
  TotalCarbohydrateNutrientRecord toDomain() {
    return TotalCarbohydrateNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [TotalFatNutrientRecordDto] to [TotalFatNutrientRecord].
@internal
extension TotalFatNutrientRecordDtoToDomain on TotalFatNutrientRecordDto {
  TotalFatNutrientRecord toDomain() {
    return TotalFatNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [SaturatedFatNutrientRecordDto] to [SaturatedFatNutrientRecord].
@internal
extension SaturatedFatNutrientRecordDtoToDomain
    on SaturatedFatNutrientRecordDto {
  SaturatedFatNutrientRecord toDomain() {
    return SaturatedFatNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [MonounsaturatedFatNutrientRecordDto] to
/// [MonounsaturatedFatNutrientRecord].
@internal
extension MonounsaturatedFatNutrientRecordDtoToDomain
    on MonounsaturatedFatNutrientRecordDto {
  MonounsaturatedFatNutrientRecord toDomain() {
    return MonounsaturatedFatNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [PolyunsaturatedFatNutrientRecordDto] to
/// [PolyunsaturatedFatNutrientRecord].
@internal
extension PolyunsaturatedFatNutrientRecordDtoToDomain
    on PolyunsaturatedFatNutrientRecordDto {
  PolyunsaturatedFatNutrientRecord toDomain() {
    return PolyunsaturatedFatNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [CholesterolNutrientRecordDto] to [CholesterolNutrientRecord].
@internal
extension CholesterolNutrientRecordDtoToDomain on CholesterolNutrientRecordDto {
  CholesterolNutrientRecord toDomain() {
    return CholesterolNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [DietaryFiberNutrientRecordDto] to [DietaryFiberNutrientRecord].
@internal
extension DietaryFiberNutrientRecordDtoToDomain
    on DietaryFiberNutrientRecordDto {
  DietaryFiberNutrientRecord toDomain() {
    return DietaryFiberNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [SugarNutrientRecordDto] to [SugarNutrientRecord].
@internal
extension SugarNutrientRecordDtoToDomain on SugarNutrientRecordDto {
  SugarNutrientRecord toDomain() {
    return SugarNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminANutrientRecordDto] to [VitaminANutrientRecord].
@internal
extension VitaminANutrientRecordDtoToDomain on VitaminANutrientRecordDto {
  VitaminANutrientRecord toDomain() {
    return VitaminANutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminB6NutrientRecordDto] to [VitaminB6NutrientRecord].
@internal
extension VitaminB6NutrientRecordDtoToDomain on VitaminB6NutrientRecordDto {
  VitaminB6NutrientRecord toDomain() {
    return VitaminB6NutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminB12NutrientRecordDto] to [VitaminB12NutrientRecord].
@internal
extension VitaminB12NutrientRecordDtoToDomain on VitaminB12NutrientRecordDto {
  VitaminB12NutrientRecord toDomain() {
    return VitaminB12NutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminCNutrientRecordDto] to [VitaminCNutrientRecord].
@internal
extension VitaminCNutrientRecordDtoToDomain on VitaminCNutrientRecordDto {
  VitaminCNutrientRecord toDomain() {
    return VitaminCNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminDNutrientRecordDto] to [VitaminDNutrientRecord].
@internal
extension VitaminDNutrientRecordDtoToDomain on VitaminDNutrientRecordDto {
  VitaminDNutrientRecord toDomain() {
    return VitaminDNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminENutrientRecordDto] to [VitaminENutrientRecord].
@internal
extension VitaminENutrientRecordDtoToDomain on VitaminENutrientRecordDto {
  VitaminENutrientRecord toDomain() {
    return VitaminENutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [VitaminKNutrientRecordDto] to [VitaminKNutrientRecord].
@internal
extension VitaminKNutrientRecordDtoToDomain on VitaminKNutrientRecordDto {
  VitaminKNutrientRecord toDomain() {
    return VitaminKNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [ThiaminNutrientRecordDto] to [ThiaminNutrientRecord].
@internal
extension ThiaminNutrientRecordDtoToDomain on ThiaminNutrientRecordDto {
  ThiaminNutrientRecord toDomain() {
    return ThiaminNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [RiboflavinNutrientRecordDto] to [RiboflavinNutrientRecord].
@internal
extension RiboflavinNutrientRecordDtoToDomain on RiboflavinNutrientRecordDto {
  RiboflavinNutrientRecord toDomain() {
    return RiboflavinNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [NiacinNutrientRecordDto] to [NiacinNutrientRecord].
@internal
extension NiacinNutrientRecordDtoToDomain on NiacinNutrientRecordDto {
  NiacinNutrientRecord toDomain() {
    return NiacinNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [FolateNutrientRecordDto] to [FolateNutrientRecord].
@internal
extension FolateNutrientRecordDtoToDomain on FolateNutrientRecordDto {
  FolateNutrientRecord toDomain() {
    return FolateNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [BiotinNutrientRecordDto] to [BiotinNutrientRecord].
@internal
extension BiotinNutrientRecordDtoToDomain on BiotinNutrientRecordDto {
  BiotinNutrientRecord toDomain() {
    return BiotinNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [PantothenicAcidNutrientRecordDto] to
/// [PantothenicAcidNutrientRecord].
@internal
extension PantothenicAcidNutrientRecordDtoToDomain
    on PantothenicAcidNutrientRecordDto {
  PantothenicAcidNutrientRecord toDomain() {
    return PantothenicAcidNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [CalciumNutrientRecordDto] to [CalciumNutrientRecord].
@internal
extension CalciumNutrientRecordDtoToDomain on CalciumNutrientRecordDto {
  CalciumNutrientRecord toDomain() {
    return CalciumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [IronNutrientRecordDto] to [IronNutrientRecord].
@internal
extension IronNutrientRecordDtoToDomain on IronNutrientRecordDto {
  IronNutrientRecord toDomain() {
    return IronNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [MagnesiumNutrientRecordDto] to [MagnesiumNutrientRecord].
@internal
extension MagnesiumNutrientRecordDtoToDomain on MagnesiumNutrientRecordDto {
  MagnesiumNutrientRecord toDomain() {
    return MagnesiumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [ManganeseNutrientRecordDto] to [ManganeseNutrientRecord].
@internal
extension ManganeseNutrientRecordDtoToDomain on ManganeseNutrientRecordDto {
  ManganeseNutrientRecord toDomain() {
    return ManganeseNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [PhosphorusNutrientRecordDto] to [PhosphorusNutrientRecord].
@internal
extension PhosphorusNutrientRecordDtoToDomain on PhosphorusNutrientRecordDto {
  PhosphorusNutrientRecord toDomain() {
    return PhosphorusNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [PotassiumNutrientRecordDto] to [PotassiumNutrientRecord].
@internal
extension PotassiumNutrientRecordDtoToDomain on PotassiumNutrientRecordDto {
  PotassiumNutrientRecord toDomain() {
    return PotassiumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [SeleniumNutrientRecordDto] to [SeleniumNutrientRecord].
@internal
extension SeleniumNutrientRecordDtoToDomain on SeleniumNutrientRecordDto {
  SeleniumNutrientRecord toDomain() {
    return SeleniumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [SodiumNutrientRecordDto] to [SodiumNutrientRecord].
@internal
extension SodiumNutrientRecordDtoToDomain on SodiumNutrientRecordDto {
  SodiumNutrientRecord toDomain() {
    return SodiumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}

/// Converts [ZincNutrientRecordDto] to [ZincNutrientRecord].
@internal
extension ZincNutrientRecordDtoToDomain on ZincNutrientRecordDto {
  ZincNutrientRecord toDomain() {
    return ZincNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain() as Mass,
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}
