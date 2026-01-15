import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_form.dart';

class LactationRecordWriteForm extends IntervalHealthRecordWriteForm {
  const LactationRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  LactationRecordWriteFormState createState() =>
      LactationRecordWriteFormState();
}

class LactationRecordWriteFormState
    extends IntervalHealthRecordFormState<LactationRecordWriteForm> {
  @override
  HealthRecord buildRecord() {
    return LactationRecord(
      startTime: startDateTime!,
      endTime: endDateTime!,
      metadata: metadata,
    );
  }
}
