import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show
        ExerciseSessionEvent,
        ExerciseSessionInstantEvent,
        ExerciseSessionIntervalEvent,
        ExerciseSessionLapEvent,
        ExerciseSessionMarkerEvent,
        ExerciseSessionSegmentEvent,
        ExerciseSessionStateTransitionEvent,
        ExerciseSessionStateTransitionType,
        ExerciseSegmentType,
        HealthPlatform,
        Length;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/exercise_segment_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/exercise_state_transition_type_extension.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_time_picker_row.dart';
import 'package:health_connector_toolbox/src/common/widgets/searchable_dropdown_menu_form_field.dart';

/// Form field for managing a list of exercise session events.
///
/// Supports all event types:
/// - State Transition (iOS only)
/// - Marker (iOS only)
/// - Lap (both platforms)
/// - Segment (both platforms)
@immutable
final class ExerciseSessionEventFormFieldGroup extends StatefulWidget {
  const ExerciseSessionEventFormFieldGroup({
    required this.startDateTime,
    required this.endDateTime,
    required this.healthPlatform,
    required this.onChanged,
    super.key,
    this.initialEvents,
  });

  /// The start time of the allowed time range (session start).
  final DateTime? startDateTime;

  /// The end time of the allowed time range (session end).
  final DateTime? endDateTime;

  /// The health platform (used to filter iOS-only events).
  final HealthPlatform healthPlatform;

  /// Callback when the events list changes.
  final ValueChanged<List<ExerciseSessionEvent>?> onChanged;

  /// Initial list of events.
  final List<ExerciseSessionEvent>? initialEvents;

  @override
  State<ExerciseSessionEventFormFieldGroup> createState() =>
      _ExerciseSessionEventFormFieldGroupState();
}

