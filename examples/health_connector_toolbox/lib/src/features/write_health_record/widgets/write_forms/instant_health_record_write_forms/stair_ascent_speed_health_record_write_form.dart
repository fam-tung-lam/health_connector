import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for stair ascent speed records.
@immutable
final class StairAscentSpeedWriteForm extends InstantHealthRecordWriteForm {
  const StairAscentSpeedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.stairAscentSpeed);

  @override
  StairAscentSpeedFormState createState() => StairAscentSpeedFormState();
}

/// State for stair ascent speed form widget.
final class StairAscentSpeedFormState
    extends InstantHealthRecordFormState<StairAscentSpeedWriteForm> {
  @override
  HealthRecord buildRecord() {
    return StairAscentSpeedRecord(
      time: startDateTime!,
      speed: value! as Velocity,
      metadata: metadata,
    );
  }
}
