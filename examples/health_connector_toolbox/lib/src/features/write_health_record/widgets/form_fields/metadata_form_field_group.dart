import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:health_connector/health_connector.dart'
    show Device, DeviceType, RecordingMethod, HealthPlatform;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/enum_dropdown_form_field.dart';

/// A reusable widget containing form fields for metadata and device
/// information.
///
/// Displays fields for:
/// - Recording method (required)
/// - Device type (required when device is needed)
/// - Device name, manufacturer, model (optional)
/// - Device hardware, firmware, software versions (optional)
/// - Device local identifier and UDI device identifier (optional)
///
/// Device fields are conditionally shown based on the recording method:
/// - Shown for automatically recorded and actively recorded methods
/// - Hidden for manual entry (device not required)
/// - Optional for unknown recording method
@immutable
final class MetadataFormFieldGroup extends StatefulWidget {
  const MetadataFormFieldGroup({
    required this.healthPlatform,
    required this.onRecordingMethodChanged,
    required this.onDeviceChanged,
    super.key,
    this.initialRecordingMethod = RecordingMethod.unknown,
    this.initialDevice,
    this.recordingMethodValidator,
    this.deviceTypeValidator,
    this.spacing = 16.0,
  });

  /// The current health platform.
  final HealthPlatform healthPlatform;

  /// The initially selected recording method.
  final RecordingMethod initialRecordingMethod;

  /// The initial device information.
  final Device? initialDevice;

  /// Callback when the recording method changes.
  final ValueChanged<RecordingMethod?> onRecordingMethodChanged;

  /// Callback when any device field changes.
  ///
  /// Provides a complete [Device] object with all current field values.
  final ValueChanged<Device?> onDeviceChanged;

  /// Validator for the recording method field.
  final String? Function(RecordingMethod?)? recordingMethodValidator;

  /// Validator for the device type field.
  final String? Function(DeviceType?)? deviceTypeValidator;

  /// Spacing between form fields. Defaults to 16.0.
  final double spacing;

  @override
  State<MetadataFormFieldGroup> createState() => _MetadataFormFieldGroupState();
}

class _MetadataFormFieldGroupState extends State<MetadataFormFieldGroup> {
  late RecordingMethod _recordingMethod;
  late DeviceType _deviceType;
  late final TextEditingController _nameController;
  late final TextEditingController _manufacturerController;
  late final TextEditingController _modelController;
  late final TextEditingController _hardwareVersionController;
  late final TextEditingController _firmwareVersionController;
  late final TextEditingController _softwareVersionController;
  late final TextEditingController _localIdentifierController;
  late final TextEditingController _udiDeviceIdentifierController;

  @override
  void initState() {
    super.initState();
    _recordingMethod = widget.initialRecordingMethod;
    _deviceType = widget.initialDevice?.type ?? DeviceType.unknown;
    _nameController = TextEditingController(text: widget.initialDevice?.name);
    _manufacturerController = TextEditingController(
      text: widget.initialDevice?.manufacturer,
    );
    _modelController = TextEditingController(text: widget.initialDevice?.model);
    _hardwareVersionController = TextEditingController(
      text: widget.initialDevice?.hardwareVersion,
    );
    _firmwareVersionController = TextEditingController(
      text: widget.initialDevice?.firmwareVersion,
    );
    _softwareVersionController = TextEditingController(
      text: widget.initialDevice?.softwareVersion,
    );
    _localIdentifierController = TextEditingController(
      text: widget.initialDevice?.localIdentifier,
    );
    _udiDeviceIdentifierController = TextEditingController(
      text: widget.initialDevice?.udiDeviceIdentifier,
    );

    // Schedule device update after the first frame to notify parent
    // of initial device state without causing setState during build
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateDevice();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _manufacturerController.dispose();
    _modelController.dispose();
    _hardwareVersionController.dispose();
    _firmwareVersionController.dispose();
    _softwareVersionController.dispose();
    _localIdentifierController.dispose();
    _udiDeviceIdentifierController.dispose();
    super.dispose();
  }

  /// Whether device type is required based on the recording method.
  bool _isDeviceTypeRequired(RecordingMethod? method) {
    return method == RecordingMethod.automaticallyRecorded ||
        method == RecordingMethod.activelyRecorded;
  }

  void _updateDevice() {
    final device = Device(
      type: _deviceType,
      name: _nameController.text.isEmpty ? null : _nameController.text,
      manufacturer: _manufacturerController.text.isEmpty
          ? null
          : _manufacturerController.text,
      model: _modelController.text.isEmpty ? null : _modelController.text,
      hardwareVersion: _hardwareVersionController.text.isEmpty
          ? null
          : _hardwareVersionController.text,
      firmwareVersion: _firmwareVersionController.text.isEmpty
          ? null
          : _firmwareVersionController.text,
      softwareVersion: _softwareVersionController.text.isEmpty
          ? null
          : _softwareVersionController.text,
      localIdentifier: _localIdentifierController.text.isEmpty
          ? null
          : _localIdentifierController.text,
      udiDeviceIdentifier: _udiDeviceIdentifierController.text.isEmpty
          ? null
          : _udiDeviceIdentifierController.text,
    );

    widget.onDeviceChanged(device);
  }

