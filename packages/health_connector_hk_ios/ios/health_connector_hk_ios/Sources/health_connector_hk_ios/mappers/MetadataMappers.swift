import Foundation
import HealthKit

// ==================== METADATA KEYS ====================

/// Custom metadata key used to store the full recording method enum value.
///
/// HealthKit only provides a boolean flag (`HKMetadataKeyWasUserEntered`) to distinguish
/// manual entry from device-recorded data. This custom key allows us to preserve the
/// full recording method enum (manualEntry, automaticallyRecorded, activelyRecorded, unknown).
private let recordingMethodMetadataKey = "recordingMethod"

// ==================== DEVICE MAPPERS ====================

extension DeviceDto {
    /**
     * Converts this DTO to a HealthKit `HKDevice`.
     *
     * Uses `model` value for `name` if `name` is null, as per HealthKit best practices.
     * Returns `nil` if all device fields are null.
     *
     * **Important:** HealthKit requires at least one non-nil field when creating an `HKDevice`.
     * If all fields are nil, HealthKit will throw:
     * ```
     * NSInvalidArgumentException: 'At least one field of the device must be non-nil.'
     * ```
     * This method prevents this exception by returning `nil` when no device information is available.
     *
     * - Returns: An `HKDevice` instance if at least one field is non-nil, otherwise `nil`
     */
    func toHealthKit() -> HKDevice? {
        // Check if at least one field is non-nil (HealthKit requirement)
        let deviceName = name ?? model
        let hasAnyField = deviceName != nil ||
                          manufacturer != nil ||
                          hardwareVersion != nil ||
                          firmwareVersion != nil ||
                          softwareVersion != nil ||
                          localIdentifier != nil ||
                          udiDeviceIdentifier != nil
        
        guard hasAnyField else {
            return nil
        }
        
        return HKDevice(
            name: deviceName,
            manufacturer: manufacturer,
            model: model,
            hardwareVersion: hardwareVersion,
            firmwareVersion: firmwareVersion,
            softwareVersion: softwareVersion,
            localIdentifier: localIdentifier,
            udiDeviceIdentifier: udiDeviceIdentifier
        )
    }
}

extension HKDevice {
    /**
     * Converts this HealthKit device to a `DeviceDto`.
     */
    func toDto() -> DeviceDto {
        return DeviceDto(
            firmwareVersion: firmwareVersion,
            hardwareVersion: hardwareVersion,
            localIdentifier: localIdentifier,
            manufacturer: manufacturer,
            model: model,
            name: name,
            softwareVersion: softwareVersion,
            udiDeviceIdentifier: udiDeviceIdentifier
        )
    }
}

// ==================== METADATA MAPPERS ====================

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
     * - Custom recording method key for full enum value (since HealthKit only has boolean)
     *
     * - Parameter timeZone: Optional timezone to store in metadata. If nil, uses device's current timezone.
     */
    func toHealthKitMetadata(timeZone: TimeZone? = nil) -> [String: Any] {
        var metadata: [String: Any] = [:]

        // Use standard HealthKit keys for sync identifiers
        if let clientRecordId = clientRecordId {
            metadata[HKMetadataKeySyncIdentifier] = clientRecordId
        }
        if let clientRecordVersion = clientRecordVersion {
            metadata[HKMetadataKeySyncVersion] = NSNumber(value: clientRecordVersion)
        }

        // Map recording method to HKMetadataKeyWasUserEntered
        // manualEntry -> true, others -> false
        if recordingMethod == .manualEntry {
            metadata[HKMetadataKeyWasUserEntered] = true
        } else {
            metadata[HKMetadataKeyWasUserEntered] = false
        }

        // Store full recording method enum as custom key for reading back
        // This allows us to distinguish between automaticallyRecorded, activelyRecorded, and unknown
        metadata[recordingMethodMetadataKey] = Int(recordingMethod.rawValue)

        // Store device name in metadata for redundancy (also stored in HKDevice.name)
        if let deviceName = device?.name {
            metadata[HKMetadataKeyDeviceName] = deviceName
        }

        // Store timezone identifier in metadata using standard HealthKit key
        // Use provided timezone or fallback to device's current timezone
        let timeZoneToStore = timeZone ?? TimeZone.current
        metadata[HKMetadataKeyTimeZone] = timeZoneToStore.identifier

        return metadata
    }

    /**
     * Extracts the device from this DTO for HealthKit sample creation.
     */
    func toHealthKitDevice() -> HKDevice? {
        return device?.toHealthKit()
    }
}

