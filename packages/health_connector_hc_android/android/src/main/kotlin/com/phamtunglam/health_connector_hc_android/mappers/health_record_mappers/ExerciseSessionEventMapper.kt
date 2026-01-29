package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseLap
import androidx.health.connect.client.records.ExerciseSegment
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionLapEventDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionSegmentEventDto
import java.time.Instant

/**
 * Converts a Health Connect [ExerciseSegment] to [ExerciseSessionSegmentEventDto].
 */
internal fun ExerciseSegment.toDto(): ExerciseSessionSegmentEventDto =
    ExerciseSessionSegmentEventDto(
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        segmentType = segmentType.toExerciseSegmentTypeDto(),
        repetitions = if (repetitions > 0) repetitions.toLong() else null,
    )

/**
 * Converts a Health Connect [ExerciseLap] to [ExerciseSessionLapEventDto].
 */
internal fun ExerciseLap.toDto(): ExerciseSessionLapEventDto = ExerciseSessionLapEventDto(
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    distanceMeters = length?.inMeters,
)

/**
 * Converts [ExerciseSessionSegmentEventDto] to Health Connect [ExerciseSegment].
 */
internal fun ExerciseSessionSegmentEventDto.toHealthConnect(): ExerciseSegment = ExerciseSegment(
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    segmentType = segmentType.toHealthConnect(),
    repetitions = repetitions?.toInt() ?: 0,
)

/**
 * Converts [ExerciseSessionLapEventDto] to Health Connect [ExerciseLap].
 */
internal fun ExerciseSessionLapEventDto.toHealthConnect(): ExerciseLap = ExerciseLap(
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    length = distanceMeters?.let { Length.meters(it) },
)
