package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ActiveCaloriesBurnedRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [ActiveCaloriesBurnedRecord] object to an [ActiveCaloriesBurnedRecordDto].
 */
internal fun ActiveCaloriesBurnedRecord.toDto(): ActiveCaloriesBurnedRecordDto =
    ActiveCaloriesBurnedRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        energy = energy.toDto(),
    )

/**
 * Converts an [ActiveCaloriesBurnedRecordDto] to a Health Connect [ActiveCaloriesBurnedRecord] object.
 */
internal fun ActiveCaloriesBurnedRecordDto.toHealthConnect(): ActiveCaloriesBurnedRecord =
    ActiveCaloriesBurnedRecord(
        energy = energy.toHealthConnect(),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
