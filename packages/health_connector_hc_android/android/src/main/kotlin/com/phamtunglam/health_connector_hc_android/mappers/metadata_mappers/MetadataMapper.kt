package com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers

import androidx.health.connect.client.records.metadata.Device
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto

/**
 * Converts a [MetadataDto] to a Health Connect [Metadata] object.
 *
 * Note: [MetadataDto.lastModifiedTime] is managed by Health Connect and not set during writes.
 * The Metadata constructor is internal, so we use the appropriate factory method based on
 * the recording method. This will be populated by Health Connect when records are written.
 *
 * @param id Optional Health Connect record ID for update operations.
 */
internal fun MetadataDto.toHealthConnect(id: String? = null): Metadata {
    val device = if (deviceType != null || deviceManufacturer != null || deviceModel != null) {
        Device(
            manufacturer = deviceManufacturer,
            model = deviceModel,
            type = deviceType?.toHealthConnect() ?: Device.TYPE_UNKNOWN,
        )
    } else {
        null
    }
    val clientRecordVersion = clientRecordVersion ?: 0L

    // If ID is provided, we're updating an existing record - use WithId factory methods
    if (id != null) {
        return when (recordingMethod) {
            RecordingMethodDto.ACTIVELY_RECORDED -> {
                requireNotNull(device) {
                    "Device must be specified when using ACTIVELY_RECORDED recording method"
                }
                Metadata.activelyRecordedWithId(id, device)
            }

            RecordingMethodDto.AUTOMATICALLY_RECORDED -> {
                requireNotNull(device) {
                    "Device must be specified when using AUTOMATICALLY_RECORDED recording method"
                }
                Metadata.autoRecordedWithId(id, device)
            }

            RecordingMethodDto.MANUAL_ENTRY -> {
                Metadata.manualEntryWithId(id, device)
            }

            RecordingMethodDto.UNKNOWN -> {
                Metadata.unknownRecordingMethodWithId(id, device)
            }
        }
    }

    // No ID provided - creating a new record
    return when (recordingMethod) {
        RecordingMethodDto.ACTIVELY_RECORDED -> {
            requireNotNull(device) {
                "Device must be specified when using ACTIVELY_RECORDED recording method"
            }
            if (clientRecordId != null) {
                Metadata.activelyRecorded(device, clientRecordId, clientRecordVersion)
            } else {
                Metadata.activelyRecorded(device)
            }
        }

        RecordingMethodDto.AUTOMATICALLY_RECORDED -> {
            requireNotNull(device) {
                "Device must be specified when using AUTOMATICALLY_RECORDED recording method"
            }
            if (clientRecordId != null) {
                Metadata.autoRecorded(device, clientRecordId, clientRecordVersion)
            } else {
                Metadata.autoRecorded(device)
            }
        }

        RecordingMethodDto.MANUAL_ENTRY -> {
            if (clientRecordId != null) {
                Metadata.manualEntry(clientRecordId, clientRecordVersion, device)
            } else {
                Metadata.manualEntry(device)
            }
        }

        RecordingMethodDto.UNKNOWN -> {
            if (clientRecordId != null) {
                Metadata.unknownRecordingMethod(clientRecordId, clientRecordVersion, device)
            } else {
                Metadata.unknownRecordingMethod(device)
            }
        }
    }
}

/**
 * Converts a Health Connect [Metadata] object to a [MetadataDto].
 */
internal fun Metadata.toDto(): MetadataDto = MetadataDto(
    dataOrigin = dataOrigin.packageName,
    recordingMethod = recordingMethod.toRecordingMethodDto(),
    lastModifiedTime = lastModifiedTime.toEpochMilli(),
    clientRecordId = clientRecordId,
    clientRecordVersion = clientRecordVersion,
    deviceType = device?.type?.toDeviceTypeDto(),
    deviceManufacturer = device?.manufacturer,
    deviceModel = device?.model,
)
