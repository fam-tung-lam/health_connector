import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Generic list tile widget for simple interval health records.
///
/// This widget handles interval health records that follow a simple pattern:
/// - Single icon
/// - Title with formatted value
/// - Standard subtitle (start/end time + duration + recording method)
/// - Detail rows with value label and MeasurementUnitDisplay
///
/// The type parameter [R] should be an interval health record type.
final class SimpleIntervalMeasurementListTile<R extends IntervalHealthRecord>
    extends StatelessWidget {
  const SimpleIntervalMeasurementListTile({
    required this.record,
    required this.icon,
    required this.titleBuilder,
    required this.valueExtractor,
    required this.onDelete,
    super.key,
  });

  final R record;
  final IconData icon;
  final String Function(R record) titleBuilder;
  final MeasurementUnit Function(R record) valueExtractor;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<R>(
      record: record,
      icon: icon,
      title: titleBuilder(record),
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
      ],
      onDelete: onDelete,
    );
  }
}
