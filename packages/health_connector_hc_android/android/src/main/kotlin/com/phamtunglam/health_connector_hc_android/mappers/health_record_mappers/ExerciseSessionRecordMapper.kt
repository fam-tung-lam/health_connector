package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseSessionRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [ExerciseSessionRecord] to [ExerciseSessionRecordDto].
 */
internal fun ExerciseSessionRecord.toDto(): ExerciseSessionRecordDto = ExerciseSessionRecordDto(
    id = metadata.id,
    metadata = metadata.toDto(),
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    exerciseType = exerciseType.toExerciseTypeDto(),
    title = title,
    notes = notes,
)

/**
 * Converts [ExerciseSessionRecordDto] to Health Connect [ExerciseSessionRecord].
 *
 * @throws IllegalArgumentException if exercise type is not supported on Android Health Connect
 */
internal fun ExerciseSessionRecordDto.toHealthConnect(): ExerciseSessionRecord =
    ExerciseSessionRecord(
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
        endZoneOffset = endZoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
        exerciseType = exerciseType.toHealthConnectExerciseType(),
        title = title?.takeIf { it.isNotBlank() },
        notes = notes?.takeIf { it.isNotBlank() },
        metadata = metadata.toHealthConnect(id),
    )
