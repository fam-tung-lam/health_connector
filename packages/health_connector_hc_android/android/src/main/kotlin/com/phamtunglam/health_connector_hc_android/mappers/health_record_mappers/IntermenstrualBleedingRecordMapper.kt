package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.IntermenstrualBleedingRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.IntermenstrualBleedingRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [IntermenstrualBleedingRecord] object to a [IntermenstrualBleedingRecordDto].
 */
internal fun IntermenstrualBleedingRecord.toDto(): IntermenstrualBleedingRecordDto =
    IntermenstrualBleedingRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
    )

/**
 * Converts a [IntermenstrualBleedingRecordDto] to a Health Connect [IntermenstrualBleedingRecord] object.
 */
internal fun IntermenstrualBleedingRecordDto.toHealthConnect(): IntermenstrualBleedingRecord =
    IntermenstrualBleedingRecord(
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
