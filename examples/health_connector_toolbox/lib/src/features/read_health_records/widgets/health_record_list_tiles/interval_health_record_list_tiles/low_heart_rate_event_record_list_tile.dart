import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying low heart rate event record tiles.
class LowHeartRateEventRecordListTile extends StatelessWidget {
  const LowHeartRateEventRecordListTile({
    required this.record,
    super.key,
  });

  final LowHeartRateEventRecord record;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<LowHeartRateEventRecord>(
      record: record,
      icon: AppIcons.favorite,
      title: _getTitle(),
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
    );
  }

  String _getTitle() {
    final beatsPerMinuteThreshold = record.rateThreshold?.inPerMinute;
    if (beatsPerMinuteThreshold != null) {
      return '${record.rateThreshold?.inPerMinute.toStringAsFixed(0)} '
          '${AppTexts.bpm}';
    }

    return AppTexts.lowHeartRateEvent;
  }
}
