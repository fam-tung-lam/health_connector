package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.RestingHeartRateRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.RestingHeartRateRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [RestingHeartRateRecord] to a [RestingHeartRateRecordDto].
 */
internal fun RestingHeartRateRecord.toDto(): RestingHeartRateRecordDto = RestingHeartRateRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    beatsPerMinute = beatsPerMinute.toDouble(),
)

/**
 * Converts a [RestingHeartRateRecordDto] to a Health Connect [RestingHeartRateRecord].
 */
internal fun RestingHeartRateRecordDto.toHealthConnect(): RestingHeartRateRecord =
    RestingHeartRateRecord(
        beatsPerMinute = beatsPerMinute.toLong(),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
