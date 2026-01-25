package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.MenstruationPeriodRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.MenstruationPeriodRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [MenstruationPeriodRecord] to [MenstruationPeriodRecordDto].
 */
internal fun MenstruationPeriodRecord.toDto(): MenstruationPeriodRecordDto =
    MenstruationPeriodRecordDto(
        id = metadata.id,
        metadata = metadata.toDto(),
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
    )

/**
 * Converts [MenstruationPeriodRecordDto] to Health Connect [MenstruationPeriodRecord].
 */
internal fun MenstruationPeriodRecordDto.toHealthConnect(): MenstruationPeriodRecord =
    MenstruationPeriodRecord(
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
        endZoneOffset = endZoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
        metadata = metadata.toHealthConnect(id),
    )
