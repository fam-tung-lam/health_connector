import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HeartbeatSample;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A form field widget for managing multiple heartbeat samples.
@immutable
final class HeartbeatSampleWriteFormFieldGroup extends StatefulWidget {
  const HeartbeatSampleWriteFormFieldGroup({
    required this.startDateTime,
    required this.endDateTime,
    required this.onChanged,
    super.key,
    this.initialSamples,
    this.validator,
  });

  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final ValueChanged<List<HeartbeatSample>?> onChanged;
  final List<HeartbeatSample>? initialSamples;
  final String? Function(List<HeartbeatSample>?)? validator;

  @override
  State<HeartbeatSampleWriteFormFieldGroup> createState() =>
      _HeartbeatSampleWriteFormFieldGroupState();
}

class _HeartbeatSampleWriteFormFieldGroupState
    extends State<HeartbeatSampleWriteFormFieldGroup> {
  late List<_HeartbeatSampleEntry> _samples;

  @override
  void initState() {
    super.initState();
    _samples =
        widget.initialSamples
            ?.map(
              (sample) => _HeartbeatSampleEntry(
                offsetSeconds: sample.timeSinceSeriesStart.inSeconds,
                precededByGap: sample.precededByGap,
              ),
            )
            .toList() ??
        [
          const _HeartbeatSampleEntry(
            offsetSeconds: 0,
            precededByGap: false,
          ),
        ];
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifyChanged());
  }

  void _notifyChanged() {
    if (widget.startDateTime == null || widget.endDateTime == null) {
      widget.onChanged(null);
      return;
    }

    final validSamples = <HeartbeatSample>[];
    final seriesDuration = widget.endDateTime!.difference(
      widget.startDateTime!,
    );

    for (final entry in _samples) {
      // Validate offset is within series duration
      if (entry.offsetSeconds < 0 ||
          entry.offsetSeconds > seriesDuration.inSeconds) {
        widget.onChanged(null);
        return;
      }

      validSamples.add(
        HeartbeatSample(
          timeSinceSeriesStart: Duration(seconds: entry.offsetSeconds),
          precededByGap: entry.precededByGap,
        ),
      );
    }

    // Sort samples by offset to ensure they're in order
    validSamples.sort(
      (a, b) => a.timeSinceSeriesStart.compareTo(b.timeSinceSeriesStart),
    );

    widget.onChanged(validSamples);
  }

  void _addSample() {
    setState(() {
      final seriesDuration = widget.endDateTime!.difference(
        widget.startDateTime!,
      );
      final lastOffset = _samples.isEmpty
          ? 0
          : _samples
                .map((e) => e.offsetSeconds)
                .reduce((a, b) => a > b ? a : b);
      final nextOffset = lastOffset + 1; // Add 1 second after last sample
      _samples.add(
        _HeartbeatSampleEntry(
          offsetSeconds: nextOffset > seriesDuration.inSeconds
              ? seriesDuration.inSeconds
              : nextOffset,
          precededByGap: false,
        ),
      );
    });
    _notifyChanged();
  }

  void _removeSample(int index) {
    setState(() {
      _samples.removeAt(index);
      if (_samples.isEmpty) {
        _samples.add(
          const _HeartbeatSampleEntry(
            offsetSeconds: 0,
            precededByGap: false,
          ),
        );
      }
    });
    _notifyChanged();
  }

  void _updateOffset(int index, int offsetSeconds) {
    setState(() {
      _samples[index] = _samples[index].copyWith(
        offsetSeconds: offsetSeconds,
      );
    });
    _notifyChanged();
  }

  void _updatePrecededByGap(int index, bool precededByGap) {
    setState(() {
      _samples[index] = _samples[index].copyWith(
        precededByGap: precededByGap,
      );
    });
    _notifyChanged();
  }

  @override
  Widget build(BuildContext context) {
    final seriesDuration =
        widget.startDateTime != null && widget.endDateTime != null
        ? widget.endDateTime!.difference(widget.startDateTime!)
        : Duration.zero;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTexts.heartbeatSamples,
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
        ...List.generate(_samples.length, (index) {
          final entry = _samples[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: entry.offsetSeconds.toString(),
                          decoration: InputDecoration(
                            labelText:
                                '${AppTexts.offsetSeconds} '
                                '(0-${seriesDuration.inSeconds})',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(AppIcons.numbers),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final parsed = int.tryParse(value);
                            if (parsed != null) {
                              _updateOffset(index, parsed);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(AppIcons.delete),
                        onPressed: () => _removeSample(index),
                        tooltip: AppTexts.removeSample,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    title: const Text(AppTexts.precededByGap),
                    value: entry.precededByGap,
                    onChanged: (value) {
                      if (value != null) {
                        _updatePrecededByGap(index, value);
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _HeartbeatSampleEntry {
  const _HeartbeatSampleEntry({
    required this.offsetSeconds,
    required this.precededByGap,
  });

  final int offsetSeconds;
  final bool precededByGap;

  _HeartbeatSampleEntry copyWith({
    int? offsetSeconds,
    bool? precededByGap,
  }) {
    return _HeartbeatSampleEntry(
      offsetSeconds: offsetSeconds ?? this.offsetSeconds,
      precededByGap: precededByGap ?? this.precededByGap,
    );
  }
}
