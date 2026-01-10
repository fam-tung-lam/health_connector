import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/sleep_stage_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for sleep stage records (iOS).
@immutable
final class SleepStageWriteForm extends IntervalHealthRecordWriteForm {
  const SleepStageWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SleepStageFormState createState() => SleepStageFormState();
}

/// State for sleep stage form widget.
final class SleepStageFormState
    extends IntervalHealthRecordFormState<SleepStageWriteForm> {
  SleepStage? stageType;
  String? title;
  String? notes;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<SleepStage>(
        labelText: AppTexts.sleepStageType,
        values: SleepStage.values,
        initialValue: stageType,
        onChanged: (type) => setState(() => stageType = type),
        validator: (type) =>
            type == null ? AppTexts.pleaseSelectSleepStageType : null,
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.bedtime,
        hint: AppTexts.pleaseSelect,
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(
          labelText: AppTexts.titleOptional,
          border: OutlineInputBorder(),
          helperText: AppTexts.optionalTitleSleepRecord,
        ),
        onChanged: (value) => setState(() {
          title = value.isEmpty ? null : value;
        }),
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(
          labelText: AppTexts.notesOptional,
          border: OutlineInputBorder(),
          helperText: AppTexts.optionalNotesSleepRecord,
        ),
        maxLines: 3,
        onChanged: (value) => setState(() {
          notes = value.isEmpty ? null : value;
        }),
      ),
    ];
  }

  @override
  bool validate() {
    if (!super.validate()) {
      return false;
    }

    // Ensure stage type is selected
    return stageType != null;
  }

  @override
  HealthRecord buildRecord() {
    return SleepStageRecord(
      id: HealthRecordId.none,
      startTime: startDateTime!,
      endTime: endDateTime!,
      stageType: stageType!,
      metadata: metadata,
      title: title,
      notes: notes,
    );
  }
}
