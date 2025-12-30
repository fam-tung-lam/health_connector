import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/ovulation_test_result_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for ovulation test records.
@immutable
final class OvulationTestWriteForm extends BaseHealthRecordWriteForm {
  const OvulationTestWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  OvulationTestFormState createState() => OvulationTestFormState();
}

/// State for ovulation test form widget.
final class OvulationTestFormState
    extends BaseHealthRecordWriteFormState<OvulationTestWriteForm> {
  OvulationTestResultType result = OvulationTestResultType.negative;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      SearchableDropdownMenuFormField<OvulationTestResultType>(
        labelText: AppTexts.testResult,
        values: OvulationTestResultType.values,
        initialValue: result,
        onChanged: (value) => setState(() {
          result = value ?? OvulationTestResultType.negative;
        }),
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.science,
        hint: AppTexts.selectTestResult,
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return OvulationTestRecord(
      time: startDateTime!,
      metadata: metadata,
      result: result,
    );
  }
}
