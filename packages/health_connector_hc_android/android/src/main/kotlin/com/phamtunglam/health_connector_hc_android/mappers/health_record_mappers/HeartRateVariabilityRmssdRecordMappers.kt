package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.HeartRateVariabilityRmssdRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateVariabilityRMSSDRecordDto
import java.time.Instant
import java.time.ZoneOffset

internal fun HeartRateVariabilityRmssdRecord.toDto(): HeartRateVariabilityRMSSDRecordDto =
    HeartRateVariabilityRMSSDRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        heartRateVariabilityMillis = heartRateVariabilityMillis,
    )

internal fun HeartRateVariabilityRMSSDRecordDto.toHealthConnect(): HeartRateVariabilityRmssdRecord =
    HeartRateVariabilityRmssdRecord(
        heartRateVariabilityMillis = heartRateVariabilityMillis,
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
