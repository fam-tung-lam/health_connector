import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        DataOrigin,
        Device,
        DistanceHealthDataType,
        FloorsClimbedHealthDataType,
        HealthConnectorErrorCode,
        HealthConnectorException,
        HealthDataType,
        HeartRateMeasurement,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        LeanBodyMassHealthDataType,
        MeasurementUnit,
        Metadata,
        RecordingMethod,
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        SleepStage,
        SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/show_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/date_time_picker_row.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/models/health_record_form_config.dart'
    show
        HealthRecordFormConfig,
        HeartRateSeriesRecordFormConfig,
        SleepSessionRecordFormConfig,
        SleepStageRecordFormConfig;
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/duration_picker_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/health_value_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/heart_rate_samples_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/metadata_form_fields.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/sleep_stage_type_dropdown_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/sleep_stages_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart' show Provider;

/// Unified page for writing health records.
///
/// This page dynamically renders the appropriate form fields based on the
/// provided [HealthDataType].
/// It handles both interval-based records (e.g., steps) and
/// instant-based records (e.g., weight).
@immutable
final class WriteHealthRecordFormPage extends StatefulWidget {
  const WriteHealthRecordFormPage({
    required this.dataType,
    super.key,
  });

  /// The health data type that determines which form fields to render.
  final HealthDataType dataType;

  @override
  State<WriteHealthRecordFormPage> createState() =>
      _WriteHealthRecordFormPageState();
}

class _WriteHealthRecordFormPageState extends State<WriteHealthRecordFormPage> {
  late final WriteHealthRecordChangeNotifier _notifier =
      Provider.of<WriteHealthRecordChangeNotifier>(
        context,
        listen: false,
      );

  late final HealthRecordFormConfig _config =
      HealthRecordFormConfig.fromDataType(widget.dataType);

  final _formKey = GlobalKey<FormState>();
  RecordingMethod _recordingMethod = RecordingMethod.unknown;
  Device? _device;
  MeasurementUnit? _value;
  bool _isWriting = false;

  // State for heart rate series samples (Android)
  List<HeartRateMeasurement>? _heartRateSamples;

  // State for sleep stages (Android SleepSessionRecord)
  List<SleepStage>? _sleepStages;

  // State for single sleep stage (iOS SleepStageRecord)
  SleepStage? _sleepStage;
  SleepStageType? _sleepStageType;

  // Optional title and notes for sleep records
  String? _sleepTitle;
  String? _sleepNotes;

  // Use different state mixins based on whether duration is needed
  DateTime? _startDate;
  TimeOfDay? _startTime;
  TimeOfDay? _duration;

  DateTime? get startDateTime {
    if (_startDate == null || _startTime == null) {
      return null;
    }
    return DateTime(
      _startDate!.year,
      _startDate!.month,
      _startDate!.day,
      _startTime!.hour,
      _startTime!.minute,
    );
  }

  DateTime? get endDateTime {
    if (!_config.needsDuration) {
      return null;
    }
    final start = startDateTime;
    if (start == null || _duration == null) {
      return null;
    }
    final durationMinutes = _duration!.hour * 60 + _duration!.minute;
    if (durationMinutes == 0) {
      return null;
    }
    return start.add(Duration(minutes: durationMinutes));
  }

  @override
  void initState() {
    super.initState();
    if (_config.needsDuration) {
      // For interval records, set start time to 30 minutes ago
      final nowMinus30Min = DateTime.now().subtract(
        const Duration(minutes: 30),
      );
      _startDate = DateTime(
        nowMinus30Min.year,
        nowMinus30Min.month,
        nowMinus30Min.day,
      );
      _startTime = TimeOfDay(
        hour: nowMinus30Min.hour,
        minute: nowMinus30Min.minute,
      );
      _duration = const TimeOfDay(hour: 0, minute: 30);
    } else {
      // For instant records, set to current time
      final now = DateTime.now();
      _startDate = DateTime(now.year, now.month, now.day);
      _startTime = TimeOfDay.fromDateTime(now);
    }
  }

  void setDate(DateTime? date) {
    setState(() {
      _startDate = date;
    });
    _updateSleepStage();
  }

  void setTime(TimeOfDay? time) {
    setState(() {
      _startTime = time;
    });
    _updateSleepStage();
  }

  void setDuration(TimeOfDay? duration) {
    setState(() {
      _duration = duration;
      // Update sleep stage if we're creating a SleepStageRecord
      if (widget.dataType is SleepStageHealthDataType &&
          _sleepStageType != null &&
          startDateTime != null &&
          endDateTime != null) {
        _sleepStage = SleepStage(
          startTime: startDateTime!,
          endTime: endDateTime!,
          stageType: _sleepStageType!,
        );
      }
    });
  }

  void _updateSleepStage() {
    if (widget.dataType is SleepStageHealthDataType &&
        _sleepStageType != null &&
        startDateTime != null &&
        endDateTime != null) {
      setState(() {
        _sleepStage = SleepStage(
          startTime: startDateTime!,
          endTime: endDateTime!,
          stageType: _sleepStageType!,
        );
      });
    } else {
      setState(() {
        _sleepStage = null;
      });
    }
  }

