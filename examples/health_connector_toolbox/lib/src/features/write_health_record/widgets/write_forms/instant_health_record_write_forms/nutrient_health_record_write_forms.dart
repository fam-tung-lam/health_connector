import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

// region Energy & Caffeine

/// Form widget for energy nutrient records.
@immutable
final class EnergyNutrientWriteForm extends InstantHealthRecordWriteForm {
  const EnergyNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.energyNutrient);

  @override
  EnergyNutrientFormState createState() => EnergyNutrientFormState();
}

final class EnergyNutrientFormState
    extends InstantHealthRecordFormState<EnergyNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return EnergyNutrientRecord(
      time: startDateTime!,
      value: value! as Energy,
      metadata: metadata,
    );
  }
}

/// Form widget for caffeine nutrient records.
@immutable
final class CaffeineNutrientWriteForm extends InstantHealthRecordWriteForm {
  const CaffeineNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.caffeine);

  @override
  CaffeineNutrientFormState createState() => CaffeineNutrientFormState();
}

final class CaffeineNutrientFormState
    extends InstantHealthRecordFormState<CaffeineNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return CaffeineNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

// endregion

// region Macronutrients

/// Form widget for protein nutrient records.
@immutable
final class ProteinNutrientWriteForm extends InstantHealthRecordWriteForm {
  const ProteinNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.protein);

  @override
  ProteinNutrientFormState createState() => ProteinNutrientFormState();
}

final class ProteinNutrientFormState
    extends InstantHealthRecordFormState<ProteinNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return ProteinNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for total carbohydrate nutrient records.
final class TotalCarbohydrateNutrientWriteForm
    extends InstantHealthRecordWriteForm {
  const TotalCarbohydrateNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.totalCarbohydrate);

  @override
  TotalCarbohydrateNutrientFormState createState() =>
      TotalCarbohydrateNutrientFormState();
}

final class TotalCarbohydrateNutrientFormState
    extends InstantHealthRecordFormState<TotalCarbohydrateNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return TotalCarbohydrateNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for total fat nutrient records.
@immutable
final class TotalFatNutrientWriteForm extends InstantHealthRecordWriteForm {
  const TotalFatNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.totalFat);

  @override
  TotalFatNutrientFormState createState() => TotalFatNutrientFormState();
}

final class TotalFatNutrientFormState
    extends InstantHealthRecordFormState<TotalFatNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return TotalFatNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for saturated fat nutrient records.
@immutable
final class SaturatedFatNutrientWriteForm extends InstantHealthRecordWriteForm {
  const SaturatedFatNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.saturatedFat);

  @override
  SaturatedFatNutrientFormState createState() =>
      SaturatedFatNutrientFormState();
}

final class SaturatedFatNutrientFormState
    extends InstantHealthRecordFormState<SaturatedFatNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return SaturatedFatNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for monounsaturated fat nutrient records.
final class MonounsaturatedFatNutrientWriteForm
    extends InstantHealthRecordWriteForm {
  const MonounsaturatedFatNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.monounsaturatedFat);

  @override
  MonounsaturatedFatNutrientFormState createState() =>
      MonounsaturatedFatNutrientFormState();
}

final class MonounsaturatedFatNutrientFormState
    extends InstantHealthRecordFormState<MonounsaturatedFatNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return MonounsaturatedFatNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for polyunsaturated fat nutrient records.
final class PolyunsaturatedFatNutrientWriteForm
    extends InstantHealthRecordWriteForm {
  const PolyunsaturatedFatNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.polyunsaturatedFat);

  @override
  PolyunsaturatedFatNutrientFormState createState() =>
      PolyunsaturatedFatNutrientFormState();
}

final class PolyunsaturatedFatNutrientFormState
    extends InstantHealthRecordFormState<PolyunsaturatedFatNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return PolyunsaturatedFatNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for cholesterol nutrient records.
@immutable
final class CholesterolNutrientWriteForm extends InstantHealthRecordWriteForm {
  const CholesterolNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.cholesterol);

  @override
  CholesterolNutrientFormState createState() => CholesterolNutrientFormState();
}

final class CholesterolNutrientFormState
    extends InstantHealthRecordFormState<CholesterolNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return CholesterolNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for dietary fiber nutrient records.
@immutable
final class DietaryFiberNutrientWriteForm extends InstantHealthRecordWriteForm {
  const DietaryFiberNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryFiber);

  @override
  DietaryFiberNutrientFormState createState() =>
      DietaryFiberNutrientFormState();
}

