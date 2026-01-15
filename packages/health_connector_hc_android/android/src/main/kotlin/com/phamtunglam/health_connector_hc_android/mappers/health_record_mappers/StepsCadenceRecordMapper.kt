package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.StepsCadenceRecord
import androidx.health.connect.client.records.StepsCadenceRecord.Sample
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.StepsCadenceSampleDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepsCadenceSeriesRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Maps [StepsCadenceRecord] to [StepsCadenceSeriesRecordDto] and vice versa.
 */
internal fun StepsCadenceRecord.toDto(): StepsCadenceSeriesRecordDto = StepsCadenceSeriesRecordDto(
    id = metadata.id,
    startTime = startTime.toEpochMilli(),
    endTime = endTime.toEpochMilli(),
    startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
    endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    samples = samples.map { sample ->
        StepsCadenceSampleDto(
            time = sample.time.toEpochMilli(),
            stepsPerMinute = sample.rate,
        )
    },
)

/**
 * Maps [StepsCadenceSeriesRecordDto] to [StepsCadenceRecord].
 */
internal fun StepsCadenceSeriesRecordDto.toHealthConnect(): StepsCadenceRecord = StepsCadenceRecord(
    samples = samples.mapNotNull { it?.toHealthConnect() },
    startTime = Instant.ofEpochMilli(startTime),
    endTime = Instant.ofEpochMilli(endTime),
    startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)

/**
 * Maps [StepsCadenceSampleDto] to [StepsCadenceRecord.Sample].
 */
internal fun StepsCadenceSampleDto.toHealthConnect(): Sample = Sample(
    time = Instant.ofEpochMilli(time),
    rate = stepsPerMinute,
)
