import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:meta/meta.dart';

/// Converts [StepsCadenceSeriesRecord] to [StepsCadenceSeriesRecordDto].
@internal
extension StepsCadenceSeriesRecordToDto on StepsCadenceSeriesRecord {
  /// Converts [StepsCadenceSeriesRecord] to [StepsCadenceSeriesRecordDto].
  StepsCadenceSeriesRecordDto toDto() {
    return StepsCadenceSeriesRecordDto(
      id: id == HealthRecordId.none ? null : id.value,
      startTime: startTime.toUtc().millisecondsSinceEpoch,
      endTime: endTime.toUtc().millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.timeZoneOffset.inSeconds,
      endZoneOffsetSeconds: endTime.timeZoneOffset.inSeconds,
      samples: samples
          .map(
            (e) => StepsCadenceSampleDto(
              time: e.time.toUtc().millisecondsSinceEpoch,
              stepsPerMinute: e.cadence.inPerMinute,
            ),
          )
          .toList(),
      metadata: metadata.toDto(),
    );
  }
}

/// Converts [StepsCadenceSeriesRecordDto] to [StepsCadenceSeriesRecord].
@internal
extension StepsCadenceSeriesRecordDtoToDomain on StepsCadenceSeriesRecordDto {
  /// Converts [StepsCadenceSeriesRecordDto] to [StepsCadenceSeriesRecord].
  StepsCadenceSeriesRecord toDomain() {
    return StepsCadenceSeriesRecord(
      id: id == null ? HealthRecordId.none : HealthRecordId(id!),
      startTime: DateTime.fromMillisecondsSinceEpoch(
        startTime,
        isUtc: true,
      ).toLocal(),
      endTime: DateTime.fromMillisecondsSinceEpoch(
        endTime,
        isUtc: true,
      ).toLocal(),
      samples: samples.where((e) => e != null).map((e) {
        final sample = e!;
        return StepsCadenceSample(
          time: DateTime.fromMillisecondsSinceEpoch(
            sample.time,
            isUtc: true,
          ).toLocal(),
          cadence: Frequency.perMinute(sample.stepsPerMinute),
        );
      }).toList(),
      metadata: metadata.toDomain(),
    );
  }
}
