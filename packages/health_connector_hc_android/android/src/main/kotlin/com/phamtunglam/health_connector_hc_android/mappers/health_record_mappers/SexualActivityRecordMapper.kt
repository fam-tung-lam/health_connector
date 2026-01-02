package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.SexualActivityRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.SexualActivityProtectionUsedTypeDto
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
    protectionUsed = protectionUsed.toSexualActivityProtectionUsedTypeDto(),
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
 * Converts a Health Connect [SexualActivityRecord] protection used value to [SexualActivityProtectionUsedTypeDto].
 */
internal fun Int.toSexualActivityProtectionUsedTypeDto(): SexualActivityProtectionUsedTypeDto =
    when (this) {
        SexualActivityRecord.PROTECTION_USED_PROTECTED ->
            SexualActivityProtectionUsedTypeDto.PROTECTED
        SexualActivityRecord.PROTECTION_USED_UNPROTECTED ->
            SexualActivityProtectionUsedTypeDto.UNPROTECTED
        SexualActivityRecord.PROTECTION_USED_UNKNOWN ->
            SexualActivityProtectionUsedTypeDto.UNKNOWN
        else -> throw IllegalArgumentException("Unknown protection used value: $this")
    }

/**
 * Converts a [SexualActivityProtectionUsedTypeDto] to a Health Connect protection used value.
 */
internal fun SexualActivityProtectionUsedTypeDto.toHealthConnect(): Int = when (this) {
    SexualActivityProtectionUsedTypeDto.PROTECTED ->
        SexualActivityRecord.PROTECTION_USED_PROTECTED
    SexualActivityProtectionUsedTypeDto.UNPROTECTED ->
        SexualActivityRecord.PROTECTION_USED_UNPROTECTED
    SexualActivityProtectionUsedTypeDto.UNKNOWN ->
        SexualActivityRecord.PROTECTION_USED_UNKNOWN
}
