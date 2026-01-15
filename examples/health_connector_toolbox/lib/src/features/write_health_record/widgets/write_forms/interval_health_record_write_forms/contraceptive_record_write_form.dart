import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/contraceptive_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

class ContraceptiveRecordWriteForm extends IntervalHealthRecordWriteForm {
  const ContraceptiveRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  ContraceptiveRecordWriteFormState createState() =>
      ContraceptiveRecordWriteFormState();
}

class ContraceptiveRecordWriteFormState
    extends IntervalHealthRecordFormState<ContraceptiveRecordWriteForm> {
  ContraceptiveType contraceptiveType = ContraceptiveType.oral;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      ...super.buildFields(context),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<ContraceptiveType>(
        labelText: AppTexts.contraceptiveType,
        values: ContraceptiveType.values,
        initialValue: contraceptiveType,
        onChanged: (value) => setState(() {
          contraceptiveType = value ?? ContraceptiveType.oral;
        }),
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.medication,
        hint: AppTexts.selectContraceptiveType,
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return ContraceptiveRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      contraceptiveType: contraceptiveType,
      metadata: metadata,
    );
  }
}
