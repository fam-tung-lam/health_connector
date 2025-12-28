import Foundation
import HealthKit

// MARK: - Custom Metadata Keys

/// Custom metadata key for storing cervical mucus appearance type as a string.
///
/// **Why this exists:**
/// HealthKit's `HKCategoryValueCervicalMucusQuality` only supports 5 appearance types
/// (dry, sticky, creamy, watery, eggWhite), but Android Health Connect supports 7 types
/// (including `unusual` and `unknown`). To maintain cross-platform parity and avoid data loss,
/// we store the complete appearance information in custom metadata.
///
/// **Storage strategy:**
/// - All 7 appearance types are stored as strings in this metadata key
/// - Native HealthKit values are used when available (dry, sticky, creamy, watery, eggWhite)
/// - For `.unusual` and `.unknown`, we use `.dry` (value 1) as a placeholder in the native
///   field since HealthKit doesn't accept invalid value for cervical mucus quality
/// - On read, custom metadata takes priority over native HealthKit values to ensure
///   we always retrieve the correct appearance type
private let cervicalMucusAppearanceTypeMetadataKey =
    "com.phamtunglam.health_connector_hk_ios.hk_metadata_key_cervical_mucus_appearance_type"

/// Custom metadata key for storing cervical mucus sensation type as a string.
///
/// **Why this exists:**
/// HealthKit's `HKCategoryTypeIdentifier.cervicalMucusQuality` exclusively tracks appearance
/// and has **no support whatsoever** for sensation (light, medium, heavy). Android Health Connect,
/// however, fully supports sensation tracking. To maintain cross-platform parity, we must store
/// sensation information in custom metadata.
///
/// **Storage strategy:**
/// - All sensation values are stored as strings in this metadata key
/// - On read, we parse the string back to the DTO enum, defaulting to `.unknown` if absent
private let cervicalMucusSensationTypeMetadataKey =
    "com.phamtunglam.health_connector_hk_ios.hk_metadata_key_cervical_mucus_sensation_type"

// MARK: - Raw String Value Enums

/// Raw string values for cervical mucus appearance types stored in `cervicalMucusAppearanceTypeMetadataKey`.
private enum CervicalMucusAppearanceTypeName: String {
    case unknown
    case dry
    case sticky
    case creamy
    case watery
    case eggWhite
    case unusual
}

/// Raw string values for cervical mucus sensation types stored in `cervicalMucusSensationTypeMetadataKey`.
private enum CervicalMucusSensationTypeName: String {
    case unknown
    case light
    case medium
    case heavy
}

// MARK: - String Conversion Extensions

extension String {
    /// Converts raw appearance string from custom metadata to `CervicalMucusAppearanceTypeDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if the string doesn't match any known appearance type
    /// - Returns: The corresponding `CervicalMucusAppearanceTypeDto` enum value
    func toCervicalMucusAppearanceTypeDto() throws -> CervicalMucusAppearanceTypeDto {
        guard let appearanceType = CervicalMucusAppearanceTypeName(rawValue: self) else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid cervical mucus appearance type string: \(self)"
            )
        }
        switch appearanceType {
        case .unknown:
            return .unknown
        case .dry:
            return .dry
        case .sticky:
            return .sticky
        case .creamy:
            return .creamy
        case .watery:
            return .watery
        case .eggWhite:
            return .eggWhite
        case .unusual:
            return .unusual
        }
    }

    /// Converts raw sensation string from custom metadata to `CervicalMucusSensationTypeDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if the string doesn't match any known sensation type
    /// - Returns: The corresponding `CervicalMucusSensationTypeDto` enum value
    func toCervicalMucusSensationTypeDto() throws -> CervicalMucusSensationTypeDto {
        guard let sensationType = CervicalMucusSensationTypeName(rawValue: self) else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid cervical mucus sensation type string: \(self)"
            )
        }
        switch sensationType {
        case .unknown:
            return .unknown
        case .light:
            return .light
        case .medium:
            return .medium
        case .heavy:
            return .heavy
        }
    }
}

// MARK: - DTO to String Extensions

extension CervicalMucusAppearanceTypeDto {
    /// Converts `CervicalMucusAppearanceTypeDto` to raw string for custom metadata storage.
    ///
    /// - Returns: The raw string value suitable for storage in `cervicalMucusAppearanceTypeMetadataKey`
    func toRawString() -> String {
        switch self {
        case .unknown:
            CervicalMucusAppearanceTypeName.unknown.rawValue
        case .dry:
            CervicalMucusAppearanceTypeName.dry.rawValue
        case .sticky:
            CervicalMucusAppearanceTypeName.sticky.rawValue
        case .creamy:
            CervicalMucusAppearanceTypeName.creamy.rawValue
        case .watery:
            CervicalMucusAppearanceTypeName.watery.rawValue
        case .eggWhite:
            CervicalMucusAppearanceTypeName.eggWhite.rawValue
        case .unusual:
            CervicalMucusAppearanceTypeName.unusual.rawValue
        }
    }
}

