package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.Vo2MaxRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.NumberDto
import com.phamtunglam.health_connector_hc_android.pigeon.Vo2MaxMeasurementMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.Vo2MaxRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [Vo2MaxRecord] to a [Vo2MaxRecordDto].
 */
internal fun Vo2MaxRecord.toDto(): Vo2MaxRecordDto = Vo2MaxRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    mLPerKgPerMin = NumberDto(
        value = vo2MillilitersPerMinuteKilogram,
    ),
    measurementMethod = measurementMethod.toVo2MaxMeasurementMethodDto(),
)

/**
 * Converts a [Vo2MaxRecordDto] to a Health Connect [Vo2MaxRecord].
 */
internal fun Vo2MaxRecordDto.toHealthConnect(): Vo2MaxRecord = Vo2MaxRecord(
    vo2MillilitersPerMinuteKilogram = mLPerKgPerMin.value,
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
    measurementMethod = measurementMethod.toVo2MaxMeasurementMethodInt(),
)

private fun Int.toVo2MaxMeasurementMethodDto(): Vo2MaxMeasurementMethodDto? = when (this) {
    Vo2MaxRecord.MEASUREMENT_METHOD_METABOLIC_CART -> Vo2MaxMeasurementMethodDto.METABOLIC_CART
    Vo2MaxRecord.MEASUREMENT_METHOD_HEART_RATE_RATIO -> Vo2MaxMeasurementMethodDto.HEART_RATE_RATIO
    Vo2MaxRecord.MEASUREMENT_METHOD_COOPER_TEST -> Vo2MaxMeasurementMethodDto.COOPER_TEST
    Vo2MaxRecord.MEASUREMENT_METHOD_MULTISTAGE_FITNESS_TEST ->
        Vo2MaxMeasurementMethodDto.MULTISTAGE_FITNESS_TEST

    Vo2MaxRecord.MEASUREMENT_METHOD_ROCKPORT_FITNESS_TEST ->
        Vo2MaxMeasurementMethodDto.ROCKPORT_FITNESS_TEST

    Vo2MaxRecord.MEASUREMENT_METHOD_OTHER -> Vo2MaxMeasurementMethodDto.OTHER
    else -> null
}

private fun Vo2MaxMeasurementMethodDto?.toVo2MaxMeasurementMethodInt(): Int = when (this) {
    Vo2MaxMeasurementMethodDto.METABOLIC_CART -> Vo2MaxRecord.MEASUREMENT_METHOD_METABOLIC_CART
    Vo2MaxMeasurementMethodDto.HEART_RATE_RATIO -> Vo2MaxRecord.MEASUREMENT_METHOD_HEART_RATE_RATIO
    Vo2MaxMeasurementMethodDto.COOPER_TEST -> Vo2MaxRecord.MEASUREMENT_METHOD_COOPER_TEST
    Vo2MaxMeasurementMethodDto.MULTISTAGE_FITNESS_TEST ->
        Vo2MaxRecord.MEASUREMENT_METHOD_MULTISTAGE_FITNESS_TEST

    Vo2MaxMeasurementMethodDto.ROCKPORT_FITNESS_TEST ->
        Vo2MaxRecord.MEASUREMENT_METHOD_ROCKPORT_FITNESS_TEST

    Vo2MaxMeasurementMethodDto.OTHER -> Vo2MaxRecord.MEASUREMENT_METHOD_OTHER
    null -> Vo2MaxRecord.MEASUREMENT_METHOD_OTHER
}
