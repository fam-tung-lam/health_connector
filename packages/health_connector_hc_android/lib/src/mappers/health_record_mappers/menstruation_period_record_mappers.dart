import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart';
import 'package:meta/meta.dart';

@internal
extension MenstruationPeriodRecordToDto on MenstruationPeriodRecord {
  MenstruationPeriodRecordDto toDto() {
    return MenstruationPeriodRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      samples: samples.map((e) => e.toDto()).toList(),
    );
  }
}

@internal
extension MenstruationPeriodRecordDtoToDomain on MenstruationPeriodRecordDto {
  MenstruationPeriodRecord toDomain() {
    return MenstruationPeriodRecord(
      id: id?.toHealthRecordId() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      samples: samples
          .whereType<MenstruationFlowRecordDto>()
          .map((e) => e.toDomain())
          .toList(),
    );
  }
}

@internal
extension MenstruationFlowRecordToDto on MenstruationFlowRecord {
  MenstruationFlowRecordDto toDto() {
    return MenstruationFlowRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      flow: _toMenstrualFlowDto(flow),
      metadata: metadata?.toDto(),
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}

@internal
extension MenstruationFlowRecordDtoToDomain on MenstruationFlowRecordDto {
  MenstruationFlowRecord toDomain() {
    return MenstruationFlowRecord(
      id: id?.toHealthRecordId() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      flow: _toMenstrualFlow(flow),
      metadata: metadata?.toDomain(),
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }
}

MenstrualFlowDto? _toMenstrualFlowDto(MenstrualFlow? flow) {
  if (flow == null) {
    return null;
  }
  switch (flow) {
    case MenstrualFlow.light:
      return MenstrualFlowDto.light;
    case MenstrualFlow.medium:
      return MenstrualFlowDto.medium;
    case MenstrualFlow.heavy:
      return MenstrualFlowDto.heavy;
    case MenstrualFlow.unknown:
      return MenstrualFlowDto.unknown;
  }
}

MenstrualFlow _toMenstrualFlow(MenstrualFlowDto? dto) {
  switch (dto) {
    case MenstrualFlowDto.light:
      return MenstrualFlow.light;
    case MenstrualFlowDto.medium:
      return MenstrualFlow.medium;
    case MenstrualFlowDto.heavy:
      return MenstrualFlow.heavy;
    case MenstrualFlowDto.unknown:
    case null:
      return MenstrualFlow.unknown;
  }
}
