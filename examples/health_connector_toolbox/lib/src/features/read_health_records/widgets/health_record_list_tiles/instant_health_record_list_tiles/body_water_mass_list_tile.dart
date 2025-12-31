import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// Widget for displaying body water mass record tiles.
final class BodyWaterMassTile extends StatelessWidget {
  const BodyWaterMassTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final BodyWaterMassRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InstantHealthRecordTile<BodyWaterMassRecord>(
      record: record,
      icon: AppIcons.waterDrop,
      title: '${record.mass.inKilograms.toStringAsFixed(2)} kg',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.instant(
        time: r.time,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
      onDelete: onDelete,
    );
  }
}
