package com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers

import androidx.health.connect.client.records.metadata.Device
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
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
    val device = Device(
        manufacturer = deviceManufacturer,
        model = deviceModel,
        type = deviceType.toHealthConnect(),
    )
    val clientRecordVersion = clientRecordVersion ?: 0L

    return if (id != null) {
        createMetadataWithId(id, device)
    } else {
        createMetadataWithoutId(device, clientRecordVersion)
    }
}

/**
 * Creates a [Metadata] with an ID for updating an existing record.
 */
private fun MetadataDto.createMetadataWithId(id: String, device: Device): Metadata =
    when (recordingMethod) {
        RecordingMethodDto.ACTIVELY_RECORDED -> Metadata.activelyRecordedWithId(id, device)
        RecordingMethodDto.AUTOMATICALLY_RECORDED -> Metadata.autoRecordedWithId(id, device)
        RecordingMethodDto.MANUAL_ENTRY -> Metadata.manualEntryWithId(id, device)
        RecordingMethodDto.UNKNOWN -> Metadata.unknownRecordingMethodWithId(id, device)
    }

/**
 * Creates a [Metadata] without an ID for creating a new record.
 */
private fun MetadataDto.createMetadataWithoutId(
    device: Device,
    clientRecordVersion: Long,
): Metadata = when (recordingMethod) {
    RecordingMethodDto.ACTIVELY_RECORDED -> createActivelyRecordedMetadata(
        device,
        clientRecordVersion,
    )
    RecordingMethodDto.AUTOMATICALLY_RECORDED -> createAutoRecordedMetadata(
        device,
        clientRecordVersion,
    )
    RecordingMethodDto.MANUAL_ENTRY -> createManualEntryMetadata(device, clientRecordVersion)
    RecordingMethodDto.UNKNOWN -> createUnknownRecordingMethodMetadata(
        device,
        clientRecordVersion,
    )
}

/**
 * Creates an actively recorded [Metadata] with optional client record ID.
 */
private fun MetadataDto.createActivelyRecordedMetadata(
    device: Device,
    clientRecordVersion: Long,
): Metadata = if (clientRecordId != null) {
    Metadata.activelyRecorded(device, clientRecordId, clientRecordVersion)
} else {
    Metadata.activelyRecorded(device)
}

/**
 * Creates an auto-recorded [Metadata] with optional client record ID.
 */
private fun MetadataDto.createAutoRecordedMetadata(
    device: Device,
    clientRecordVersion: Long,
): Metadata = if (clientRecordId != null) {
    Metadata.autoRecorded(device, clientRecordId, clientRecordVersion)
} else {
    Metadata.autoRecorded(device)
}

/**
 * Creates a manual entry [Metadata] with optional client record ID.
 */
private fun MetadataDto.createManualEntryMetadata(
    device: Device,
    clientRecordVersion: Long,
): Metadata = if (clientRecordId != null) {
    Metadata.manualEntry(clientRecordId, clientRecordVersion, device)
} else {
    Metadata.manualEntry(device)
}

/**
 * Creates an unknown recording method [Metadata] with optional client record ID.
 */
private fun MetadataDto.createUnknownRecordingMethodMetadata(
    device: Device,
    clientRecordVersion: Long,
): Metadata = if (clientRecordId != null) {
    Metadata.unknownRecordingMethod(clientRecordId, clientRecordVersion, device)
} else {
    Metadata.unknownRecordingMethod(device)
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
    deviceType = device?.type?.toDeviceTypeDto() ?: DeviceTypeDto.UNKNOWN,
    deviceManufacturer = device?.manufacturer,
    deviceModel = device?.model,
)
