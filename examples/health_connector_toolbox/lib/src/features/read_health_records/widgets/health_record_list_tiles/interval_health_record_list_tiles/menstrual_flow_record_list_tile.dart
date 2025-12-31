import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/menstrual_flow_type_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying menstrual flow interval record tiles.
final class MenstrualFlowRecordListTile extends StatelessWidget {
  const MenstrualFlowRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final MenstrualFlowRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<MenstrualFlowRecord>(
      record: record,
      icon: AppIcons.waterDrop,
      title: AppTexts.menstrualFlow,
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.flow,
          value: r.flow.label,
        ),
        HealthRecordDetailRow(
          label: AppTexts.isCycleStart,
          value: r.isCycleStart.toString(),
        ),
      ],
      onDelete: onDelete,
    );
  }
}
