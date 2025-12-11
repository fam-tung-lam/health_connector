package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.DistanceRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [DistanceRecord] object to a [DistanceRecordDto].
 */
internal fun DistanceRecord.toDto(): DistanceRecordDto = DistanceRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    distance = distance.toDto(),
)

/**
 * Converts a [DistanceRecordDto] to a Health Connect [DistanceRecord] object.
 */
internal fun DistanceRecordDto.toHealthConnect(): DistanceRecord = DistanceRecord(
    distance = distance.toHealthConnect(),
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(),
)
