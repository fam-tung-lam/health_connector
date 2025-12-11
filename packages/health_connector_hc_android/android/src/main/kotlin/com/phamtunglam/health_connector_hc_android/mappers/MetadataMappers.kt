package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.records.metadata.Device
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
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

/**
 * Converts a [DeviceTypeDto] to a Health Connect device type constant.
 */
internal fun DeviceTypeDto.toHealthConnect(): Int = when (this) {
    DeviceTypeDto.UNKNOWN -> Device.TYPE_UNKNOWN
    DeviceTypeDto.WATCH -> Device.TYPE_WATCH
    DeviceTypeDto.PHONE -> Device.TYPE_PHONE
    DeviceTypeDto.SCALE -> Device.TYPE_SCALE
    DeviceTypeDto.RING -> Device.TYPE_RING
    DeviceTypeDto.FITNESS_BAND -> Device.TYPE_FITNESS_BAND
    DeviceTypeDto.CHEST_STRAP -> Device.TYPE_CHEST_STRAP
    DeviceTypeDto.HEAD_MOUNTED -> Device.TYPE_HEAD_MOUNTED
    DeviceTypeDto.SMART_DISPLAY -> Device.TYPE_SMART_DISPLAY
}

/**
 * Converts a Health Connect device type constant to a [DeviceTypeDto].
 */
internal fun Int.toDeviceTypeDto(): DeviceTypeDto = when (this) {
    Device.TYPE_UNKNOWN -> DeviceTypeDto.UNKNOWN
    Device.TYPE_WATCH -> DeviceTypeDto.WATCH
    Device.TYPE_PHONE -> DeviceTypeDto.PHONE
    Device.TYPE_SCALE -> DeviceTypeDto.SCALE
    Device.TYPE_RING -> DeviceTypeDto.RING
    Device.TYPE_FITNESS_BAND -> DeviceTypeDto.FITNESS_BAND
    Device.TYPE_CHEST_STRAP -> DeviceTypeDto.CHEST_STRAP
    Device.TYPE_HEAD_MOUNTED -> DeviceTypeDto.HEAD_MOUNTED
    Device.TYPE_SMART_DISPLAY -> DeviceTypeDto.SMART_DISPLAY
    else -> DeviceTypeDto.UNKNOWN
}

/**
 * Converts a [MetadataDto] to a Health Connect [Metadata] object.
 *
 * Note: [MetadataDto.lastModifiedTime] is managed by Health Connect and not set during writes.
 * The Metadata constructor is internal, so we use the appropriate factory method based on
 * the recording method. This will be populated by Health Connect when records are written.
 */
internal fun MetadataDto.toHealthConnect(): Metadata {
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
