package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.SexualActivityRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.SexualActivityProtectionUsedDto
import com.phamtunglam.health_connector_hc_android.pigeon.SexualActivityRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [SexualActivityRecord] object to a [SexualActivityRecordDto].
 */
internal fun SexualActivityRecord.toDto(): SexualActivityRecordDto = SexualActivityRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    protectionUsed = protectionUsed.toSexualActivityProtectionUsedDto(),
)

/**
 * Converts a [SexualActivityRecordDto] to a Health Connect [SexualActivityRecord] object.
 */
internal fun SexualActivityRecordDto.toHealthConnect(): SexualActivityRecord = SexualActivityRecord(
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    protectionUsed = protectionUsed.toHealthConnect(),
    metadata = metadata.toHealthConnect(id),
)

/**
 * Converts a Health Connect [SexualActivityRecord] protection used value to [SexualActivityProtectionUsedDto].
 */
internal fun Int.toSexualActivityProtectionUsedDto(): SexualActivityProtectionUsedDto =
    when (this) {
        SexualActivityRecord.PROTECTION_USED_PROTECTED ->
            SexualActivityProtectionUsedDto.PROTECTED
        SexualActivityRecord.PROTECTION_USED_UNPROTECTED ->
            SexualActivityProtectionUsedDto.UNPROTECTED
        SexualActivityRecord.PROTECTION_USED_UNKNOWN ->
            SexualActivityProtectionUsedDto.UNKNOWN
        else -> throw IllegalArgumentException("Unknown protection used value: $this")
    }

/**
 * Converts a [SexualActivityProtectionUsedDto] to a Health Connect protection used value.
 */
internal fun SexualActivityProtectionUsedDto.toHealthConnect(): Int = when (this) {
    SexualActivityProtectionUsedDto.PROTECTED ->
        SexualActivityRecord.PROTECTION_USED_PROTECTED
    SexualActivityProtectionUsedDto.UNPROTECTED ->
        SexualActivityRecord.PROTECTION_USED_UNPROTECTED
    SexualActivityProtectionUsedDto.UNKNOWN ->
        SexualActivityRecord.PROTECTION_USED_UNKNOWN
}
