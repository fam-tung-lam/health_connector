import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show Energy, Mass, MealType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/meal_type_dropdown_field.dart';

/// A form field widget for entering nutrition record data.
///
/// Allows entering multiple optional nutrient values including energy,
/// macronutrients, vitamins, minerals, and other nutrients.
@immutable
final class NutritionFormField extends StatefulWidget {
  const NutritionFormField({
    required this.onChanged,
    super.key,
  });

  /// Callback when nutrition data changes.
  ///
  /// Provides all the nutrient values that have been entered.
  final void Function({
    String? foodName,
    MealType? mealType,
    Energy? energy,
    Mass? protein,
    Mass? totalCarbohydrate,
    Mass? totalFat,
    Mass? saturatedFat,
    Mass? monounsaturatedFat,
    Mass? polyunsaturatedFat,
    Mass? cholesterol,
    Mass? dietaryFiber,
    Mass? sugar,
    Mass? vitaminA,
    Mass? vitaminB6,
    Mass? vitaminB12,
    Mass? vitaminC,
    Mass? vitaminD,
    Mass? vitaminE,
    Mass? vitaminK,
    Mass? thiamin,
    Mass? riboflavin,
    Mass? niacin,
    Mass? folate,
    Mass? biotin,
    Mass? pantothenicAcid,
    Mass? calcium,
    Mass? iron,
    Mass? magnesium,
    Mass? manganese,
    Mass? phosphorus,
    Mass? potassium,
    Mass? selenium,
    Mass? sodium,
    Mass? zinc,
    Mass? caffeine,
  })
  onChanged;

  @override
  State<NutritionFormField> createState() => _NutritionFormFieldState();
}

class _NutritionFormFieldState extends State<NutritionFormField> {
  String? _foodName;
  MealType _mealType = MealType.unknown;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _notifyChanged() {
    widget.onChanged(
      foodName: _foodName?.isEmpty ?? true ? null : _foodName,
      mealType: _mealType == MealType.unknown ? null : _mealType,
      energy: _parseEnergy('energy'),
      protein: _parseMass('protein'),
      totalCarbohydrate: _parseMass('totalCarbohydrate'),
      totalFat: _parseMass('totalFat'),
      saturatedFat: _parseMass('saturatedFat'),
      monounsaturatedFat: _parseMass('monounsaturatedFat'),
      polyunsaturatedFat: _parseMass('polyunsaturatedFat'),
      cholesterol: _parseMass('cholesterol'),
      dietaryFiber: _parseMass('dietaryFiber'),
      sugar: _parseMass('sugar'),
      vitaminA: _parseMass('vitaminA'),
      vitaminB6: _parseMass('vitaminB6'),
      vitaminB12: _parseMass('vitaminB12'),
      vitaminC: _parseMass('vitaminC'),
      vitaminD: _parseMass('vitaminD'),
      vitaminE: _parseMass('vitaminE'),
      vitaminK: _parseMass('vitaminK'),
      thiamin: _parseMass('thiamin'),
      riboflavin: _parseMass('riboflavin'),
      niacin: _parseMass('niacin'),
      folate: _parseMass('folate'),
      biotin: _parseMass('biotin'),
      pantothenicAcid: _parseMass('pantothenicAcid'),
      calcium: _parseMass('calcium'),
      iron: _parseMass('iron'),
      magnesium: _parseMass('magnesium'),
      manganese: _parseMass('manganese'),
      phosphorus: _parseMass('phosphorus'),
      potassium: _parseMass('potassium'),
      selenium: _parseMass('selenium'),
      sodium: _parseMass('sodium'),
      zinc: _parseMass('zinc'),
      caffeine: _parseMass('caffeine'),
    );
  }

  /// Validates energy input value.
  ///
  /// Returns null if valid, error message otherwise.
  String? _validateEnergy(String? value) {
    if (value?.isEmpty ?? true) {
      return null; // Optional field
    }

    final parsed = double.tryParse(value!);
    if (parsed == null) {
      return 'Invalid number';
    }
    if (parsed < 0) {
      return 'Cannot be negative';
    }
    if (parsed > 5000) {
      return 'Exceeds reasonable limit (5000 kcal)';
    }

    // Check decimal precision (max 3 decimal places)
    final parts = value.split('.');
    if (parts.length == 2 && parts[1].length > 3) {
      return 'Maximum 3 decimal places allowed';
    }

    return null;
  }

  /// Validates mass input value.
  ///
  /// Returns null if valid, error message otherwise.
  String? _validateMass(String? value) {
    if (value?.isEmpty ?? true) {
      return null; // Optional field
    }

    final parsed = double.tryParse(value!);
    if (parsed == null) {
      return 'Invalid number';
    }
    if (parsed < 0) {
      return 'Cannot be negative';
    }
    if (parsed > 10000) {
      return 'Exceeds reasonable limit (10000 g)';
    }

    // Check decimal precision (max 3 decimal places)
    final parts = value.split('.');
    if (parts.length == 2 && parts[1].length > 3) {
      return 'Maximum 3 decimal places allowed';
    }

    return null;
  }

  Energy? _parseEnergy(String key) {
    final controller = _controllers[key];
    if (controller == null || controller.text.isEmpty) {
      return null;
    }
    final value = double.tryParse(controller.text);
    if (value == null || value <= 0) {
      return null;
    }
    return Energy.kilocalories(value);
  }