extension Dictionary where Key == String, Value == Any {
    /**
     * Converts HealthKit metadata dictionary to a `MetadataDto`.
     *
     * Reads from standard HealthKit metadata keys:
     * - `HKMetadataKeySyncIdentifier` -> clientRecordId
     * - `HKMetadataKeySyncVersion` -> clientRecordVersion
     * - `HKMetadataKeyWasUserEntered` -> recordingMethod (manualEntry if true)
     * - `HKMetadataKeyDeviceName` -> device name (if not in HKDevice)
     * - Custom recording method key -> full enum value (for backward compatibility)
     */
    func toMetadataDto(source: HKSource, device: HKDevice?) -> MetadataDto {
        // Extract sync identifier from standard HealthKit key
        let clientRecordId = self[HKMetadataKeySyncIdentifier] as? String

        // Extract sync version from standard HealthKit key
        let clientRecordVersion: Int64?
        if let versionNumber = self[HKMetadataKeySyncVersion] as? NSNumber {
            clientRecordVersion = versionNumber.int64Value
        } else {
            clientRecordVersion = nil
        }

        // Determine recording method from HKMetadataKeyWasUserEntered and custom key
        let recordingMethod: RecordingMethodDto
        if let wasUserEntered = self[HKMetadataKeyWasUserEntered] as? Bool, wasUserEntered {
            // If HKMetadataKeyWasUserEntered is true, it's manual entry
            recordingMethod = .manualEntry
        } else if let methodValue = self[recordingMethodMetadataKey] as? Int {
            // Use custom key if available (for automaticallyRecorded, activelyRecorded, unknown)
            recordingMethod = RecordingMethodDto(rawValue: methodValue) ?? .unknown
        } else if let methodValue = self[recordingMethodMetadataKey] as? Int64 {
            recordingMethod = RecordingMethodDto(rawValue: Int(methodValue)) ?? .unknown
        } else {
            // Default to unknown if no information available
            recordingMethod = .unknown
        }

        // Device name is extracted from HKDevice.name in toDto() method
        // HKMetadataKeyDeviceName in metadata is for redundancy but we prefer HKDevice.name
        let deviceDto = device?.toDto()

        return MetadataDto(
            clientRecordId: clientRecordId,
            clientRecordVersion: clientRecordVersion,
            dataOrigin: DataOriginDto(
                packageName: source.bundleIdentifier
            ),
            device: deviceDto,
            recordingMethod: recordingMethod
        )
    }

    /**
     * Extracts timezone offset in seconds from GMT from the metadata dictionary.
     *
     * Reads the timezone identifier from `HKMetadataKeyTimeZone` and calculates the offset
     * for the given date (important because timezone offsets vary due to daylight saving time).
     *
     * - Parameter date: The date to calculate the timezone offset for
     * - Returns: The timezone offset in seconds from GMT, or `nil` if timezone information is not available
     */
    func extractTimeZoneOffset(for date: Date) -> Int64? {
        // Read the timezone string from sample metadata
        guard let timeZoneString = self[HKMetadataKeyTimeZone] as? String,
              let timeZone = TimeZone(identifier: timeZoneString) else {
            return nil
        }

        // Get seconds offset from GMT for the given date
        // This is important because timezone offsets vary due to daylight saving time
        let secondsFromGMT = timeZone.secondsFromGMT(for: date)

        return Int64(secondsFromGMT)
    }
}

