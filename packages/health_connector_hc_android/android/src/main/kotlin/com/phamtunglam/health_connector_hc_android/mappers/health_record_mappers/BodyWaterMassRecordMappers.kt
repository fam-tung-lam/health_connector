package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.BodyWaterMassRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BodyWaterMassRecordDto
import java.time.Instant
import java.time.ZoneOffset

internal fun BodyWaterMassRecord.toDto(): BodyWaterMassRecordDto = BodyWaterMassRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    mass = mass.toDto(),
)

internal fun BodyWaterMassRecordDto.toHealthConnect(): BodyWaterMassRecord = BodyWaterMassRecord(
    mass = mass.toHealthConnect(),
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(id),
)
