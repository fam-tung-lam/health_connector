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
  }) : super(dataType: HealthDataType.dietaryEnergyConsumed);

  @override
  EnergyNutrientFormState createState() => EnergyNutrientFormState();
}

final class EnergyNutrientFormState
    extends InstantHealthRecordFormState<EnergyNutrientWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryEnergyConsumedRecord(
      time: startDateTime!,
      energy: value! as Energy,
      metadata: metadata,
    );
  }
}

/// Form widget for caffeine nutrient records.
@immutable
final class DietaryCaffeineWriteForm extends InstantHealthRecordWriteForm {
  const DietaryCaffeineWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryCaffeine);

  @override
  DietaryCaffeineFormState createState() => DietaryCaffeineFormState();
}

final class DietaryCaffeineFormState
    extends InstantHealthRecordFormState<DietaryCaffeineWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryCaffeineRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

// endregion

// region Macronutrients

/// Form widget for protein nutrient records.
@immutable
final class DietaryProteinWriteForm extends InstantHealthRecordWriteForm {
  const DietaryProteinWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryProtein);

  @override
  DietaryProteinFormState createState() => DietaryProteinFormState();
}

final class DietaryProteinFormState
    extends InstantHealthRecordFormState<DietaryProteinWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryProteinRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for total carbohydrate nutrient records.
final class DietaryTotalCarbohydrateWriteForm
    extends InstantHealthRecordWriteForm {
  const DietaryTotalCarbohydrateWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryTotalCarbohydrate);

  @override
  DietaryTotalCarbohydrateFormState createState() =>
      DietaryTotalCarbohydrateFormState();
}

final class DietaryTotalCarbohydrateFormState
    extends InstantHealthRecordFormState<DietaryTotalCarbohydrateWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryTotalCarbohydrateRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for total fat nutrient records.
@immutable
final class DietaryTotalFatWriteForm extends InstantHealthRecordWriteForm {
  const DietaryTotalFatWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryTotalFat);

  @override
  DietaryTotalFatFormState createState() => DietaryTotalFatFormState();
}

final class DietaryTotalFatFormState
    extends InstantHealthRecordFormState<DietaryTotalFatWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryTotalFatRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for saturated fat nutrient records.
@immutable
final class DietarySaturatedFatWriteForm extends InstantHealthRecordWriteForm {
  const DietarySaturatedFatWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietarySaturatedFat);

  @override
  DietarySaturatedFatFormState createState() => DietarySaturatedFatFormState();
}

final class DietarySaturatedFatFormState
    extends InstantHealthRecordFormState<DietarySaturatedFatWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietarySaturatedFatRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for monounsaturated fat nutrient records.
final class DietaryMonounsaturatedFatWriteForm
    extends InstantHealthRecordWriteForm {
  const DietaryMonounsaturatedFatWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryMonounsaturatedFat);

  @override
  DietaryMonounsaturatedFatFormState createState() =>
      DietaryMonounsaturatedFatFormState();
}

final class DietaryMonounsaturatedFatFormState
    extends InstantHealthRecordFormState<DietaryMonounsaturatedFatWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryMonounsaturatedFatRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for polyunsaturated fat nutrient records.
final class DietaryPolyunsaturatedFatWriteForm
    extends InstantHealthRecordWriteForm {
  const DietaryPolyunsaturatedFatWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryPolyunsaturatedFat);

  @override
  DietaryPolyunsaturatedFatFormState createState() =>
      DietaryPolyunsaturatedFatFormState();
}

final class DietaryPolyunsaturatedFatFormState
    extends InstantHealthRecordFormState<DietaryPolyunsaturatedFatWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryPolyunsaturatedFatRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for cholesterol nutrient records.
@immutable
final class DietaryCholesterolWriteForm extends InstantHealthRecordWriteForm {
  const DietaryCholesterolWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryCholesterol);

  @override
  DietaryCholesterolFormState createState() => DietaryCholesterolFormState();
}

final class DietaryCholesterolFormState
    extends InstantHealthRecordFormState<DietaryCholesterolWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryCholesterolRecord(
      time: startDateTime!,
      mass: value! as Mass,
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
    return DietaryFiberRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for sugar nutrient records.
@immutable
final class DietarySugarWriteForm extends InstantHealthRecordWriteForm {
  const DietarySugarWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietarySugar);

  @override
  DietarySugarFormState createState() => DietarySugarFormState();
}

final class DietarySugarFormState
    extends InstantHealthRecordFormState<DietarySugarWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietarySugarRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

