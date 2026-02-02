import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show ExerciseRouteLocation, Length;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_time_picker_row.dart';

/// Form field for managing a list of exercise route locations.
///
/// Allows users to add GPS waypoints with coordinates, altitude, and accuracy.
/// Provides a "Generate Sample" button for testing with realistic route data.
@immutable
final class ExerciseRouteFormFieldGroup extends StatefulWidget {
  const ExerciseRouteFormFieldGroup({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialLocations,
  });

  /// The start time of the allowed time range (session start).
  final DateTime? startDateTime;

  /// The end time of the allowed time range (session end).
  final DateTime? endDateTime;

  /// Callback when the locations list changes.
  final ValueChanged<List<ExerciseRouteLocation>?> onChanged;

  /// Initial list of locations.
  final List<ExerciseRouteLocation>? initialLocations;

  @override
  State<ExerciseRouteFormFieldGroup> createState() =>
      _ExerciseRouteFormFieldGroupState();
}

class _ExerciseRouteFormFieldGroupState
    extends State<ExerciseRouteFormFieldGroup> {
  late List<_RouteLocationEntry> _locations;

  @override
  void initState() {
    super.initState();
    _locations =
        widget.initialLocations?.map((loc) {
          return _RouteLocationEntry(
            time: loc.time,
            latitude: loc.latitude,
            longitude: loc.longitude,
            altitudeMeters: loc.altitude?.inMeters,
            horizontalAccuracyMeters: loc.horizontalAccuracy?.inMeters,
            verticalAccuracyMeters: loc.verticalAccuracy?.inMeters,
          );
        }).toList() ??
        [];
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifyChanged());
  }

  void _notifyChanged() {
    if (widget.startDateTime == null || widget.endDateTime == null) {
      widget.onChanged(null);
      return;
    }

    final validLocations = <ExerciseRouteLocation>[];
    for (final entry in _locations) {
      // Validate time is within session bounds
      if (entry.time.isBefore(widget.startDateTime!) ||
          entry.time.isAfter(widget.endDateTime!)) {
        widget.onChanged(null);
        return;
      }

      // Validate latitude
      if (entry.latitude == null ||
          entry.latitude! < -90 ||
          entry.latitude! > 90) {
        widget.onChanged(null);
        return;
      }

      // Validate longitude
      if (entry.longitude == null ||
          entry.longitude! < -180 ||
          entry.longitude! > 180) {
        widget.onChanged(null);
        return;
      }

      // Validate accuracy is non-negative if provided
      if ((entry.horizontalAccuracyMeters != null &&
              entry.horizontalAccuracyMeters! < 0) ||
          (entry.verticalAccuracyMeters != null &&
              entry.verticalAccuracyMeters! < 0)) {
        widget.onChanged(null);
        return;
      }

      validLocations.add(
        ExerciseRouteLocation(
          time: entry.time,
          latitude: entry.latitude!,
          longitude: entry.longitude!,
          altitude: entry.altitudeMeters != null
              ? Length.meters(entry.altitudeMeters!)
              : null,
          horizontalAccuracy: entry.horizontalAccuracyMeters != null
              ? Length.meters(entry.horizontalAccuracyMeters!)
              : null,
          verticalAccuracy: entry.verticalAccuracyMeters != null
              ? Length.meters(entry.verticalAccuracyMeters!)
              : null,
        ),
      );
    }

    widget.onChanged(validLocations.isEmpty ? null : validLocations);
  }

  void _addLocation() {
    setState(() {
      final defaultTime = _locations.isNotEmpty
          ? _locations.last.time.add(const Duration(minutes: 1))
          : widget.startDateTime ?? DateTime.now();

      _locations.add(
        _RouteLocationEntry(
          time: defaultTime,
          latitude: null,
          longitude: null,
        ),
      );
    });
    _notifyChanged();
  }

  void _removeLocation(int index) {
    setState(() => _locations.removeAt(index));
    _notifyChanged();
  }

  void _updateTime(int index, DateTime? date, TimeOfDay? time) {
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
      _locations[index] = _locations[index].copyWith(time: newTime);
    });
    _notifyChanged();
  }

  void _updateLatitude(int index, String? value) {
    final lat = double.tryParse(value ?? '');
    setState(() {
      _locations[index] = _locations[index].copyWith(
        latitude: lat,
        clearLatitude: lat == null,
      );
    });
    _notifyChanged();
  }

  void _updateLongitude(int index, String? value) {
    final lng = double.tryParse(value ?? '');
    setState(() {
      _locations[index] = _locations[index].copyWith(
        longitude: lng,
        clearLongitude: lng == null,
      );
    });
    _notifyChanged();
  }

  void _updateAltitude(int index, String? value) {
    final alt = double.tryParse(value ?? '');
    setState(() {
      _locations[index] = _locations[index].copyWith(
        altitudeMeters: alt,
        clearAltitude: alt == null,
      );
    });
    _notifyChanged();
  }

  void _updateHorizontalAccuracy(int index, String? value) {
    final acc = double.tryParse(value ?? '');
    setState(() {
      _locations[index] = _locations[index].copyWith(
        horizontalAccuracyMeters: acc,
        clearHorizontalAccuracy: acc == null,
      );
    });
    _notifyChanged();
  }

  void _updateVerticalAccuracy(int index, String? value) {
    final acc = double.tryParse(value ?? '');
    setState(() {
      _locations[index] = _locations[index].copyWith(
        verticalAccuracyMeters: acc,
        clearVerticalAccuracy: acc == null,
      );
    });
    _notifyChanged();
  }

  void _generateSampleRoute() {
    if (widget.startDateTime == null || widget.endDateTime == null) {
      return;
    }

    final start = widget.startDateTime!;
    final end = widget.endDateTime!;
    final duration = end.difference(start);

    // Generate 5 points evenly spaced
    const pointCount = 5;
    final interval = duration ~/ pointCount;

    // Base coordinates: Central Park, New York
    const baseLat = 40.7829;
    const baseLng = -73.9654;
    const baseAlt = 25.0; // meters above sea level

    final random = Random();
    final newLocations = <_RouteLocationEntry>[];

    for (var i = 0; i < pointCount; i++) {
      final time = start.add(interval * i);
      // Add small variations to simulate walking path
      final latVariation = (random.nextDouble() - 0.5) * 0.002;
      final lngVariation = (random.nextDouble() - 0.5) * 0.002;
      final altVariation = (random.nextDouble() - 0.5) * 5;

      newLocations.add(
        _RouteLocationEntry(
          time: time,
          latitude: baseLat + latVariation + (i * 0.0005),
          longitude: baseLng + lngVariation + (i * 0.0003),
          altitudeMeters: baseAlt + altVariation,
          horizontalAccuracyMeters: 5.0 + random.nextDouble() * 10,
          verticalAccuracyMeters: 3.0 + random.nextDouble() * 5,
        ),
      );
    }

    setState(() {
      _locations = newLocations;
    });
    _notifyChanged();
  }

  String? _validate() {
    if (widget.startDateTime == null || widget.endDateTime == null) {
      return AppTexts.pleaseSelectBothStartAndEndDateTime;
    }

    for (final entry in _locations) {
      if (entry.time.isBefore(widget.startDateTime!) ||
          entry.time.isAfter(widget.endDateTime!)) {
        return AppTexts.routeTimeMustBeWithinSession;
      }

      if (entry.latitude == null ||
          entry.latitude! < -90 ||
          entry.latitude! > 90) {
        return AppTexts.latitudeMustBeBetween;
      }

      if (entry.longitude == null ||
          entry.longitude! < -180 ||
          entry.longitude! > 180) {
        return AppTexts.longitudeMustBeBetween;
      }

      if ((entry.horizontalAccuracyMeters != null &&
              entry.horizontalAccuracyMeters! < 0) ||
          (entry.verticalAccuracyMeters != null &&
              entry.verticalAccuracyMeters! < 0)) {
        return AppTexts.accuracyMustBeNonNegative;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<ExerciseRouteLocation>>(
      initialValue: widget.initialLocations,
      validator: (_) => _validate(),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with title and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppTexts.exerciseRoute,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      icon: const Icon(AppIcons.autoAwesome, size: 18),
                      label: const Text(AppTexts.generateSampleRoute),
                      onPressed:
                          widget.startDateTime != null &&
                              widget.endDateTime != null
                          ? _generateSampleRoute
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(AppIcons.add),
                      onPressed: _addLocation,
                      tooltip: AppTexts.addRouteLocation,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Locations list
            if (_locations.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppTexts.noRouteLocations,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ..._locations.asMap().entries.map((entry) {
                final index = entry.key;
                final location = entry.value;

                return _RouteLocationCard(
                  index: index,
                  location: location,
                  onRemove: () => _removeLocation(index),
                  onTimeChanged: (date, time) => _updateTime(index, date, time),
                  onLatitudeChanged: (value) => _updateLatitude(index, value),
                  onLongitudeChanged: (value) => _updateLongitude(index, value),
                  onAltitudeChanged: (value) => _updateAltitude(index, value),
                  onHorizontalAccuracyChanged: (value) =>
                      _updateHorizontalAccuracy(index, value),
                  onVerticalAccuracyChanged: (value) =>
                      _updateVerticalAccuracy(index, value),
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

/// Card widget for a single route location entry.
class _RouteLocationCard extends StatefulWidget {
  const _RouteLocationCard({
    required this.index,
    required this.location,
    required this.onRemove,
    required this.onTimeChanged,
    required this.onLatitudeChanged,
    required this.onLongitudeChanged,
    required this.onAltitudeChanged,
    required this.onHorizontalAccuracyChanged,
    required this.onVerticalAccuracyChanged,
  });

  final int index;
  final _RouteLocationEntry location;
  final VoidCallback onRemove;
  final void Function(DateTime? date, TimeOfDay? time) onTimeChanged;
  final ValueChanged<String?> onLatitudeChanged;
  final ValueChanged<String?> onLongitudeChanged;
  final ValueChanged<String?> onAltitudeChanged;
  final ValueChanged<String?> onHorizontalAccuracyChanged;
  final ValueChanged<String?> onVerticalAccuracyChanged;

  @override
  State<_RouteLocationCard> createState() => _RouteLocationCardState();
}

class _RouteLocationCardState extends State<_RouteLocationCard> {
  bool _showAdvanced = false;

  @override
  Widget build(BuildContext context) {
    final location = widget.location;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location number and remove button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppTexts.routeLocation} ${widget.index + 1}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(AppIcons.delete, size: 20),
                  onPressed: widget.onRemove,
                  tooltip: AppTexts.delete,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Time picker
            DateTimePickerRow(
              startDate: DateTime(
                location.time.year,
                location.time.month,
                location.time.day,
              ),
              startTime: TimeOfDay.fromDateTime(location.time),
              dateLabel: AppTexts.date,
              timeLabel: AppTexts.time,
              onDateChanged: (date) => widget.onTimeChanged(
                date,
                TimeOfDay.fromDateTime(location.time),
              ),
              onTimeChanged: (time) => widget.onTimeChanged(
                DateTime(
                  location.time.year,
                  location.time.month,
                  location.time.day,
                ),
                time,
              ),
            ),
            const SizedBox(height: 8),

            // Latitude and Longitude row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    key: ValueKey('lat-${widget.index}-${location.latitude}'),
                    initialValue: location.latitude?.toString(),
                    decoration: const InputDecoration(
                      labelText: AppTexts.latitude,
                      hintText: AppTexts.latitudeHint,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(AppIcons.terrain),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    onChanged: widget.onLatitudeChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppTexts.fieldRequired;
                      }
                      final lat = double.tryParse(value);
                      if (lat == null || lat < -90 || lat > 90) {
                        return AppTexts.latitudeMustBeBetween;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    key: ValueKey('lng-${widget.index}-${location.longitude}'),
                    initialValue: location.longitude?.toString(),
                    decoration: const InputDecoration(
                      labelText: AppTexts.longitude,
                      hintText: AppTexts.longitudeHint,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(AppIcons.terrain),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    onChanged: widget.onLongitudeChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppTexts.fieldRequired;
                      }
                      final lng = double.tryParse(value);
                      if (lng == null || lng < -180 || lng > 180) {
                        return AppTexts.longitudeMustBeBetween;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Altitude
            TextFormField(
              key: ValueKey('alt-${widget.index}-${location.altitudeMeters}'),
              initialValue: location.altitudeMeters?.toString(),
              decoration: const InputDecoration(
                labelText: AppTexts.altitudeOptional,
                suffixText: AppTexts.metersAbbr,
                border: OutlineInputBorder(),
                prefixIcon: Icon(AppIcons.terrain),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              onChanged: widget.onAltitudeChanged,
            ),

            // Advanced section toggle
            const SizedBox(height: 8),
            InkWell(
              onTap: () => setState(() => _showAdvanced = !_showAdvanced),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(
                      _showAdvanced
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Accuracy (advanced)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),

            // Advanced fields (collapsible)
            if (_showAdvanced) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: ValueKey(
                        'hacc-${widget.index}-'
                        '${location.horizontalAccuracyMeters}',
                      ),
                      initialValue: location.horizontalAccuracyMeters
                          ?.toString(),
                      decoration: const InputDecoration(
                        labelText: AppTexts.horizontalAccuracyOptional,
                        suffixText: AppTexts.metersAbbr,
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: widget.onHorizontalAccuracyChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        final acc = double.tryParse(value);
                        if (acc != null && acc < 0) {
                          return AppTexts.accuracyMustBeNonNegative;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      key: ValueKey(
                        'vacc-${widget.index}-'
                        '${location.verticalAccuracyMeters}',
                      ),
                      initialValue: location.verticalAccuracyMeters?.toString(),
                      decoration: const InputDecoration(
                        labelText: AppTexts.verticalAccuracyOptional,
                        suffixText: AppTexts.metersAbbr,
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: widget.onVerticalAccuracyChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }
                        final acc = double.tryParse(value);
                        if (acc != null && acc < 0) {
                          return AppTexts.accuracyMustBeNonNegative;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Internal entry class for managing route location data.
class _RouteLocationEntry {
  const _RouteLocationEntry({
    required this.time,
    required this.latitude,
    required this.longitude,
    this.altitudeMeters,
    this.horizontalAccuracyMeters,
    this.verticalAccuracyMeters,
  });

  final DateTime time;
  final double? latitude;
  final double? longitude;
  final double? altitudeMeters;
  final double? horizontalAccuracyMeters;
  final double? verticalAccuracyMeters;

  _RouteLocationEntry copyWith({
    DateTime? time,
    double? latitude,
    double? longitude,
    double? altitudeMeters,
    double? horizontalAccuracyMeters,
    double? verticalAccuracyMeters,
    bool clearLatitude = false,
    bool clearLongitude = false,
    bool clearAltitude = false,
    bool clearHorizontalAccuracy = false,
    bool clearVerticalAccuracy = false,
  }) {
    return _RouteLocationEntry(
      time: time ?? this.time,
      latitude: clearLatitude ? null : (latitude ?? this.latitude),
      longitude: clearLongitude ? null : (longitude ?? this.longitude),
      altitudeMeters: clearAltitude
          ? null
          : (altitudeMeters ?? this.altitudeMeters),
      horizontalAccuracyMeters: clearHorizontalAccuracy
          ? null
          : (horizontalAccuracyMeters ?? this.horizontalAccuracyMeters),
      verticalAccuracyMeters: clearVerticalAccuracy
          ? null
          : (verticalAccuracyMeters ?? this.verticalAccuracyMeters),
    );
  }
}
