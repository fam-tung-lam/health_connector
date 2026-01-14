package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [HydrationRecord] object to a [HydrationRecordDto].
 */
internal fun HydrationRecord.toDto(): HydrationRecordDto = HydrationRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    liters = volume.inLiters,
)

/**
 * Converts a [HydrationRecordDto] to a Health Connect [HydrationRecord] object.
 */
internal fun HydrationRecordDto.toHealthConnect(): HydrationRecord = HydrationRecord(
    volume = Volume.liters(liters),
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
