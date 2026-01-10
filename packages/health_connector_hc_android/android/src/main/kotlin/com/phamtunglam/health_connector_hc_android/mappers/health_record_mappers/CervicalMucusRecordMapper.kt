package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.CervicalMucusRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusAppearanceDto
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusSensationDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [CervicalMucusRecord] to [CervicalMucusRecordDto].
 */
internal fun CervicalMucusRecord.toDto(): CervicalMucusRecordDto = CervicalMucusRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    appearance = appearance.toCervicalMucusAppearanceDto(),
    sensation = sensation.toCervicalMucusSensationDto(),
)

/**
 * Converts a [CervicalMucusRecordDto] to a Health Connect [CervicalMucusRecord].
 */
internal fun CervicalMucusRecordDto.toHealthConnect(): CervicalMucusRecord = CervicalMucusRecord(
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    appearance = appearance.toHealthConnect(),
    sensation = sensation.toHealthConnect(),
    metadata = metadata.toHealthConnect(id),
)

/**
 * Converts a Health Connect [CervicalMucusRecord] appearance value to
 * [CervicalMucusAppearanceDto].
 */
internal fun Int.toCervicalMucusAppearanceDto(): CervicalMucusAppearanceDto = when (this) {
    CervicalMucusRecord.APPEARANCE_DRY ->
        CervicalMucusAppearanceDto.DRY
    CervicalMucusRecord.APPEARANCE_STICKY ->
        CervicalMucusAppearanceDto.STICKY
    CervicalMucusRecord.APPEARANCE_CREAMY ->
        CervicalMucusAppearanceDto.CREAMY
    CervicalMucusRecord.APPEARANCE_WATERY ->
        CervicalMucusAppearanceDto.WATERY
    CervicalMucusRecord.APPEARANCE_EGG_WHITE ->
        CervicalMucusAppearanceDto.EGG_WHITE
    CervicalMucusRecord.APPEARANCE_UNUSUAL ->
        CervicalMucusAppearanceDto.UNUSUAL
    CervicalMucusRecord.APPEARANCE_UNKNOWN ->
        CervicalMucusAppearanceDto.UNKNOWN
    else -> throw IllegalArgumentException("Unknown appearance value: $this")
}

/**
 * Converts a [CervicalMucusAppearanceDto] to a Health Connect appearance value.
 */
internal fun CervicalMucusAppearanceDto.toHealthConnect(): Int = when (this) {
    CervicalMucusAppearanceDto.DRY ->
        CervicalMucusRecord.APPEARANCE_DRY
    CervicalMucusAppearanceDto.STICKY ->
        CervicalMucusRecord.APPEARANCE_STICKY
    CervicalMucusAppearanceDto.CREAMY ->
        CervicalMucusRecord.APPEARANCE_CREAMY
    CervicalMucusAppearanceDto.WATERY ->
        CervicalMucusRecord.APPEARANCE_WATERY
    CervicalMucusAppearanceDto.EGG_WHITE ->
        CervicalMucusRecord.APPEARANCE_EGG_WHITE
    CervicalMucusAppearanceDto.UNUSUAL ->
        CervicalMucusRecord.APPEARANCE_UNUSUAL
    CervicalMucusAppearanceDto.UNKNOWN ->
        CervicalMucusRecord.APPEARANCE_UNKNOWN
}

/**
 * Converts a Health Connect [CervicalMucusRecord] sensation value to
 * [CervicalMucusSensationDto].
 */
internal fun Int.toCervicalMucusSensationDto(): CervicalMucusSensationDto = when (this) {
    CervicalMucusRecord.SENSATION_LIGHT ->
        CervicalMucusSensationDto.LIGHT
    CervicalMucusRecord.SENSATION_MEDIUM ->
        CervicalMucusSensationDto.MEDIUM
    CervicalMucusRecord.SENSATION_HEAVY ->
        CervicalMucusSensationDto.HEAVY
    CervicalMucusRecord.SENSATION_UNKNOWN ->
        CervicalMucusSensationDto.UNKNOWN
    else -> throw IllegalArgumentException("Unknown sensation value: $this")
}

/**
 * Converts a [CervicalMucusSensationDto] to a Health Connect sensation value.
 */
internal fun CervicalMucusSensationDto.toHealthConnect(): Int = when (this) {
    CervicalMucusSensationDto.LIGHT ->
        CervicalMucusRecord.SENSATION_LIGHT
    CervicalMucusSensationDto.MEDIUM ->
        CervicalMucusRecord.SENSATION_MEDIUM
    CervicalMucusSensationDto.HEAVY ->
        CervicalMucusRecord.SENSATION_HEAVY
    CervicalMucusSensationDto.UNKNOWN ->
        CervicalMucusRecord.SENSATION_UNKNOWN
}