extension CervicalMucusSensationTypeDto {
    /// Converts `CervicalMucusSensationTypeDto` to raw string for custom metadata storage.
    ///
    /// - Returns: The raw string value suitable for storage in `cervicalMucusSensationTypeMetadataKey`
    func toRawString() -> String {
        switch self {
        case .unknown:
            CervicalMucusSensationTypeName.unknown.rawValue
        case .light:
            CervicalMucusSensationTypeName.light.rawValue
        case .medium:
            CervicalMucusSensationTypeName.medium.rawValue
        case .heavy:
            CervicalMucusSensationTypeName.heavy.rawValue
        }
    }
}

// MARK: - HKCategorySample to DTO

extension HKCategorySample {
    /// Converts a HealthKit cervical mucus category sample to `CervicalMucusRecordDto`.
    ///
    /// **Reading strategy - Appearance:**
    /// We implement a fallback chain to handle various data sources:
    /// 1. **Custom metadata (priority 1):** Check for string in `cervicalMucusAppearanceTypeMetadataKey`
    ///    - This handles records written by our SDK (includes `.unusual` and `.unknown`)
    ///    - This handles all 7 appearance types with full fidelity
    /// 2. **Native HealthKit value (priority 2):** Parse `HKCategoryValueCervicalMucusQuality` from sample.value
    ///    - This handles records written by Apple Health app or other apps
    ///    - Only supports 5 appearance types (dry, sticky, creamy, watery, eggWhite)
    /// 3. **Default to `.unknown` (priority 3):** If both above fail
    ///
    /// **Why this fallback order:**
    /// Custom metadata takes priority because it's the only source that can represent all 7
    /// appearance types. Native HealthKit values are consulted second to maintain compatibility
    /// with records written by other apps that don't use our custom metadata pattern.
    ///
    /// **Reading strategy - Sensation:**
    /// Sensation has a simpler strategy since HealthKit provides no native support:
    /// 1. **Custom metadata (only source):** Parse string from `cervicalMucusSensationTypeMetadataKey`
    /// 2. **Default to `.unknown`:** If metadata is absent
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if custom metadata contains invalid string values
    /// - Returns: `CervicalMucusRecordDto` with appearance and sensation populated from available sources
    func toCervicalMucusRecordDto() throws -> CervicalMucusRecordDto {
        // Appearance Handling:
        // Priority 1: Custom metadata (supports all 7 types including .unusual and .unknown)
        // Priority 2: Native HealthKit value (supports only 5 types: dry, sticky, creamy, watery, eggWhite)
        // Priority 3: Default to .unknown if both sources are unavailable
        let appearance: CervicalMucusAppearanceTypeDto =
            if let appearanceString = metadata?[cervicalMucusAppearanceTypeMetadataKey]
                as? String
            {
                // Custom metadata found - parse it. This is written by our SDK.
                try appearanceString.toCervicalMucusAppearanceTypeDto()
            } else if let hkAppearance = HKCategoryValueCervicalMucusQuality(rawValue: value) {
                // No custom metadata, but we have a valid native HealthKit value.
                // This likely came from Apple Health app or another app.
                hkAppearance.toCervicalMucusAppearanceTypeDto()
            } else {
                // No metadata and no valid HealthKit value - data source unknown or corrupted
                .unknown
            }

        // Sensation Handling:
        // HealthKit has no native support for sensation, so we only check custom metadata.
        // Default to .unknown if metadata is absent (e.g., records from Apple Health app).
        let sensation: CervicalMucusSensationTypeDto =
            if let sensationString = metadata?[cervicalMucusSensationTypeMetadataKey]
                as? String
            {
                try sensationString.toCervicalMucusSensationTypeDto()
            } else {
                .unknown
            }

        let metadataDict = metadata ?? [:]

        return CervicalMucusRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            zoneOffsetSeconds: Int64(TimeZone.current.secondsFromGMT(for: startDate)),
            appearance: appearance,
            sensation: sensation
        )
    }
}

// MARK: - DTO to HealthKit

extension CervicalMucusRecordDto {
    /// Converts a `CervicalMucusRecordDto` to a HealthKit category sample.
    ///
    /// **Writing strategy - Dual storage approach:**
    /// We employ a dual storage strategy to maximize compatibility and data fidelity:
    /// 1. **Custom metadata:** Store ALL appearance and sensation types as strings
    ///    - Preserves complete information including `.unusual` and `.unknown` appearance
    ///    - Preserves sensation data (light, medium, heavy) since HealthKit has no native field
    /// 2. **Native HealthKit field:** Store appearance in sample.value when possible
    ///    - Uses `HKCategoryValueCervicalMucusQuality` for 5 supported types
    ///    - Uses `.dry` (value 1) as placeholder for `.unusual` and `.unknown`
    ///
    /// **Why use .dry as placeholder instead of .notApplicable (value 0):**
    /// HealthKit enforces strict validation on `HKCategoryTypeIdentifierCervicalMucusQuality`.
    /// Only values 1-5 are valid:
    /// - 1 = .dry
    /// - 2 = .sticky
    /// - 3 = .creamy
    /// - 4 = .watery
    /// - 5 = .eggWhite
    ///
    /// Value 0 (.notApplicable) or any invalid value causes a runtime crash:
    /// `_HKObjectValidationFailureException: Value 0 is not compatible with type
    /// HKCategoryTypeIdentifierCervicalMucusQuality`
    ///
    /// We chose `.dry` (value 1) as the placeholder because:
    /// - It's the lowest valid value
    /// - The actual appearance is always stored in custom metadata, so the native value
    ///   is only a fallback for compatibility with apps that don't read our metadata
    /// - When reading back, we prioritize custom metadata, so the placeholder is ignored
    ///
    /// **Compatibility considerations:**
    /// - Records written by this SDK: Custom metadata is read first → full fidelity
    /// - Records read by Apple Health app: Native field is displayed → shows valid appearance
    ///   (even if placeholder .dry, it's better than crashing or showing nothing)
    /// - Records read by other apps: Depends on whether they support custom metadata
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if category type creation fails
    /// - Returns: `HKCategorySample` with appearance in both native field and custom metadata
    func toHealthKit() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .cervicalMucusQuality
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for cervical mucus"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(time) / 1000)
        let endDate = startDate // Cervical mucus is an instant observation, not a duration

