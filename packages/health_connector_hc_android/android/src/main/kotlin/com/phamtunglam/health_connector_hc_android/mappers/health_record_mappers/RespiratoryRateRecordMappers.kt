package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.RespiratoryRateRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.RespiratoryRateRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [RespiratoryRateRecord] to a [RespiratoryRateRecordDto].
 */
internal fun RespiratoryRateRecord.toDto(): RespiratoryRateRecordDto = RespiratoryRateRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    rate = rate.toNumericDto(),
)

/**
 * Converts a [RespiratoryRateRecordDto] to a Health Connect [RespiratoryRateRecord].
 */
internal fun RespiratoryRateRecordDto.toHealthConnect(): RespiratoryRateRecord =
    RespiratoryRateRecord(
        rate = rate.value,
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(),
    )
