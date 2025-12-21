package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.BodyFatRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [BodyFatRecord] object to a [BodyFatPercentageRecordDto].
 */
internal fun BodyFatRecord.toDto(): BodyFatPercentageRecordDto = BodyFatPercentageRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    percentage = percentage.toDto(),
)

/**
 * Converts a [BodyFatPercentageRecordDto] to a Health Connect [BodyFatRecord] object.
 */
internal fun BodyFatPercentageRecordDto.toHealthConnect(): BodyFatRecord = BodyFatRecord(
    percentage = percentage.toHealthConnect(),
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
