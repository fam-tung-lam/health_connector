import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying heart rate recovery one minute record tiles.
class HeartRateRecoveryOneMinuteRecordListTile extends StatelessWidget {
  const HeartRateRecoveryOneMinuteRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final HeartRateRecoveryOneMinuteRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<HeartRateRecoveryOneMinuteRecord>(
      record: record,
      icon: AppIcons.favorite,
      title: _getTitle(),
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
      onDelete: onDelete,
    );
  }

  String _getTitle() {
    final beatsPerMinute = record.rate.inPerMinute;
    return '${beatsPerMinute.toStringAsFixed(0)} ${AppTexts.bpm}';
  }
}
