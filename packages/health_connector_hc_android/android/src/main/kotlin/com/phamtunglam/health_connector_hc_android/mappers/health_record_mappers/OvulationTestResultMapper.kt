package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.OvulationTestRecord
import com.phamtunglam.health_connector_hc_android.pigeon.OvulationTestResultDto

/**
 * Converts a Health Connect ovulation test result value to [OvulationTestResultDto].
 */
internal fun Int.toOvulationTestResultDto(): OvulationTestResultDto = when (this) {
    OvulationTestRecord.RESULT_NEGATIVE ->
        OvulationTestResultDto.NEGATIVE
    OvulationTestRecord.RESULT_INCONCLUSIVE ->
        OvulationTestResultDto.INCONCLUSIVE
    OvulationTestRecord.RESULT_HIGH ->
        OvulationTestResultDto.HIGH
    OvulationTestRecord.RESULT_POSITIVE ->
        OvulationTestResultDto.POSITIVE
    else -> throw IllegalArgumentException("Unknown ovulation test result value: $this")
}

/**
 * Converts a [OvulationTestResultDto] to a Health Connect ovulation test result value.
 */
internal fun OvulationTestResultDto.toHealthConnect(): Int = when (this) {
    OvulationTestResultDto.NEGATIVE ->
        OvulationTestRecord.RESULT_NEGATIVE
    OvulationTestResultDto.INCONCLUSIVE ->
        OvulationTestRecord.RESULT_INCONCLUSIVE
    OvulationTestResultDto.HIGH ->
        OvulationTestRecord.RESULT_HIGH
    OvulationTestResultDto.POSITIVE ->
        OvulationTestRecord.RESULT_POSITIVE
}
