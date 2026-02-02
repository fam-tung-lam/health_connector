package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ExerciseSegment
import androidx.health.connect.client.records.ExerciseSessionRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionEventDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionLapEventDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionSegmentEventDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [ExerciseSessionRecord] to [ExerciseSessionRecordDto].
 */
internal fun ExerciseSessionRecord.toDto(): ExerciseSessionRecordDto {
    // Convert segments and laps to event DTOs
    val segmentEvents = segments.map {
        it.toDto() as ExerciseSessionEventDto
    }
    val lapEvents = laps.map {
        it.toDto() as ExerciseSessionEventDto
    }
    val allEvents = segmentEvents + lapEvents

    return ExerciseSessionRecordDto(
        id = metadata.id,
        metadata = metadata.toDto(),
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        exerciseType = exerciseType.toExerciseTypeDto(),
        title = title,
        notes = notes,
        events = allEvents,
    )
}

/**
 * Converts [ExerciseSessionRecordDto] to Health Connect [ExerciseSessionRecord].
 *
 * @throws IllegalArgumentException if exercise type is not supported on Android Health Connect,
 * or if any segment type is not compatible with the session type
 */
internal fun ExerciseSessionRecordDto.toHealthConnect(): ExerciseSessionRecord {
    // Convert exercise type first to validate and use for segment compatibility check
    val sessionType = exerciseType.toHealthConnectExerciseType()

    // Separate segments and laps from events
    val segmentDtos = events.filterIsInstance<ExerciseSessionSegmentEventDto>()
    val segments = segmentDtos.map { it.toHealthConnect() }
    val laps = events
        .filterIsInstance<ExerciseSessionLapEventDto>()
        .map { it.toHealthConnect() }

    // Validate segment compatibility with session type
    segments.forEach { segment ->
        val segmentType = segment.segmentType
        if (!ExerciseSegment.isSegmentTypeCompatibleWithSessionType(segmentType, sessionType)) {
            throw IllegalArgumentException(
                "segmentType and sessionType is not compatible. " +
                    "Segment type: $segmentType, Session type: $sessionType",
            )
        }
    }

    return ExerciseSessionRecord(
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
        endZoneOffset = endZoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
        exerciseType = sessionType,
        title = title?.takeIf { it.isNotBlank() },
        notes = notes?.takeIf { it.isNotBlank() },
        segments = segments,
        laps = laps,
        exerciseRoute = exerciseRoute?.toHealthConnect(),
        metadata = metadata.toHealthConnect(id),
    )
}
