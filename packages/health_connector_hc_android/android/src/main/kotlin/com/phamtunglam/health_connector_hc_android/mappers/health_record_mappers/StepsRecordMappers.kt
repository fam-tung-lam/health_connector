package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.StepsRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toNumberDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.StepsRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [StepsRecord] object to a [StepsRecordDto].
 */
internal fun StepsRecord.toDto(): StepsRecordDto = StepsRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    count = count.toNumberDto(),
)

/**
 * Converts a [StepsRecordDto] to a Health Connect [StepsRecord] object.
 */
internal fun StepsRecordDto.toHealthConnect(): StepsRecord = StepsRecord(
    count = count.value.toLong(),
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
