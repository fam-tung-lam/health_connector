import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// Widget for displaying heart rate variability RMSSD record tiles.
final class HeartRateVariabilityRMSSDTile extends StatelessWidget {
  const HeartRateVariabilityRMSSDTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final HeartRateVariabilityRMSSDRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InstantHealthRecordTile<HeartRateVariabilityRMSSDRecord>(
      record: record,
      icon: AppIcons.favorite,
      title: '${record.heartRateVariabilityMillis.value.toStringAsFixed(1)} ms',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.instant(
        time: r.time,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
      onDelete: onDelete,
    );
  }
}
