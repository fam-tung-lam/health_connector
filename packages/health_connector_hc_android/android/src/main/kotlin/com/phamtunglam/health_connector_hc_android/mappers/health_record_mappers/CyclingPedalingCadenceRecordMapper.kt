package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.CyclingPedalingCadenceRecord
import androidx.health.connect.client.records.CyclingPedalingCadenceRecord.Sample
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.CyclingPedalingCadenceSampleDto
import com.phamtunglam.health_connector_hc_android.pigeon.CyclingPedalingCadenceSeriesRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [CyclingPedalingCadenceRecord] object to a [CyclingPedalingCadenceSeriesRecordDto].
 */
internal fun CyclingPedalingCadenceRecord.toDto(): CyclingPedalingCadenceSeriesRecordDto =
    CyclingPedalingCadenceSeriesRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        samples = samples.map { sample ->
            CyclingPedalingCadenceSampleDto(
                time = sample.time.toEpochMilli(),
                revolutionsPerMinute = sample.revolutionsPerMinute,
            )
        },
    )

/**
 * Converts a [CyclingPedalingCadenceSeriesRecordDto] to a Health Connect [CyclingPedalingCadenceRecord] object.
 */
internal fun CyclingPedalingCadenceSeriesRecordDto.toHealthConnect(): CyclingPedalingCadenceRecord =
    CyclingPedalingCadenceRecord(
        samples = samples.map { sample ->
            Sample(
                time = Instant.ofEpochMilli(sample.time),
                revolutionsPerMinute = sample.revolutionsPerMinute,
            )
        },
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
