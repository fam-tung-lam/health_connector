import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_time_picker_row.dart';

/// Generic form field for managing a list of timestamped samples.
///
/// This widget eliminates duplication across heart rate, sleep stage, and
/// speed sample form fields by providing a reusable, type-safe implementation.
///
/// Type parameters:
/// - [T]: The sample type (e.g., HeartRateSample, SleepStage)
/// - [V]: The value type (e.g., int for BPM, SleepStageType for stage type)
@immutable
final class RecordSampleFormFieldGroup<T, V> extends StatefulWidget {
  const RecordSampleFormFieldGroup({
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    required this.valueInputBuilder,
    required this.sampleFactory,
    required this.sampleExtractor,
    required this.defaultValue,
    super.key,
    this.initialSamples,
    this.validator,
    this.requiresTimeRange = false,
    this.valueValidator,
  });

  /// The title displayed above the samples list.
  final String title;

  /// The start time of the allowed time range.
  final DateTime? startDateTime;

  /// The end time of the allowed time range.
  final DateTime? endDateTime;

  /// Callback when the samples list changes.
  final ValueChanged<List<T>?> onChanged;

  /// Builder for the value input widget.
  ///
  /// Parameters: (index, currentValue, onValueChanged)
  final Widget Function(int index, V? value, ValueChanged<V?> onChanged)
  valueInputBuilder;

  /// Factory to create a sample from time(s) and value.
  ///
  /// For single-time samples: `(time, null, value) => Sample`
  /// For time-range samples: `(startTime, endTime, value) => Sample`
  final T Function(DateTime time, DateTime? endTime, V value) sampleFactory;

  /// Extractor to get time, endTime, and value from a sample.
  final ({DateTime time, DateTime? endTime, V value}) Function(T sample)
  sampleExtractor;

  /// Default value for new samples.
  final V defaultValue;

  /// Initial list of samples.
  final List<T>? initialSamples;

  /// Validator for the entire samples list.
  final String? Function(List<T>?)? validator;

  /// Whether samples require both start and end times (e.g., sleep stages).
  final bool requiresTimeRange;

  /// Validator for individual sample values.
  final bool Function(V?)? valueValidator;

  @override
  State<RecordSampleFormFieldGroup<T, V>> createState() =>
      _RecordSampleFormFieldGroupState<T, V>();
}