        var hkMetadata = metadata.toHealthKitMetadata()

        // Store sensation in custom metadata - this is the ONLY way to preserve sensation
        // since HealthKit's cervicalMucusQuality type has no native sensation field
        hkMetadata[cervicalMucusSensationTypeMetadataKey] = sensation.toRawString()

        // Store appearance in custom metadata - this preserves all 7 types including
        // .unusual and .unknown which aren't supported by native HealthKit
        hkMetadata[cervicalMucusAppearanceTypeMetadataKey] = appearance.toRawString()

        // Determine the native HealthKit category value for the sample.value field:
        // - For natively supported types (dry, sticky, creamy, watery, eggWhite): use actual value
        // - For .unusual or .unknown: use .dry (1) as placeholder since value 0 causes crashes
        //
        // The actual appearance is always retrievable from custom metadata on read,
        // so this native value primarily serves compatibility with non-SDK apps.
        let appearanceHealthKitRawValue: Int =
            appearance.toHealthKit()?.rawValue
                ?? HKCategoryValueCervicalMucusQuality.dry.rawValue

        return HKCategorySample(
            type: categoryType,
            value: appearanceHealthKitRawValue,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: hkMetadata.isEmpty ? nil : hkMetadata
        )
    }
}

// MARK: - Appearance Mapping Helpers

extension HKCategoryValueCervicalMucusQuality {
    /// Converts `HKCategoryValueCervicalMucusQuality` to `CervicalMucusAppearanceTypeDto`.
    ///
    /// **Why @unknown default returns .unknown:**
    /// The `@unknown default` case handles future HealthKit versions that might add new appearance
    /// types. Rather than crashing or throwing errors, we gracefully degrade to `.unknown`,
    /// ensuring forward compatibility with future iOS versions.
    ///
    /// - Returns: The corresponding `CervicalMucusAppearanceTypeDto` for the HealthKit value
    func toCervicalMucusAppearanceTypeDto() -> CervicalMucusAppearanceTypeDto {
        switch self {
        case .dry:
            return .dry
        case .sticky:
            return .sticky
        case .creamy:
            return .creamy
        case .watery:
            return .watery
        case .eggWhite:
            return .eggWhite
        @unknown default:
            // Future-proofing: If Apple adds new cervical mucus quality types in future iOS versions,
            // we default to .unknown rather than crashing. This ensures the SDK remains functional
            // even when newer HealthKit types are introduced.
            return .unknown
        }
    }
}

extension CervicalMucusAppearanceTypeDto {
    /// Converts `CervicalMucusAppearanceTypeDto` to `HKCategoryValueCervicalMucusQuality`.
    ///
    /// **Why this returns an optional:**
    /// Not all DTO appearance types have corresponding HealthKit values. Specifically:
    /// - `.unknown`: No equivalent in HealthKit (conceptual mismatch)
    /// - `.unusual`: Not supported by HealthKit (Android Health Connect exclusive)
    ///
    /// By returning `nil` for these cases, we signal to the caller that a placeholder value
    /// (`.dry`) should be used in the native HealthKit field, while the actual value is
    /// preserved in custom metadata.
    ///
    /// - Returns: The corresponding `HKCategoryValueCervicalMucusQuality`, or `nil` if no mapping exists
    func toHealthKit() -> HKCategoryValueCervicalMucusQuality? {
        switch self {
        case .dry:
            HKCategoryValueCervicalMucusQuality.dry
        case .sticky:
            HKCategoryValueCervicalMucusQuality.sticky
        case .creamy:
            HKCategoryValueCervicalMucusQuality.creamy
        case .watery:
            HKCategoryValueCervicalMucusQuality.watery
        case .eggWhite:
            HKCategoryValueCervicalMucusQuality.eggWhite
        case .unknown, .unusual:
            // These types have no HealthKit equivalent - return nil to signal that
            // a placeholder value should be used in the native field.
            // The actual value is always stored in custom metadata.
            nil
        }
    }
}
