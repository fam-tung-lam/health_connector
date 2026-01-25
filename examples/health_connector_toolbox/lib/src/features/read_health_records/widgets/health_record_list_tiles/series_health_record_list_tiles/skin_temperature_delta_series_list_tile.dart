import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/series_health_record_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/skin_temperature_delta_series_record_samples_list.dart';

/// Widget for displaying skin temperature delta series record tiles.
final class SkinTemperatureDeltaSeriesTile extends StatelessWidget {
  const SkinTemperatureDeltaSeriesTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final SkinTemperatureDeltaSeriesRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SeriesHealthRecordTile<
      SkinTemperatureDeltaSeriesRecord,
      SkinTemperatureDeltaSample
    >(
      record: record,
      icon: AppIcons.temperature,
      title: 'Skin Temperature Delta Series',
      subtitleBuilder: (r, ctx) {
        final parts = <String>[];
        if (r.baseline != null) {
          parts.add(
            'Baseline: ${r.baseline!.inCelsius.toStringAsFixed(1)}°C',
          );
        }
        parts.add('${AppTexts.recording}: ${r.metadata.recordingMethod.name}');
        return Text(
          parts.join(' • '),
          style: Theme.of(ctx).textTheme.bodySmall,
        );
      },
      detailRowsBuilder: (r, ctx) => [
        if (r.baseline != null)
          HealthRecordDetailRow(
            label: 'Baseline',
            value: '${r.baseline!.inCelsius.toStringAsFixed(1)}°C',
          ),
        HealthRecordDetailRow(
          label: 'Measurement Location',
          value: r.measurementLocation.name,
        ),
      ],
      samplesBuilder: (samples, ctx) =>
          SkinTemperatureDeltaSeriesRecordSamplesList(samples: samples),
      onDelete: onDelete,
    );
  }
}
