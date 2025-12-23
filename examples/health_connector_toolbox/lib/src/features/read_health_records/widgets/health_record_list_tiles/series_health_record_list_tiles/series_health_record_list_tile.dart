import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart' show SeriesHealthRecord;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/base_health_record_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_builder_type_aliases.dart';

/// A unified tile widget for displaying series health records.
///
/// This widget provides a consistent interface for all series health record
/// types by accepting builder callbacks for customization. It extends the
/// interval record layout with series-specific information (samples count).
/// Currently serves as a placeholder for future series record implementations.
@immutable
final class SeriesHealthRecordTile<T extends SeriesHealthRecord<S>, S>
    extends StatelessWidget {
  const SeriesHealthRecordTile({
    required this.record,
    required this.icon,
    required this.title,
    required this.subtitleBuilder,
    required this.detailRowsBuilder,
    required this.onDelete,
    this.samplesBuilder,
    super.key,
  });

  final T record;
  final IconData icon;
  final String title;
  final RecordSubtitleBuilder<T> subtitleBuilder;
  final RecordDetailRowsBuilder<T> detailRowsBuilder;
  final VoidCallback onDelete;
  final SeriesSamplesBuilder<List<S>>? samplesBuilder;

  @override
  Widget build(BuildContext context) {
    final detailRows = [
      HealthRecordDetailRow(
        label: AppTexts.id,
        value: record.id.value,
      ),
      HealthRecordDetailRow(
        label: AppTexts.samplesCount,
        value: record.samplesCount,
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

    // Build subtitle with series info
    final baseSubtitle = subtitleBuilder(record, context);
    final seriesInfo = Text(
      '${AppTexts.samples}: ${record.samplesCount}',
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    );

    final combinedSubtitle = baseSubtitle is Column
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...baseSubtitle.children,
              seriesInfo,
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              baseSubtitle,
              seriesInfo,
            ],
          );

    // If samplesBuilder is provided, add samples to detail rows
    final allDetailRows = [
      ...detailRows,
      if (samplesBuilder != null && record.samples.isNotEmpty) ...[
        const SizedBox(height: 16),
        samplesBuilder!(record.samples, context) ?? const SizedBox.shrink(),
      ],
    ];

    return BaseHealthRecordListTile(
      icon: icon,
      title: title,
      subtitle: combinedSubtitle,
      detailRows: allDetailRows,
      metadata: record.metadata,
      onDelete: onDelete,
    );
  }
}
