package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.MenstruationFlowRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.MenstrualFlowInstantRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [MenstruationFlowRecord] object to a [MenstrualFlowInstantRecordDto].
 */
internal fun MenstruationFlowRecord.toDto(): MenstrualFlowInstantRecordDto =
    MenstrualFlowInstantRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        flow = flow.toMenstrualFlowDto(),
    )

/**
 * Converts a [MenstrualFlowInstantRecordDto] to a Health Connect [MenstruationFlowRecord] object.
 */
internal fun MenstrualFlowInstantRecordDto.toHealthConnect(): MenstruationFlowRecord =
    MenstruationFlowRecord(
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        flow = flow.toHealthConnect(),
        metadata = metadata.toHealthConnect(id),
    )
