package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ElevationGainedRecord
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ElevationGainedRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [ElevationGainedRecord] object to a [ElevationGainedRecordDto].
 */
internal fun ElevationGainedRecord.toDto(): ElevationGainedRecordDto = ElevationGainedRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    meters = elevation.inMeters,
)

/**
 * Converts a [ElevationGainedRecordDto] to a Health Connect [ElevationGainedRecord] object.
 */
internal fun ElevationGainedRecordDto.toHealthConnect(): ElevationGainedRecord =
    ElevationGainedRecord(
        elevation = Length.meters(meters),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
