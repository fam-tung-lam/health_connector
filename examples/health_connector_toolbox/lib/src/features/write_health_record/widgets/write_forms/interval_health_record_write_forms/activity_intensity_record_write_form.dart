import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/activity_intensity_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for activity intensity records.
@immutable
final class ActivityIntensityRecordWriteForm
    extends IntervalHealthRecordWriteForm {
  const ActivityIntensityRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ActivityIntensityRecordFormState createState() =>
      ActivityIntensityRecordFormState();
}

/// State for activity intensity form widget.
final class ActivityIntensityRecordFormState
    extends IntervalHealthRecordFormState<ActivityIntensityRecordWriteForm> {
  ActivityIntensityType? intensityType;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<ActivityIntensityType>(
        labelText: AppTexts.activityIntensityType,
        values: ActivityIntensityType.values,
        initialValue: intensityType,
        onChanged: (type) => setState(() => intensityType = type),
        validator: (type) => type == null
            ? AppTexts.getPleaseSelectText(AppTexts.activityIntensityType)
            : null,
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.speed,
        hint: AppTexts.pleaseSelect,
      ),
    ];
  }

  @override
  bool validate() {
    // Validate form fields first
    if (!super.validate()) {
      return false;
    }

    // Ensure intensity type is selected
    return intensityType != null;
  }

  @override
  HealthRecord buildRecord() {
    return ActivityIntensityRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      activityIntensityType: intensityType!,
      metadata: metadata,
    );
  }
}
