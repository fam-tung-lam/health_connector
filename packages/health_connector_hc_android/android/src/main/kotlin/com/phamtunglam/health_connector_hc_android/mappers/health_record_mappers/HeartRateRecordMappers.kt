package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.HeartRateRecord.Sample
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toNumberDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateMeasurementDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateSeriesRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [HeartRateRecord] object to a [HeartRateSeriesRecordDto].
 */
internal fun HeartRateRecord.toDto(): HeartRateSeriesRecordDto = HeartRateSeriesRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    samples = samples.map { sample ->
        HeartRateMeasurementDto(
            time = sample.time.toEpochMilli(),
            beatsPerMinute = sample.beatsPerMinute.toNumberDto(),
        )
    },
)

/**
 * Converts a [HeartRateSeriesRecordDto] to a Health Connect [HeartRateRecord] object.
 */
internal fun HeartRateSeriesRecordDto.toHealthConnect(): HeartRateRecord = HeartRateRecord(
    samples = samples.map { sample ->
        Sample(
            time = Instant.ofEpochMilli(sample.time),
            beatsPerMinute = sample.beatsPerMinute.value.toLong(),
        )
    },
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
