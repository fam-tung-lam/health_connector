import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for diastolic blood pressure records.
final class DiastolicBloodPressureWriteForm
    extends InstantHealthRecordWriteForm {
  const DiastolicBloodPressureWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.diastolicBloodPressure);

  @override
  DiastolicBloodPressureFormState createState() =>
      DiastolicBloodPressureFormState();
}

/// State for diastolic blood pressure form widget.
final class DiastolicBloodPressureFormState
    extends InstantHealthRecordFormState<DiastolicBloodPressureWriteForm> {
  @override
  HealthRecord buildRecord() {
    return DiastolicBloodPressureRecord(
      time: startDateTime!,
      pressure: value! as Pressure,
      metadata: metadata,
    );
  }
}
