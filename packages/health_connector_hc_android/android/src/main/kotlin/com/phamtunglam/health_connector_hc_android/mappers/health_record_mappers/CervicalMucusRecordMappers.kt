package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.CervicalMucusRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusAppearanceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusSensationTypeDto
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
    appearance = appearance.toCervicalMucusAppearanceTypeDto(),
    sensation = sensation.toCervicalMucusSensationTypeDto(),
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
 * [CervicalMucusAppearanceTypeDto].
 */
internal fun Int.toCervicalMucusAppearanceTypeDto(): CervicalMucusAppearanceTypeDto = when (this) {
    CervicalMucusRecord.APPEARANCE_DRY ->
        CervicalMucusAppearanceTypeDto.DRY
    CervicalMucusRecord.APPEARANCE_STICKY ->
        CervicalMucusAppearanceTypeDto.STICKY
    CervicalMucusRecord.APPEARANCE_CREAMY ->
        CervicalMucusAppearanceTypeDto.CREAMY
    CervicalMucusRecord.APPEARANCE_WATERY ->
        CervicalMucusAppearanceTypeDto.WATERY
    CervicalMucusRecord.APPEARANCE_EGG_WHITE ->
        CervicalMucusAppearanceTypeDto.EGG_WHITE
    CervicalMucusRecord.APPEARANCE_UNUSUAL ->
        CervicalMucusAppearanceTypeDto.UNUSUAL
    CervicalMucusRecord.APPEARANCE_UNKNOWN ->
        CervicalMucusAppearanceTypeDto.UNKNOWN
    else -> throw IllegalArgumentException("Unknown appearance value: $this")
}

/**
 * Converts a [CervicalMucusAppearanceTypeDto] to a Health Connect appearance value.
 */
internal fun CervicalMucusAppearanceTypeDto.toHealthConnect(): Int = when (this) {
    CervicalMucusAppearanceTypeDto.DRY ->
        CervicalMucusRecord.APPEARANCE_DRY
    CervicalMucusAppearanceTypeDto.STICKY ->
        CervicalMucusRecord.APPEARANCE_STICKY
    CervicalMucusAppearanceTypeDto.CREAMY ->
        CervicalMucusRecord.APPEARANCE_CREAMY
    CervicalMucusAppearanceTypeDto.WATERY ->
        CervicalMucusRecord.APPEARANCE_WATERY
    CervicalMucusAppearanceTypeDto.EGG_WHITE ->
        CervicalMucusRecord.APPEARANCE_EGG_WHITE
    CervicalMucusAppearanceTypeDto.UNUSUAL ->
        CervicalMucusRecord.APPEARANCE_UNUSUAL
    CervicalMucusAppearanceTypeDto.UNKNOWN ->
        CervicalMucusRecord.APPEARANCE_UNKNOWN
}

/**
 * Converts a Health Connect [CervicalMucusRecord] sensation value to
 * [CervicalMucusSensationTypeDto].
 */
internal fun Int.toCervicalMucusSensationTypeDto(): CervicalMucusSensationTypeDto = when (this) {
    CervicalMucusRecord.SENSATION_LIGHT ->
        CervicalMucusSensationTypeDto.LIGHT
    CervicalMucusRecord.SENSATION_MEDIUM ->
        CervicalMucusSensationTypeDto.MEDIUM
    CervicalMucusRecord.SENSATION_HEAVY ->
        CervicalMucusSensationTypeDto.HEAVY
    CervicalMucusRecord.SENSATION_UNKNOWN ->
        CervicalMucusSensationTypeDto.UNKNOWN
    else -> throw IllegalArgumentException("Unknown sensation value: $this")
}

/**
 * Converts a [CervicalMucusSensationTypeDto] to a Health Connect sensation value.
 */
internal fun CervicalMucusSensationTypeDto.toHealthConnect(): Int = when (this) {
    CervicalMucusSensationTypeDto.LIGHT ->
        CervicalMucusRecord.SENSATION_LIGHT
    CervicalMucusSensationTypeDto.MEDIUM ->
        CervicalMucusRecord.SENSATION_MEDIUM
    CervicalMucusSensationTypeDto.HEAVY ->
        CervicalMucusRecord.SENSATION_HEAVY
    CervicalMucusSensationTypeDto.UNKNOWN ->
        CervicalMucusRecord.SENSATION_UNKNOWN
}
