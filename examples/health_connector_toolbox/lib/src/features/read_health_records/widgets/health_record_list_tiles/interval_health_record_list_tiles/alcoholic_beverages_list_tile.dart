import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying alcoholic beverages record tiles.
final class AlcoholicBeveragesTile extends StatelessWidget {
  const AlcoholicBeveragesTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final AlcoholicBeveragesRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<AlcoholicBeveragesRecord>(
      record: record,
      icon: Icons.local_bar,
      title: '${record.count.value.toInt()} beverage(s)',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
      onDelete: onDelete,
    );
  }
}
