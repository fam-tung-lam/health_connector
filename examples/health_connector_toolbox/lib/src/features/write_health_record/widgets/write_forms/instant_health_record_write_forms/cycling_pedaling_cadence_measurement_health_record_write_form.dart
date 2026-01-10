import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for cycling pedaling cadence measurement records.
@immutable
final class CyclingPedalingCadenceMeasurementWriteForm
    extends InstantHealthRecordWriteForm {
  const CyclingPedalingCadenceMeasurementWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(
         dataType: HealthDataType.cyclingPedalingCadence,
       );

  @override
  CyclingPedalingCadenceMeasurementFormState createState() =>
      CyclingPedalingCadenceMeasurementFormState();
}

/// State for cycling pedaling cadence measurement form widget.
final class CyclingPedalingCadenceMeasurementFormState
    extends
        InstantHealthRecordFormState<
          CyclingPedalingCadenceMeasurementWriteForm
        > {
  @override
  HealthRecord buildRecord() {
    return CyclingPedalingCadenceRecord(
      id: HealthRecordId.none,
      time: startDateTime!,
      cadence: value! as Frequency,
      metadata: metadata,
    );
  }
}
