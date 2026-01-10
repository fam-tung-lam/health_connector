import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/menstrual_flow_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for menstrual flow instant records.
@immutable
final class MenstrualFlowInstantWriteForm extends BaseHealthRecordWriteForm {
  const MenstrualFlowInstantWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  MenstrualFlowInstantFormState createState() =>
      MenstrualFlowInstantFormState();
}

/// State for menstrual flow instant form widget.
final class MenstrualFlowInstantFormState
    extends BaseHealthRecordWriteFormState<MenstrualFlowInstantWriteForm> {
  MenstrualFlow flow = MenstrualFlow.unknown;

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
    ];
  }

  @override
  HealthRecord buildRecord() {
    return MenstrualFlowInstantRecord(
      time: startDateTime!,
      flow: flow,
      metadata: metadata,
    );
  }
}
