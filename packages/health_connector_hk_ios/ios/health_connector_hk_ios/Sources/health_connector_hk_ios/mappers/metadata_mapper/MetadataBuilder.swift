import Foundation
import HealthKit

/// Fluent builder for constructing HKMetadata dictionaries with type-safe custom keys.
///
/// This builder provides a clean API for constructing metadata dictionaries that include
/// both standard HealthKit metadata and custom SDK-specific keys.
///
/// ## Usage
///
/// ```swift
/// // Start with base metadata from individual parameters
/// var builder = MetadataBuilder(
///     from: dto,
///     startTimeZoneOffset: 3600
/// )
///
/// // Add custom keys using type-safe API
/// builder.set(CervicalMucusAppearanceKey.self, value: appearance)
/// builder.set(CervicalMucusSensationKey.self, value: sensation)
///
/// // Add standard HealthKit keys
/// builder.set(standardKey: HKMetadataKeyExternalUUID, value: externalId)
///
/// // Build the final dictionary
/// let hkMetadata = builder.build()
/// ```
///
/// ## Chaining
///
/// All methods return `Self` for fluent chaining:
///
/// ```swift
/// let metadata = MetadataBuilder(
///     from: dto,
///     startTimeZoneOffset: -18000
/// )
///     .setting(SessionTypeKey.self, value: .meditation)
///     .setting(standardKey: HKMetadataKeyExternalUUID, value: title)
///     .build()
/// ```
final class MetadataBuilder {
    /// The underlying metadata dictionary being built.
    private var metadata: [String: Any]

    /// The source of the health data (e.g., app bundle identifier).
    private var source: HKSource?

    /// The device that generated the health data.
    private var device: HKDevice?

    // MARK: - Accessors

    /// read-only access to the metadata dictionary.
    var metadataDict: [String: Any] {
        metadata
    }

    /// read-only access to the source.
    var healthSource: HKSource? {
        source
    }

    /// read-only access to the device.
    var healthDevice: HKDevice? {
        device
    }

    // MARK: - Initializers

