import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

/// Base widget for series health record forms.
@immutable
abstract class SeriesHealthRecordWriteForm<TSample>
    extends IntervalHealthRecordWriteForm {
  const SeriesHealthRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  SeriesHealthRecordFormState<TSample, SeriesHealthRecordWriteForm<TSample>>
  createState();
}

/// Base state for series health record forms.
abstract class SeriesHealthRecordFormState<
  TSample,
  T extends SeriesHealthRecordWriteForm<TSample>
>
    extends IntervalHealthRecordFormState<T> {
  /// The list of samples for this series record.
  List<TSample> samples = [];

  @override
  bool validate() {
    if (!super.validate()) {
      return false;
    }

    // Validate minimum sample count
    if (samples.isEmpty) {
      return false;
    }

    return true;
  }

  /// Builds the series-specific form fields (samples input).
  ///
  /// The samples field should handle user input for the sample list and
  /// call setState to update the [samples] list.
  List<Widget> buildSeriesFields(BuildContext context);

  @override
  List<Widget> buildFields(BuildContext context) {
    return [
      // Get fields from the parent interval write form
      ...super.buildFields(context),

      const SizedBox(height: 16),
      ...buildSeriesFields(context),
    ];
  }
}
