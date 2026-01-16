import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_form.dart';

/// Form widget for peripheral perfusion index records.
@immutable
final class PeripheralPerfusionIndexRecordWriteForm
    extends InstantHealthRecordWriteForm {
  const PeripheralPerfusionIndexRecordWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  }) : super(dataType: HealthDataType.peripheralPerfusionIndex);

  @override
  PeripheralPerfusionIndexRecordFormState createState() =>
      PeripheralPerfusionIndexRecordFormState();
}

/// State for peripheral perfusion index form widget.
final class PeripheralPerfusionIndexRecordFormState
    extends
        InstantHealthRecordFormState<PeripheralPerfusionIndexRecordWriteForm> {
  @override
  HealthRecord buildRecord() {
    return PeripheralPerfusionIndexRecord(
      time: startDateTime!,
      percentage: value! as Percentage,
      metadata: metadata,
    );
  }
}
