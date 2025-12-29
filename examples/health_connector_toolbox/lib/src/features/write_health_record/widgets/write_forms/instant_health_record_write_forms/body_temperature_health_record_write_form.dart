import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for body temperature records.
@immutable
final class BodyTemperatureWriteForm extends InstantHealthRecordWriteForm {
  const BodyTemperatureWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.bodyTemperature);

  @override
  BodyTemperatureFormState createState() => BodyTemperatureFormState();
}

/// State for body temperature form widget.
final class BodyTemperatureFormState
    extends InstantHealthRecordFormState<BodyTemperatureWriteForm> {
  @override
  HealthRecord buildRecord() {
    return BodyTemperatureRecord(
      time: startDateTime!,
      temperature: value! as Temperature,
      metadata: metadata,
    );
  }
}