    /// Initializes with base metadata from a `MetadataDto`.
    ///
    /// Uses standard HealthKit metadata keys where available:
    /// - `HKMetadataKeySyncIdentifier` for clientRecordId
    /// - `HKMetadataKeySyncVersion` for clientRecordVersion
    /// - `HKMetadataKeyWasUserEntered` for manual entry detection
    /// - `HKMetadataKeyDeviceName` for device name (redundancy with HKDevice.name)
    /// - `HKMetadataKeyTimeZone` for timezone identifier (if provided)
    /// - Custom timezone offset keys for start and end timezone offsets
    ///
    /// - Parameters:
    ///   - dto: The metadata DTO to start from
    ///   - startTimeZoneOffset: Timezone offset in seconds from GMT for start time (defaults to GMT/0 if not provided)
    ///   - endTimeZoneOffset: Timezone offset in seconds from GMT for end time (defaults to startTimeZoneOffset)
    /// - Throws: `HealthConnectorError.invalidArgument` if the offset is outside ±14 hours (±50400 seconds)
    init(
        from dto: MetadataDto,
        startTimeZoneOffset: Int64? = nil,
        endTimeZoneOffset: Int64? = nil
    ) throws {
        var baseMetadata: [String: Any] = [:]

        if let clientRecordId = dto.clientRecordId {
            baseMetadata[HKMetadataKeySyncIdentifier] = clientRecordId
        }
        if let clientRecordVersion = dto.clientRecordVersion {
            baseMetadata[HKMetadataKeySyncVersion] = NSNumber(value: clientRecordVersion)
        }

        // Store device name in metadata for redundancy (also stored in HKDevice.name)
        let deviceName = dto.deviceName ?? dto.deviceModel
        if let deviceName {
            baseMetadata[HKMetadataKeyDeviceName] = deviceName
        }

        // Resolve timezone offsets with fallback to GMT (0) for deterministic behavior
        let resolvedStartOffset = startTimeZoneOffset ?? 0
        let resolvedEndOffset = endTimeZoneOffset ?? resolvedStartOffset

        // Validate timezone offsets (±14 hours = ±50400 seconds is the valid range)
        let maxOffset: Int64 = 14 * 60 * 60 // 50400 seconds
        if abs(resolvedStartOffset) > maxOffset {
            throw HealthConnectorError.invalidArgument(
                message: "Start timezone offset is invalid (must be within ±14 hours from GMT)",
                context: ["offset": resolvedStartOffset, "maxOffset": maxOffset]
            )
        }
        if abs(resolvedEndOffset) > maxOffset {
            throw HealthConnectorError.invalidArgument(
                message: "End timezone offset is invalid (must be within ±14 hours from GMT)",
                context: ["offset": resolvedEndOffset, "maxOffset": maxOffset]
            )
        }

        // Convert offset to timezone identifier for standard key
        // Note: This creates a fixed offset timezone (e.g., "GMT+0200")
        // Fallback to GMT if TimeZone creation fails (should never happen for valid offsets)
        let startTimeZone =
            TimeZone(secondsFromGMT: Int(resolvedStartOffset)) ?? TimeZone(secondsFromGMT: 0)!
        baseMetadata[HKMetadataKeyTimeZone] = startTimeZone.identifier

        // Custom keys explicitly store timezone offsets
        baseMetadata[StartTimeZoneOffsetKey.fullKey] = StartTimeZoneOffsetKey.serialize(
            resolvedStartOffset)
        baseMetadata[EndTimeZoneOffsetKey.fullKey] = EndTimeZoneOffsetKey.serialize(
            resolvedEndOffset)

        // Store device type in custom metadata
        baseMetadata[DeviceTypeKey.fullKey] = DeviceTypeKey.serialize(dto.deviceType)

        // Store recording method in custom metadata key
        baseMetadata[RecordingMethodKey.fullKey] = RecordingMethodKey.serialize(dto.recordingMethod)

        // Store recording method in native metadata key as a fallback
        baseMetadata[HKMetadataKeyWasUserEntered] =
            dto.recordingMethod == RecordingMethodDto.manualEntry

        metadata = baseMetadata

        // Note: We can only get the default HKSource (current app)
        // The actual source bundle identifier from dto.dataOrigin cannot be used to create an HKSource
        // HKSource instances are created by HealthKit, not by us
        source = HKSource.default()

        // Create HKDevice from device properties if any are present
        // Fallback to deviceModel for name if deviceName is not provided
        if dto.deviceName != nil || dto.deviceManufacturer != nil || dto.deviceModel != nil
            || dto.deviceHardwareVersion != nil || dto.deviceSoftwareVersion != nil
            || dto.deviceFirmwareVersion != nil || dto.deviceLocalIdentifier != nil
            || dto.deviceUdiDeviceIdentifier != nil
        {
            device = HKDevice(
                name: dto.deviceName ?? dto.deviceModel,
                manufacturer: dto.deviceManufacturer,
                model: dto.deviceModel,
                hardwareVersion: dto.deviceHardwareVersion,
                firmwareVersion: dto.deviceFirmwareVersion,
                softwareVersion: dto.deviceSoftwareVersion,
                localIdentifier: dto.deviceLocalIdentifier,
                udiDeviceIdentifier: dto.deviceUdiDeviceIdentifier
            )
        } else {
            device = nil
        }
    }

    /// Initializes with an empty metadata dictionary.
    init() {
        metadata = [:]
        source = nil
        device = nil
    }

    /// Initializes with an existing metadata dictionary.
    ///
    /// - Parameter metadata: The starting metadata dictionary
    init(metadata: [String: Any]) {
        self.metadata = metadata
        source = nil
        device = nil
    }

    /// Initializes from existing HealthKit metadata with source and device information.
    ///
    /// This named constructor is useful when reading data from HealthKit and needing to
    /// preserve the source and device information along with the metadata dictionary.
    ///
    /// - Parameters:
    ///   - metadata: The HealthKit metadata dictionary
    ///   - source: The source of the health data
    ///   - device: Optional device that generated the health data
    init(fromHKMetadata metadata: [String: Any], source: HKSource, device: HKDevice?) {
        self.metadata = metadata
        self.source = source
        self.device = device
    }

    // MARK: - Parsing

