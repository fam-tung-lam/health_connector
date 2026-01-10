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
         dataType: HealthDataType.cyclingPedalingCadenceMeasurementRecord,
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
    return CyclingPedalingCadenceMeasurementRecord(
      id: HealthRecordId.none,
      measurement: CyclingPedalingCadenceMeasurement(
        time: startDateTime!,
        cadence: value! as Number,
      ),
      metadata: metadata,
    );
  }
}
