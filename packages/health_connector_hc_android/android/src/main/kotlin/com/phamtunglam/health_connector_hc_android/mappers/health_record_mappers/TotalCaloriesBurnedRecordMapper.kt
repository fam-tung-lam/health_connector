package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.TotalCaloriesBurnedRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.TotalCaloriesBurnedRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [TotalCaloriesBurnedRecord] object to a [TotalCaloriesBurnedRecordDto].
 */
internal fun TotalCaloriesBurnedRecord.toDto(): TotalCaloriesBurnedRecordDto =
    TotalCaloriesBurnedRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        energy = energy.toDto(),
    )

/**
 * Converts a [TotalCaloriesBurnedRecordDto] to a Health Connect [TotalCaloriesBurnedRecord] object.
 */
internal fun TotalCaloriesBurnedRecordDto.toHealthConnect(): TotalCaloriesBurnedRecord =
    TotalCaloriesBurnedRecord(
        energy = energy.toHealthConnect(),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
