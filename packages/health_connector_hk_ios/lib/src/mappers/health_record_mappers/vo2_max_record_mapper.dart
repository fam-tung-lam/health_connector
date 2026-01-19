import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [Vo2MaxRecordDto] to [Vo2MaxRecord].
@internal
extension Vo2MaxRecordDtoToDomain on Vo2MaxRecordDto {
  Vo2MaxRecord toDomain() {
    return Vo2MaxRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      vo2MlPerMinPerKg: Number(
        millilitersPerKilogramPerMinute,
      ),
      testType: testType?.toDomain(),
    );
  }
}

/// Converts [Vo2MaxRecord] to [Vo2MaxRecordDto].
@internal
extension Vo2MaxRecordToDto on Vo2MaxRecord {
  Vo2MaxRecordDto toDto() {
    return Vo2MaxRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      millilitersPerKilogramPerMinute: vo2MlPerMinPerKg.value.toDouble(),
      testType: testType?.toDto(),
    );
  }
}

/// Converts [Vo2MaxTestTypeDto] to [Vo2MaxTestType].
@internal
extension Vo2MaxTestTypeDtoToDomain on Vo2MaxTestTypeDto {
  Vo2MaxTestType toDomain() {
    switch (this) {
      case Vo2MaxTestTypeDto.maxExercise:
        return Vo2MaxTestType.metabolicCart;
      case Vo2MaxTestTypeDto.predictionNonExercise:
        return Vo2MaxTestType.heartRateRatio;
      case Vo2MaxTestTypeDto.predictionSubMaxExercise:
        return Vo2MaxTestType.other;
      case Vo2MaxTestTypeDto.predictionStepTest:
        return Vo2MaxTestType.predictionStepTest;
    }
  }
}

/// Converts [Vo2MaxTestType] to [Vo2MaxTestTypeDto].
@internal
extension Vo2MaxTestTypeToDto on Vo2MaxTestType {
  Vo2MaxTestTypeDto? toDto() {
    switch (this) {
      case Vo2MaxTestType.metabolicCart:
        return Vo2MaxTestTypeDto.maxExercise;
      case Vo2MaxTestType.heartRateRatio:
        return Vo2MaxTestTypeDto.predictionNonExercise;
      case Vo2MaxTestType.predictionStepTest:
        return Vo2MaxTestTypeDto.predictionStepTest;
      case Vo2MaxTestType.cooperTest:
      case Vo2MaxTestType.multistageFitnessTest:
      case Vo2MaxTestType.rockportFitnessTest:
      case Vo2MaxTestType.other:
        return Vo2MaxTestTypeDto.predictionSubMaxExercise;
    }
  }
}
