package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.MenstruationFlowRecord
import com.phamtunglam.health_connector_hc_android.pigeon.MenstrualFlowDto

/**
 * Converts a Health Connect menstrual flow value to [MenstrualFlowDto].
 */
internal fun Int.toMenstrualFlowDto(): MenstrualFlowDto = when (this) {
    MenstruationFlowRecord.FLOW_UNKNOWN ->
        MenstrualFlowDto.UNKNOWN
    MenstruationFlowRecord.FLOW_LIGHT ->
        MenstrualFlowDto.LIGHT
    MenstruationFlowRecord.FLOW_MEDIUM ->
        MenstrualFlowDto.MEDIUM
    MenstruationFlowRecord.FLOW_HEAVY ->
        MenstrualFlowDto.HEAVY
    else -> throw IllegalArgumentException("Unknown menstrual flow value: $this")
}

/**
 * Converts a [MenstrualFlowDto] to a Health Connect menstrual flow value.
 */
internal fun MenstrualFlowDto.toHealthConnect(): Int = when (this) {
    MenstrualFlowDto.UNKNOWN ->
        MenstruationFlowRecord.FLOW_UNKNOWN
    MenstrualFlowDto.LIGHT ->
        MenstruationFlowRecord.FLOW_LIGHT
    MenstrualFlowDto.MEDIUM ->
        MenstruationFlowRecord.FLOW_MEDIUM
    MenstrualFlowDto.HEAVY ->
        MenstruationFlowRecord.FLOW_HEAVY
}
