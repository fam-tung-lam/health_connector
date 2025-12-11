package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.FloorsClimbedRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.FloorsClimbedRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [FloorsClimbedRecord] object to a [FloorsClimbedRecordDto].
 */
internal fun FloorsClimbedRecord.toDto(): FloorsClimbedRecordDto = FloorsClimbedRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    floors = floors.toNumericDto(),
)

/**
 * Converts a [FloorsClimbedRecordDto] to a Health Connect [FloorsClimbedRecord] object.
 */
internal fun FloorsClimbedRecordDto.toHealthConnect(): FloorsClimbedRecord = FloorsClimbedRecord(
    floors = floors.value,
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(),
)
