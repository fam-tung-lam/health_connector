package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HeightRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [HeightRecord] object to a [HeightRecordDto].
 */
internal fun HeightRecord.toDto(): HeightRecordDto = HeightRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    meters = height.inMeters,
)

/**
 * Converts a [HeightRecordDto] to a Health Connect [HeightRecord] object.
 */
internal fun HeightRecordDto.toHealthConnect(): HeightRecord = HeightRecord(
    height = Length.meters(meters),
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