    /// Converts the contained HealthKit metadata dictionary to a `MetadataDto`.
    ///
    /// Reads from standard HealthKit metadata keys:
    /// - `HKMetadataKeySyncIdentifier` -> clientRecordId
    /// - `HKMetadataKeySyncVersion` -> clientRecordVersion
    /// - `HKMetadataKeyWasUserEntered` -> isManualEntry
    /// - `HKMetadataKeyDeviceName` -> device name (if not in HKDevice)
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if the builder was not initialized with source information
    func toMetadataDto() throws -> MetadataDto {
        guard let source else {
            throw HealthConnectorError.invalidArgument(
                message:
                "MetadataBuilder was not initialized with source information, which is required for this operation",
                context: ["method": "toMetadataDto"]
            )
        }
        let clientRecordId = metadata[HKMetadataKeySyncIdentifier] as? String
        let clientRecordVersion: Int64? =
            if let versionNumber = metadata[HKMetadataKeySyncVersion] as? NSNumber {
                versionNumber.int64Value
            } else {
                nil
            }

        // Extract device information from HKDevice or fall back to metadata
        let deviceName: String?
        let deviceModel: String?

        if let device {
            // Prefer HKDevice information when available
            deviceName = device.name
            deviceModel = device.model
        } else {
            // Fall back to metadata keys when device is nil
            deviceName = metadata[HKMetadataKeyDeviceName] as? String
            // Note: There's no standard HKMetadataKey for device model, so it will be nil
            deviceModel = nil
        }

        let deviceType = DeviceTypeKey.readOrDefault(from: metadata)

        // Resolve recording method with fallback to native key
        let recordingMethod: RecordingMethodDto
        if let customValue = RecordingMethodKey.read(from: metadata) {
            recordingMethod = customValue
        } else {
            let wasUserEntered = metadata[HKMetadataKeyWasUserEntered] as? Bool ?? false
            recordingMethod = wasUserEntered ? .manualEntry : .unknown
        }

        return MetadataDto(
            clientRecordId: clientRecordId,
            clientRecordVersion: clientRecordVersion,
            deviceType: deviceType,
            recordingMethod: recordingMethod,
            dataOrigin: source.bundleIdentifier,
            deviceName: deviceName,
            deviceManufacturer: device?.manufacturer,
            deviceModel: deviceModel,
            deviceHardwareVersion: device?.hardwareVersion,
            deviceFirmwareVersion: device?.firmwareVersion,
            deviceSoftwareVersion: device?.softwareVersion,
            deviceLocalIdentifier: device?.localIdentifier,
            deviceUdiDeviceIdentifier: device?.udiDeviceIdentifier
        )
    }

    // MARK: - Custom Key Methods

    /// Adds a custom metadata value using a `CustomMetadataKey` type.
    ///
    /// - Parameters:
    ///   - key: The key type (e.g., `SessionTypeKey.self`)
    ///   - value: The value to store
    @discardableResult
    func set<K: CustomMetadataKey>(_: K.Type, value: K.Value) -> Self {
        metadata[K.fullKey] = K.serialize(value)
        return self
    }

    // MARK: - Standard Key Methods

    /// Sets a standard HealthKit metadata key.
    ///
    /// - Parameters:
    ///   - standardKey: The HealthKit metadata key (e.g., `HKMetadataKeyExternalUUID`)
    ///   - value: The value to store
    @discardableResult
    func set(standardKey: String, value: Any) -> Self {
        metadata[standardKey] = value
        return self
    }

    /// Removes a standard HealthKit metadata key from the dictionary.
    ///
    /// - Parameter standardKey: The key to remove
    @discardableResult
    func remove(standardKey: String) -> Self {
        metadata.removeValue(forKey: standardKey)
        return self
    }

    // MARK: - Build

    /// Builds the final metadata dictionary.
    ///
    /// - Returns: The metadata dictionary, or `nil` if empty
    func build() -> [String: Any]? {
        metadata.isEmpty ? nil : metadata
    }

    // MARK: - Inspection

    /// Returns `true` if the metadata dictionary is empty.
    var isEmpty: Bool {
        metadata.isEmpty
    }

    /// Returns the current count of metadata entries.
    var count: Int {
        metadata.count
    }
}