  void _onRecordingMethodChanged(RecordingMethod? method) {
    if (method == null) {
      return;
    }

    setState(() {
      _recordingMethod = method;
      widget.onRecordingMethodChanged(method);
      _updateDevice();
    });
  }

  void _onDeviceTypeChanged(DeviceType? type) {
    if (type == null) {
      return;
    }

    setState(() {
      _deviceType = type;
    });
    _updateDevice();
  }

  void _onTextFieldChanged() {
    _updateDevice();
  }

  @override
  Widget build(BuildContext context) {
    final isDeviceTypeRequired = _isDeviceTypeRequired(_recordingMethod);
    final isAppleHealth = widget.healthPlatform == HealthPlatform.appleHealth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EnumDropdownFormField<RecordingMethod>(
          labelText: AppTexts.recordingMethod,
          values: RecordingMethod.values,
          value: _recordingMethod,
          onChanged: _onRecordingMethodChanged,
          validator: widget.recordingMethodValidator,
          displayNameBuilder: (method) => method.displayName,
          prefixIcon: AppIcons.settings,
        ),
        SizedBox(height: widget.spacing),
        EnumDropdownFormField<DeviceType>(
          labelText: AppTexts.deviceType,
          values: DeviceType.values,
          value: _deviceType,
          onChanged: _onDeviceTypeChanged,
          validator: isDeviceTypeRequired ? widget.deviceTypeValidator : null,
          displayNameBuilder: (deviceType) => deviceType.displayName,
          prefixIcon: AppIcons.devices,
        ),
        SizedBox(height: widget.spacing),
        TextFormField(
          controller: _manufacturerController,
          decoration: const InputDecoration(
            labelText: AppTexts.manufacturer,
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.devices),
          ),
          onChanged: (_) => _onTextFieldChanged(),
        ),
        SizedBox(height: widget.spacing),
        TextFormField(
          controller: _modelController,
          decoration: const InputDecoration(
            labelText: AppTexts.model,
            border: OutlineInputBorder(),
            prefixIcon: Icon(AppIcons.devices),
          ),
          onChanged: (_) => _onTextFieldChanged(),
        ),
        if (isAppleHealth) ...[
          SizedBox(height: widget.spacing),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: AppTexts.name,
              border: OutlineInputBorder(),
              prefixIcon: Icon(AppIcons.devices),
            ),
            onChanged: (_) => _onTextFieldChanged(),
          ),
          SizedBox(height: widget.spacing),
          if (isAppleHealth)
            TextFormField(
              controller: _hardwareVersionController,
              decoration: const InputDecoration(
                labelText: AppTexts.hardwareVersion,
                border: OutlineInputBorder(),
                prefixIcon: Icon(AppIcons.devices),
              ),
              onChanged: (_) => _onTextFieldChanged(),
            ),
          SizedBox(height: widget.spacing),
          TextFormField(
            controller: _firmwareVersionController,
            decoration: const InputDecoration(
              labelText: AppTexts.firmwareVersion,
              border: OutlineInputBorder(),
              prefixIcon: Icon(AppIcons.devices),
            ),
            onChanged: (_) => _onTextFieldChanged(),
          ),
          SizedBox(height: widget.spacing),
          TextFormField(
            controller: _softwareVersionController,
            decoration: const InputDecoration(
              labelText: AppTexts.softwareVersion,
              border: OutlineInputBorder(),
              prefixIcon: Icon(AppIcons.devices),
            ),
            onChanged: (_) => _onTextFieldChanged(),
          ),
          SizedBox(height: widget.spacing),
          TextFormField(
            controller: _localIdentifierController,
            decoration: const InputDecoration(
              labelText: AppTexts.localIdentifier,
              border: OutlineInputBorder(),
              prefixIcon: Icon(AppIcons.devices),
            ),
            onChanged: (_) => _onTextFieldChanged(),
          ),
          SizedBox(height: widget.spacing),
          TextFormField(
            controller: _udiDeviceIdentifierController,
            decoration: const InputDecoration(
              labelText: AppTexts.udiDeviceId,
              border: OutlineInputBorder(),
              prefixIcon: Icon(AppIcons.devices),
            ),
            onChanged: (_) => _onTextFieldChanged(),
          ),
        ],
      ],
    );
  }
}
