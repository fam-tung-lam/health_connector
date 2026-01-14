package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ActiveEnergyBurnedRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [ActiveCaloriesBurnedRecord] object to an [ActiveEnergyBurnedRecordDto].
 */
internal fun ActiveCaloriesBurnedRecord.toDto(): ActiveEnergyBurnedRecordDto =
    ActiveEnergyBurnedRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        kilocalories = energy.inKilocalories,
    )

/**
 * Converts an [ActiveEnergyBurnedRecordDto] to a Health Connect [ActiveCaloriesBurnedRecord] object.
 */
internal fun ActiveEnergyBurnedRecordDto.toHealthConnect(): ActiveCaloriesBurnedRecord =
    ActiveCaloriesBurnedRecord(
        energy = Energy.kilocalories(kilocalories),
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
