import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/basal_body_temperature_measurement_location_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// Widget for displaying basal body temperature record tiles.
final class BasalBodyTemperatureTile extends StatelessWidget {
  const BasalBodyTemperatureTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final BasalBodyTemperatureRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InstantHealthRecordTile<BasalBodyTemperatureRecord>(
      record: record,
      icon: AppIcons.temperature,
      title: '${record.temperature.inCelsius.toStringAsFixed(1)} °C',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.instant(
        time: r.time,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.measurementLocation,
          value: r.measurementLocation.displayName,
        ),
      ],
      onDelete: onDelete,
    );
  }
}
