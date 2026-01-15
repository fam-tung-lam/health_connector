import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/progesterone_test_result_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for progesterone test records.
@immutable
final class ProgesteroneTestWriteForm extends BaseHealthRecordWriteForm {
  const ProgesteroneTestWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ProgesteroneTestFormState createState() => ProgesteroneTestFormState();
}

/// State for progesterone test form widget.
final class ProgesteroneTestFormState
    extends BaseHealthRecordWriteFormState<ProgesteroneTestWriteForm> {
  ProgesteroneTestResult result = ProgesteroneTestResult.negative;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      SearchableDropdownMenuFormField<ProgesteroneTestResult>(
        labelText: AppTexts.testResult,
        values: ProgesteroneTestResult.values,
        initialValue: result,
        onChanged: (value) => setState(() {
          result = value ?? ProgesteroneTestResult.negative;
        }),
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.science,
        hint: AppTexts.selectTestResult,
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return ProgesteroneTestRecord(
      time: startDateTime!,
      metadata: metadata,
      result: result,
    );
  }
}
