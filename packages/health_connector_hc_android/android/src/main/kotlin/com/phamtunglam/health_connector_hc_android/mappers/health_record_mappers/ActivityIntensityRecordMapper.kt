package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ActivityIntensityRecord
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityTypeDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a Health Connect [ActivityIntensityRecord] object to a [ActivityIntensityRecordDto].
 */
internal fun ActivityIntensityRecord.toDto(): ActivityIntensityRecordDto {
    val activityIntensityTypeDto = when (this.activityIntensityType) {
        ActivityIntensityRecord.ACTIVITY_INTENSITY_TYPE_MODERATE ->
            ActivityIntensityTypeDto.MODERATE

        ActivityIntensityRecord.ACTIVITY_INTENSITY_TYPE_VIGOROUS ->
            ActivityIntensityTypeDto.VIGOROUS

        else -> throw IllegalArgumentException(
            "Unsupported activity intensity type: ${this.activityIntensityType}",
        )
    }

    return ActivityIntensityRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        activityIntensityType = activityIntensityTypeDto,
        title = null,
        notes = null,
    )
}

/**
 * Converts a [ActivityIntensityRecordDto] to a Health Connect [ActivityIntensityRecord] object.
 */
internal fun ActivityIntensityRecordDto.toHealthConnect(): ActivityIntensityRecord {
    val activityIntensityType = when (this.activityIntensityType) {
        ActivityIntensityTypeDto.MODERATE ->
            ActivityIntensityRecord.ACTIVITY_INTENSITY_TYPE_MODERATE

        ActivityIntensityTypeDto.VIGOROUS ->
            ActivityIntensityRecord.ACTIVITY_INTENSITY_TYPE_VIGOROUS
    }

    return ActivityIntensityRecord(
        activityIntensityType = activityIntensityType,
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        metadata = metadata.toHealthConnect(id),
    )
}
