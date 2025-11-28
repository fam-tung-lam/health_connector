package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.LeanBodyMassRecord
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import androidx.health.connect.client.units.Temperature
import com.phamtunglam.health_connector_hc_android.pigeon.ActiveCaloriesBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.FloorsClimbedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateMeasurementDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.LeanBodyMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WheelchairPushesRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts an [ActiveCaloriesBurnedRecordDto] to a Health Connect [ActiveCaloriesBurnedRecord] object.
 */
internal fun ActiveCaloriesBurnedRecordDto.toHealthConnect(): ActiveCaloriesBurnedRecord {
    return ActiveCaloriesBurnedRecord(
        energy = energy.toHealthConnect(),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [ActiveCaloriesBurnedRecord] object to an [ActiveCaloriesBurnedRecordDto].
 */
internal fun ActiveCaloriesBurnedRecord.toDto(): ActiveCaloriesBurnedRecordDto {
    return ActiveCaloriesBurnedRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        energy = energy.toDto()
    )
}

/**
 * Converts a [DistanceRecordDto] to a Health Connect [DistanceRecord] object.
 */
internal fun DistanceRecordDto.toHealthConnect(): DistanceRecord {
    return DistanceRecord(
        distance = distance.toHealthConnect(),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [DistanceRecord] object to a [DistanceRecordDto].
 */
internal fun DistanceRecord.toDto(): DistanceRecordDto {
    return DistanceRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        distance = distance.toDto()
    )
}

/**
 * Converts a [FloorsClimbedRecordDto] to a Health Connect [FloorsClimbedRecord] object.
 */
internal fun FloorsClimbedRecordDto.toHealthConnect(): FloorsClimbedRecord {
    return FloorsClimbedRecord(
        floors = floors.value,
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [FloorsClimbedRecord] object to a [FloorsClimbedRecordDto].
 */
internal fun FloorsClimbedRecord.toDto(): FloorsClimbedRecordDto {
    return FloorsClimbedRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        floors = floors.toNumericDto()
    )
}

/**
 * Converts a [StepRecordDto] to a Health Connect [StepsRecord] object.
 */
internal fun StepRecordDto.toHealthConnect(): StepsRecord {
    return StepsRecord(
        count = count.toLong(),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [StepsRecord] object to a [StepRecordDto].
 */
internal fun StepsRecord.toDto(): StepRecordDto {
    return StepRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        count = count.toNumericDto()
    )
}

/**
 * Converts a [WeightRecordDto] to a Health Connect [WeightRecord] object.
 */
internal fun WeightRecordDto.toHealthConnect(): WeightRecord {
    return WeightRecord(
        weight = weight.toHealthConnect(),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [WeightRecord] object to a [WeightRecordDto].
 */
internal fun WeightRecord.toDto(): WeightRecordDto {
    return WeightRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        weight = weight.toDto()
    )
}

/**
 * Converts a [LeanBodyMassRecordDto] to a Health Connect [LeanBodyMassRecord] object.
 */
internal fun LeanBodyMassRecordDto.toHealthConnect(): LeanBodyMassRecord {
    return LeanBodyMassRecord(
        mass = mass.toHealthConnect(),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [LeanBodyMassRecord] object to a [LeanBodyMassRecordDto].
 */
internal fun LeanBodyMassRecord.toDto(): LeanBodyMassRecordDto {
    return LeanBodyMassRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        mass = mass.toDto()
    )
}

/**
 * Converts a [HeightRecordDto] to a Health Connect [HeightRecord] object.
 */
internal fun HeightRecordDto.toHealthConnect(): HeightRecord {
    return HeightRecord(
        height = height.toHealthConnect(),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [HeightRecord] object to a [HeightRecordDto].
 */
internal fun HeightRecord.toDto(): HeightRecordDto {
    return HeightRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        height = height.toDto()
    )
}

/**
 * Converts a [BodyFatPercentageRecordDto] to a Health Connect [BodyFatRecord] object.
 */
internal fun BodyFatPercentageRecordDto.toHealthConnect(): BodyFatRecord {
    return BodyFatRecord(
        percentage = percentage.toHealthConnect(),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [BodyFatRecord] object to a [BodyFatPercentageRecordDto].
 */
internal fun BodyFatRecord.toDto(): BodyFatPercentageRecordDto {
    return BodyFatPercentageRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        percentage = percentage.toDto()
    )
}

/**
 * Converts a [BodyTemperatureRecordDto] to a Health Connect [BodyTemperatureRecord] object.
 */
internal fun BodyTemperatureRecordDto.toHealthConnect(): BodyTemperatureRecord {
    return BodyTemperatureRecord(
        temperature = Temperature.celsius(temperature.value),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [BodyTemperatureRecord] object to a [BodyTemperatureRecordDto].
 */
internal fun BodyTemperatureRecord.toDto(): BodyTemperatureRecordDto {
    return BodyTemperatureRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        temperature = temperature.inCelsius.toTemperatureDto()
    )
}

/**
 * Converts a [WheelchairPushesRecordDto] to a Health Connect [WheelchairPushesRecord] object.
 */
internal fun WheelchairPushesRecordDto.toHealthConnect(): WheelchairPushesRecord {
    return WheelchairPushesRecord(
        count = pushes.value.toLong(),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [WheelchairPushesRecord] object to a [WheelchairPushesRecordDto].
 */
internal fun WheelchairPushesRecord.toDto(): WheelchairPushesRecordDto {
    return WheelchairPushesRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        pushes = count.toNumericDto()
    )
}

/**
 * Converts a [HydrationRecordDto] to a Health Connect [HydrationRecord] object.
 */
internal fun HydrationRecordDto.toHealthConnect(): HydrationRecord {
    return HydrationRecord(
        volume = volume.toHealthConnect(),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [HydrationRecord] object to a [HydrationRecordDto].
 */
internal fun HydrationRecord.toDto(): HydrationRecordDto {
    return HydrationRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        volume = volume.toDto()
    )
}

/**
 * Converts a [HeartRateSeriesRecordDto] to a Health Connect [HeartRateRecord] object.
 */
internal fun HeartRateSeriesRecordDto.toHealthConnect(): HeartRateRecord {
    return HeartRateRecord(
        samples = samples.map { sample ->
            HeartRateRecord.Sample(
                time = Instant.ofEpochMilli(sample.time),
                beatsPerMinute = sample.beatsPerMinute.value.toLong()
            )
        },
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
}

/**
 * Converts a Health Connect [HeartRateRecord] object to a [HeartRateSeriesRecordDto].
 */
internal fun HeartRateRecord.toDto(): HeartRateSeriesRecordDto {
    return HeartRateSeriesRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        samples = samples.map { sample ->
            HeartRateMeasurementDto(
                time = sample.time.toEpochMilli(),
                beatsPerMinute = sample.beatsPerMinute.toNumericDto()
            )
        }
    )
}

internal fun SleepStageTypeDto.toHealthConnect(): Int {
    return when (this) {
        SleepStageTypeDto.UNKNOWN -> SleepSessionRecord.STAGE_TYPE_UNKNOWN
        SleepStageTypeDto.AWAKE -> SleepSessionRecord.STAGE_TYPE_AWAKE
        SleepStageTypeDto.SLEEPING -> SleepSessionRecord.STAGE_TYPE_SLEEPING
        SleepStageTypeDto.OUT_OF_BED -> SleepSessionRecord.STAGE_TYPE_OUT_OF_BED
        SleepStageTypeDto.LIGHT -> SleepSessionRecord.STAGE_TYPE_LIGHT
        SleepStageTypeDto.DEEP -> SleepSessionRecord.STAGE_TYPE_DEEP
        SleepStageTypeDto.REM -> SleepSessionRecord.STAGE_TYPE_REM
        SleepStageTypeDto.IN_BED -> SleepSessionRecord.STAGE_TYPE_AWAKE_IN_BED
    }
}

internal fun Int.toSleepStageTypeDto(): SleepStageTypeDto {
    return when (this) {
        SleepSessionRecord.STAGE_TYPE_UNKNOWN -> SleepStageTypeDto.UNKNOWN
        SleepSessionRecord.STAGE_TYPE_AWAKE -> SleepStageTypeDto.AWAKE
        SleepSessionRecord.STAGE_TYPE_SLEEPING -> SleepStageTypeDto.SLEEPING
        SleepSessionRecord.STAGE_TYPE_OUT_OF_BED -> SleepStageTypeDto.OUT_OF_BED
        SleepSessionRecord.STAGE_TYPE_LIGHT -> SleepStageTypeDto.LIGHT
        SleepSessionRecord.STAGE_TYPE_DEEP -> SleepStageTypeDto.DEEP
        SleepSessionRecord.STAGE_TYPE_REM -> SleepStageTypeDto.REM
        SleepSessionRecord.STAGE_TYPE_AWAKE_IN_BED -> SleepStageTypeDto.IN_BED
        else -> SleepStageTypeDto.UNKNOWN
    }
}

internal fun SleepStageDto.toHealthConnect(): SleepSessionRecord.Stage {
    return SleepSessionRecord.Stage(
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        stage = stage.toHealthConnect()
    )
}

internal fun SleepSessionRecord.Stage.toDto(): SleepStageDto {
    return SleepStageDto(
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        stage = stage.toSleepStageTypeDto()
    )
}

internal fun SleepSessionRecordDto.toHealthConnect(): SleepSessionRecord {
    return SleepSessionRecord(
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
        endZoneOffset = endZoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
        title = title,
        notes = notes,
        stages = stages.map { it.toHealthConnect() },
        metadata = metadata.toHealthConnect()
    )
}

internal fun SleepSessionRecord.toDto(): SleepSessionRecordDto {
    return SleepSessionRecordDto(
        id = metadata.id,
        metadata = metadata.toDto(),
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        title = title,
        notes = notes,
        stages = stages.map { it.toDto() }
    )
}
