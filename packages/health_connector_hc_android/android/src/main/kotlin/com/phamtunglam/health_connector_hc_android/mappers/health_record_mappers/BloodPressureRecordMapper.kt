package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.BloodPressureRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyPositionDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementLocationDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a BodyPositionDto to the Health Connect BloodPressureRecord.BodyPosition.
 */
internal fun BodyPositionDto.toHealthConnect(): Int = when (this) {
    BodyPositionDto.UNKNOWN -> BloodPressureRecord.BODY_POSITION_UNKNOWN
    BodyPositionDto.STANDING_UP -> BloodPressureRecord.BODY_POSITION_STANDING_UP
    BodyPositionDto.SITTING_DOWN -> BloodPressureRecord.BODY_POSITION_SITTING_DOWN
    BodyPositionDto.LYING_DOWN -> BloodPressureRecord.BODY_POSITION_LYING_DOWN
    BodyPositionDto.RECLINING -> BloodPressureRecord.BODY_POSITION_RECLINING
}

/**
 * Converts Health Connect body position int to BodyPositionDto.
 */
internal fun Int.toBodyPositionDto(): BodyPositionDto = when (this) {
    BloodPressureRecord.BODY_POSITION_STANDING_UP -> BodyPositionDto.STANDING_UP
    BloodPressureRecord.BODY_POSITION_SITTING_DOWN -> BodyPositionDto.SITTING_DOWN
    BloodPressureRecord.BODY_POSITION_LYING_DOWN -> BodyPositionDto.LYING_DOWN
    BloodPressureRecord.BODY_POSITION_RECLINING -> BodyPositionDto.RECLINING
    else -> BodyPositionDto.UNKNOWN
}

/**
 * Converts a MeasurementLocationDto to the Health Connect BloodPressureRecord.MeasurementLocation.
 */
internal fun MeasurementLocationDto.toHealthConnect(): Int = when (this) {
    MeasurementLocationDto.UNKNOWN -> BloodPressureRecord.MEASUREMENT_LOCATION_UNKNOWN
    MeasurementLocationDto.LEFT_WRIST -> BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_WRIST
    MeasurementLocationDto.RIGHT_WRIST -> BloodPressureRecord.MEASUREMENT_LOCATION_RIGHT_WRIST
    MeasurementLocationDto.LEFT_UPPER_ARM ->
        BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_UPPER_ARM

    MeasurementLocationDto.RIGHT_UPPER_ARM ->
        BloodPressureRecord.MEASUREMENT_LOCATION_RIGHT_UPPER_ARM
}

/**
 * Converts Health Connect measurement location int to MeasurementLocationDto.
 */
internal fun Int.toMeasurementLocationDto(): MeasurementLocationDto = when (this) {
    BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_WRIST -> MeasurementLocationDto.LEFT_WRIST
    BloodPressureRecord.MEASUREMENT_LOCATION_RIGHT_WRIST -> MeasurementLocationDto.RIGHT_WRIST
    BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_UPPER_ARM ->
        MeasurementLocationDto.LEFT_UPPER_ARM

    BloodPressureRecord.MEASUREMENT_LOCATION_RIGHT_UPPER_ARM ->
        MeasurementLocationDto.RIGHT_UPPER_ARM

    else -> MeasurementLocationDto.UNKNOWN
}

/**
 * Converts a Health Connect [BloodPressureRecord] to a [BloodPressureRecordDto].
 */
internal fun BloodPressureRecord.toDto(): BloodPressureRecordDto = BloodPressureRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    systolic = systolic.toDto(),
    diastolic = diastolic.toDto(),
    bodyPosition = bodyPosition.toBodyPositionDto(),
    measurementLocation = measurementLocation.toMeasurementLocationDto(),
)

/**
 * Converts a [BloodPressureRecordDto] to a Health Connect [BloodPressureRecord].
 */
internal fun BloodPressureRecordDto.toHealthConnect(): BloodPressureRecord = BloodPressureRecord(
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    systolic = systolic.toHealthConnect(),
    diastolic = diastolic.toHealthConnect(),
    bodyPosition = bodyPosition.toHealthConnect(),
    measurementLocation = measurementLocation.toHealthConnect(),
    metadata = metadata.toHealthConnect(id),
)