class _RecordSampleFormFieldGroupState<T, V>
    extends State<RecordSampleFormFieldGroup<T, V>> {
  late List<_SampleEntry<V>> _samples;

  @override
  void initState() {
    super.initState();
    _samples =
        widget.initialSamples?.map((sample) {
          final extracted = widget.sampleExtractor(sample);
          return _SampleEntry<V>(
            time: extracted.time,
            endTime: extracted.endTime,
            value: extracted.value,
          );
        }).toList() ??
        [
          _SampleEntry<V>(
            time: widget.startDateTime ?? DateTime.now(),
            endTime: widget.requiresTimeRange
                ? (widget.startDateTime ?? DateTime.now()).add(
                    const Duration(hours: 1),
                  )
                : null,
            value: widget.defaultValue,
          ),
        ];
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifyChanged());
  }

  void _notifyChanged() {
    if (widget.startDateTime == null || widget.endDateTime == null) {
      widget.onChanged(null);
      return;
    }

    final validSamples = <T>[];
    for (final entry in _samples) {
      // Validate start time
      if (entry.time.isBefore(widget.startDateTime!) ||
          entry.time.isAfter(widget.endDateTime!)) {
        widget.onChanged(null);
        return;
      }

      // Validate end time if present
      if (entry.endTime != null) {
        if (entry.endTime!.isBefore(widget.startDateTime!) ||
            entry.endTime!.isAfter(widget.endDateTime!) ||
            entry.endTime!.isBefore(entry.time)) {
          widget.onChanged(null);
          return;
        }
      }

      // Validate value
      if (widget.valueValidator != null &&
          !widget.valueValidator!(entry.value)) {
        widget.onChanged(null);
        return;
      }

      validSamples.add(
        widget.sampleFactory(entry.time, entry.endTime, entry.value),
      );
    }

    widget.onChanged(validSamples);
  }

  void _addSample() {
    setState(() {
      final lastEntry = _samples.isNotEmpty
          ? _samples.last
          : _SampleEntry<V>(
              time: widget.startDateTime ?? DateTime.now(),
              value: widget.defaultValue,
            );

      final newTime =
          lastEntry.endTime ?? lastEntry.time.add(const Duration(minutes: 1));

      _samples.add(
        _SampleEntry<V>(
          time: newTime,
          endTime: widget.requiresTimeRange
              ? newTime.add(const Duration(hours: 1))
              : null,
          value: widget.defaultValue,
        ),
      );
    });
    _notifyChanged();
  }

  void _removeSample(int index) {
    setState(() => _samples.removeAt(index));
    _notifyChanged();
  }

  void _updateTime(
    int index,
    DateTime? date,
    TimeOfDay? time, {
    bool isEndTime = false,
  }) {
    if (date == null || time == null) {
      return;
    }

    final newTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      if (isEndTime) {
        _samples[index] = _samples[index].copyWith(endTime: newTime);
      } else {
        _samples[index] = _samples[index].copyWith(time: newTime);
      }
    });
    _notifyChanged();
  }

  void _updateValue(int index, V? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _samples[index] = _samples[index].copyWith(value: value);
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

    final samples = _samples
        .map((e) => widget.sampleFactory(e.time, e.endTime, e.value))
        .toList();

    return widget.validator?.call(samples);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      initialValue: widget.initialSamples,
      validator: (_) => _validate(),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with title and add button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
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

            // Samples list
            if (_samples.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppTexts.noSamplesAvailable,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              )
            else
              ..._samples.asMap().entries.map((entry) {
                final index = entry.key;
                final sample = entry.value;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sample number and remove button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${AppTexts.sample} ${index + 1}',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(AppIcons.delete, size: 20),
                              onPressed: () => _removeSample(index),
                              tooltip: AppTexts.removeSample,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Start time picker
                        DateTimePickerRow(
                          startDate: DateTime(
                            sample.time.year,
                            sample.time.month,
                            sample.time.day,
                          ),
                          startTime: TimeOfDay.fromDateTime(sample.time),
                          dateLabel: widget.requiresTimeRange
                              ? AppTexts.startDate
                              : AppTexts.date,
                          timeLabel: widget.requiresTimeRange
                              ? AppTexts.startTime
                              : AppTexts.time,
                          onDateChanged: (date) => _updateTime(
                            index,
                            date,
                            TimeOfDay.fromDateTime(sample.time),
                          ),
                          onTimeChanged: (time) => _updateTime(
                            index,
                            DateTime(
                              sample.time.year,
                              sample.time.month,
                              sample.time.day,
                            ),
                            time,
                          ),
                        ),

                        // End time picker (if time range required)
                        if (widget.requiresTimeRange &&
                            sample.endTime != null) ...[
                          const SizedBox(height: 8),
                          DateTimePickerRow(
                            startDate: DateTime(
                              sample.endTime!.year,
                              sample.endTime!.month,
                              sample.endTime!.day,
                            ),
                            startTime: TimeOfDay.fromDateTime(sample.endTime!),
                            dateLabel: AppTexts.endDate,
                            timeLabel: AppTexts.endTime,
                            onDateChanged: (date) => _updateTime(
                              index,
                              date,
                              TimeOfDay.fromDateTime(sample.endTime!),
                              isEndTime: true,
                            ),
                            onTimeChanged: (time) => _updateTime(
                              index,
                              DateTime(
                                sample.endTime!.year,
                                sample.endTime!.month,
                                sample.endTime!.day,
                              ),
                              time,
                              isEndTime: true,
                            ),
                          ),
                        ],

                        const SizedBox(height: 8),

                        // Value input (custom per type)
                        widget.valueInputBuilder(
                          index,
                          sample.value,
                          (value) => _updateValue(index, value),
                        ),
                      ],
                    ),
                  ),
                );
              }),

            // Error message
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
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

/// Internal entry class for managing sample data.
class _SampleEntry<V> {
  const _SampleEntry({
    required this.time,
    required this.value,
    this.endTime,
  });

  final DateTime time;
  final DateTime? endTime;
  final V value;

  _SampleEntry<V> copyWith({
    DateTime? time,
    DateTime? endTime,
    V? value,
  }) {
    return _SampleEntry<V>(
      time: time ?? this.time,
      endTime: endTime ?? this.endTime,
      value: value ?? this.value,
    );
  }
}
