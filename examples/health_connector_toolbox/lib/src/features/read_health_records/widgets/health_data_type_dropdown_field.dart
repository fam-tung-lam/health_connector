import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show HealthDataType, HealthRecord, MeasurementUnit;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';

/// A reusable dropdown field for selecting a health data type.
@immutable
final class HealthDataTypeDropdownField extends StatelessWidget {
  const HealthDataTypeDropdownField({
    required this.onChanged,
    super.key,
    this.initialValue,
    this.validator,
    this.itemsFilter,
    this.items,
  });

  final HealthDataType<HealthRecord, MeasurementUnit>? initialValue;
  final ValueChanged<HealthDataType<HealthRecord, MeasurementUnit>?> onChanged;
  final FormFieldValidator<HealthDataType<HealthRecord, MeasurementUnit>>?
  validator;
  final bool Function(HealthDataType<HealthRecord, MeasurementUnit>)?
  itemsFilter;
  final List<HealthDataType<HealthRecord, MeasurementUnit>>? items;

  @override
  Widget build(BuildContext context) {
    final allItems = items ?? HealthDataType.values;
    final filteredItems = itemsFilter != null
        ? allItems.where(itemsFilter!).toList()
        : allItems.toList();

    return DropdownButtonFormField<
      HealthDataType<HealthRecord, MeasurementUnit>
    >(
      initialValue: initialValue,
      decoration: const InputDecoration(
        labelText: AppTexts.dataType,
        border: OutlineInputBorder(),
        prefixIcon: Icon(AppIcons.category),
      ),
      items: filteredItems.map((type) {
        return DropdownMenuItem(value: type, child: Text(type.displayName));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
