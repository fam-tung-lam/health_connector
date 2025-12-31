import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';

/// Form widget for intermenstrual bleeding records.
@immutable
final class IntermenstrualBleedingWriteForm extends BaseHealthRecordWriteForm {
  const IntermenstrualBleedingWriteForm({
    required super.healthPlatform,
    required super.onSubmit,
    super.key,
  });

  @override
  IntermenstrualBleedingFormState createState() =>
      IntermenstrualBleedingFormState();
}

/// State for intermenstrual bleeding form widget.
final class IntermenstrualBleedingFormState
    extends BaseHealthRecordWriteFormState<IntermenstrualBleedingWriteForm> {
  @override
  List<Widget> buildFields(BuildContext context) {
    // No additional fields needed - just time and metadata from base
    return [];
  }

  @override
  HealthRecord buildRecord() {
    return IntermenstrualBleedingRecord(
      time: startDateTime!,
      metadata: metadata,
    );
  }
}
