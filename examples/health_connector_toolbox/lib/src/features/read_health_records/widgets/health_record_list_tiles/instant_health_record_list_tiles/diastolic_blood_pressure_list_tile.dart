import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/blood_pressure_body_position_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/blood_pressure_measurement_location_extension.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile_subtitle.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/instant_health_record_list_tile.dart';

/// Widget for displaying diastolic blood pressure record tiles.
@immutable
final class DiastolicBloodPressureTile extends StatelessWidget {
  const DiastolicBloodPressureTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final DiastolicBloodPressureRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InstantHealthRecordTile<DiastolicBloodPressureRecord>(
      record: record,
      icon: AppIcons.bloodPressure,
      title:
          '${record.pressure.inMillimetersOfMercury.toStringAsFixed(0)} mmHg',
      subtitleBuilder: (r, ctx) => HealthRecordListTileSubtitle.instant(
        time: r.time,
        recordingMethod: r.metadata.recordingMethod.name,
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.diastolic,
          value: r.pressure,
        ),
        HealthRecordDetailRow(
          label: AppTexts.bodyPosition,
          value: r.bodyPosition.displayName,
        ),
        HealthRecordDetailRow(
          label: AppTexts.measurementLocation,
          value: r.measurementLocation.displayName,
        ),
      ],
      onDelete: onDelete,
    );
  }
}
