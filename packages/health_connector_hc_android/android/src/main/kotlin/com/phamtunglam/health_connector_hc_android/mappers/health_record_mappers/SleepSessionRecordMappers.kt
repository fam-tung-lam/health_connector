package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.SleepSessionRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageTypeDto
import java.time.Instant
import java.time.ZoneOffset

internal fun SleepStageTypeDto.toHealthConnect(): Int = when (this) {
    SleepStageTypeDto.UNKNOWN -> SleepSessionRecord.STAGE_TYPE_UNKNOWN
    SleepStageTypeDto.AWAKE -> SleepSessionRecord.STAGE_TYPE_AWAKE
    SleepStageTypeDto.SLEEPING -> SleepSessionRecord.STAGE_TYPE_SLEEPING
    SleepStageTypeDto.OUT_OF_BED -> SleepSessionRecord.STAGE_TYPE_OUT_OF_BED
    SleepStageTypeDto.LIGHT -> SleepSessionRecord.STAGE_TYPE_LIGHT
    SleepStageTypeDto.DEEP -> SleepSessionRecord.STAGE_TYPE_DEEP
    SleepStageTypeDto.REM -> SleepSessionRecord.STAGE_TYPE_REM
    SleepStageTypeDto.IN_BED -> SleepSessionRecord.STAGE_TYPE_AWAKE_IN_BED
}

internal fun Int.toSleepStageTypeDto(): SleepStageTypeDto = when (this) {
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

internal fun SleepStageDto.toHealthConnect(): SleepSessionRecord.Stage = SleepSessionRecord.Stage(
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    stage = stage.toHealthConnect(),
)

internal fun SleepSessionRecord.Stage.toDto(): SleepStageDto = SleepStageDto(
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    stage = stage.toSleepStageTypeDto(),
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
    metadata = metadata.toHealthConnect(),
)
