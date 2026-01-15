import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/contraceptive_type_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying contraceptive record tiles.
final class ContraceptiveRecordListTile extends StatelessWidget {
  const ContraceptiveRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final ContraceptiveRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<ContraceptiveRecord>(
      record: record,
      icon: Icons.medical_information,
      title: AppTexts.contraceptive,
      subtitleBuilder: (r, ctx) {
        return HealthRecordListTileSubtitle.interval(
          startTime: r.startTime,
          endTime: r.endTime,
          recordingMethod: r.metadata.recordingMethod.name,
        );
      },
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.contraceptiveType,
          value: r.contraceptiveType.displayName,
        ),
      ],
      onDelete: onDelete,
    );
  }
}
