import Foundation
import HealthKit

extension MetadataDto {
    /**
     * Converts this DTO to a HealthKit metadata dictionary.
     *
     * Uses standard HealthKit metadata keys where available:
     * - `HKMetadataKeySyncIdentifier` for clientRecordId
     * - `HKMetadataKeySyncVersion` for clientRecordVersion
     * - `HKMetadataKeyWasUserEntered` for manual entry detection
     * - `HKMetadataKeyDeviceName` for device name (redundancy with HKDevice.name)
     * - `HKMetadataKeyTimeZone` for timezone identifier (if provided)
     */
    func toHealthKitMetadata(timeZone: TimeZone? = nil) -> [String: Any] {
        var metadata: [String: Any] = [:]

        if let clientRecordId {
            metadata[HKMetadataKeySyncIdentifier] = clientRecordId
        }
        if let clientRecordVersion {
            metadata[HKMetadataKeySyncVersion] = NSNumber(value: clientRecordVersion)
        }

        metadata[HKMetadataKeyWasUserEntered] = isManualEntry

        // Store device name in metadata for redundancy (also stored in HKDevice.name)
        let deviceName = deviceName ?? deviceModel
        if let deviceName {
            metadata[HKMetadataKeyDeviceName] = deviceName
        }

        // Use provided timezone or fallback to device's current timezone
        let timeZoneToStore = timeZone ?? TimeZone.current
        metadata[HKMetadataKeyTimeZone] = timeZoneToStore.identifier

        return metadata
    }

    /**
     * Extracts the device from this DTO for HealthKit sample creation.
     *
     * Uses `deviceModel` value for `name` if `deviceName` is null, as per HealthKit best practices.
     * Returns `nil` if all device fields are null.
     *
     * ## HealthKit Requirement
     *
     * HealthKit requires at least one non-nil field when creating an `HKDevice`. If all fields are
     * nil, HealthKit will throw `NSInvalidArgumentException: 'At least one field of the device must be non-nil.'`
     *
     * This method prevents this exception by returning `nil` when no device information is available.
     */
    func toHealthKitDevice() -> HKDevice? {
        // Check if at least one field is non-nil
        let deviceName = deviceName ?? deviceModel
        let hasAnyField = deviceName != nil ||
            deviceManufacturer != nil ||
            deviceHardwareVersion != nil ||
            deviceFirmwareVersion != nil ||
            deviceSoftwareVersion != nil ||
            deviceLocalIdentifier != nil ||
            deviceUdiDeviceIdentifier != nil

        guard hasAnyField else {
            return nil
        }

        return HKDevice(
            name: deviceName,
            manufacturer: deviceManufacturer,
            model: deviceModel,
            hardwareVersion: deviceHardwareVersion,
            firmwareVersion: deviceFirmwareVersion,
            softwareVersion: deviceSoftwareVersion,
            localIdentifier: deviceLocalIdentifier,
            udiDeviceIdentifier: deviceUdiDeviceIdentifier
        )
    }
}

extension [String: Any] {
    /**
     * Converts HealthKit metadata dictionary to a `MetadataDto`.
     *
     * Reads from standard HealthKit metadata keys:
     * - `HKMetadataKeySyncIdentifier` -> clientRecordId
     * - `HKMetadataKeySyncVersion` -> clientRecordVersion
     * - `HKMetadataKeyWasUserEntered` -> isManualEntry
     * - `HKMetadataKeyDeviceName` -> device name (if not in HKDevice)
     */
    func toMetadataDto(source: HKSource, device: HKDevice?) -> MetadataDto {
        let clientRecordId = self[HKMetadataKeySyncIdentifier] as? String
        let clientRecordVersion: Int64? = if let versionNumber = self[HKMetadataKeySyncVersion] as? NSNumber {
            versionNumber.int64Value
        } else {
            nil
        }

        // Set isManualEntry to false if not present (unknown/not manual entry)
        let isManualEntry = self[HKMetadataKeyWasUserEntered] as? Bool ?? false

        return MetadataDto(
            clientRecordId: clientRecordId,
            clientRecordVersion: clientRecordVersion,
            dataOrigin: source.bundleIdentifier,

            // Device name is extracted from HKDevice.name
            // HKMetadataKeyDeviceName in metadata is for redundancy but we prefer HKDevice.name
            deviceName: device?.name,
            deviceManufacturer: device?.manufacturer,
            deviceModel: device?.model,
            deviceHardwareVersion: device?.hardwareVersion,
            deviceFirmwareVersion: device?.firmwareVersion,
            deviceSoftwareVersion: device?.softwareVersion,
            deviceLocalIdentifier: device?.localIdentifier,
            deviceUdiDeviceIdentifier: device?.udiDeviceIdentifier,
            isManualEntry: isManualEntry
        )
    }

    /**
     * Extracts timezone offset in seconds from GMT from the metadata dictionary.
     */
    func extractTimeZoneOffset(for date: Date) -> Int64? {
        guard let timeZoneString = self[HKMetadataKeyTimeZone] as? String,
              let timeZone = TimeZone(identifier: timeZoneString)
        else {
            return nil
        }

        // Get seconds offset from GMT for the given date
        // This is important because timezone offsets vary due to daylight saving time
        let secondsFromGMT = timeZone.secondsFromGMT(for: date)

        return Int64(secondsFromGMT)
    }
}
