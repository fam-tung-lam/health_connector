import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for walking speed records.
@immutable
final class WalkingSpeedWriteForm extends InstantHealthRecordWriteForm {
  const WalkingSpeedWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.walkingSpeed);

  @override
  WalkingSpeedFormState createState() => WalkingSpeedFormState();
}

/// State for walking speed form widget.
final class WalkingSpeedFormState
    extends InstantHealthRecordFormState<WalkingSpeedWriteForm> {
  @override
  HealthRecord buildRecord() {
    return WalkingSpeedRecord(
      time: startDateTime!,
      speed: value! as Velocity,
      metadata: metadata,
    );
  }
}