final class DietaryFiberNutrientFormState
    extends InstantHealthRecordFormState<DietaryFiberNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryFiberNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for sugar nutrient records.
@immutable
final class SugarNutrientWriteForm extends InstantHealthRecordWriteForm {
  const SugarNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.sugar);

  @override
  SugarNutrientFormState createState() => SugarNutrientFormState();
}

final class SugarNutrientFormState
    extends InstantHealthRecordFormState<SugarNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return SugarNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

// endregion

// region Minerals

/// Form widget for calcium nutrient records.
@immutable
final class CalciumNutrientWriteForm extends InstantHealthRecordWriteForm {
  const CalciumNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.calcium);

  @override
  CalciumNutrientFormState createState() => CalciumNutrientFormState();
}

final class CalciumNutrientFormState
    extends InstantHealthRecordFormState<CalciumNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return CalciumNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for iron nutrient records.
@immutable
final class IronNutrientWriteForm extends InstantHealthRecordWriteForm {
  const IronNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.iron);

  @override
  IronNutrientFormState createState() => IronNutrientFormState();
}

final class IronNutrientFormState
    extends InstantHealthRecordFormState<IronNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return IronNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for magnesium nutrient records.
@immutable
final class MagnesiumNutrientWriteForm extends InstantHealthRecordWriteForm {
  const MagnesiumNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.magnesium);

  @override
  MagnesiumNutrientFormState createState() => MagnesiumNutrientFormState();
}

final class MagnesiumNutrientFormState
    extends InstantHealthRecordFormState<MagnesiumNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return MagnesiumNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for manganese nutrient records.
@immutable
final class ManganeseNutrientWriteForm extends InstantHealthRecordWriteForm {
  const ManganeseNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.manganese);

  @override
  ManganeseNutrientFormState createState() => ManganeseNutrientFormState();
}

final class ManganeseNutrientFormState
    extends InstantHealthRecordFormState<ManganeseNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return ManganeseNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for phosphorus nutrient records.
@immutable
final class PhosphorusNutrientWriteForm extends InstantHealthRecordWriteForm {
  const PhosphorusNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.phosphorus);

  @override
  PhosphorusNutrientFormState createState() => PhosphorusNutrientFormState();
}

final class PhosphorusNutrientFormState
    extends InstantHealthRecordFormState<PhosphorusNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return PhosphorusNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for potassium nutrient records.
@immutable
final class PotassiumNutrientWriteForm extends InstantHealthRecordWriteForm {
  const PotassiumNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.potassium);

  @override
  PotassiumNutrientFormState createState() => PotassiumNutrientFormState();
}

final class PotassiumNutrientFormState
    extends InstantHealthRecordFormState<PotassiumNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return PotassiumNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for selenium nutrient records.
@immutable
final class SeleniumNutrientWriteForm extends InstantHealthRecordWriteForm {
  const SeleniumNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.selenium);

  @override
  SeleniumNutrientFormState createState() => SeleniumNutrientFormState();
}

final class SeleniumNutrientFormState
    extends InstantHealthRecordFormState<SeleniumNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return SeleniumNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for sodium nutrient records.
@immutable
final class SodiumNutrientWriteForm extends InstantHealthRecordWriteForm {
  const SodiumNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.sodium);

  @override
  SodiumNutrientFormState createState() => SodiumNutrientFormState();
}

final class SodiumNutrientFormState
    extends InstantHealthRecordFormState<SodiumNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return SodiumNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for zinc nutrient records.
@immutable
final class ZincNutrientWriteForm extends InstantHealthRecordWriteForm {
  const ZincNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.zinc);

  @override
  ZincNutrientFormState createState() => ZincNutrientFormState();
}

final class ZincNutrientFormState
    extends InstantHealthRecordFormState<ZincNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return ZincNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

// endregion

// region Vitamins

/// Form widget for vitamin A nutrient records.
@immutable
final class VitaminANutrientWriteForm extends InstantHealthRecordWriteForm {
  const VitaminANutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.vitaminA);

  @override
  VitaminANutrientFormState createState() => VitaminANutrientFormState();
}

final class VitaminANutrientFormState
    extends InstantHealthRecordFormState<VitaminANutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return VitaminANutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin B6 nutrient records.
@immutable
final class VitaminB6NutrientWriteForm extends InstantHealthRecordWriteForm {
  const VitaminB6NutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.vitaminB6);

  @override
  VitaminB6NutrientFormState createState() => VitaminB6NutrientFormState();
}

