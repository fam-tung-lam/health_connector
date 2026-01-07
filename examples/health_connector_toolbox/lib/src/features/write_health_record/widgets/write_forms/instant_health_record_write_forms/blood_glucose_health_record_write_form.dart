import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/meal_type_extension.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for blood glucose records.
@immutable
final class BloodGlucoseWriteForm extends InstantHealthRecordWriteForm {
  const BloodGlucoseWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.bloodGlucose);

  @override
  BloodGlucoseFormState createState() => BloodGlucoseFormState();
}

/// State for blood glucose form widget.
final class BloodGlucoseFormState
    extends InstantHealthRecordFormState<BloodGlucoseWriteForm> {
  BloodGlucoseRelationToMeal _relationToMeal =
      BloodGlucoseRelationToMeal.unknown;
  MealType _mealType = MealType.unknown;
  BloodGlucoseSpecimenSource _specimenSource =
      BloodGlucoseSpecimenSource.unknown;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      DropdownButtonFormField<BloodGlucoseRelationToMeal>(
        initialValue: _relationToMeal,
        decoration: const InputDecoration(
          labelText: AppTexts.relationToMeal,
          border: OutlineInputBorder(),
        ),
        items: BloodGlucoseRelationToMeal.values.map((relation) {
          return DropdownMenuItem(
            value: relation,
            child: Text(_getRelationToMealLabel(relation)),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _relationToMeal = value;
            });
          }
        },
      ),
      const SizedBox(height: 16),
      DropdownButtonFormField<MealType>(
        initialValue: _mealType,
        decoration: const InputDecoration(
          labelText: AppTexts.mealType,
          border: OutlineInputBorder(),
        ),
        items: MealType.values.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text(type.displayName),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _mealType = value;
            });
          }
        },
      ),
      const SizedBox(height: 16),
      DropdownButtonFormField<BloodGlucoseSpecimenSource>(
        initialValue: _specimenSource,
        decoration: const InputDecoration(
          labelText: AppTexts.specimenSource,
          border: OutlineInputBorder(),
        ),
        items: BloodGlucoseSpecimenSource.values.map((source) {
          return DropdownMenuItem(
            value: source,
            child: Text(_getSpecimenSourceLabel(source)),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _specimenSource = value;
            });
          }
        },
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return BloodGlucoseRecord(
      time: startDateTime!,
      bloodGlucose: value! as BloodGlucose,
      relationToMeal: _relationToMeal,
      mealType: _mealType,
      specimenSource: _specimenSource,
      metadata: metadata,
    );
  }

  String _getRelationToMealLabel(BloodGlucoseRelationToMeal relation) {
    return switch (relation) {
      BloodGlucoseRelationToMeal.unknown => AppTexts.unknown,
      BloodGlucoseRelationToMeal.general => AppTexts.relationToMealGeneral,
      BloodGlucoseRelationToMeal.fasting => AppTexts.relationToMealFasting,
      BloodGlucoseRelationToMeal.beforeMeal =>
        AppTexts.relationToMealBeforeMeal,
      BloodGlucoseRelationToMeal.afterMeal => AppTexts.relationToMealAfterMeal,
    };
  }

  String _getSpecimenSourceLabel(BloodGlucoseSpecimenSource source) {
    return switch (source) {
      BloodGlucoseSpecimenSource.unknown => AppTexts.unknown,
      BloodGlucoseSpecimenSource.interstitialFluid =>
        AppTexts.specimenSourceInterstitialFluid,
      BloodGlucoseSpecimenSource.capillaryBlood =>
        AppTexts.specimenSourceCapillaryBlood,
      BloodGlucoseSpecimenSource.plasma => AppTexts.specimenSourcePlasma,
      BloodGlucoseSpecimenSource.serum => AppTexts.specimenSourceSerum,
      BloodGlucoseSpecimenSource.tears => AppTexts.specimenSourceTears,
      BloodGlucoseSpecimenSource.wholeBlood =>
        AppTexts.specimenSourceWholeBlood,
    };
  }
}
