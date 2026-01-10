import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show Energy, HealthDataType, Mass, MealType, MeasurementUnit;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/health_data_type_ui_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/meal_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/measurement_unit_value_parser.dart';
import 'package:health_connector_toolbox/src/common/utils/measurement_unit_value_validator.dart';
import 'package:health_connector_toolbox/src/common/widgets/collapsible_form_section.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/models/nutrition_form_data.dart';

/// A form field widget for entering nutrition record data.
///
/// Uses extension methods on [HealthDataType] to build nutrient fields
/// dynamically with consistent styling and validation.
@immutable
final class NutrientWriteFormFieldGroup extends StatefulWidget {
  const NutrientWriteFormFieldGroup({
    required this.onChanged,
    super.key,
  });

  /// Callback when nutrition data changes.
  ///
  /// Provides a [NutritionData] object containing all entered values.
  final ValueChanged<NutritionData> onChanged;

  @override
  State<NutrientWriteFormFieldGroup> createState() =>
      _NutrientWriteFormFieldGroupState();
}

class _NutrientWriteFormFieldGroupState
    extends State<NutrientWriteFormFieldGroup> {
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
        energy: _values[HealthDataType.dietaryEnergyConsumed] as Energy?,
        protein: _values[HealthDataType.dietaryProtein] as Mass?,
        totalCarbohydrate:
            _values[HealthDataType.dietaryTotalCarbohydrate] as Mass?,
        totalFat: _values[HealthDataType.dietaryTotalFat] as Mass?,
        saturatedFat: _values[HealthDataType.dietarySaturatedFat] as Mass?,
        monounsaturatedFat:
            _values[HealthDataType.dietaryMonounsaturatedFat] as Mass?,
        polyunsaturatedFat:
            _values[HealthDataType.dietaryPolyunsaturatedFat] as Mass?,
        cholesterol: _values[HealthDataType.dietaryCholesterol] as Mass?,
        dietaryFiber: _values[HealthDataType.dietaryFiber] as Mass?,
        sugar: _values[HealthDataType.dietarySugar] as Mass?,
        vitaminA: _values[HealthDataType.dietaryVitaminA] as Mass?,
        vitaminB6: _values[HealthDataType.dietaryVitaminB6] as Mass?,
        vitaminB12: _values[HealthDataType.dietaryVitaminB12] as Mass?,
        vitaminC: _values[HealthDataType.dietaryVitaminC] as Mass?,
        vitaminD: _values[HealthDataType.dietaryVitaminD] as Mass?,
        vitaminE: _values[HealthDataType.dietaryVitaminE] as Mass?,
        vitaminK: _values[HealthDataType.dietaryVitaminK] as Mass?,
        thiamin: _values[HealthDataType.dietaryThiamin] as Mass?,
        riboflavin: _values[HealthDataType.dietaryRiboflavin] as Mass?,
        niacin: _values[HealthDataType.dietaryNiacin] as Mass?,
        folate: _values[HealthDataType.dietaryFolate] as Mass?,
        biotin: _values[HealthDataType.dietaryBiotin] as Mass?,
        pantothenicAcid:
            _values[HealthDataType.dietaryPantothenicAcid] as Mass?,
        calcium: _values[HealthDataType.dietaryCalcium] as Mass?,
        iron: _values[HealthDataType.dietaryIron] as Mass?,
        magnesium: _values[HealthDataType.dietaryMagnesium] as Mass?,
        manganese: _values[HealthDataType.dietaryManganese] as Mass?,
        phosphorus: _values[HealthDataType.dietaryPhosphorus] as Mass?,
        potassium: _values[HealthDataType.dietaryPotassium] as Mass?,
        selenium: _values[HealthDataType.dietarySelenium] as Mass?,
        sodium: _values[HealthDataType.dietarySodium] as Mass?,
        zinc: _values[HealthDataType.dietaryZinc] as Mass?,
        caffeine: _values[HealthDataType.dietaryCaffeine] as Mass?,
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
        SearchableDropdownMenuFormField<MealType>(
          labelText: AppTexts.mealType,
          values: MealType.values,
          initialValue: _mealType,
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
            HealthDataType.dietaryEnergyConsumed,
            HealthDataType.dietaryProtein,
            HealthDataType.dietaryTotalCarbohydrate,
            HealthDataType.dietaryTotalFat,
            HealthDataType.dietarySaturatedFat,
            HealthDataType.dietaryMonounsaturatedFat,
            HealthDataType.dietaryPolyunsaturatedFat,
            HealthDataType.dietaryCholesterol,
            HealthDataType.dietaryFiber,
            HealthDataType.dietarySugar,
          ]),
        ),

        // Vitamins Section (Collapsed by default)
        CollapsibleFormSection(
          title: AppTexts.vitamins,
          subtitle: AppTexts.vitaminsSubtitle,
          children: _buildNutrientFields([
            HealthDataType.dietaryVitaminA,
            HealthDataType.dietaryVitaminB6,
            HealthDataType.dietaryVitaminB12,
            HealthDataType.dietaryVitaminC,
            HealthDataType.dietaryVitaminD,
            HealthDataType.dietaryVitaminE,
            HealthDataType.dietaryVitaminK,
            HealthDataType.dietaryThiamin,
            HealthDataType.dietaryRiboflavin,
            HealthDataType.dietaryNiacin,
            HealthDataType.dietaryFolate,
            HealthDataType.dietaryBiotin,
            HealthDataType.dietaryPantothenicAcid,
          ]),
        ),

        // Minerals Section (Collapsed by default)
        CollapsibleFormSection(
          title: AppTexts.minerals,
          subtitle: AppTexts.mineralsSubtitle,
          children: _buildNutrientFields([
            HealthDataType.dietaryCalcium,
            HealthDataType.dietaryIron,
            HealthDataType.dietaryMagnesium,
            HealthDataType.dietaryManganese,
            HealthDataType.dietaryPhosphorus,
            HealthDataType.dietaryPotassium,
            HealthDataType.dietarySelenium,
            HealthDataType.dietarySodium,
            HealthDataType.dietaryZinc,
          ]),
        ),

        // Other Nutrients Section (Collapsed by default)
        CollapsibleFormSection(
          title: AppTexts.other,
          subtitle: AppTexts.additionalNutrients,
          children: _buildNutrientFields([
            HealthDataType.dietaryCaffeine,
          ]),
        ),
      ],
    );
  }
}
