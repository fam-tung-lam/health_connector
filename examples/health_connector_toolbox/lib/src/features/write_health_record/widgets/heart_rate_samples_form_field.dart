import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show HeartRateMeasurement, Number;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/widgets/date_time_picker_row.dart';

/// A form field widget for managing multiple heart rate measurement samples.
///
/// Allows users to add, remove, and edit heart rate samples. Each sample
/// consists of a time and BPM value. Samples must be within the specified
/// time range.
@immutable
final class HeartRateSamplesFormField extends StatefulWidget {
  const HeartRateSamplesFormField({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  /// The start time of the time range (samples must be within this range).
  final DateTime? startDateTime;

  /// The end time of the time range (samples must be within this range).
  final DateTime? endDateTime;

  /// Callback when the samples list changes.
  ///
  /// Provides a list of [HeartRateMeasurement] or null if invalid.
  final ValueChanged<List<HeartRateMeasurement>?> onChanged;

  /// Initial list of samples.
  final List<HeartRateMeasurement>? initialSamples;

  /// Validator for the samples field.
  final String? Function(List<HeartRateMeasurement>?)? validator;

  @override
  State<HeartRateSamplesFormField> createState() =>
      _HeartRateSamplesFormFieldState();
}

class _HeartRateSamplesFormFieldState extends State<HeartRateSamplesFormField> {
  late List<_SampleEntry> _samples;

  @override
  void initState() {
    super.initState();
    _samples =
        widget.initialSamples
            ?.map(
              (sample) => _SampleEntry(
                time: sample.time,
                bpm: sample.beatsPerMinute.value.toDouble(),
              ),
            )
            .toList() ??
        [
          _SampleEntry(
            time: widget.startDateTime ?? DateTime.now(),
            bpm: 72.0,
          ),
        ];
    // Defer the notification to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifyChanged();
    });
  }

  void _notifyChanged() {
    if (widget.startDateTime == null || widget.endDateTime == null) {
      widget.onChanged(null);
      return;
    }

    final validSamples = <HeartRateMeasurement>[];
    for (final entry in _samples) {
      if (entry.time.isBefore(widget.startDateTime!) ||
          entry.time.isAfter(widget.endDateTime!)) {
        widget.onChanged(null);
        return;
      }
      if (entry.bpm <= 0) {
        widget.onChanged(null);
        return;
      }
      validSamples.add(
        HeartRateMeasurement(
          time: entry.time,
          beatsPerMinute: Number(entry.bpm.toInt()),
        ),
      );
    }

    widget.onChanged(validSamples);
  }

  void _addSample() {
    setState(() {
      final lastTime = _samples.isNotEmpty
          ? _samples.last.time
          : widget.startDateTime ?? DateTime.now();
      _samples.add(
        _SampleEntry(
          time: lastTime.add(const Duration(minutes: 1)),
          bpm: 72.0,
        ),
      );
    });
    _notifyChanged();
  }

  void _removeSample(int index) {
    setState(() {
      _samples.removeAt(index);
    });
    _notifyChanged();
  }

  void _updateSampleTime(int index, DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) {
      return;
    }
    setState(() {
      _samples[index] = _samples[index].copyWith(
        time: DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        ),
      );
    });
    _notifyChanged();
  }

  void _updateSampleBpm(int index, String value) {
    final bpm = double.tryParse(value);
    if (bpm == null || bpm <= 0) {
      return;
    }
    setState(() {
      _samples[index] = _samples[index].copyWith(bpm: bpm);
    });
    _notifyChanged();
  }

  String? _validate() {
    if (_samples.isEmpty) {
      return AppTexts.atLeastOneSampleRequired;
    }

    if (widget.startDateTime == null || widget.endDateTime == null) {
      return AppTexts.pleaseSelectBothStartAndEndDateTime;
    }

    for (final entry in _samples) {
      if (entry.time.isBefore(widget.startDateTime!) ||
          entry.time.isAfter(widget.endDateTime!)) {
        return AppTexts.sampleTimeMustBeWithinRange;
      }
      if (entry.bpm <= 0) {
        return AppTexts.heartRateMustBePositive;
      }
    }

    return widget.validator?.call(
      _samples
          .map(
            (e) => HeartRateMeasurement(
              time: e.time,
              beatsPerMinute: Number(e.bpm.toInt()),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<HeartRateMeasurement>>(
      initialValue: widget.initialSamples,
      validator: (_) => _validate(),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppTexts.heartRateSamples,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(AppIcons.add),
                  onPressed: _addSample,
                  tooltip: AppTexts.addSample,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_samples.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppTexts.atLeastOneSampleRequired,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ..._samples.asMap().entries.map((entry) {
                final index = entry.key;
                final sample = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${AppTexts.sampleTime} ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_samples.length > 1)
                              IconButton(
                                icon: const Icon(
                                  AppIcons.removeCircle,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeSample(index),
                                tooltip: AppTexts.removeSample,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        DateTimePickerRow(
                          startDate: DateTime(
                            sample.time.year,
                            sample.time.month,
                            sample.time.day,
                          ),
                          startTime: TimeOfDay.fromDateTime(sample.time),
                          onDateChanged: (date) {
                            final currentTime = TimeOfDay.fromDateTime(
                              sample.time,
                            );
                            _updateSampleTime(index, date, currentTime);
                          },
                          onTimeChanged: (time) {
                            final currentDate = DateTime(
                              sample.time.year,
                              sample.time.month,
                              sample.time.day,
                            );
                            _updateSampleTime(index, currentDate, time);
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: sample.bpm.toInt().toString(),
                          decoration: InputDecoration(
                            labelText: AppTexts.sampleBpm,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(AppIcons.numbers),
                            errorText: field.errorText,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateSampleBpm(index, value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppTexts.pleaseEnterHeartRate;
                            }
                            final bpm = double.tryParse(value);
                            if (bpm == null) {
                              return AppTexts.pleaseEnterValidNumber;
                            }
                            if (bpm <= 0) {
                              return AppTexts.heartRateMustBePositive;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Internal class to hold sample entry state.
class _SampleEntry {
  const _SampleEntry({
    required this.time,
    required this.bpm,
  });

  final DateTime time;
  final double bpm;

  _SampleEntry copyWith({
    DateTime? time,
    double? bpm,
  }) {
    return _SampleEntry(
      time: time ?? this.time,
      bpm: bpm ?? this.bpm,
    );
  }
}