class _ExerciseSessionEventFormFieldGroupState
    extends State<ExerciseSessionEventFormFieldGroup> {
  late List<_EventEntry> _events;

  /// Whether iOS-only events are supported.
  bool get _supportsIOSOnlyEvents =>
      widget.healthPlatform == HealthPlatform.appleHealth;

  @override
  void initState() {
    super.initState();
    _events =
        widget.initialEvents?.map((event) {
          return switch (event) {
            ExerciseSessionInstantEvent(:final time) => switch (event) {
              ExerciseSessionStateTransitionEvent(:final type) => _EventEntry(
                type: _EventType.stateTransition,
                startTime: time,
                endTime: time,
                transitionType: type,
              ),
              ExerciseSessionMarkerEvent() => _EventEntry(
                type: _EventType.marker,
                startTime: time,
                endTime: time,
              ),
            },
            ExerciseSessionIntervalEvent(:final startTime, :final endTime) =>
              switch (event) {
                ExerciseSessionLapEvent(:final distance) => _EventEntry(
                  type: _EventType.lap,
                  startTime: startTime,
                  endTime: endTime,
                  distanceMeters: distance?.inMeters,
                ),
                ExerciseSessionSegmentEvent(
                  :final segmentType,
                  :final repetitions,
                ) =>
                  _EventEntry(
                    type: _EventType.segment,
                    startTime: startTime,
                    endTime: endTime,
                    segmentType: segmentType,
                    repetitions: repetitions,
                  ),
              },
          };
        }).toList() ??
        [];
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifyChanged());
  }

  void _notifyChanged() {
    if (widget.startDateTime == null || widget.endDateTime == null) {
      widget.onChanged(null);
      return;
    }

    final validEvents = <ExerciseSessionEvent>[];
    for (final entry in _events) {
      // Validate start time
      if (entry.startTime.isBefore(widget.startDateTime!) ||
          entry.startTime.isAfter(widget.endDateTime!)) {
        widget.onChanged(null);
        return;
      }

      // Validate end time (skip for instant events: stateTransition, marker)
      final isInstantEvent =
          entry.type == _EventType.stateTransition ||
          entry.type == _EventType.marker;
      if (!isInstantEvent &&
          (entry.endTime.isBefore(widget.startDateTime!) ||
              entry.endTime.isAfter(widget.endDateTime!) ||
              entry.endTime.isBefore(entry.startTime))) {
        widget.onChanged(null);
        return;
      }

      // Validate type-specific fields and create event
      ExerciseSessionEvent event;
      switch (entry.type) {
        case _EventType.stateTransition:
          if (entry.transitionType == null) {
            widget.onChanged(null);
            return;
          }
          event = ExerciseSessionStateTransitionEvent(
            time: entry.startTime,
            type: entry.transitionType!,
          );
        case _EventType.marker:
          event = ExerciseSessionMarkerEvent(time: entry.startTime);
        case _EventType.lap:
          event = ExerciseSessionLapEvent(
            startTime: entry.startTime,
            endTime: entry.endTime,
            distance: entry.distanceMeters != null
                ? Length.meters(entry.distanceMeters!)
                : null,
          );
        case _EventType.segment:
          if (entry.segmentType == null) {
            widget.onChanged(null);
            return;
          }
          event = ExerciseSessionSegmentEvent(
            startTime: entry.startTime,
            endTime: entry.endTime,
            segmentType: entry.segmentType!,
            repetitions: entry.repetitions,
          );
      }

      validEvents.add(event);
    }

    widget.onChanged(validEvents.isEmpty ? null : validEvents);
  }

  void _addEvent() {
    setState(() {
      final lastEntry = _events.isNotEmpty
          ? _events.last
          : _EventEntry(
              type: _EventType.lap,
              startTime: widget.startDateTime ?? DateTime.now(),
              endTime: (widget.startDateTime ?? DateTime.now()).add(
                const Duration(minutes: 1),
              ),
            );

      final newStartTime = lastEntry.endTime.add(const Duration(minutes: 1));
      final newEndTime = newStartTime.add(const Duration(minutes: 1));

      _events.add(
        _EventEntry(
          type: _EventType.lap,
          startTime: newStartTime,
          endTime: newEndTime,
        ),
      );
    });
    _notifyChanged();
  }

  void _removeEvent(int index) {
    setState(() => _events.removeAt(index));
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
      final entry = _events[index];
      final isInstantEvent =
          entry.type == _EventType.stateTransition ||
          entry.type == _EventType.marker;
      if (isInstantEvent) {
        _events[index] = entry.copyWith(
          startTime: newTime,
          endTime: newTime,
        );
      } else if (isEndTime) {
        _events[index] = entry.copyWith(endTime: newTime);
      } else {
        _events[index] = entry.copyWith(startTime: newTime);
      }
    });
    _notifyChanged();
  }

  void _updateEventType(int index, _EventType? type) {
    if (type == null) {
      return;
    }
    setState(() {
      final currentEntry = _events[index];
      final isInstantEvent =
          type == _EventType.stateTransition || type == _EventType.marker;
      // For instant events, use single time (startTime) for both
      final endTime = isInstantEvent
          ? currentEntry.startTime
          : currentEntry.endTime;
      // Clear type-specific fields when changing event type
      _events[index] = _EventEntry(
        type: type,
        startTime: currentEntry.startTime,
        endTime: endTime,
        // Only preserve fields relevant to the new type
        transitionType: type == _EventType.stateTransition
            ? currentEntry.transitionType
            : null,
        segmentType: type == _EventType.segment
            ? currentEntry.segmentType
            : null,
        distanceMeters: type == _EventType.lap
            ? currentEntry.distanceMeters
            : null,
        repetitions: type == _EventType.segment
            ? currentEntry.repetitions
            : null,
      );
    });
    _notifyChanged();
  }

  void _updateTransitionType(
    int index,
    ExerciseSessionStateTransitionType? type,
  ) {
    setState(() {
      _events[index] = _events[index].copyWith(transitionType: type);
    });
    _notifyChanged();
  }

  void _updateSegmentType(int index, ExerciseSegmentType? type) {
    setState(() {
      _events[index] = _events[index].copyWith(segmentType: type);
    });
    _notifyChanged();
  }

  void _updateDistance(int index, String? value) {
    final distanceMeters = double.tryParse(value ?? '');
    setState(() {
      _events[index] = _events[index].copyWith(
        distanceMeters: distanceMeters != null && distanceMeters > 0
            ? distanceMeters
            : null,
      );
    });
    _notifyChanged();
  }

  void _updateRepetitions(int index, String? value) {
    final repetitions = int.tryParse(value ?? '');
    setState(() {
      _events[index] = _events[index].copyWith(
        repetitions: repetitions != null && repetitions > 0
            ? repetitions
            : null,
      );
    });
    _notifyChanged();
  }

  String? _validate() {
    if (widget.startDateTime == null || widget.endDateTime == null) {
      return AppTexts.pleaseSelectBothStartAndEndDateTime;
    }

    for (final entry in _events) {
      if (entry.startTime.isBefore(widget.startDateTime!) ||
          entry.startTime.isAfter(widget.endDateTime!)) {
        return 'Event start time must be within session time range';
      }

      final isInstantEvent =
          entry.type == _EventType.stateTransition ||
          entry.type == _EventType.marker;
      if (!isInstantEvent &&
          (entry.endTime.isBefore(widget.startDateTime!) ||
              entry.endTime.isAfter(widget.endDateTime!) ||
              entry.endTime.isBefore(entry.startTime))) {
        return 'Event end time must be within session time range '
            'and after start time';
      }

      switch (entry.type) {
        case _EventType.stateTransition:
          if (entry.transitionType == null) {
            return 'Please select transition type';
          }
        case _EventType.segment:
          if (entry.segmentType == null) {
            return 'Please select segment type';
          }
        case _EventType.marker:
        case _EventType.lap:
          break; // No additional validation needed
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<ExerciseSessionEvent>>(
      initialValue: widget.initialEvents,
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
                  AppTexts.events,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(AppIcons.add),
                  onPressed: _addEvent,
                  tooltip: AppTexts.addEvent,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Events list
            if (_events.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppTexts.noEventsAvailable,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ..._events.asMap().entries.map((entry) {
                final index = entry.key;
                final event = entry.value;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event number and remove button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${AppTexts.event} ${index + 1}',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(AppIcons.delete, size: 20),
                              onPressed: () => _removeEvent(index),
                              tooltip: AppTexts.removeEvent,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Event type selector
                        SearchableDropdownMenuFormField<_EventType>(
                          key: ValueKey('event-type-$index-${event.type}'),
                          labelText: AppTexts.eventType,
                          values: _EventType.values
                              .where(
                                (type) =>
                                    (type != _EventType.stateTransition &&
                                        type != _EventType.marker) ||
                                    _supportsIOSOnlyEvents,
                              )
                              .toList(),
                          initialValue: event.type,
                          onChanged: (type) => _updateEventType(index, type),
                          validator: (type) => type == null
                              ? AppTexts.getPleaseSelectText(AppTexts.eventType)
                              : null,
                          displayNameBuilder: (type) => switch (type) {
                            _EventType.stateTransition =>
                              AppTexts.stateTransitionEvent,
                            _EventType.marker => AppTexts.markerEvent,
                            _EventType.lap => AppTexts.lapEvent,
                            _EventType.segment => AppTexts.segmentEvent,
                          },
                          prefixIcon: AppIcons.fitnessCenter,
                          hint: AppTexts.pleaseSelect,
                        ),
                        const SizedBox(height: 8),

                        if (event.type == _EventType.stateTransition ||
                            event.type == _EventType.marker) ...[
                          DateTimePickerRow(
                            startDate: DateTime(
                              event.startTime.year,
                              event.startTime.month,
                              event.startTime.day,
                            ),
                            startTime: TimeOfDay.fromDateTime(event.startTime),
                            dateLabel: AppTexts.startDate,
                            timeLabel: AppTexts.time,
                            onDateChanged: (date) => _updateTime(
                              index,
                              date,
                              TimeOfDay.fromDateTime(event.startTime),
                            ),
                            onTimeChanged: (time) => _updateTime(
                              index,
                              DateTime(
                                event.startTime.year,
                                event.startTime.month,
                                event.startTime.day,
                              ),
                              time,
                            ),
                          ),
                        ] else ...[
                          DateTimePickerRow(
                            startDate: DateTime(
                              event.startTime.year,
                              event.startTime.month,
                              event.startTime.day,
                            ),
                            startTime: TimeOfDay.fromDateTime(event.startTime),
                            dateLabel: AppTexts.startDate,
                            timeLabel: AppTexts.startTime,
                            onDateChanged: (date) => _updateTime(
                              index,
                              date,
                              TimeOfDay.fromDateTime(event.startTime),
                            ),
                            onTimeChanged: (time) => _updateTime(
                              index,
                              DateTime(
                                event.startTime.year,
                                event.startTime.month,
                                event.startTime.day,
                              ),
                              time,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DateTimePickerRow(
                            startDate: DateTime(
                              event.endTime.year,
                              event.endTime.month,
                              event.endTime.day,
                            ),
                            startTime: TimeOfDay.fromDateTime(event.endTime),
                            dateLabel: AppTexts.endDate,
                            timeLabel: AppTexts.endTime,
                            onDateChanged: (date) => _updateTime(
                              index,
                              date,
                              TimeOfDay.fromDateTime(event.endTime),
                              isEndTime: true,
                            ),
                            onTimeChanged: (time) => _updateTime(
                              index,
                              DateTime(
                                event.endTime.year,
                                event.endTime.month,
                                event.endTime.day,
                              ),
                              time,
                              isEndTime: true,
                            ),
                          ),
                        ],

                        // Type-specific fields
                        if (event.type == _EventType.stateTransition) ...[
                          const SizedBox(height: 8),
                          SearchableDropdownMenuFormField<
                            ExerciseSessionStateTransitionType
                          >(
                            key: ValueKey(
                              'transition-type-$index-${event.transitionType}',
                            ),
                            labelText: AppTexts.transitionType,
                            values: ExerciseSessionStateTransitionType.values,
                            initialValue: event.transitionType,
                            onChanged: (type) =>
                                _updateTransitionType(index, type),
                            validator: (type) => type == null
                                ? AppTexts.getPleaseSelectText(
                                    AppTexts.transitionType,
                                  )
                                : null,
                            displayNameBuilder: (type) => type.displayName,
                            prefixIcon: AppIcons.fitnessCenter,
                            hint: AppTexts.pleaseSelect,
                          ),
                        ] else if (event.type == _EventType.lap) ...[
                          const SizedBox(height: 8),
                          TextFormField(
                            key: ValueKey('distance-$index-${event.type}'),
                            initialValue: event.distanceMeters?.toString(),
                            decoration: const InputDecoration(
                              labelText: AppTexts.lapDistanceOptional,
                              suffixText: AppTexts.metersAbbr,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(AppIcons.fitnessCenter),
                              helperText: AppTexts.lapDistanceHelper,
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            onChanged: (value) => _updateDistance(index, value),
                          ),
                        ] else if (event.type == _EventType.segment) ...[
                          const SizedBox(height: 8),
                          SearchableDropdownMenuFormField<ExerciseSegmentType>(
                            key: ValueKey(
                              'segment-type-$index-${event.segmentType}',
                            ),
                            labelText: AppTexts.segmentType,
                            values: ExerciseSegmentType.values,
                            initialValue: event.segmentType,
                            onChanged: (type) =>
                                _updateSegmentType(index, type),
                            validator: (type) => type == null
                                ? AppTexts.getPleaseSelectText(
                                    AppTexts.segmentType,
                                  )
                                : null,
                            displayNameBuilder: (type) => type.displayName,
                            prefixIcon: AppIcons.fitnessCenter,
                            hint: AppTexts.pleaseSelect,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            key: ValueKey('repetitions-$index-${event.type}'),
                            initialValue: event.repetitions?.toString(),
                            decoration: const InputDecoration(
                              labelText: AppTexts.repetitionsOptional,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(AppIcons.fitnessCenter),
                              helperText: AppTexts.segmentRepetitionsHelper,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                _updateRepetitions(index, value),
                          ),
                        ],
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Internal enum for event type selection.
enum _EventType {
  stateTransition,
  marker,
  lap,
  segment,
}

/// Internal entry class for managing event data.
class _EventEntry {
  const _EventEntry({
    required this.type,
    required this.startTime,
    required this.endTime,
    this.transitionType,
    this.segmentType,
    this.distanceMeters,
    this.repetitions,
  });

  final _EventType type;
  final DateTime startTime;
  final DateTime endTime;
  final ExerciseSessionStateTransitionType? transitionType;
  final ExerciseSegmentType? segmentType;
  final double? distanceMeters;
  final int? repetitions;

  _EventEntry copyWith({
    _EventType? type,
    DateTime? startTime,
    DateTime? endTime,
    ExerciseSessionStateTransitionType? transitionType,
    ExerciseSegmentType? segmentType,
    double? distanceMeters,
    int? repetitions,
  }) {
    return _EventEntry(
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      transitionType: transitionType ?? this.transitionType,
      segmentType: segmentType ?? this.segmentType,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      repetitions: repetitions ?? this.repetitions,
    );
  }
}
