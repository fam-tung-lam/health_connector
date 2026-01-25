package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.SkinTemperatureRecord
import androidx.health.connect.client.records.SkinTemperatureRecord.Delta
import androidx.health.connect.client.units.Temperature
import androidx.health.connect.client.units.TemperatureDelta
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.SkinTemperatureDeltaSampleDto
import com.phamtunglam.health_connector_hc_android.pigeon.SkinTemperatureDeltaSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SkinTemperatureMeasurementLocationDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts Health Connect skin temperature measurement location int to SkinTemperatureMeasurementLocationDto.
 */
internal fun Int.toSkinTemperatureMeasurementLocationDto(): SkinTemperatureMeasurementLocationDto =
    when (this) {
        SkinTemperatureRecord.MEASUREMENT_LOCATION_FINGER ->
            SkinTemperatureMeasurementLocationDto.FINGER
        SkinTemperatureRecord.MEASUREMENT_LOCATION_TOE ->
            SkinTemperatureMeasurementLocationDto.TOE
        SkinTemperatureRecord.MEASUREMENT_LOCATION_WRIST ->
            SkinTemperatureMeasurementLocationDto.WRIST
        else -> SkinTemperatureMeasurementLocationDto.UNKNOWN
    }

/**
 * Converts a [SkinTemperatureMeasurementLocationDto] to a Health Connect
 * [SkinTemperatureRecord] measurement location.
 */
internal fun SkinTemperatureMeasurementLocationDto.toHealthConnect(): Int = when (this) {
    SkinTemperatureMeasurementLocationDto.UNKNOWN ->
        SkinTemperatureRecord.MEASUREMENT_LOCATION_UNKNOWN
    SkinTemperatureMeasurementLocationDto.FINGER ->
        SkinTemperatureRecord.MEASUREMENT_LOCATION_FINGER
    SkinTemperatureMeasurementLocationDto.TOE ->
        SkinTemperatureRecord.MEASUREMENT_LOCATION_TOE
    SkinTemperatureMeasurementLocationDto.WRIST ->
        SkinTemperatureRecord.MEASUREMENT_LOCATION_WRIST
}

/**
 * Converts a Health Connect [SkinTemperatureRecord] to a [SkinTemperatureDeltaSeriesRecordDto].
 */
internal fun SkinTemperatureRecord.toDto(): SkinTemperatureDeltaSeriesRecordDto =
    SkinTemperatureDeltaSeriesRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        samples = deltas.map { delta ->
            SkinTemperatureDeltaSampleDto(
                time = delta.time.toEpochMilli(),
                temperatureDeltaCelsius = delta.delta.inCelsius,
            )
        },
        baselineCelsius = baseline?.inCelsius,
        measurementLocation = measurementLocation.toSkinTemperatureMeasurementLocationDto(),
    )

/**
 * Converts a [SkinTemperatureDeltaSeriesRecordDto] to a Health Connect [SkinTemperatureRecord] object.
 */
internal fun SkinTemperatureDeltaSeriesRecordDto.toHealthConnect(): SkinTemperatureRecord =
    SkinTemperatureRecord(
        deltas = samples.map { delta ->
            Delta(
                time = Instant.ofEpochMilli(delta.time),
                delta = TemperatureDelta.celsius(delta.temperatureDeltaCelsius),
            )
        },
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        baseline = baselineCelsius?.let { Temperature.celsius(it) },
        measurementLocation = measurementLocation?.toHealthConnect()
            ?: SkinTemperatureRecord.MEASUREMENT_LOCATION_UNKNOWN,
        metadata = metadata.toHealthConnect(id),
    )
