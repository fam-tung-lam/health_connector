package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.feature.ExperimentalMindfulnessSessionApi
import androidx.health.connect.client.records.MindfulnessSessionRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.MindfulnessSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MindfulnessSessionTypeDto
import java.time.ZoneOffset

// region MindfulnessSessionType Mappers

/**
 * Converts [MindfulnessSessionRecord] type to [MindfulnessSessionTypeDto].
 */
@OptIn(ExperimentalMindfulnessSessionApi::class)
internal fun Int.toMindfulnessSessionTypeDto(): MindfulnessSessionTypeDto = when (this) {
    MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_MEDITATION ->
        MindfulnessSessionTypeDto.MEDITATION
    MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_BREATHING ->
        MindfulnessSessionTypeDto.BREATHING
    MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_MUSIC ->
        MindfulnessSessionTypeDto.MUSIC
    MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_MOVEMENT ->
        MindfulnessSessionTypeDto.MOVEMENT
    MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_UNGUIDED ->
        MindfulnessSessionTypeDto.UNGUIDED
    else -> MindfulnessSessionTypeDto.UNKNOWN
}

/**
 * Converts [MindfulnessSessionTypeDto] to [MindfulnessSessionRecord] type.
 */
@OptIn(ExperimentalMindfulnessSessionApi::class)
internal fun MindfulnessSessionTypeDto.toHealthConnectMindfulnessSessionType(): Int = when (this) {
    MindfulnessSessionTypeDto.MEDITATION ->
        MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_MEDITATION
    MindfulnessSessionTypeDto.BREATHING ->
        MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_BREATHING
    MindfulnessSessionTypeDto.MUSIC ->
        MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_MUSIC
    MindfulnessSessionTypeDto.MOVEMENT ->
        MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_MOVEMENT
    MindfulnessSessionTypeDto.UNGUIDED ->
        MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_UNGUIDED
    MindfulnessSessionTypeDto.UNKNOWN ->
        MindfulnessSessionRecord.MINDFULNESS_SESSION_TYPE_UNKNOWN
}

// endregion

// region MindfulnessSessionRecord Mappers

/**
 * Converts [MindfulnessSessionRecord] to DTO.
 */
@OptIn(ExperimentalMindfulnessSessionApi::class)
internal fun MindfulnessSessionRecord.toDto(): MindfulnessSessionRecordDto =
    MindfulnessSessionRecordDto(
        id = metadata.id,
        metadata = metadata.toDto(),
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        sessionType = mindfulnessSessionType.toMindfulnessSessionTypeDto(),
        title = title,
        notes = notes,
    )

/**
 * Converts DTO to [MindfulnessSessionRecord].
 */
@OptIn(ExperimentalMindfulnessSessionApi::class)
internal fun MindfulnessSessionRecordDto.toHealthConnect(): MindfulnessSessionRecord =
    MindfulnessSessionRecord(
        startTime = java.time.Instant.ofEpochMilli(startTime),
        endTime = java.time.Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        mindfulnessSessionType = sessionType.toHealthConnectMindfulnessSessionType(),
        title = title,
        notes = notes,
        metadata = metadata.toHealthConnect(id),
    )

// endregion
