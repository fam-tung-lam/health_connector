import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/menstrual_flow_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/date_time_range_picker_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for menstrual flow interval records.
@immutable
final class MenstrualFlowWriteForm extends BaseHealthRecordWriteForm {
  const MenstrualFlowWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  MenstrualFlowFormState createState() => MenstrualFlowFormState();
}

/// State for menstrual flow interval form widget.
final class MenstrualFlowFormState
    extends BaseHealthRecordWriteFormState<MenstrualFlowWriteForm>
    with DateTimeRangePickerPageStateMixin<MenstrualFlowWriteForm> {
  MenstrualFlow flow = MenstrualFlow.unknown;
  bool isCycleStart = false;

  @override
  Widget buildDateTimePicker(BuildContext context) {
    return buildDateTimeRangePicker(context);
  }

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      SearchableDropdownMenuFormField<MenstrualFlow>(
        labelText: AppTexts.flow,
        values: MenstrualFlow.values,
        initialValue: flow,
        onChanged: (value) => setState(() {
          flow = value ?? MenstrualFlow.unknown;
        }),
        displayNameBuilder: (type) => type.label,
        prefixIcon: AppIcons.waterDrop,
      ),
      const SizedBox(height: 16),
      SwitchListTile(
        title: const Text(AppTexts.isCycleStart),
        value: isCycleStart,
        onChanged: (value) => setState(() {
          isCycleStart = value;
        }),
        secondary: const Icon(AppIcons.waterDrop),
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return MenstrualFlowRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      flow: flow,
      isCycleStart: isCycleStart,
      metadata: metadata,
    );
  }
}
