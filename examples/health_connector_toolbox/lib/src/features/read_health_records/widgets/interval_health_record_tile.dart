import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show IntervalHealthRecord;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/base_health_record_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_tile_builders.dart';

/// A unified tile widget for displaying interval health records.
///
/// This widget provides a consistent interface for all interval health record
/// types (e.g., StepsRecord, DistanceRecord) by accepting builder callbacks for
/// customization. It displays common interval record fields (startTime,
/// endTime, duration, zone offsets) and uses the base health record tile for
/// consistent layout.
@immutable
final class IntervalHealthRecordTile<T extends IntervalHealthRecord>
    extends StatelessWidget {
  const IntervalHealthRecordTile({
    required this.record,
    required this.icon,
    required this.title,
    required this.subtitleBuilder,
    required this.detailRowsBuilder,
    required this.onDelete,
    super.key,
  });

  final T record;
  final IconData icon;
  final String title;
  final RecordSubtitleBuilder<T> subtitleBuilder;
  final RecordDetailRowsBuilder<T> detailRowsBuilder;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final detailRows = [
      HealthRecordDetailRow(
        label: AppTexts.id,
        value: record.id.value,
      ),
      HealthRecordDetailRow(
        label: AppTexts.startZoneOffsetSeconds,
        value: record.startZoneOffsetSeconds,
      ),
      HealthRecordDetailRow(
        label: AppTexts.endZoneOffsetSeconds,
        value: record.endZoneOffsetSeconds,
      ),
      ...detailRowsBuilder(record, context),
    ];

    return BaseHealthRecordTile(
      icon: icon,
      title: title,
      subtitle: subtitleBuilder(record, context),
      detailRows: detailRows,
      metadata: record.metadata,
      onDelete: onDelete,
    );
  }
}
