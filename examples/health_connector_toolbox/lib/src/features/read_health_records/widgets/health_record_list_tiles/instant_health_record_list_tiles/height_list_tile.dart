import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// Widget for displaying height record tiles.
final class HeightTile extends StatelessWidget {
  const HeightTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final HeightRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InstantHealthRecordTile<HeightRecord>(
      record: record,
      icon: AppIcons.height,
      title: '${record.height.inMeters.toStringAsFixed(2)} m',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.instant(
        time: r.time,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
      ],
      onDelete: onDelete,
    );
  }
}