// endregion

// region Minerals

/// Form widget for calcium nutrient records.
@immutable
final class DietaryCalciumWriteForm extends InstantHealthRecordWriteForm {
  const DietaryCalciumWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryCalcium);

  @override
  DietaryCalciumFormState createState() => DietaryCalciumFormState();
}

final class DietaryCalciumFormState
    extends InstantHealthRecordFormState<DietaryCalciumWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryCalciumRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for iron nutrient records.
@immutable
final class DietaryIronWriteForm extends InstantHealthRecordWriteForm {
  const DietaryIronWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryIron);

  @override
  DietaryIronFormState createState() => DietaryIronFormState();
}

final class DietaryIronFormState
    extends InstantHealthRecordFormState<DietaryIronWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryIronRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for magnesium nutrient records.
@immutable
final class DietaryMagnesiumWriteForm extends InstantHealthRecordWriteForm {
  const DietaryMagnesiumWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryMagnesium);

  @override
  DietaryMagnesiumFormState createState() => DietaryMagnesiumFormState();
}

final class DietaryMagnesiumFormState
    extends InstantHealthRecordFormState<DietaryMagnesiumWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryMagnesiumRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for manganese nutrient records.
@immutable
final class DietaryManganeseWriteForm extends InstantHealthRecordWriteForm {
  const DietaryManganeseWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryManganese);

  @override
  DietaryManganeseFormState createState() => DietaryManganeseFormState();
}

final class DietaryManganeseFormState
    extends InstantHealthRecordFormState<DietaryManganeseWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryManganeseRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for phosphorus nutrient records.
@immutable
final class DietaryPhosphorusWriteForm extends InstantHealthRecordWriteForm {
  const DietaryPhosphorusWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryPhosphorus);

  @override
  DietaryPhosphorusFormState createState() => DietaryPhosphorusFormState();
}

final class DietaryPhosphorusFormState
    extends InstantHealthRecordFormState<DietaryPhosphorusWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryPhosphorusRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for potassium nutrient records.
@immutable
final class DietaryPotassiumWriteForm extends InstantHealthRecordWriteForm {
  const DietaryPotassiumWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryPotassium);

  @override
  DietaryPotassiumFormState createState() => DietaryPotassiumFormState();
}

final class DietaryPotassiumFormState
    extends InstantHealthRecordFormState<DietaryPotassiumWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryPotassiumRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for selenium nutrient records.
@immutable
final class DietarySeleniumWriteForm extends InstantHealthRecordWriteForm {
  const DietarySeleniumWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietarySelenium);

  @override
  DietarySeleniumFormState createState() => DietarySeleniumFormState();
}

final class DietarySeleniumFormState
    extends InstantHealthRecordFormState<DietarySeleniumWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietarySeleniumRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for sodium nutrient records.
@immutable
final class DietarySodiumWriteForm extends InstantHealthRecordWriteForm {
  const DietarySodiumWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietarySodium);

  @override
  DietarySodiumFormState createState() => DietarySodiumFormState();
}

final class DietarySodiumFormState
    extends InstantHealthRecordFormState<DietarySodiumWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietarySodiumRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for zinc nutrient records.
@immutable
final class DietaryZincWriteForm extends InstantHealthRecordWriteForm {
  const DietaryZincWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryZinc);

  @override
  DietaryZincFormState createState() => DietaryZincFormState();
}

final class DietaryZincFormState
    extends InstantHealthRecordFormState<DietaryZincWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryZincRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

// endregion

// region Vitamins

/// Form widget for vitamin A nutrient records.
@immutable
final class DietaryVitaminAWriteForm extends InstantHealthRecordWriteForm {
  const DietaryVitaminAWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryVitaminA);

  @override
  DietaryVitaminAFormState createState() => DietaryVitaminAFormState();
}

final class DietaryVitaminAFormState
    extends InstantHealthRecordFormState<DietaryVitaminAWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryVitaminARecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin B6 nutrient records.
@immutable
final class DietaryVitaminB6WriteForm extends InstantHealthRecordWriteForm {
  const DietaryVitaminB6WriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryVitaminB6);

  @override
  DietaryVitaminB6FormState createState() => DietaryVitaminB6FormState();
}

final class DietaryVitaminB6FormState
    extends InstantHealthRecordFormState<DietaryVitaminB6WriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryVitaminB6Record(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin B12 nutrient records.
@immutable
final class DietaryVitaminB12WriteForm extends InstantHealthRecordWriteForm {
  const DietaryVitaminB12WriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryVitaminB12);

  @override
  DietaryVitaminB12FormState createState() => DietaryVitaminB12FormState();
}

