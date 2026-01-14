package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.BoneMassRecord
import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BoneMassRecordDto
import java.time.Instant
import java.time.ZoneOffset

internal fun BoneMassRecord.toDto(): BoneMassRecordDto = BoneMassRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    kilograms = mass.inKilograms,
)

internal fun BoneMassRecordDto.toHealthConnect(): BoneMassRecord = BoneMassRecord(
    mass = Mass.kilograms(kilograms),
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
