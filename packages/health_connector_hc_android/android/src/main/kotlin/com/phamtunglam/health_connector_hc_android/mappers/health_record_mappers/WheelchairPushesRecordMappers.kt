package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.WheelchairPushesRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toNumberDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.WheelchairPushesRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [WheelchairPushesRecord] object to a [WheelchairPushesRecordDto].
 */
internal fun WheelchairPushesRecord.toDto(): WheelchairPushesRecordDto = WheelchairPushesRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    pushes = count.toNumberDto(),
)

/**
 * Converts a [WheelchairPushesRecordDto] to a Health Connect [WheelchairPushesRecord] object.
 */
internal fun WheelchairPushesRecordDto.toHealthConnect(): WheelchairPushesRecord =
    WheelchairPushesRecord(
        count = pushes.value.toLong(),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
