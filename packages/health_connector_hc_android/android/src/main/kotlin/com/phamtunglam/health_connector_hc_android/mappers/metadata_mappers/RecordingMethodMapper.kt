package com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers

import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto

/**
 * Converts a Health Connect recording method constant to a [RecordingMethodDto].
 */
internal fun Int.toRecordingMethodDto(): RecordingMethodDto = when (this) {
    Metadata.RECORDING_METHOD_MANUAL_ENTRY -> RecordingMethodDto.MANUAL_ENTRY
    Metadata.RECORDING_METHOD_AUTOMATICALLY_RECORDED -> RecordingMethodDto.AUTOMATICALLY_RECORDED
    Metadata.RECORDING_METHOD_ACTIVELY_RECORDED -> RecordingMethodDto.ACTIVELY_RECORDED
    else -> RecordingMethodDto.UNKNOWN
}
