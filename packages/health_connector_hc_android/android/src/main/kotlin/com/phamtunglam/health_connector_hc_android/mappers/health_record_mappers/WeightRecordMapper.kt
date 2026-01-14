package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.WeightRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [WeightRecord] object to a [WeightRecordDto].
 */
internal fun WeightRecord.toDto(): WeightRecordDto = WeightRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    kilograms = weight.inKilograms,
)

/**
 * Converts a [WeightRecordDto] to a Health Connect [WeightRecord] object.
 */
internal fun WeightRecordDto.toHealthConnect(): WeightRecord = WeightRecord(
    weight = Mass.kilograms(kilograms),
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
