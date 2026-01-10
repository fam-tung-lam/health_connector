package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.OvulationTestRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.OvulationTestRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [OvulationTestRecord] object to a [OvulationTestRecordDto].
 */
internal fun OvulationTestRecord.toDto(): OvulationTestRecordDto = OvulationTestRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    result = result.toOvulationTestResultDto(),
)

/**
 * Converts a [OvulationTestRecordDto] to a Health Connect [OvulationTestRecord] object.
 */
internal fun OvulationTestRecordDto.toHealthConnect(): OvulationTestRecord = OvulationTestRecord(
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    result = result.toHealthConnect(),
    metadata = metadata.toHealthConnect(id),
)
