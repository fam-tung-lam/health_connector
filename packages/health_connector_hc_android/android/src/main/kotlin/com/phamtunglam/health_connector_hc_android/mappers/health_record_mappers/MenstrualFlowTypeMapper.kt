package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.MenstruationFlowRecord
import com.phamtunglam.health_connector_hc_android.pigeon.MenstrualFlowTypeDto

/**
 * Converts a Health Connect menstrual flow value to [MenstrualFlowTypeDto].
 */
internal fun Int.toMenstrualFlowTypeDto(): MenstrualFlowTypeDto = when (this) {
    MenstruationFlowRecord.FLOW_UNKNOWN ->
        MenstrualFlowTypeDto.UNKNOWN
    MenstruationFlowRecord.FLOW_LIGHT ->
        MenstrualFlowTypeDto.LIGHT
    MenstruationFlowRecord.FLOW_MEDIUM ->
        MenstrualFlowTypeDto.MEDIUM
    MenstruationFlowRecord.FLOW_HEAVY ->
        MenstrualFlowTypeDto.HEAVY
    else -> throw IllegalArgumentException("Unknown menstrual flow value: $this")
}

/**
 * Converts a [MenstrualFlowTypeDto] to a Health Connect menstrual flow value.
 */
internal fun MenstrualFlowTypeDto.toHealthConnect(): Int = when (this) {
    MenstrualFlowTypeDto.UNKNOWN ->
        MenstruationFlowRecord.FLOW_UNKNOWN
    MenstrualFlowTypeDto.LIGHT ->
        MenstruationFlowRecord.FLOW_LIGHT
    MenstrualFlowTypeDto.MEDIUM ->
        MenstruationFlowRecord.FLOW_MEDIUM
    MenstrualFlowTypeDto.HEAVY ->
        MenstruationFlowRecord.FLOW_HEAVY
}