  String? _durationValidator(TimeOfDay? value) {
    if (value == null) {
      return '${AppTexts.pleaseSelect} Duration';
    }
    final durationMinutes = value.hour * 60 + value.minute;
    if (durationMinutes == 0) {
      return 'Duration must be greater than 0';
    }
    if (startDateTime == null) {
      return AppTexts.pleaseSelectDateTime;
    }
    final end = endDateTime;
    if (end == null) {
      return 'Failed to calculate end time';
    }
    return null;
  }

  Future<void> _submitRecord() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate device is present when required
    if ((_recordingMethod == RecordingMethod.automaticallyRecorded ||
            _recordingMethod == RecordingMethod.activelyRecorded) &&
        _device == null) {
      return;
    }

    // Validate required fields
    if (startDateTime == null) {
      return;
    }
    if (_config.needsDuration && endDateTime == null) {
      return;
    }

    // Special validation for heart rate series record
    if (widget.dataType is HeartRateSeriesRecordHealthDataType) {
      if (_heartRateSamples == null || _heartRateSamples!.isEmpty) {
        return;
      }
    } else if (widget.dataType is SleepSessionHealthDataType) {
      if (_sleepStages == null || _sleepStages!.isEmpty) {
        return;
      }
    } else if (widget.dataType is SleepStageHealthDataType) {
      if (_sleepStage == null) {
        return;
      }
    } else {
      if (_value == null) {
        return;
      }
    }

    setState(() {
      _isWriting = true;
    });

    try {
      // Use a fake package name 'com.example.health_connector_toolbox'.
      // In production this should come from app config.
      const dataOrigin = DataOrigin('com.example.health_connector_toolbox');
      final metadata = switch (_recordingMethod) {
        RecordingMethod.manualEntry => Metadata.manualEntry(
          dataOrigin: dataOrigin,
        ),
        RecordingMethod.automaticallyRecorded => Metadata.automaticallyRecorded(
          dataOrigin: dataOrigin,
          device: _device!,
        ),
        RecordingMethod.activelyRecorded => Metadata.activelyRecorded(
          dataOrigin: dataOrigin,
          device: _device!,
        ),
        RecordingMethod.unknown => Metadata.unknownRecordingMethod(
          dataOrigin: dataOrigin,
          device: _device,
        ),
      };

      final record = switch (widget.dataType) {
        HeartRateSeriesRecordHealthDataType() =>
          (_config as HeartRateSeriesRecordFormConfig).buildRecordWithSamples(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            samples: _heartRateSamples!,
            metadata: metadata,
          ),
        SleepSessionHealthDataType() =>
          (_config as SleepSessionRecordFormConfig).buildRecordWithStages(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            stages: _sleepStages!,
            metadata: metadata,
            title: _sleepTitle?.isEmpty ?? true ? null : _sleepTitle,
            notes: _sleepNotes?.isEmpty ?? true ? null : _sleepNotes,
          ),
        SleepStageHealthDataType() =>
          (_config as SleepStageRecordFormConfig).buildRecordWithStage(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            stageType: _sleepStage!.stageType,
            metadata: metadata,
            title: _sleepTitle?.isEmpty ?? true ? null : _sleepTitle,
            notes: _sleepNotes?.isEmpty ?? true ? null : _sleepNotes,
          ),
        _ => _config.buildRecord(
          startDateTime: startDateTime!,
          endDateTime: endDateTime,
          value: _value!,
          metadata: metadata,
        ),
      };

      await _notifier.writeHealthRecord(record);

      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.success,
        '${AppTexts.successfullyWroteRecord} '
        '${_notifier.newRecordId?.value ?? 'unknown'}',
      );

