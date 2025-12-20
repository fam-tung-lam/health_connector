import 'package:health_connector_core/health_connector_core.dart'
    show HealthRecordId, Vo2Max, Vo2MaxRecord, Vo2MaxTestType, sinceV1_3_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show Vo2MaxDto, Vo2MaxMeasurementMethodDto, Vo2MaxRecordDto, Vo2MaxUnitDto;
import 'package:meta/meta.dart' show internal;

/// Converts [Vo2MaxRecordDto] to [Vo2MaxRecord].
@sinceV1_3_0
@internal
extension Vo2MaxRecordDtoToDomain on Vo2MaxRecordDto {
  Vo2MaxRecord toDomain() {
    return Vo2MaxRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      vo2Max: Vo2Max.millilitersPerKilogramPerMinute(vo2Max.value),
      testType: measurementMethod?.toDomain(),
    );
  }
}

/// Converts [Vo2MaxRecord] to [Vo2MaxRecordDto].
@sinceV1_3_0
@internal
extension Vo2MaxRecordToDto on Vo2MaxRecord {
  Vo2MaxRecordDto toDto() {
    return Vo2MaxRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      vo2Max: Vo2MaxDto(
        value: vo2Max.value,
        unit: Vo2MaxUnitDto.millilitersPerKilogramPerMinute,
      ),
      measurementMethod: testType?.toDto(),
    );
  }
}

/// Converts [Vo2MaxMeasurementMethodDto] to [Vo2MaxTestType].
@sinceV1_3_0
@internal
extension Vo2MaxMeasurementMethodDtoToDomain on Vo2MaxMeasurementMethodDto {
  Vo2MaxTestType toDomain() {
    return switch (this) {
      Vo2MaxMeasurementMethodDto.metabolicCart => Vo2MaxTestType.metabolicCart,
      Vo2MaxMeasurementMethodDto.heartRateRatio =>
        Vo2MaxTestType.heartRateRatio,
      Vo2MaxMeasurementMethodDto.cooperTest => Vo2MaxTestType.cooperTest,
      Vo2MaxMeasurementMethodDto.multistageFitnessTest =>
        Vo2MaxTestType.multistageFitnessTest,
      Vo2MaxMeasurementMethodDto.rockportFitnessTest =>
        Vo2MaxTestType.rockportFitnessTest,
      Vo2MaxMeasurementMethodDto.other => Vo2MaxTestType.other,
    };
  }
}

/// Converts [Vo2MaxTestType] to [Vo2MaxMeasurementMethodDto].
@sinceV1_3_0
@internal
extension Vo2MaxTestTypeToDto on Vo2MaxTestType {
  Vo2MaxMeasurementMethodDto toDto() {
    return switch (this) {
      Vo2MaxTestType.metabolicCart => Vo2MaxMeasurementMethodDto.metabolicCart,
      Vo2MaxTestType.heartRateRatio =>
        Vo2MaxMeasurementMethodDto.heartRateRatio,
      Vo2MaxTestType.cooperTest => Vo2MaxMeasurementMethodDto.cooperTest,
      Vo2MaxTestType.multistageFitnessTest =>
        Vo2MaxMeasurementMethodDto.multistageFitnessTest,
      Vo2MaxTestType.rockportFitnessTest =>
        Vo2MaxMeasurementMethodDto.rockportFitnessTest,
      // iOS-specific types map to OTHER on Android
      Vo2MaxTestType.predictionStepTest => Vo2MaxMeasurementMethodDto.other,
      Vo2MaxTestType.other => Vo2MaxMeasurementMethodDto.other,
    };
  }
}
