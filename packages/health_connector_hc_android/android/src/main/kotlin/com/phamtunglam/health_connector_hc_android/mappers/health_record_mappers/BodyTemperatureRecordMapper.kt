package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.units.Temperature
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BodyTemperatureRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [BodyTemperatureRecord] object to a [BodyTemperatureRecordDto].
 */
internal fun BodyTemperatureRecord.toDto(): BodyTemperatureRecordDto = BodyTemperatureRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    celsius = temperature.inCelsius,
)

/**
 * Converts a [BodyTemperatureRecordDto] to a Health Connect [BodyTemperatureRecord] object.
 */
internal fun BodyTemperatureRecordDto.toHealthConnect(): BodyTemperatureRecord =
    BodyTemperatureRecord(
        temperature = Temperature.celsius(celsius),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
