import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/device_placement_side_ui_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/health_record_value_write_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for walking step length records.
@immutable
final class WalkingStepLengthWriteForm extends IntervalHealthRecordWriteForm {
  const WalkingStepLengthWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  WalkingStepLengthFormState createState() => WalkingStepLengthFormState();
}

/// State for walking step length form widget.
final class WalkingStepLengthFormState
    extends IntervalHealthRecordFormState<WalkingStepLengthWriteForm> {
  /// The placement side of the device used to measure walking step length
  /// (required).
  DevicePlacementSide? devicePlacementSide;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      HealthRecordValueWriteFormField(
        dataType: HealthDataType.walkingStepLength,
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
    return WalkingStepLengthRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      length: value! as Length,
      devicePlacementSide: devicePlacementSide!,
      metadata: metadata,
    );
  }
}
