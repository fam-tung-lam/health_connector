import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DistanceRecord,
        FloorsClimbedRecord,
        HealthRecord,
        HeartRateMeasurement,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        InstantHealthRecord,
        IntervalHealthRecord,
        LeanBodyMassRecord,
        SeriesHealthRecord,
        StepRecord,
        WeightRecord,
        WheelchairPushesRecord,
        SleepSessionRecord,
        SleepStageRecord,
        SleepStage,
        SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart'
    as theme;
import 'package:health_connector_toolbox/src/common/utils/date_format_utils.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/heart_rate_samples_list.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/instant_health_record_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/interval_health_record_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/series_health_record_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/sleep_stages_list.dart';

/// A widget that displays a health record in a list tile format.
///
/// Automatically selects the appropriate unified tile widget based on the
/// record type hierarchy (InstantHealthRecord, IntervalHealthRecord,
/// SeriesHealthRecord) and provides record-specific builders for customization.
@immutable
final class HealthRecordListTile extends StatelessWidget {
  const HealthRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final HealthRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    if (record is InstantHealthRecord) {
      return _buildInstantRecord(context, record as InstantHealthRecord);
    } else if (record is SeriesHealthRecord) {
      return _buildSeriesRecord(context, record as SeriesHealthRecord);
    } else if (record is IntervalHealthRecord) {
      return _buildIntervalRecord(context, record as IntervalHealthRecord);
    } else {
      return ListTile(
        title: const Text(AppTexts.unknownRecordType),
        subtitle: Text('${AppTexts.id}: ${record.id.value}'),
      );
    }
  }

  Widget _buildInstantRecord(
    BuildContext context,
    InstantHealthRecord record,
  ) {
    return switch (record) {
      WeightRecord() => InstantHealthRecordTile<WeightRecord>(
        record: record,
        icon: AppIcons.monitorWeight,
        title:
            '${record.weight.inKilograms.toStringAsFixed(2)} kg '
            '(${record.weight.inPounds.toStringAsFixed(2)} lbs)',
        subtitleBuilder: (r, ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
            ),
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        ),
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.weightKg,
            value: r.weight.inKilograms.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.weightLbs,
            value: r.weight.inPounds.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.weightGrams,
            value: r.weight.inGrams.toStringAsFixed(2),
          ),
        ],
        onDelete: onDelete,
      ),
      HeightRecord() => InstantHealthRecordTile<HeightRecord>(
        record: record,
        icon: AppIcons.height,
        title:
            '${record.height.inMeters.toStringAsFixed(2)} m '
            '(${record.height.inCentimeters.toStringAsFixed(0)} cm)',
        subtitleBuilder: (r, ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
            ),
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        ),
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.heightMeters,
            value: r.height.inMeters.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.heightCm,
            value: r.height.inCentimeters.toStringAsFixed(0),
          ),
        ],
        onDelete: onDelete,
      ),
      BodyFatPercentageRecord() =>
        InstantHealthRecordTile<BodyFatPercentageRecord>(
          record: record,
          icon: AppIcons.percent,
          title: '${record.percentage.asWhole.toStringAsFixed(2)}%',
          subtitleBuilder: (r, ctx) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
              ),
              Text(
                '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          ),
          detailRowsBuilder: (r, ctx) => [
            HealthRecordDetailRow(
              label: AppTexts.bodyFatPercentagePercent,
              value: '${r.percentage.asWhole.toStringAsFixed(2)}%',
            ),
            HealthRecordDetailRow(
              label: 'Decimal',
              value: r.percentage.asDecimal.toStringAsFixed(4),
            ),
          ],
          onDelete: onDelete,
        ),
      LeanBodyMassRecord() => InstantHealthRecordTile<LeanBodyMassRecord>(
        record: record,
        icon: AppIcons.monitorWeight,
        title:
            '${record.mass.inKilograms.toStringAsFixed(2)} kg '
            '(${record.mass.inPounds.toStringAsFixed(2)} lbs)',
        subtitleBuilder: (r, ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
            ),
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        ),
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.leanBodyMassKg,
            value: r.mass.inKilograms.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.leanBodyMassLbs,
            value: r.mass.inPounds.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.leanBodyMassGrams,
            value: r.mass.inGrams.toStringAsFixed(2),
          ),
        ],
        onDelete: onDelete,
      ),
      BodyTemperatureRecord() => InstantHealthRecordTile<BodyTemperatureRecord>(
        record: record,
        icon: AppIcons.temperature,
        title:
            '${record.temperature.inCelsius.toStringAsFixed(2)} °C '
            '(${record.temperature.inFahrenheit.toStringAsFixed(2)} °F)',
        subtitleBuilder: (r, ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
            ),
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        ),
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.bodyTemperatureCelsius,
            value: r.temperature.inCelsius.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.bodyTemperatureFahrenheit,
            value: r.temperature.inFahrenheit.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.bodyTemperatureKelvin,
            value: r.temperature.inKelvin.toStringAsFixed(2),
          ),
        ],
        onDelete: onDelete,
      ),
      HeartRateMeasurementRecord() =>
        InstantHealthRecordTile<HeartRateMeasurementRecord>(
          record: record,
          icon: AppIcons.favorite,
          title:
              '${record.beatsPerMinute.value.toInt()} '
              '${AppTexts.heartRateLabel}',
          subtitleBuilder: (r, ctx) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
              ),
              Text(
                '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          ),
          detailRowsBuilder: (r, ctx) => [
            HealthRecordDetailRow(
              label: AppTexts.heartRateBpm,
              value: r.beatsPerMinute.value.toInt().toString(),
            ),
          ],
          onDelete: onDelete,
        ),
    };
  }

  Widget _buildIntervalRecord(
    BuildContext context,
    IntervalHealthRecord record,
  ) {
    return switch (record) {
      HeartRateSeriesRecord() => _buildSeriesRecord(context, record),
      SleepSessionRecord() => _buildSeriesRecord(context, record),
      StepRecord() => IntervalHealthRecordTile<StepRecord>(
        record: record,
        icon: AppIcons.directionsWalk,
        title: '${record.count.value.toInt()} ${AppTexts.stepsLabel}',
        subtitleBuilder: (r, ctx) {
          final duration = r.duration;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.startLabel} '
                '${DateFormatUtils.formatDateTime(r.startTime)}',
              ),
              Text(
                '${AppTexts.endLabel} '
                '${DateFormatUtils.formatDateTime(r.endTime)}',
              ),
              Text(
                '${AppTexts.duration} ${duration.inHours}h '
                '${duration.inMinutes.remainder(60)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          );
        },
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.count,
            value: r.count.value,
          ),
        ],
        onDelete: onDelete,
      ),
      DistanceRecord() => IntervalHealthRecordTile<DistanceRecord>(
        record: record,
        icon: AppIcons.straighten,
        title:
            '${record.distance.inMeters.toStringAsFixed(2)} m '
            '(${record.distance.inKilometers.toStringAsFixed(2)} km)',
        subtitleBuilder: (r, ctx) {
          final duration = r.duration;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.startLabel} '
                '${DateFormatUtils.formatDateTime(r.startTime)}',
              ),
              Text(
                '${AppTexts.endLabel} '
                '${DateFormatUtils.formatDateTime(r.endTime)}',
              ),
              Text(
                '${AppTexts.duration} ${duration.inHours}h '
                '${duration.inMinutes.remainder(60)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          );
        },
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.distanceMeters,
            value: r.distance.inMeters.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.distanceKm,
            value: r.distance.inKilometers.toStringAsFixed(2),
          ),
        ],
        onDelete: onDelete,
      ),
      ActiveCaloriesBurnedRecord() =>
        IntervalHealthRecordTile<ActiveCaloriesBurnedRecord>(
          record: record,
          icon: AppIcons.localFireDepartment,
          title:
              '${record.energy.inKilocalories.toStringAsFixed(2)} kcal '
              '(${record.energy.inCalories.toStringAsFixed(0)} cal)',
          subtitleBuilder: (r, ctx) {
            final duration = r.duration;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${AppTexts.startLabel} '
                  '${DateFormatUtils.formatDateTime(r.startTime)}',
                ),
                Text(
                  '${AppTexts.endLabel} '
                  '${DateFormatUtils.formatDateTime(r.endTime)}',
                ),
                Text(
                  '${AppTexts.duration} ${duration.inHours}h '
                  '${duration.inMinutes.remainder(60)}m',
                  style: const TextStyle(
                    fontSize: 12,
                    color: theme.AppColors.grey600,
                  ),
                ),
              ],
            );
          },
          detailRowsBuilder: (r, ctx) => [
            HealthRecordDetailRow(
              label: AppTexts.activeCaloriesBurnedKcal,
              value: r.energy.inKilocalories.toStringAsFixed(2),
            ),
            HealthRecordDetailRow(
              label: AppTexts.activeCaloriesBurnedCal,
              value: r.energy.inCalories.toStringAsFixed(0),
            ),
          ],
          onDelete: onDelete,
        ),
      FloorsClimbedRecord() => IntervalHealthRecordTile<FloorsClimbedRecord>(
        record: record,
        icon: AppIcons.stairs,
        title: '${record.floors.value.toInt()} ${AppTexts.floorsClimbedLabel}',
        subtitleBuilder: (r, ctx) {
          final duration = r.duration;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.startLabel} '
                '${DateFormatUtils.formatDateTime(r.startTime)}',
              ),
              Text(
                '${AppTexts.endLabel} '
                '${DateFormatUtils.formatDateTime(r.endTime)}',
              ),
              Text(
                '${AppTexts.duration} ${duration.inHours}h '
                '${duration.inMinutes.remainder(60)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          );
        },
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.count,
            value: r.floors.value.toString(),
          ),
        ],
        onDelete: onDelete,
      ),
      WheelchairPushesRecord() =>
        IntervalHealthRecordTile<WheelchairPushesRecord>(
          record: record,
          icon: AppIcons.accessible,
          title:
              '${record.pushes.value.toInt()} '
              '${AppTexts.wheelchairPushesLabel}',
          subtitleBuilder: (r, ctx) {
            final duration = r.duration;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${AppTexts.startLabel} '
                  '${DateFormatUtils.formatDateTime(r.startTime)}',
                ),
                Text(
                  '${AppTexts.endLabel} '
                  '${DateFormatUtils.formatDateTime(r.endTime)}',
                ),
                Text(
                  '${AppTexts.duration} ${duration.inHours}h '
                  '${duration.inMinutes.remainder(60)}m',
                  style: const TextStyle(
                    fontSize: 12,
                    color: theme.AppColors.grey600,
                  ),
                ),
              ],
            );
          },
          detailRowsBuilder: (r, ctx) => [
            HealthRecordDetailRow(
              label: AppTexts.count,
              value: r.pushes.value.toString(),
            ),
          ],
          onDelete: onDelete,
        ),
      HydrationRecord() => IntervalHealthRecordTile<HydrationRecord>(
        record: record,
        icon: AppIcons.volume,
        title:
            '${record.volume.inLiters.toStringAsFixed(2)} L '
            '(${record.volume.inMilliliters.toStringAsFixed(0)} mL)',
        subtitleBuilder: (r, ctx) {
          final duration = r.duration;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.startLabel} '
                '${DateFormatUtils.formatDateTime(r.startTime)}',
              ),
              Text(
                '${AppTexts.endLabel} '
                '${DateFormatUtils.formatDateTime(r.endTime)}',
              ),
              Text(
                '${AppTexts.duration} ${duration.inHours}h '
                '${duration.inMinutes.remainder(60)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          );
        },
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.hydrationLiters,
            value: r.volume.inLiters.toStringAsFixed(2),
          ),
          HealthRecordDetailRow(
            label: AppTexts.hydrationMilliliters,
            value: r.volume.inMilliliters.toStringAsFixed(0),
          ),
          HealthRecordDetailRow(
            label: AppTexts.hydrationFluidOunces,
            value: r.volume.inFluidOuncesUs.toStringAsFixed(2),
          ),
        ],
        onDelete: onDelete,
      ),
      SleepStageRecord() => _buildSleepStageRecord(context, record),
    };
  }

  Widget _buildSeriesRecord(
    BuildContext context,
    SeriesHealthRecord record,
  ) {
    return switch (record) {
      HeartRateSeriesRecord() => _buildHeartRateSeriesRecord(
        context,
        record,
      ),
      SleepSessionRecord() => _buildSleepSessionRecord(
        context,
        record,
      ),
    };
  }

  /// Maps a [SleepStageType] to its display string.
  static String _getStageTypeDisplayName(SleepStageType type) {
    return switch (type) {
      SleepStageType.unknown => AppTexts.sleepStageUnknown,
      SleepStageType.awake => AppTexts.sleepStageAwake,
      SleepStageType.sleeping => AppTexts.sleepStageSleeping,
      SleepStageType.outOfBed => AppTexts.sleepStageOutOfBed,
      SleepStageType.light => AppTexts.sleepStageLight,
      SleepStageType.deep => AppTexts.sleepStageDeep,
      SleepStageType.rem => AppTexts.sleepStageRem,
      SleepStageType.inBed => AppTexts.sleepStageInBed,
    };
  }

  Widget _buildSleepStageRecord(
    BuildContext context,
    SleepStageRecord record,
  ) {
    final duration = record.duration;
    final stageTypeName = _getStageTypeDisplayName(record.stageType);
    return IntervalHealthRecordTile<SleepStageRecord>(
      record: record,
      icon: AppIcons.bedtime,
      title: '$stageTypeName (${duration.inMinutes}m)',
      subtitleBuilder: (r, ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.startLabel} '
              '${DateFormatUtils.formatDateTime(r.startTime)}',
            ),
            Text(
              '${AppTexts.endLabel} '
              '${DateFormatUtils.formatDateTime(r.endTime)}',
            ),
            Text(
              '${AppTexts.duration} ${duration.inHours}h '
              '${duration.inMinutes.remainder(60)}m',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        );
      },
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.stageType,
          value: _getStageTypeDisplayName(r.stageType),
        ),
        HealthRecordDetailRow(
          label: AppTexts.duration,
          value: '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
        ),
      ],
      onDelete: onDelete,
    );
  }

  Widget _buildSleepSessionRecord(
    BuildContext context,
    SleepSessionRecord record,
  ) {
    final totalSleepDuration = record.totalSleepDuration;
    final duration = record.duration;
    return SeriesHealthRecordTile<SleepSessionRecord, SleepStage>(
      record: record,
      icon: AppIcons.bedtime,
      title:
          '${totalSleepDuration.inHours}h '
          '${totalSleepDuration.inMinutes.remainder(60)}m '
          '${AppTexts.sleepStage.toLowerCase()}',
      subtitleBuilder: (r, ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.startLabel} '
              '${DateFormatUtils.formatDateTime(r.startTime)}',
            ),
            Text(
              '${AppTexts.endLabel} '
              '${DateFormatUtils.formatDateTime(r.endTime)}',
            ),
            Text(
              '${AppTexts.duration} ${duration.inHours}h '
              '${duration.inMinutes.remainder(60)}m',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        );
      },
      samplesBuilder: (stages, ctx) => SleepStagesList(stages: stages),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.duration,
          value: '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
        ),
        HealthRecordDetailRow(
          label: 'Total Sleep Duration',
          value:
              '${totalSleepDuration.inHours}h '
              '${totalSleepDuration.inMinutes.remainder(60)}m',
        ),
        HealthRecordDetailRow(
          label: 'Number of Stages',
          value: r.samples.length.toString(),
        ),
      ],
      onDelete: onDelete,
    );
  }

  Widget _buildHeartRateSeriesRecord(
    BuildContext context,
    HeartRateSeriesRecord record,
  ) {
    return SeriesHealthRecordTile<HeartRateSeriesRecord, HeartRateMeasurement>(
      record: record,
      icon: AppIcons.favorite,
      title:
          '${record.averageBpm.value.toInt()} ${AppTexts.heartRateLabel} '
          '(${record.samplesCount} ${AppTexts.heartRateSamples.toLowerCase()})',
      subtitleBuilder: (r, ctx) {
        final duration = r.duration;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.startLabel} '
              '${DateFormatUtils.formatDateTime(r.startTime)}',
            ),
            Text(
              '${AppTexts.endLabel} '
              '${DateFormatUtils.formatDateTime(r.endTime)}',
            ),
            Text(
              '${AppTexts.duration} ${duration.inHours}h '
              '${duration.inMinutes.remainder(60)}m',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
            if (r.samples.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                '${AppTexts.averageBpm}: ${r.averageBpm.value.toInt()}, '
                '${AppTexts.minBpm}: ${r.minBpm.value.toInt()}, '
                '${AppTexts.maxBpm}: ${r.maxBpm.value.toInt()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          ],
        );
      },
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.averageBpm,
          value: r.averageBpm.value.toInt().toString(),
        ),
        HealthRecordDetailRow(
          label: AppTexts.minBpm,
          value: r.minBpm.value.toInt().toString(),
        ),
        HealthRecordDetailRow(
          label: AppTexts.maxBpm,
          value: r.maxBpm.value.toInt().toString(),
        ),
      ],
      samplesBuilder: (samples, ctx) => HeartRateSamplesList(
        samples: samples,
      ),
      onDelete: onDelete,
    );
  }
}
