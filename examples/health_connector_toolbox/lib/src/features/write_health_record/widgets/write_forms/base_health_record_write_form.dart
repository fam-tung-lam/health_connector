import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/start_date_time_picker_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/widgets/buttons/elevated_gradient_button.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_form_fields/metadata_write_form_field_group.dart';

/// Callback type for form submission.
typedef OnSubmitCallback = Future<void> Function(HealthRecord record);
typedef RecordBuilder = HealthRecord Function();

/// Base widget for all health record forms.
@immutable
abstract class BaseHealthRecordWriteForm extends StatefulWidget {
  const BaseHealthRecordWriteForm({
    required this.healthPlatform,
    required this.onSubmit,
    super.key,
  });

  /// The health platform (iOS HealthKit or Android Health Connect).
  final HealthPlatform healthPlatform;

  /// Callback invoked when the form is submitted with a valid record.
  final OnSubmitCallback onSubmit;

  @override
  BaseHealthRecordWriteFormState createState();
}

/// Base state for all health record forms.
///
/// Provides common form infrastructure including:
/// - Form validation via GlobalKey
/// - Common UI layout with consistent spacing
/// - Date/time state management
/// - Metadata state management
/// - Abstract methods for validation and record building
abstract class BaseHealthRecordWriteFormState<
  T extends BaseHealthRecordWriteForm
>
    extends State<T>
    with StartDateTimePickerPageStateMixin<T> {
  static const _dataOrigin = DataOrigin(
    'com.phamtunglam.health_connector_toolbox',
  );

  /// Form key for validation
  final formKey = GlobalKey<FormState>();

  RecordingMethod _recordingMethod = RecordingMethod.unknown;
  Device? _device;

  /// Current metadata built from form state.
  Metadata get metadata {
    return switch (_recordingMethod) {
      RecordingMethod.manualEntry => Metadata.manualEntry(
        dataOrigin: _dataOrigin,
      ),
      RecordingMethod.automaticallyRecorded => Metadata.automaticallyRecorded(
        dataOrigin: _dataOrigin,
        device: _device!,
      ),
      RecordingMethod.activelyRecorded => Metadata.activelyRecorded(
        dataOrigin: _dataOrigin,
        device: _device!,
      ),
      RecordingMethod.unknown => Metadata.unknownRecordingMethod(
        dataOrigin: _dataOrigin,
        device: _device,
      ),
    };
  }

  /// Validates all fields in the form.
  ///
  /// Returns true if all fields are valid, false otherwise.
  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  /// Builds the health record from the current form state.
  ///
  /// Called after successful validation to construct the record
  /// that will be written to the health platform.
  HealthRecord buildRecord();

  Future<void> _submitRecord() async {
    if (!validate()) {
      return;
    }

    await widget.onSubmit(buildRecord());
  }

  /// Builds the list of form fields for this record type.
  ///
  /// Subclasses must implement this to provide their specific fields.
  List<Widget> buildFields(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Date/Time Picker provided by mixin
                  buildDateTimePicker(context),

                  // Type-specific form fields
                  const SizedBox(height: 16),
                  ...buildFields(context),

                  // Metadata fields (recording method, device)
                  const SizedBox(height: 16),
                  MetadataWriteFormFieldGroup(
                    healthPlatform: widget.healthPlatform,
                    initialRecordingMethod: _recordingMethod,
                    initialDevice: _device,
                    onRecordingMethodChanged: (method) {
                      if (method != null) {
                        setState(() {
                          _recordingMethod = method;
                        });
                      }
                    },
                    onDeviceChanged: (device) {
                      setState(() {
                        _device = device;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // Submit Button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedGradientButton(
            onPressed: _submitRecord,
            label: AppTexts.write,
          ),
        ),
      ],
    );
  }
}
