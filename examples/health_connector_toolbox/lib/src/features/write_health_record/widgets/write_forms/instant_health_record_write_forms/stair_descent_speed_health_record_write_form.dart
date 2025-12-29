import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for stair descent speed records.
@immutable
final class StairDescentSpeedWriteForm extends InstantHealthRecordWriteForm {
  const StairDescentSpeedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.stairDescentSpeed);

  @override
  StairDescentSpeedFormState createState() => StairDescentSpeedFormState();
}

/// State for stair descent speed form widget.
final class StairDescentSpeedFormState
    extends InstantHealthRecordFormState<StairDescentSpeedWriteForm> {
  @override
  HealthRecord buildRecord() {
    return StairDescentSpeedRecord(
      time: startDateTime!,
      speed: value! as Velocity,
      metadata: metadata,
    );
  }
}
