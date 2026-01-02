package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.SpeedRecord
import androidx.health.connect.client.records.SpeedRecord.Sample
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.SpeedMeasurementDto
import com.phamtunglam.health_connector_hc_android.pigeon.SpeedSeriesRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [SpeedRecord] object to a [SpeedSeriesRecordDto].
 */
internal fun SpeedRecord.toDto(): SpeedSeriesRecordDto = SpeedSeriesRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    samples = samples.map { sample ->
        SpeedMeasurementDto(
            time = sample.time.toEpochMilli(),
            speed = sample.speed.toDto(),
        )
    },
)

/**
 * Converts a [SpeedSeriesRecordDto] to a Health Connect [SpeedRecord] object.
 */
internal fun SpeedSeriesRecordDto.toHealthConnect(): SpeedRecord = SpeedRecord(
    samples = samples.map { sample ->
        Sample(
            time = Instant.ofEpochMilli(sample.time),
            speed = sample.speed.toHealthConnect(),
        )
    },
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
