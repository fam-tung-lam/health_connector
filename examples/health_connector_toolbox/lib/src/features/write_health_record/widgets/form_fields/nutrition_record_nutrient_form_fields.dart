import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show Energy, HealthDataType, Mass, MealType, MeasurementUnit;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/health_data_type_ui_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/meal_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/measurement_unit_value_parser.dart';
import 'package:health_connector_toolbox/src/common/utils/measurement_unit_value_validator.dart';
import 'package:health_connector_toolbox/src/common/widgets/collapsible_form_section.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/models/nutrition_form_data.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/enum_dropdown_form_field.dart';

/// A form field widget for entering nutrition record data.
///
/// Allows entering multiple optional nutrient values including energy,
/// macronutrients, vitamins, minerals, and other nutrients.
/// Fields are organized into collapsible sections to reduce cognitive load.
///
/// Uses extension methods on [HealthDataType] to build nutrient fields
/// dynamically with consistent styling and validation.
@immutable
final class NutritionRecordNutrientFormFields extends StatefulWidget {
  const NutritionRecordNutrientFormFields({
    required this.onChanged,
    super.key,
  });

  /// Callback when nutrition data changes.
  ///
  /// Provides a [NutritionData] object containing all entered values.
  final ValueChanged<NutritionData> onChanged;

  @override
  State<NutritionRecordNutrientFormFields> createState() =>
      _NutritionRecordNutrientFormFieldsState();
}

