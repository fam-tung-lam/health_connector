import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show SleepStage, SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/sleep_stage_type_extension.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/enum_dropdown_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/series_health_record_samples_form_field.dart';

/// A form field widget for managing multiple sleep stage samples.
///
/// Now uses the generic [SeriesHealthRecordSamplesFormField] widget to
/// eliminate duplication.
@immutable
final class SleepSessionRecordSleepStagesFormField extends StatelessWidget {
  const SleepSessionRecordSleepStagesFormField({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final ValueChanged<List<SleepStage>?> onChanged;
  final List<SleepStage>? initialSamples;
  final String? Function(List<SleepStage>?)? validator;

  @override
  Widget build(BuildContext context) {
    return SeriesHealthRecordSamplesFormField<SleepStage, SleepStageType>(
      title: AppTexts.sleepStages,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      onChanged: onChanged,
      initialSamples: initialSamples,
      validator: validator,
      defaultValue: SleepStageType.light,
      requiresTimeRange: true,
      // Sleep stages need start and end times
      valueInputBuilder: (index, stageType, onStageTypeChanged) {
        return EnumDropdownFormField<SleepStageType>(
          labelText: AppTexts.sleepStageType,
          values: SleepStageType.values,
          value: stageType,
          onChanged: onStageTypeChanged,
          displayNameBuilder: (type) => type.displayName,
          prefixIcon: AppIcons.bedtime,
          hint: AppTexts.pleaseSelect,
        );
      },
      sampleFactory: (startTime, endTime, stageType) => SleepStage(
        startTime: startTime,
        endTime: endTime ?? startTime.add(const Duration(hours: 1)),
        stageType: stageType,
      ),
      sampleExtractor: (sample) => (
        time: sample.startTime,
        endTime: sample.endTime as DateTime?,
        value: sample.stageType,
      ),
      valueValidator: (_) => true, // All SleepStageType values are valid
    );
  }
}