final class DietaryVitaminB12FormState
    extends InstantHealthRecordFormState<DietaryVitaminB12WriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryVitaminB12Record(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin C nutrient records.
@immutable
final class DietaryVitaminCWriteForm extends InstantHealthRecordWriteForm {
  const DietaryVitaminCWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryVitaminC);

  @override
  DietaryVitaminCFormState createState() => DietaryVitaminCFormState();
}

final class DietaryVitaminCFormState
    extends InstantHealthRecordFormState<DietaryVitaminCWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryVitaminCRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin D nutrient records.
@immutable
final class DietaryVitaminDWriteForm extends InstantHealthRecordWriteForm {
  const DietaryVitaminDWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryVitaminD);

  @override
  DietaryVitaminDFormState createState() => DietaryVitaminDFormState();
}

final class DietaryVitaminDFormState
    extends InstantHealthRecordFormState<DietaryVitaminDWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryVitaminDRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin E nutrient records.
@immutable
final class DietaryVitaminEWriteForm extends InstantHealthRecordWriteForm {
  const DietaryVitaminEWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryVitaminE);

  @override
  DietaryVitaminEFormState createState() => DietaryVitaminEFormState();
}

final class DietaryVitaminEFormState
    extends InstantHealthRecordFormState<DietaryVitaminEWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryVitaminERecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for vitamin K nutrient records.
@immutable
final class DietaryVitaminKWriteForm extends InstantHealthRecordWriteForm {
  const DietaryVitaminKWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryVitaminK);

  @override
  DietaryVitaminKFormState createState() => DietaryVitaminKFormState();
}

final class DietaryVitaminKFormState
    extends InstantHealthRecordFormState<DietaryVitaminKWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryVitaminKRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for thiamin nutrient records.
@immutable
final class DietaryThiaminWriteForm extends InstantHealthRecordWriteForm {
  const DietaryThiaminWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryThiamin);

  @override
  DietaryThiaminFormState createState() => DietaryThiaminFormState();
}

final class DietaryThiaminFormState
    extends InstantHealthRecordFormState<DietaryThiaminWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryThiaminRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for riboflavin nutrient records.
@immutable
final class DietaryRiboflavinWriteForm extends InstantHealthRecordWriteForm {
  const DietaryRiboflavinWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryRiboflavin);

  @override
  DietaryRiboflavinFormState createState() => DietaryRiboflavinFormState();
}

final class DietaryRiboflavinFormState
    extends InstantHealthRecordFormState<DietaryRiboflavinWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryRiboflavinRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for niacin nutrient records.
@immutable
final class DietaryNiacinWriteForm extends InstantHealthRecordWriteForm {
  const DietaryNiacinWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryNiacin);

  @override
  DietaryNiacinFormState createState() => DietaryNiacinFormState();
}

final class DietaryNiacinFormState
    extends InstantHealthRecordFormState<DietaryNiacinWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryNiacinRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for folate nutrient records.
@immutable
final class DietaryFolateWriteForm extends InstantHealthRecordWriteForm {
  const DietaryFolateWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryFolate);

  @override
  DietaryFolateFormState createState() => DietaryFolateFormState();
}

final class DietaryFolateFormState
    extends InstantHealthRecordFormState<DietaryFolateWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryFolateRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for biotin nutrient records.
@immutable
final class DietaryBiotinWriteForm extends InstantHealthRecordWriteForm {
  const DietaryBiotinWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryBiotin);

  @override
  DietaryBiotinFormState createState() => DietaryBiotinFormState();
}

final class DietaryBiotinFormState
    extends InstantHealthRecordFormState<DietaryBiotinWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryBiotinRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

/// Form widget for pantothenic acid nutrient records.
final class DietaryPantothenicAcidWriteForm
    extends InstantHealthRecordWriteForm {
  const DietaryPantothenicAcidWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.dietaryPantothenicAcid);

  @override
  DietaryPantothenicAcidFormState createState() =>
      DietaryPantothenicAcidFormState();
}

final class DietaryPantothenicAcidFormState
    extends InstantHealthRecordFormState<DietaryPantothenicAcidWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DietaryPantothenicAcidRecord(
      time: startDateTime!,
      mass: value! as Mass,
      metadata: metadata,
    );
  }
}

// endregion