class _NutritionRecordNutrientFormFieldsState
    extends State<NutritionRecordNutrientFormFields> {
  String? _foodName;
  MealType _mealType = MealType.unknown;
  final Map<HealthDataType, TextEditingController> _controllers = {};
  final Map<HealthDataType, MeasurementUnit?> _values = {};

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _notifyChanged() {
    widget.onChanged(
      NutritionData(
        foodName: _foodName?.isEmpty ?? true ? null : _foodName,
        mealType: _mealType,
        energy: _values[HealthDataType.energyNutrient] as Energy?,
        protein: _values[HealthDataType.protein] as Mass?,
        totalCarbohydrate: _values[HealthDataType.totalCarbohydrate] as Mass?,
        totalFat: _values[HealthDataType.totalFat] as Mass?,
        saturatedFat: _values[HealthDataType.saturatedFat] as Mass?,
        monounsaturatedFat: _values[HealthDataType.monounsaturatedFat] as Mass?,
        polyunsaturatedFat: _values[HealthDataType.polyunsaturatedFat] as Mass?,
        cholesterol: _values[HealthDataType.cholesterol] as Mass?,
        dietaryFiber: _values[HealthDataType.dietaryFiber] as Mass?,
        sugar: _values[HealthDataType.sugar] as Mass?,
        vitaminA: _values[HealthDataType.vitaminA] as Mass?,
        vitaminB6: _values[HealthDataType.vitaminB6] as Mass?,
        vitaminB12: _values[HealthDataType.vitaminB12] as Mass?,
        vitaminC: _values[HealthDataType.vitaminC] as Mass?,
        vitaminD: _values[HealthDataType.vitaminD] as Mass?,
        vitaminE: _values[HealthDataType.vitaminE] as Mass?,
        vitaminK: _values[HealthDataType.vitaminK] as Mass?,
        thiamin: _values[HealthDataType.thiamin] as Mass?,
        riboflavin: _values[HealthDataType.riboflavin] as Mass?,
        niacin: _values[HealthDataType.niacin] as Mass?,
        folate: _values[HealthDataType.folate] as Mass?,
        biotin: _values[HealthDataType.biotin] as Mass?,
        pantothenicAcid: _values[HealthDataType.pantothenicAcid] as Mass?,
        calcium: _values[HealthDataType.calcium] as Mass?,
        iron: _values[HealthDataType.iron] as Mass?,
        magnesium: _values[HealthDataType.magnesium] as Mass?,
        manganese: _values[HealthDataType.manganese] as Mass?,
        phosphorus: _values[HealthDataType.phosphorus] as Mass?,
        potassium: _values[HealthDataType.potassium] as Mass?,
        selenium: _values[HealthDataType.selenium] as Mass?,
        sodium: _values[HealthDataType.sodium] as Mass?,
        zinc: _values[HealthDataType.zinc] as Mass?,
        caffeine: _values[HealthDataType.caffeine] as Mass?,
      ),
    );
  }

  TextEditingController _getController(HealthDataType dataType) {
    if (!_controllers.containsKey(dataType)) {
      _controllers[dataType] = TextEditingController();
    }
    return _controllers[dataType]!;
  }

  void _onNutrientChanged(HealthDataType dataType, String value) {
    try {
      final parsed = MeasurementUnitValueParser.parseValue(
        forDataType: dataType,
        value: value,
      );
      _values[dataType] = parsed;
    } on FormatException catch (_) {
      // Invalid input - set to null
      _values[dataType] = null;
    } on ArgumentError catch (_) {
      // Empty input - set to null
      _values[dataType] = null;
    }
    _notifyChanged();
  }

  String? _validateNutrient(HealthDataType dataType, String? value) {
    // All nutrients are optional → null/empty is valid
    if (value == null || value.isEmpty) {
      return null;
    }

    try {
      final parsed = MeasurementUnitValueParser.parseValue(
        forDataType: dataType,
        value: value,
      );

      MeasurementUnitValueValidator.validate(
        forDataType: dataType,
        value: parsed,
      );

      // Validation successful
      return null;
    } on FormatException catch (e) {
      // Return the format exception message as validation error
      return e.message;
    } on ArgumentError catch (e) {
      return e.message.toString();
    }
  }

  Widget _buildNutrientField(HealthDataType dataType) {
    final controller = _getController(dataType);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: dataType.fieldLabel,
          suffixText: dataType.fieldSuffix,
          prefixIcon: Icon(dataType.icon),
        ),
        keyboardType: dataType.keyboardType,
        onChanged: (String value) => _onNutrientChanged(dataType, value),
        validator: (String? value) => _validateNutrient(dataType, value),
      ),
    );
  }

  List<Widget> _buildNutrientFields(List<HealthDataType> dataTypes) {
    return dataTypes.map(_buildNutrientField).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Basic Info
        TextFormField(
          initialValue: _foodName,
          decoration: const InputDecoration(
            labelText: AppTexts.foodNameOptional,
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.fastfood),
            helperText: AppTexts.foodNameOptionalHelper,
          ),
          onChanged: (value) {
            setState(() {
              _foodName = value.isEmpty ? null : value;
            });
            _notifyChanged();
          },
        ),
        const SizedBox(height: 16.0),
        EnumDropdownFormField<MealType>(
          labelText: AppTexts.mealType,
          values: MealType.values,
          value: _mealType,
          onChanged: (type) {
            setState(() {
              _mealType = type ?? MealType.unknown;
            });
            _notifyChanged();
          },
          displayNameBuilder: (type) => type.displayName,
          prefixIcon: AppIcons.fastfood,
          hint: AppTexts.pleaseSelect,
        ),
        const SizedBox(height: 16.0),

        // Macronutrients Section (Expanded by default)
        CollapsibleFormSection(
          title: AppTexts.energyAndMacronutrients,
          subtitle: AppTexts.energyMacronutrientsSubtitle,
          initiallyExpanded: true,
          children: _buildNutrientFields([
            HealthDataType.energyNutrient,
            HealthDataType.protein,
            HealthDataType.totalCarbohydrate,
            HealthDataType.totalFat,
            HealthDataType.saturatedFat,
            HealthDataType.monounsaturatedFat,
            HealthDataType.polyunsaturatedFat,
            HealthDataType.cholesterol,
            HealthDataType.dietaryFiber,
            HealthDataType.sugar,
          ]),
        ),

        // Vitamins Section (Collapsed by default)
        CollapsibleFormSection(
          title: AppTexts.vitamins,
          subtitle: AppTexts.vitaminsSubtitle,
          children: _buildNutrientFields([
            HealthDataType.vitaminA,
            HealthDataType.vitaminB6,
            HealthDataType.vitaminB12,
            HealthDataType.vitaminC,
            HealthDataType.vitaminD,
            HealthDataType.vitaminE,
            HealthDataType.vitaminK,
            HealthDataType.thiamin,
            HealthDataType.riboflavin,
            HealthDataType.niacin,
            HealthDataType.folate,
            HealthDataType.biotin,
            HealthDataType.pantothenicAcid,
          ]),
        ),

        // Minerals Section (Collapsed by default)
        CollapsibleFormSection(
          title: AppTexts.minerals,
          subtitle: AppTexts.mineralsSubtitle,
          children: _buildNutrientFields([
            HealthDataType.calcium,
            HealthDataType.iron,
            HealthDataType.magnesium,
            HealthDataType.manganese,
            HealthDataType.phosphorus,
            HealthDataType.potassium,
            HealthDataType.selenium,
            HealthDataType.sodium,
            HealthDataType.zinc,
          ]),
        ),

        // Other Nutrients Section (Collapsed by default)
        CollapsibleFormSection(
          title: AppTexts.other,
          subtitle: AppTexts.additionalNutrients,
          children: _buildNutrientFields([
            HealthDataType.caffeine,
          ]),
        ),
      ],
    );
  }
}
