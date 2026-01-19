import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/device_placement_side_ui_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for walking double support percentage records.
@immutable
final class WalkingDoubleSupportPercentageWriteForm
    extends IntervalHealthRecordWriteForm {
  const WalkingDoubleSupportPercentageWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  WalkingDoubleSupportPercentageFormState createState() =>
      WalkingDoubleSupportPercentageFormState();
}

/// State for walking double support percentage form widget.
final class WalkingDoubleSupportPercentageFormState
    extends
        IntervalHealthRecordFormState<WalkingDoubleSupportPercentageWriteForm> {
  /// The placement side of the device used to measure walking double support
  /// percentage (required).
  DevicePlacementSide? devicePlacementSide;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.walkingDoubleSupportPercentage,
        onChanged: (MeasurementUnit? newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<DevicePlacementSide>(
        labelText: AppTexts.devicePlacementSide,
        values: DevicePlacementSide.values,
        initialValue: devicePlacementSide,
        onChanged: (side) => setState(() => devicePlacementSide = side),
        validator: (side) => side == null
            ? AppTexts.getPleaseSelectText(AppTexts.devicePlacementSide)
            : null,
        displayNameBuilder: (side) => side.displayName,
        prefixIcon: AppIcons.deviceHub,
        hint: AppTexts.pleaseSelect,
      ),
    ];
  }

  @override
  bool validate() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return false;
    }

    return devicePlacementSide != null;
  }

  @override
  HealthRecord buildRecord() {
    return WalkingDoubleSupportPercentageRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      percentage: value! as Percentage,
      devicePlacementSide: devicePlacementSide!,
      metadata: metadata,
    );
  }
}
