package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.SleepSessionRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageSampleDto
import java.time.Instant
import java.time.ZoneOffset

internal fun SleepStageDto.toHealthConnect(): Int = when (this) {
    SleepStageDto.UNKNOWN -> SleepSessionRecord.STAGE_TYPE_UNKNOWN
    SleepStageDto.AWAKE -> SleepSessionRecord.STAGE_TYPE_AWAKE
    SleepStageDto.SLEEPING -> SleepSessionRecord.STAGE_TYPE_SLEEPING
    SleepStageDto.OUT_OF_BED -> SleepSessionRecord.STAGE_TYPE_OUT_OF_BED
    SleepStageDto.LIGHT -> SleepSessionRecord.STAGE_TYPE_LIGHT
    SleepStageDto.DEEP -> SleepSessionRecord.STAGE_TYPE_DEEP
    SleepStageDto.REM -> SleepSessionRecord.STAGE_TYPE_REM
    SleepStageDto.IN_BED -> SleepSessionRecord.STAGE_TYPE_AWAKE_IN_BED
}

internal fun Int.toSleepStageDto(): SleepStageDto = when (this) {
    SleepSessionRecord.STAGE_TYPE_UNKNOWN -> SleepStageDto.UNKNOWN
    SleepSessionRecord.STAGE_TYPE_AWAKE -> SleepStageDto.AWAKE
    SleepSessionRecord.STAGE_TYPE_SLEEPING -> SleepStageDto.SLEEPING
    SleepSessionRecord.STAGE_TYPE_OUT_OF_BED -> SleepStageDto.OUT_OF_BED
    SleepSessionRecord.STAGE_TYPE_LIGHT -> SleepStageDto.LIGHT
    SleepSessionRecord.STAGE_TYPE_DEEP -> SleepStageDto.DEEP
    SleepSessionRecord.STAGE_TYPE_REM -> SleepStageDto.REM
    SleepSessionRecord.STAGE_TYPE_AWAKE_IN_BED -> SleepStageDto.IN_BED
    else -> SleepStageDto.UNKNOWN
}

internal fun SleepStageSampleDto.toHealthConnect(): SleepSessionRecord.Stage =
    SleepSessionRecord.Stage(
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        stage = stage.toHealthConnect(),
    )

internal fun SleepSessionRecord.Stage.toDto(): SleepStageSampleDto = SleepStageSampleDto(
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    stage = stage.toSleepStageDto(),
)

/**
 * Converts a Health Connect [SleepSessionRecord] object to a [SleepSessionRecordDto].
 */
internal fun SleepSessionRecord.toDto(): SleepSessionRecordDto = SleepSessionRecordDto(
    id = metadata.id,
    metadata = metadata.toDto(),
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    title = title,
    notes = notes,
    stages = stages.map { it.toDto() },
)

/**
 * Converts a [SleepSessionRecordDto] to a Health Connect [SleepSessionRecord] object.
 */
internal fun SleepSessionRecordDto.toHealthConnect(): SleepSessionRecord = SleepSessionRecord(
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
    metadata = metadata.toHealthConnect(id),
)
