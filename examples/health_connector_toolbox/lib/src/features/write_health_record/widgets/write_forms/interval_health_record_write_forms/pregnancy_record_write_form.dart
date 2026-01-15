import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

class PregnancyRecordWriteForm extends IntervalHealthRecordWriteForm {
  const PregnancyRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  PregnancyRecordWriteFormState createState() =>
      PregnancyRecordWriteFormState();
}

class PregnancyRecordWriteFormState
    extends IntervalHealthRecordFormState<PregnancyRecordWriteForm> {
  @override
  HealthRecord buildRecord() {
    return PregnancyRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      metadata: metadata,
    );
  }
}