      Navigator.of(context).pop();
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }

      final message = _getErrorMessage(e);
      showAppSnackBar(context, SnackBarType.error, message);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.error,
        '${AppTexts.errorPrefixColon} $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isWriting = false;
        });
      }
    }
  }

  String _getErrorMessage(HealthConnectorException e) {
    if (e.code == HealthConnectorErrorCode.unsupportedHealthPlatformApi) {
      return switch (widget.dataType) {
        StepsHealthDataType() => AppTexts.writePermissionDeniedSteps,
        WeightHealthDataType() => AppTexts.writePermissionDeniedWeight,
        HeightHealthDataType() => AppTexts.writePermissionDeniedHeight,
        BodyFatPercentageHealthDataType() =>
          AppTexts.writePermissionDeniedBodyFatPercentage,
        LeanBodyMassHealthDataType() =>
          AppTexts.writePermissionDeniedLeanBodyMass,
        BodyTemperatureHealthDataType() =>
          AppTexts.writePermissionDeniedBodyTemperature,
        DistanceHealthDataType() => AppTexts.writePermissionDeniedDistance,
        ActiveCaloriesBurnedHealthDataType() =>
          AppTexts.writePermissionDeniedActiveCaloriesBurned,
        FloorsClimbedHealthDataType() =>
          AppTexts.writePermissionDeniedFloorsClimbed,
        WheelchairPushesHealthDataType() =>
          AppTexts.writePermissionDeniedWheelchairPushes,
        HydrationHealthDataType() => AppTexts.writePermissionDeniedHydration,
        HeartRateMeasurementRecordHealthDataType() =>
          AppTexts.writePermissionDeniedHeartRateRecord,
        HeartRateSeriesRecordHealthDataType() =>
          AppTexts.writePermissionDeniedHeartRateRecord,
        SleepSessionHealthDataType() =>
          AppTexts.writePermissionDeniedSleepSession,
        SleepStageHealthDataType() =>
          AppTexts.writePermissionDeniedSleepStageRecord,
      };
    }
    return e.message;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isWriting,
      message: AppTexts.save,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            switch (widget.dataType) {
              StepsHealthDataType() => AppTexts.insertSteps,
              WeightHealthDataType() => AppTexts.insertWeight,
              HeightHealthDataType() => AppTexts.insertHeight,
              BodyFatPercentageHealthDataType() =>
                AppTexts.insertBodyFatPercentage,
              LeanBodyMassHealthDataType() => AppTexts.insertLeanBodyMass,
              BodyTemperatureHealthDataType() => AppTexts.insertBodyTemperature,
              DistanceHealthDataType() => AppTexts.insertDistance,
              ActiveCaloriesBurnedHealthDataType() =>
                AppTexts.insertActiveCaloriesBurned,
              FloorsClimbedHealthDataType() => AppTexts.insertFloorsClimbed,
              WheelchairPushesHealthDataType() =>
                AppTexts.insertWheelchairPushes,
              HydrationHealthDataType() => AppTexts.insertHydration,
              HeartRateMeasurementRecordHealthDataType() =>
                AppTexts.insertHeartRateRecord,
              HeartRateSeriesRecordHealthDataType() =>
                AppTexts.insertHeartRateRecord,
              SleepSessionHealthDataType() => AppTexts.insertSleepSession,
              SleepStageHealthDataType() => AppTexts.insertSleepStageRecord,
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DateTimePickerRow(
                  startDate: _startDate,
                  startTime: _startTime,
                  onDateChanged: setDate,
                  onTimeChanged: setTime,
                ),
                if (_config.needsDuration) ...[
                  const SizedBox(height: 16),
                  DurationPickerField(
                    label: 'Duration (HH:MM)',
                    initialValue: _duration,
                    onChanged: setDuration,
                    validator: _durationValidator,
                  ),
                ],
                const SizedBox(height: 16),
                if (widget.dataType is HeartRateSeriesRecordHealthDataType)
                  HeartRateSamplesFormField(
                    startDateTime: startDateTime,
                    endDateTime: endDateTime,
                    onChanged: (samples) {
                      setState(() {
                        _heartRateSamples = samples;
                      });
                    },
                  )
                else if (widget.dataType is SleepSessionHealthDataType)
                  SleepStagesFormField(
                    startDateTime: startDateTime,
                    endDateTime: endDateTime,
                    onChanged: (stages) {
                      setState(() {
                        _sleepStages = stages;
                      });
                    },
                  )
                else if (widget.dataType is SleepStageHealthDataType) ...[
                  SleepStageTypeDropdownField(
                    value: _sleepStageType,
                    onChanged: (type) {
                      setState(() {
                        _sleepStageType = type;
                      });
                      _updateSleepStage();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a sleep stage type';
                      }
                      return null;
                    },
                  ),
                ] else
                  HealthValueField(
                    dataType: widget.dataType,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                // Optional title and notes fields for sleep records
                if (widget.dataType is SleepSessionHealthDataType ||
                    widget.dataType is SleepStageHealthDataType) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _sleepTitle,
                    decoration: const InputDecoration(
                      labelText: 'Title (optional)',
                      border: OutlineInputBorder(),
                      helperText: 'Optional title for the sleep record',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _sleepTitle = value.isEmpty ? null : value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _sleepNotes,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      border: OutlineInputBorder(),
                      helperText: 'Optional notes about the sleep record',
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        _sleepNotes = value.isEmpty ? null : value;
                      });
                    },
                  ),
                ],
                const SizedBox(height: 16),
                MetadataFormFields(
                  healthPlatform: _notifier.healthPlatform,
                  initialRecordingMethod: _recordingMethod,
                  initialDevice: _device,
                  onRecordingMethodChanged: (method) {
                    setState(() {
                      _recordingMethod = method ?? RecordingMethod.unknown;
                    });
                  },
                  onDeviceChanged: (device) {
                    setState(() {
                      _device = device;
                    });
                  },
                  recordingMethodValidator: (value) {
                    if (value == null) {
                      return AppTexts.pleaseSelectRecordingMethod;
                    }
                    return null;
                  },
                  deviceTypeValidator: (value) {
                    if (value == null) {
                      return AppTexts.pleaseSelectDeviceType;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isWriting ? null : _submitRecord,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  child: const Text(AppTexts.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
