package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.PowerRecord
import androidx.health.connect.client.records.PowerRecord.Sample
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.PowerMeasurementDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerSeriesRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [PowerRecord] object to a [PowerSeriesRecordDto].
 */
internal fun PowerRecord.toDto(): PowerSeriesRecordDto = PowerSeriesRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    samples = samples.map { sample ->
        PowerMeasurementDto(
            time = sample.time.toEpochMilli(),
            power = sample.power.toDto(),
        )
    },
)

/**
 * Converts a [PowerSeriesRecordDto] to a Health Connect [PowerRecord] object.
 */
internal fun PowerSeriesRecordDto.toHealthConnect(): PowerRecord = PowerRecord(
    samples = samples.map { sample ->
        Sample(
            time = Instant.ofEpochMilli(sample.time),
            power = sample.power.toHealthConnect(),
        )
    },
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
