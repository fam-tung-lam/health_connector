import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/cervical_mucus_appearance_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/cervical_mucus_sensation_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for cervical mucus records.
@immutable
final class CervicalMucusWriteForm extends BaseHealthRecordWriteForm {
  const CervicalMucusWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  CervicalMucusFormState createState() => CervicalMucusFormState();
}

/// State for cervical mucus form widget.
final class CervicalMucusFormState
    extends BaseHealthRecordWriteFormState<CervicalMucusWriteForm> {
  CervicalMucusAppearanceType appearance = CervicalMucusAppearanceType.unknown;
  CervicalMucusSensationType sensation = CervicalMucusSensationType.unknown;

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      SearchableDropdownMenuFormField<CervicalMucusAppearanceType>(
        labelText: AppTexts.appearance,
        values: CervicalMucusAppearanceType.values,
        initialValue: appearance,
        onChanged: (value) => setState(() {
          appearance = value ?? CervicalMucusAppearanceType.unknown;
        }),
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.waterDrop,
        hint: AppTexts.optional,
      ),
      const SizedBox(height: 16),
      SearchableDropdownMenuFormField<CervicalMucusSensationType>(
        labelText: AppTexts.sensation,
        values: CervicalMucusSensationType.values,
        initialValue: sensation,
        onChanged: (value) => setState(() {
          sensation = value ?? CervicalMucusSensationType.unknown;
        }),
        displayNameBuilder: (type) => type.displayName,
        prefixIcon: AppIcons.waterDrop,
        hint: AppTexts.optional,
      ),
    ];
  }

  @override
  HealthRecord buildRecord() {
    return CervicalMucusRecord(
      time: startDateTime!,
      metadata: metadata,
      appearance: appearance,
      sensation: sensation,
    );
  }
}
