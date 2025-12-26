import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// Widget for displaying speed activity record tiles.
final class SpeedActivityTile extends StatelessWidget {
  const SpeedActivityTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final SpeedActivityRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InstantHealthRecordTile<SpeedActivityRecord>(
      record: record,
      icon: AppIcons.speed,
      title:
          '${switch (record) {
            WalkingSpeedRecord() => AppTexts.walkingSpeed,
            RunningSpeedRecord() => AppTexts.runningSpeed,
            StairAscentSpeedRecord() => AppTexts.stairAscentSpeed,
            StairDescentSpeedRecord() => AppTexts.stairDescentSpeed,
          }}: ${record.speed.inMetersPerSecond.toStringAsFixed(2)} m/s',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.instant(
        time: r.time,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
      onDelete: onDelete,
    );
  }
}
