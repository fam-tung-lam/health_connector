package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.MenstruationFlowRecord
import androidx.health.connect.client.records.MenstruationPeriodRecord
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.MenstrualFlowDto
import com.phamtunglam.health_connector_hc_android.pigeon.MenstruationFlowRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MenstruationPeriodRecordDto
import java.time.Instant
import java.time.ZoneOffset

internal fun MenstrualFlowDto.toHealthConnect(): Int = when (this) {
    MenstrualFlowDto.UNKNOWN -> MenstruationFlowRecord.FLOW_UNKNOWN
    MenstrualFlowDto.LIGHT -> MenstruationFlowRecord.FLOW_LIGHT
    MenstrualFlowDto.MEDIUM -> MenstruationFlowRecord.FLOW_MEDIUM
    MenstrualFlowDto.HEAVY -> MenstruationFlowRecord.FLOW_HEAVY
}

internal fun Int.toMenstrualFlowDto(): MenstrualFlowDto = when (this) {
    MenstruationFlowRecord.FLOW_UNKNOWN -> MenstrualFlowDto.UNKNOWN
    MenstruationFlowRecord.FLOW_LIGHT -> MenstrualFlowDto.LIGHT
    MenstruationFlowRecord.FLOW_MEDIUM -> MenstrualFlowDto.MEDIUM
    MenstruationFlowRecord.FLOW_HEAVY -> MenstrualFlowDto.HEAVY
    else -> MenstrualFlowDto.UNKNOWN
}

internal fun MenstruationFlowRecord.toDto(): MenstruationFlowRecordDto = MenstruationFlowRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    flow = flow.toMenstrualFlowDto(),
    metadata = metadata.toDto(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
)

internal fun MenstruationFlowRecordDto.toHealthConnect(): MenstruationFlowRecord =
    MenstruationFlowRecord(
        time = Instant.ofEpochMilli(time),
        flow = flow?.toHealthConnect() ?: MenstruationFlowRecord.FLOW_UNKNOWN,
        metadata = metadata?.toHealthConnect() ?: Metadata.manualEntry(),
        zoneOffset = zoneOffsetSeconds?.let {
            ZoneOffset.ofTotalSeconds(it.toInt())
        } ?: ZoneOffset.UTC,
    )

/**
 * Converts a Health Connect [MenstruationPeriodRecord] to a [MenstruationPeriodRecordDto].
 * Note: Samples are NOT populated here as they require a separate query.
 */
internal fun MenstruationPeriodRecord.toDto(): MenstruationPeriodRecordDto =
    MenstruationPeriodRecordDto(
        id = metadata.id,
        metadata = metadata.toDto(),
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        samples = emptyList(), // Samples must be populated by the Handler
    )

/**
 * Converts a [MenstruationPeriodRecordDto] to a Health Connect [MenstruationPeriodRecord].
 * Note: Samples are ignored as they are stored as separate records.
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
        metadata = metadata.toHealthConnect(),
    )
