import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show SleepStage, SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/widgets/date_time_picker_row.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/sleep_stage_type_dropdown_field.dart';

/// A form field widget for managing multiple sleep stage samples.
///
/// Allows users to add, remove, and edit sleep stages. Each stage consists of
/// start time, end time, and stage type. Stages must be within the specified
/// session time range.
@immutable
final class SleepStagesFormField extends StatefulWidget {
  const SleepStagesFormField({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialStages,
    this.validator,
  });

  /// The start time of the session time range (stages must be within
  /// this range).
  final DateTime? startDateTime;

  /// The end time of the session time range (stages must be within this range).
  final DateTime? endDateTime;

  /// Callback when the stages list changes.
  ///
  /// Provides a list of [SleepStage] or null if invalid.
  final ValueChanged<List<SleepStage>?> onChanged;

  /// Initial list of stages.
  final List<SleepStage>? initialStages;

  /// Validator for the stages field.
  final String? Function(List<SleepStage>?)? validator;

  @override
  State<SleepStagesFormField> createState() => _SleepStagesFormFieldState();
}

class _SleepStagesFormFieldState extends State<SleepStagesFormField> {
  late List<_StageEntry> _stages;

  @override
  void initState() {
    super.initState();
    _stages =
        widget.initialStages
            ?.map(
              (stage) => _StageEntry(
                startTime: stage.startTime,
                endTime: stage.endTime,
                stageType: stage.stageType,
              ),
            )
            .toList() ??
        [
          _StageEntry(
            startTime: widget.startDateTime ?? DateTime.now(),
            endTime: (widget.startDateTime ?? DateTime.now()).add(
              const Duration(hours: 1),
            ),
            stageType: SleepStageType.light,
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

    final validStages = <SleepStage>[];
    for (final entry in _stages) {
      if (entry.startTime.isBefore(widget.startDateTime!) ||
          entry.endTime.isAfter(widget.endDateTime!) ||
          entry.startTime.isAfter(entry.endTime)) {
        widget.onChanged(null);
        return;
      }
      if (entry.stageType == null) {
        widget.onChanged(null);
        return;
      }
      validStages.add(
        SleepStage(
          startTime: entry.startTime,
          endTime: entry.endTime,
          stageType: entry.stageType!,
        ),
      );
    }

    widget.onChanged(validStages);
  }

  void _addStage() {
    setState(() {
      final lastEndTime = _stages.isNotEmpty
          ? _stages.last.endTime
          : widget.startDateTime ?? DateTime.now();
      _stages.add(
        _StageEntry(
          startTime: lastEndTime,
          endTime: lastEndTime.add(const Duration(hours: 1)),
          stageType: SleepStageType.light,
        ),
      );
    });
    _notifyChanged();
  }

  void _removeStage(int index) {
    setState(() {
      _stages.removeAt(index);
    });
    _notifyChanged();
  }

  void _updateStageStartTime(int index, DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) {
      return;
    }
    setState(() {
      final newStartTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      _stages[index] = _stages[index].copyWith(startTime: newStartTime);
    });
    _notifyChanged();
  }

  void _updateStageEndTime(int index, DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) {
      return;
    }
    setState(() {
      final newEndTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      _stages[index] = _stages[index].copyWith(endTime: newEndTime);
    });
    _notifyChanged();
  }

  void _updateStageType(int index, SleepStageType? stageType) {
    if (stageType == null) {
      return;
    }
    setState(() {
      _stages[index] = _stages[index].copyWith(stageType: stageType);
    });
    _notifyChanged();
  }

  String? _validate() {
    if (_stages.isEmpty) {
      return AppTexts.atLeastOneSleepStageRequired;
    }

    if (widget.startDateTime == null || widget.endDateTime == null) {
      return AppTexts.pleaseSelectBothStartAndEndDateTime;
    }

    for (final entry in _stages) {
      if (entry.startTime.isBefore(widget.startDateTime!) ||
          entry.endTime.isAfter(widget.endDateTime!)) {
        return 'Sleep stage time must be within session time range';
      }
      if (entry.startTime.isAfter(entry.endTime)) {
        return 'Stage end time must be after start time';
      }
      if (entry.stageType == null) {
        return 'Please select a stage type for all stages';
      }
    }

    return widget.validator?.call(
      _stages
          .map(
            (e) => SleepStage(
              startTime: e.startTime,
              endTime: e.endTime,
              stageType: e.stageType!,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<SleepStage>>(
      initialValue: widget.initialStages,
      validator: (_) => _validate(),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppTexts.sleepStages,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(AppIcons.add),
                  onPressed: _addStage,
                  tooltip: AppTexts.addSleepStage,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_stages.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppTexts.atLeastOneSleepStageRequired,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ..._stages.asMap().entries.map((entry) {
                final index = entry.key;
                final stage = entry.value;
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
                              '${AppTexts.sleepStage} ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_stages.length > 1)
                              IconButton(
                                icon: const Icon(
                                  AppIcons.removeCircle,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeStage(index),
                                tooltip: AppTexts.removeSleepStage,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppTexts.startTime,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        DateTimePickerRow(
                          startDate: DateTime(
                            stage.startTime.year,
                            stage.startTime.month,
                            stage.startTime.day,
                          ),
                          startTime: TimeOfDay.fromDateTime(stage.startTime),
                          onDateChanged: (date) {
                            final currentTime = TimeOfDay.fromDateTime(
                              stage.startTime,
                            );
                            _updateStageStartTime(index, date, currentTime);
                          },
                          onTimeChanged: (time) {
                            final currentDate = DateTime(
                              stage.startTime.year,
                              stage.startTime.month,
                              stage.startTime.day,
                            );
                            _updateStageStartTime(index, currentDate, time);
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppTexts.endTime,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        DateTimePickerRow(
                          startDate: DateTime(
                            stage.endTime.year,
                            stage.endTime.month,
                            stage.endTime.day,
                          ),
                          startTime: TimeOfDay.fromDateTime(stage.endTime),
                          onDateChanged: (date) {
                            final currentTime = TimeOfDay.fromDateTime(
                              stage.endTime,
                            );
                            _updateStageEndTime(index, date, currentTime);
                          },
                          onTimeChanged: (time) {
                            final currentDate = DateTime(
                              stage.endTime.year,
                              stage.endTime.month,
                              stage.endTime.day,
                            );
                            _updateStageEndTime(index, currentDate, time);
                          },
                        ),
                        const SizedBox(height: 8),
                        SleepStageTypeDropdownField(
                          value: stage.stageType,
                          onChanged: (type) => _updateStageType(index, type),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a stage type';
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

/// Internal class to hold sleep stage entry state.
class _StageEntry {
  const _StageEntry({
    required this.startTime,
    required this.endTime,
    required this.stageType,
  });

  final DateTime startTime;
  final DateTime endTime;
  final SleepStageType? stageType;

  _StageEntry copyWith({
    DateTime? startTime,
    DateTime? endTime,
    SleepStageType? stageType,
  }) {
    return _StageEntry(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      stageType: stageType ?? this.stageType,
    );
  }
}
