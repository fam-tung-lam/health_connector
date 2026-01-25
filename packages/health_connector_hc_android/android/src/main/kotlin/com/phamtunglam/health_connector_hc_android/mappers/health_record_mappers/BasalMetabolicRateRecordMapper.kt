package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.BasalMetabolicRateRecord
import androidx.health.connect.client.units.Power
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BasalMetabolicRateRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [BasalMetabolicRateRecord] object to a [BasalMetabolicRateRecordDto].
 */
internal fun BasalMetabolicRateRecord.toDto(): BasalMetabolicRateRecordDto =
    BasalMetabolicRateRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        kilocaloriesPerDay = basalMetabolicRate.inKilocaloriesPerDay,
    )

/**
 * Converts a [BasalMetabolicRateRecordDto] to a Health Connect [BasalMetabolicRateRecord] object.
 */
internal fun BasalMetabolicRateRecordDto.toHealthConnect(): BasalMetabolicRateRecord =
    BasalMetabolicRateRecord(
        basalMetabolicRate = Power.kilocaloriesPerDay(kilocaloriesPerDay),
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
