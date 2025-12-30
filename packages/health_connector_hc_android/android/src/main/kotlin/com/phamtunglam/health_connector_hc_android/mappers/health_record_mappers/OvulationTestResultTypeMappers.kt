package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.OvulationTestRecord
import com.phamtunglam.health_connector_hc_android.pigeon.OvulationTestResultTypeDto

/**
 * Converts a Health Connect ovulation test result value to [OvulationTestResultTypeDto].
 */
internal fun Int.toOvulationTestResultTypeDto(): OvulationTestResultTypeDto = when (this) {
    OvulationTestRecord.RESULT_NEGATIVE ->
        OvulationTestResultTypeDto.NEGATIVE
    OvulationTestRecord.RESULT_INCONCLUSIVE ->
        OvulationTestResultTypeDto.INCONCLUSIVE
    OvulationTestRecord.RESULT_HIGH ->
        OvulationTestResultTypeDto.HIGH
    OvulationTestRecord.RESULT_POSITIVE ->
        OvulationTestResultTypeDto.POSITIVE
    else -> throw IllegalArgumentException("Unknown ovulation test result value: $this")
}

/**
 * Converts a [OvulationTestResultTypeDto] to a Health Connect ovulation test result value.
 */
internal fun OvulationTestResultTypeDto.toHealthConnect(): Int = when (this) {
    OvulationTestResultTypeDto.NEGATIVE ->
        OvulationTestRecord.RESULT_NEGATIVE
    OvulationTestResultTypeDto.INCONCLUSIVE ->
        OvulationTestRecord.RESULT_INCONCLUSIVE
    OvulationTestResultTypeDto.HIGH ->
        OvulationTestRecord.RESULT_HIGH
    OvulationTestResultTypeDto.POSITIVE ->
        OvulationTestRecord.RESULT_POSITIVE
}
