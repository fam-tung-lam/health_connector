package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.OxygenSaturationRecord
import androidx.health.connect.client.units.Percentage
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.OxygenSaturationRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [OxygenSaturationRecord] to a [OxygenSaturationRecordDto].
 */
internal fun OxygenSaturationRecord.toDto(): OxygenSaturationRecordDto = OxygenSaturationRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    percentage = percentage.value,
)

/**
 * Converts a [OxygenSaturationRecordDto] to a Health Connect [OxygenSaturationRecord].
 */
internal fun OxygenSaturationRecordDto.toHealthConnect(): OxygenSaturationRecord =
    OxygenSaturationRecord(
        percentage = Percentage(percentage),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
