package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.LeanBodyMassRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.LeanBodyMassRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [LeanBodyMassRecord] object to a [LeanBodyMassRecordDto].
 */
internal fun LeanBodyMassRecord.toDto(): LeanBodyMassRecordDto = LeanBodyMassRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    mass = mass.toDto(),
)

/**
 * Converts a [LeanBodyMassRecordDto] to a Health Connect [LeanBodyMassRecord] object.
 */
internal fun LeanBodyMassRecordDto.toHealthConnect(): LeanBodyMassRecord = LeanBodyMassRecord(
    mass = mass.toHealthConnect(),
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
