import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        CrossCountrySkiingDistanceRecord,
        CyclingDistanceRecord,
        DistanceActivityRecord,
        DownhillSnowSportsDistanceRecord,
        PaddleSportsDistanceRecord,
        RowingDistanceRecord,
        SixMinuteWalkTestDistanceRecord,
        SkatingSportsDistanceRecord,
        SwimmingDistanceRecord,
        WheelchairDistanceRecord,
        WalkingRunningDistanceRecord,
        sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/cross_country_skiing_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/cycling_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/downhill_snow_sports_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/paddle_sports_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/rowing_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/six_minute_walk_test_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/skating_sports_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/swimming_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/walking_running_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/wheelchair_distance_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DistanceActivityRecordDto, DistanceActivityTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DistanceActivityRecord] subclasses to [DistanceActivityRecordDto].
@sinceV2_0_0
@internal
extension DistanceActivityRecordToDto on DistanceActivityRecord {
  DistanceActivityRecordDto toDto() {
    return switch (this) {
      final CyclingDistanceRecord record => CyclingDistanceRecordToDto(
        record,
      ).toDto(),
      final SwimmingDistanceRecord record => SwimmingDistanceRecordToDto(
        record,
      ).toDto(),
      final WheelchairDistanceRecord record => WheelchairDistanceRecordToDto(
        record,
      ).toDto(),
      final DownhillSnowSportsDistanceRecord record =>
        DownhillSnowSportsDistanceRecordToDto(record).toDto(),
      final RowingDistanceRecord record => RowingDistanceRecordToDto(
        record,
      ).toDto(),
      final PaddleSportsDistanceRecord record =>
        PaddleSportsDistanceRecordToDto(record).toDto(),
      final CrossCountrySkiingDistanceRecord record =>
        CrossCountrySkiingDistanceRecordToDto(record).toDto(),
      final SkatingSportsDistanceRecord record =>
        SkatingSportsDistanceRecordToDto(record).toDto(),
      final SixMinuteWalkTestDistanceRecord record =>
        SixMinuteWalkTestDistanceRecordToDto(record).toDto(),
      final WalkingRunningDistanceRecord record =>
        WalkingRunningDistanceRecordToDto(record).toDto(),
    };
  }
}

/// Converts [DistanceActivityRecordDto] to correct [DistanceActivityRecord].
@sinceV2_0_0
@internal
extension DistanceActivityRecordDtoToDomain on DistanceActivityRecordDto {
  DistanceActivityRecord toDomain() {
    return switch (activityType) {
      DistanceActivityTypeDto.cycling => CyclingDistanceRecordDtoToDomain(
        this,
      ).toDomain(),
      DistanceActivityTypeDto.swimming => SwimmingDistanceRecordDtoToDomain(
        this,
      ).toDomain(),
      DistanceActivityTypeDto.wheelchair => WheelchairDistanceRecordDtoToDomain(
        this,
      ).toDomain(),
      DistanceActivityTypeDto.downhillSnowSports =>
        DownhillSnowSportsDistanceRecordDtoToDomain(this).toDomain(),
      DistanceActivityTypeDto.rowing => RowingDistanceRecordDtoToDomain(
        this,
      ).toDomain(),
      DistanceActivityTypeDto.paddleSports =>
        PaddleSportsDistanceRecordDtoToDomain(
          this,
        ).toDomain(),
      DistanceActivityTypeDto.crossCountrySkiing =>
        CrossCountrySkiingDistanceRecordDtoToDomain(this).toDomain(),
      DistanceActivityTypeDto.skatingSports =>
        SkatingSportsDistanceRecordDtoToDomain(this).toDomain(),
      DistanceActivityTypeDto.sixMinuteWalkTest =>
        SixMinuteWalkTestDistanceRecordDtoToDomain(this).toDomain(),
      DistanceActivityTypeDto.walkingRunning =>
        WalkingRunningDistanceRecordDtoToDomain(this).toDomain(),
    };
  }
}
