import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for forced vital capacity records.
@immutable
final class ForcedVitalCapacityWriteForm extends InstantHealthRecordWriteForm {
  const ForcedVitalCapacityWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.forcedVitalCapacity);

  @override
  ForcedVitalCapacityFormState createState() => ForcedVitalCapacityFormState();
}

/// State for forced vital capacity form widget.
final class ForcedVitalCapacityFormState
    extends InstantHealthRecordFormState<ForcedVitalCapacityWriteForm> {
  @override
  HealthRecord buildRecord() {
    return ForcedVitalCapacityRecord(
      time: startDateTime!,
      volume: value! as Volume,
      metadata: metadata,
    );
  }
}
