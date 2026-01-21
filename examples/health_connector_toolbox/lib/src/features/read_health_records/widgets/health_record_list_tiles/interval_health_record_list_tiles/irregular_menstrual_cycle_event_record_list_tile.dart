import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/interval_health_record_list_tile.dart';

/// Widget for displaying irregular menstrual cycle event record tiles.
class IrregularMenstrualCycleEventRecordListTile extends StatelessWidget {
  const IrregularMenstrualCycleEventRecordListTile({
    required this.record,
    super.key,
  });

  final IrregularMenstrualCycleEventRecord record;

  @override
  Widget build(BuildContext context) {
    return IntervalHealthRecordTile<IrregularMenstrualCycleEventRecord>(
      record: record,
      icon: AppIcons.waterDrop,
      title: AppTexts.irregularMenstrualCycleEvent,
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.interval(
        startTime: r.startTime,
        endTime: r.endTime,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [],
    );
  }
}