  Mass? _parseMass(String key) {
    final controller = _controllers[key];
    if (controller == null || controller.text.isEmpty) {
      return null;
    }
    final value = double.tryParse(controller.text);
    if (value == null || value <= 0) {
      return null;
    }
    return Mass.grams(value);
  }

  TextEditingController _getController(String key, String label) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController();
      _controllers[key]!.addListener(_notifyChanged);
    }
    return _controllers[key]!;
  }

  Widget _buildMassField(String key, String label, String unit) {
    return TextFormField(
      controller: _getController(key, label),
      decoration: InputDecoration(
        labelText: '$label ($unit, ${AppTexts.fieldOptional})',
        border: const OutlineInputBorder(),
        helperText: '${AppTexts.fieldOptionalHelper} $unit',
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: _validateMass,
    );
  }

  Widget _buildEnergyField() {
    return TextFormField(
      controller: _getController('energy', 'Energy'),
      decoration: const InputDecoration(
        labelText: AppTexts.energyKcalOptional,
        border: OutlineInputBorder(),
        helperText: AppTexts.energyKcalHelper,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: _validateEnergy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        const SizedBox(height: 16),
        MealTypeDropdownField(
          value: _mealType,
          onChanged: (type) {
            setState(() {
              _mealType = type ?? MealType.unknown;
            });
            _notifyChanged();
          },
        ),
        const SizedBox(height: 24),
        const Text(
          AppTexts.nutrientsAllOptional,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          AppTexts.energyAndMacronutrients,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        _buildEnergyField(),
        const SizedBox(height: 8),
        _buildMassField('protein', 'Protein', 'g'),
        const SizedBox(height: 8),
        _buildMassField('totalCarbohydrate', 'Total Carbohydrate', 'g'),
        const SizedBox(height: 8),
        _buildMassField('totalFat', 'Total Fat', 'g'),
        const SizedBox(height: 8),
        _buildMassField('saturatedFat', 'Saturated Fat', 'g'),
        const SizedBox(height: 8),
        _buildMassField('monounsaturatedFat', 'Monounsaturated Fat', 'g'),
        const SizedBox(height: 8),
        _buildMassField('polyunsaturatedFat', 'Polyunsaturated Fat', 'g'),
        const SizedBox(height: 8),
        _buildMassField('cholesterol', 'Cholesterol', 'g'),
        const SizedBox(height: 8),
        _buildMassField('dietaryFiber', 'Dietary Fiber', 'g'),
        const SizedBox(height: 8),
        _buildMassField('sugar', 'Sugar', 'g'),
        const SizedBox(height: 16),
        const Text(
          AppTexts.vitamins,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        _buildMassField('vitaminA', 'Vitamin A', 'g'),
        const SizedBox(height: 8),
        _buildMassField('vitaminB6', 'Vitamin B6', 'g'),
        const SizedBox(height: 8),
        _buildMassField('vitaminB12', 'Vitamin B12', 'g'),
        const SizedBox(height: 8),
        _buildMassField('vitaminC', 'Vitamin C', 'g'),
        const SizedBox(height: 8),
        _buildMassField('vitaminD', 'Vitamin D', 'g'),
        const SizedBox(height: 8),
        _buildMassField('vitaminE', 'Vitamin E', 'g'),
        const SizedBox(height: 8),
        _buildMassField('vitaminK', 'Vitamin K', 'g'),
        const SizedBox(height: 8),
        _buildMassField('thiamin', 'Thiamin', 'g'),
        const SizedBox(height: 8),
        _buildMassField('riboflavin', 'Riboflavin', 'g'),
        const SizedBox(height: 8),
        _buildMassField('niacin', 'Niacin', 'g'),
        const SizedBox(height: 8),
        _buildMassField('folate', 'Folate', 'g'),
        const SizedBox(height: 8),
        _buildMassField('biotin', 'Biotin', 'g'),
        const SizedBox(height: 8),
        _buildMassField('pantothenicAcid', 'Pantothenic Acid', 'g'),
        const SizedBox(height: 16),
        const Text(
          AppTexts.minerals,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        _buildMassField('calcium', 'Calcium', 'g'),
        const SizedBox(height: 8),
        _buildMassField('iron', 'Iron', 'g'),
        const SizedBox(height: 8),
        _buildMassField('magnesium', 'Magnesium', 'g'),
        const SizedBox(height: 8),
        _buildMassField('manganese', 'Manganese', 'g'),
        const SizedBox(height: 8),
        _buildMassField('phosphorus', 'Phosphorus', 'g'),
        const SizedBox(height: 8),
        _buildMassField('potassium', 'Potassium', 'g'),
        const SizedBox(height: 8),
        _buildMassField('selenium', 'Selenium', 'g'),
        const SizedBox(height: 8),
        _buildMassField('sodium', 'Sodium', 'g'),
        const SizedBox(height: 8),
        _buildMassField('zinc', 'Zinc', 'g'),
        const SizedBox(height: 16),
        const Text(
          AppTexts.other,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        _buildMassField('caffeine', 'Caffeine', 'g'),
      ],
    );
  }
}