final class VitaminB6NutrientFormState
    extends InstantHealthRecordFormState<VitaminB6NutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return VitaminB6NutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin B12 nutrient records.
@immutable
final class VitaminB12NutrientWriteForm extends InstantHealthRecordWriteForm {
  const VitaminB12NutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.vitaminB12);

  @override
  VitaminB12NutrientFormState createState() => VitaminB12NutrientFormState();
}

final class VitaminB12NutrientFormState
    extends InstantHealthRecordFormState<VitaminB12NutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return VitaminB12NutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin C nutrient records.
@immutable
final class VitaminCNutrientWriteForm extends InstantHealthRecordWriteForm {
  const VitaminCNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.vitaminC);

  @override
  VitaminCNutrientFormState createState() => VitaminCNutrientFormState();
}

final class VitaminCNutrientFormState
    extends InstantHealthRecordFormState<VitaminCNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return VitaminCNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin D nutrient records.
@immutable
final class VitaminDNutrientWriteForm extends InstantHealthRecordWriteForm {
  const VitaminDNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.vitaminD);

  @override
  VitaminDNutrientFormState createState() => VitaminDNutrientFormState();
}

final class VitaminDNutrientFormState
    extends InstantHealthRecordFormState<VitaminDNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return VitaminDNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin E nutrient records.
@immutable
final class VitaminENutrientWriteForm extends InstantHealthRecordWriteForm {
  const VitaminENutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.vitaminE);

  @override
  VitaminENutrientFormState createState() => VitaminENutrientFormState();
}

final class VitaminENutrientFormState
    extends InstantHealthRecordFormState<VitaminENutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return VitaminENutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin K nutrient records.
@immutable
final class VitaminKNutrientWriteForm extends InstantHealthRecordWriteForm {
  const VitaminKNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.vitaminK);

  @override
  VitaminKNutrientFormState createState() => VitaminKNutrientFormState();
}

final class VitaminKNutrientFormState
    extends InstantHealthRecordFormState<VitaminKNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return VitaminKNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for thiamin nutrient records.
@immutable
final class ThiaminNutrientWriteForm extends InstantHealthRecordWriteForm {
  const ThiaminNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.thiamin);

  @override
  ThiaminNutrientFormState createState() => ThiaminNutrientFormState();
}

final class ThiaminNutrientFormState
    extends InstantHealthRecordFormState<ThiaminNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return ThiaminNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for riboflavin nutrient records.
@immutable
final class RiboflavinNutrientWriteForm extends InstantHealthRecordWriteForm {
  const RiboflavinNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.riboflavin);

  @override
  RiboflavinNutrientFormState createState() => RiboflavinNutrientFormState();
}

final class RiboflavinNutrientFormState
    extends InstantHealthRecordFormState<RiboflavinNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return RiboflavinNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for niacin nutrient records.
@immutable
final class NiacinNutrientWriteForm extends InstantHealthRecordWriteForm {
  const NiacinNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.niacin);

  @override
  NiacinNutrientFormState createState() => NiacinNutrientFormState();
}

final class NiacinNutrientFormState
    extends InstantHealthRecordFormState<NiacinNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return NiacinNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for folate nutrient records.
@immutable
final class FolateNutrientWriteForm extends InstantHealthRecordWriteForm {
  const FolateNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.folate);

  @override
  FolateNutrientFormState createState() => FolateNutrientFormState();
}

final class FolateNutrientFormState
    extends InstantHealthRecordFormState<FolateNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return FolateNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for biotin nutrient records.
@immutable
final class BiotinNutrientWriteForm extends InstantHealthRecordWriteForm {
  const BiotinNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.biotin);

  @override
  BiotinNutrientFormState createState() => BiotinNutrientFormState();
}

final class BiotinNutrientFormState
    extends InstantHealthRecordFormState<BiotinNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BiotinNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for pantothenic acid nutrient records.
final class PantothenicAcidNutrientWriteForm
    extends InstantHealthRecordWriteForm {
  const PantothenicAcidNutrientWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.pantothenicAcid);

  @override
  PantothenicAcidNutrientFormState createState() =>
      PantothenicAcidNutrientFormState();
}

final class PantothenicAcidNutrientFormState
    extends InstantHealthRecordFormState<PantothenicAcidNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return PantothenicAcidNutrientRecord(
      time: startDateTime!,
      value: value! as Mass,
      metadata: metadata,
    );
  }
}

// endregion
