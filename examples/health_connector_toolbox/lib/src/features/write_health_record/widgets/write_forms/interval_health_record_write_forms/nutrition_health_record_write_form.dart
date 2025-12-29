import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/models/nutrition_form_data.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/nutrient_write_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for nutrition records.
@immutable
final class NutritionWriteForm extends IntervalHealthRecordWriteForm {
  const NutritionWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  NutritionFormState createState() => NutritionFormState();
}

/// State for nutrition form widget.
final class NutritionFormState
    extends IntervalHealthRecordFormState<NutritionWriteForm> {
  NutritionData nutritionData = const NutritionData();

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      NutrientWriteFormFieldGroup(
        onChanged: (data) => setState(() => nutritionData = data),
      ),
    ];
  }

  @override
  bool validate() {
    // All nutrition fields are optional, so form validation is always valid
    return formKey.currentState?.validate() ?? false;
  }

  @override
  HealthRecord buildRecord() {
    return NutritionRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      metadata: metadata,
      foodName: nutritionData.foodName,
      mealType: nutritionData.mealType,
      energy: nutritionData.energy,
      protein: nutritionData.protein,
      totalCarbohydrate: nutritionData.totalCarbohydrate,
      totalFat: nutritionData.totalFat,
      saturatedFat: nutritionData.saturatedFat,
      monounsaturatedFat: nutritionData.monounsaturatedFat,
      polyunsaturatedFat: nutritionData.polyunsaturatedFat,
      cholesterol: nutritionData.cholesterol,
      dietaryFiber: nutritionData.dietaryFiber,
      sugar: nutritionData.sugar,
      vitaminA: nutritionData.vitaminA,
      vitaminB6: nutritionData.vitaminB6,
      vitaminB12: nutritionData.vitaminB12,
      vitaminC: nutritionData.vitaminC,
      vitaminD: nutritionData.vitaminD,
      vitaminE: nutritionData.vitaminE,
      vitaminK: nutritionData.vitaminK,
      thiamin: nutritionData.thiamin,
      riboflavin: nutritionData.riboflavin,
      niacin: nutritionData.niacin,
      folate: nutritionData.folate,
      biotin: nutritionData.biotin,
      pantothenicAcid: nutritionData.pantothenicAcid,
      calcium: nutritionData.calcium,
      iron: nutritionData.iron,
      magnesium: nutritionData.magnesium,
      manganese: nutritionData.manganese,
      phosphorus: nutritionData.phosphorus,
      potassium: nutritionData.potassium,
      selenium: nutritionData.selenium,
      sodium: nutritionData.sodium,
      zinc: nutritionData.zinc,
      caffeine: nutritionData.caffeine,
    );
  }
}
