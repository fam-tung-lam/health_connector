import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for systolic blood pressure records.
final class SystolicBloodPressureWriteForm
    extends InstantHealthRecordWriteForm {
  const SystolicBloodPressureWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.systolicBloodPressure);

  @override
  SystolicBloodPressureFormState createState() =>
      SystolicBloodPressureFormState();
}

/// State for systolic blood pressure form widget.
final class SystolicBloodPressureFormState
    extends InstantHealthRecordFormState<SystolicBloodPressureWriteForm> {
  @override
  HealthRecord buildRecord() {
    return SystolicBloodPressureRecord(
      time: startDateTime!,
      pressure: value! as Pressure,
      metadata: metadata,
    );
  }
}
