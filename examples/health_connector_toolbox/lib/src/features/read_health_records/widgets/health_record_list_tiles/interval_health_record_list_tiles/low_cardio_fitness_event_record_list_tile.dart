import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying low cardio fitness event record tiles.
class LowCardioFitnessEventRecordListTile extends StatelessWidget {
  const LowCardioFitnessEventRecordListTile({
    required this.record,
    super.key,
  });

  final LowCardioFitnessEventRecord record;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<LowCardioFitnessEventRecord>(
      record: record,
      icon: AppIcons.heartBroken,
      title: _getTitle(),
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
        if (r.vo2MlPerMinPerKgThreshold != null)
          HealthRecordDetailRow(
            label: '${AppTexts.threshold}:',
            value: '${r.vo2MlPerMinPerKgThreshold?.value} ml/kg/min',
          ),
      ],
    );
  }

  String _getTitle() {
    final vo2 = record.vo2MlPerMinPerKg?.value;
    if (vo2 != null) {
      return '$vo2 ml/kg/min';
    }

    return AppTexts.lowCardioFitnessEvent;
  }
}
