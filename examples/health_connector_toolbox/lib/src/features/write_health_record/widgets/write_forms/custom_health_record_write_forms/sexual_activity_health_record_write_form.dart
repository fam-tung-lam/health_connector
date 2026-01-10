import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/sexual_activity_protection_used_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for sexual activity records.
@immutable
final class SexualActivityWriteForm extends BaseHealthRecordWriteForm {
  const SexualActivityWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SexualActivityFormState createState() => SexualActivityFormState();
}

/// State for sexual activity form widget.
final class SexualActivityFormState
    extends BaseHealthRecordWriteFormState<SexualActivityWriteForm> {
  SexualActivityProtectionUsed protectionUsed =
      SexualActivityProtectionUsed.unknown;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      SearchableDropdownMenuFormField<SexualActivityProtectionUsed>(
        labelText: AppTexts.protectionUsed,
        values: SexualActivityProtectionUsed.values,
        initialValue: protectionUsed,
        onChanged: (value) => setState(() {
          protectionUsed = value ?? SexualActivityProtectionUsed.unknown;
        }),
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.favorite,
        hint: AppTexts.optional,
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return SexualActivityRecord(
      time: startDateTime!,
      metadata: metadata,
      protectionUsed: protectionUsed,
    );
  }
}
