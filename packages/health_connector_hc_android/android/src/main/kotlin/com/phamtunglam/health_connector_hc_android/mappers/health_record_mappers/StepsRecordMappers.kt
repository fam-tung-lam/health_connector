package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.StepsRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toLong
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [StepsRecord] object to a [StepRecordDto].
 */
internal fun StepsRecord.toDto(): StepRecordDto = StepRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    count = count.toNumericDto(),
)

/**
 * Converts a [StepRecordDto] to a Health Connect [StepsRecord] object.
 */
internal fun StepRecordDto.toHealthConnect(): StepsRecord = StepsRecord(
    count = count.toLong(),
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(),
)
