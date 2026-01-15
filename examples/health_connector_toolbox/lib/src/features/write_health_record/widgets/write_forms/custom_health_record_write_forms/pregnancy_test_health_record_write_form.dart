import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/pregnancy_test_result_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for pregnancy test records.
@immutable
final class PregnancyTestWriteForm extends BaseHealthRecordWriteForm {
  const PregnancyTestWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  PregnancyTestFormState createState() => PregnancyTestFormState();
}

/// State for pregnancy test form widget.
final class PregnancyTestFormState
    extends BaseHealthRecordWriteFormState<PregnancyTestWriteForm> {
  PregnancyTestResult result = PregnancyTestResult.negative;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      SearchableDropdownMenuFormField<PregnancyTestResult>(
        labelText: AppTexts.testResult,
        values: PregnancyTestResult.values,
        initialValue: result,
        onChanged: (value) => setState(() {
          result = value ?? PregnancyTestResult.negative;
        }),
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.science,
        hint: AppTexts.selectTestResult,
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return PregnancyTestRecord(
      time: startDateTime!,
      metadata: metadata,
      result: result,
    );
  }
}
