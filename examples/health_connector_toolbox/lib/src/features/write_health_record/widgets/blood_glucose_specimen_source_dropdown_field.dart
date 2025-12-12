import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';

import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

class BloodGlucoseSpecimenSourceDropdownField extends StatelessWidget {
  const BloodGlucoseSpecimenSourceDropdownField({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final BloodGlucoseSpecimenSource value;
  final ValueChanged<BloodGlucoseSpecimenSource?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<BloodGlucoseSpecimenSource>(
      initialValue: value,
      decoration: const InputDecoration(
        labelText: AppTexts.specimenSource,
        border: OutlineInputBorder(),
      ),
      items: BloodGlucoseSpecimenSource.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type.name),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
