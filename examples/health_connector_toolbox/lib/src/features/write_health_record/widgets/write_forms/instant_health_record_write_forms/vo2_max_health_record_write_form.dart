import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for VO2 max records.
@immutable
final class Vo2MaxWriteForm extends InstantHealthRecordWriteForm {
  const Vo2MaxWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.vo2Max);

  @override
  Vo2MaxFormState createState() => Vo2MaxFormState();
}

/// State for VO2 max form widget.
final class Vo2MaxFormState
    extends InstantHealthRecordFormState<Vo2MaxWriteForm> {
  @override
  HealthRecord buildRecord() {
    return Vo2MaxRecord(
      time: startDateTime!,
      mLPerKgPerMin: value! as Number,
      metadata: metadata,
    );
  }
}
