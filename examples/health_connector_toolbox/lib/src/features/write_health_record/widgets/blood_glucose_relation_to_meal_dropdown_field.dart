import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';

import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

class BloodGlucoseRelationToMealDropdownField extends StatelessWidget {
  const BloodGlucoseRelationToMealDropdownField({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final BloodGlucoseRelationToMeal value;
  final ValueChanged<BloodGlucoseRelationToMeal?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<BloodGlucoseRelationToMeal>(
      initialValue: value,
      decoration: const InputDecoration(
        labelText: AppTexts.relationToMeal,
        border: OutlineInputBorder(),
      ),
      items: BloodGlucoseRelationToMeal.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type.name),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
