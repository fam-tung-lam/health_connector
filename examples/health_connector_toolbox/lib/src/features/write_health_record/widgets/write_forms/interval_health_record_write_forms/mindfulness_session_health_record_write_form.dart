import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/mindfulness_session_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Form widget for mindfulness session records.
@immutable
final class MindfulnessSessionWriteForm extends IntervalHealthRecordWriteForm {
  const MindfulnessSessionWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  MindfulnessSessionFormState createState() => MindfulnessSessionFormState();
}

/// State for mindfulness session form widget.
final class MindfulnessSessionFormState
    extends IntervalHealthRecordFormState<MindfulnessSessionWriteForm> {
  MindfulnessSessionType? sessionType;
  String? title;
  String? notes;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<MindfulnessSessionType>(
        labelText: AppTexts.mindfulnessSession,
        values: MindfulnessSessionType.values,
        initialValue: sessionType,
        onChanged: (type) => setState(() => sessionType = type),
        validator: (type) => type == null
            ? AppTexts.getPleaseSelectText(AppTexts.mindfulnessSession)
            : null,
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.selfImprovement,
        hint: AppTexts.pleaseSelect,
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(
          labelText: AppTexts.titleOptional,
          border: OutlineInputBorder(),
          helperText: AppTexts.titleOptional,
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
          helperText: AppTexts.notesOptional,
        ),
        onChanged: (value) => setState(() {
          notes = value.isEmpty ? null : value;
        }),
        maxLines: 3,
      ),
    ];
  }

  @override
  bool validate() {
    // Validate form fields first
    if (!validate()) {
      return false;
    }

    // Ensure session type is selected
    return sessionType != null;
  }

  @override
  HealthRecord buildRecord() {
    return MindfulnessSessionRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      sessionType: sessionType!,
      metadata: metadata,
      title: title,
      notes: notes,
    );
  }
}
