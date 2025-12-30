package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.BasalBodyTemperatureRecord
import androidx.health.connect.client.records.BodyTemperatureMeasurementLocation
import androidx.health.connect.client.units.Temperature
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toTemperatureDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BasalBodyTemperatureMeasurementLocationDto
import com.phamtunglam.health_connector_hc_android.pigeon.BasalBodyTemperatureRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [BasalBodyTemperatureRecord] object to a [BasalBodyTemperatureRecordDto].
 */
internal fun BasalBodyTemperatureRecord.toDto(): BasalBodyTemperatureRecordDto =
    BasalBodyTemperatureRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        temperature = temperature.inCelsius.toTemperatureDto(),
        measurementLocation = measurementLocation.toBasalBodyTemperatureMeasurementLocationDto(),
    )

/**
 * Converts a [BasalBodyTemperatureRecordDto] to a Health Connect [BasalBodyTemperatureRecord] object.
 */
internal fun BasalBodyTemperatureRecordDto.toHealthConnect(): BasalBodyTemperatureRecord =
    BasalBodyTemperatureRecord(
        temperature = Temperature.celsius(temperature.value),
        measurementLocation = measurementLocation.toHealthConnect(),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )

/**
 * Converts a Health Connect [BasalBodyTemperatureRecord] measurement location to a
 * [BasalBodyTemperatureMeasurementLocationDto].
 */
internal fun Int.toBasalBodyTemperatureMeasurementLocationDto():
    BasalBodyTemperatureMeasurementLocationDto =
    when (this) {
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_ARMPIT ->
            BasalBodyTemperatureMeasurementLocationDto.ARMPIT

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_EAR ->
            BasalBodyTemperatureMeasurementLocationDto.EAR

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_FINGER ->
            BasalBodyTemperatureMeasurementLocationDto.FINGER

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_FOREHEAD ->
            BasalBodyTemperatureMeasurementLocationDto.FOREHEAD

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_MOUTH ->
            BasalBodyTemperatureMeasurementLocationDto.MOUTH

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_RECTUM ->
            BasalBodyTemperatureMeasurementLocationDto.RECTUM

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_TEMPORAL_ARTERY ->
            BasalBodyTemperatureMeasurementLocationDto.TEMPORAL_ARTERY

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_TOE ->
            BasalBodyTemperatureMeasurementLocationDto.TOE

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_VAGINA ->
            BasalBodyTemperatureMeasurementLocationDto.VAGINA

        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_WRIST ->
            BasalBodyTemperatureMeasurementLocationDto.WRIST

        else -> BasalBodyTemperatureMeasurementLocationDto.UNKNOWN
    }

/**
 * Converts a [BasalBodyTemperatureMeasurementLocationDto] to a Health Connect
 * [BasalBodyTemperatureRecord] measurement location.
 */
internal fun BasalBodyTemperatureMeasurementLocationDto.toHealthConnect(): Int = when (this) {
    BasalBodyTemperatureMeasurementLocationDto.UNKNOWN ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_UNKNOWN

    BasalBodyTemperatureMeasurementLocationDto.ARMPIT ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_ARMPIT

    BasalBodyTemperatureMeasurementLocationDto.EAR ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_EAR

    BasalBodyTemperatureMeasurementLocationDto.FINGER ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_FINGER

    BasalBodyTemperatureMeasurementLocationDto.FOREHEAD ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_FOREHEAD

    BasalBodyTemperatureMeasurementLocationDto.MOUTH ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_MOUTH

    BasalBodyTemperatureMeasurementLocationDto.RECTUM ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_RECTUM

    BasalBodyTemperatureMeasurementLocationDto.TEMPORAL_ARTERY ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_TEMPORAL_ARTERY

    BasalBodyTemperatureMeasurementLocationDto.TOE ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_TOE

    BasalBodyTemperatureMeasurementLocationDto.VAGINA ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_VAGINA

    BasalBodyTemperatureMeasurementLocationDto.WRIST ->
        BodyTemperatureMeasurementLocation.MEASUREMENT_LOCATION_WRIST
}
