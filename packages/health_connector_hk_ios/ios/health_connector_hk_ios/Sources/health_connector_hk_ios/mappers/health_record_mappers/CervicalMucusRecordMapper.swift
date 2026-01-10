import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

extension HKCategorySample {
    /// Converts a HealthKit cervical mucus category sample to `CervicalMucusRecordDto`.
    ///
    /// **Reading strategy - Appearance:**
    /// We implement a fallback chain to handle various data sources:
    /// 1. **Custom metadata (priority 1):** Check `CervicalMucusAppearanceKey`
    ///    - This handles records written by our SDK (includes `.unusual` and `.unknown`)
    ///    - This handles all 7 appearance types with full fidelity
    /// 2. **Native HealthKit value (priority 2):** Parse `HKCategoryValueCervicalMucusQuality`
    ///    - This handles records written by Apple Health app or other apps
    ///    - Only supports 5 appearance types (dry, sticky, creamy, watery, eggWhite)
    /// 3. **Default to `.unknown` (priority 3):** If both above fail
    ///
    /// **Reading strategy - Sensation:**
    /// Sensation has a simpler strategy since HealthKit provides no native support:
    /// 1. **Custom metadata (only source):** Parse from `CervicalMucusSensationKey`
    /// 2. **Default to `.unknown`:** If metadata is absent
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if custom metadata contains invalid string values
    /// - Returns: `CervicalMucusRecordDto` with appearance and sensation populated from available sources
    func toCervicalMucusRecordDto() throws -> CervicalMucusRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Appearance Handling:
        // Priority 1: Custom metadata (supports all 7 types including .unusual and .unknown)
        // Priority 2: Native HealthKit value (supports only 5 types)
        // Priority 3: Default to .unknown
        let appearance: CervicalMucusAppearanceDto =
            if let customAppearance = CervicalMucusAppearanceKey.read(from: builder.metadataDict) {
                customAppearance
            } else if let hkAppearance = HKCategoryValueCervicalMucusQuality(rawValue: value) {
                hkAppearance.toCervicalMucusAppearanceDto()
            } else {
                .unknown
            }

        // Sensation Handling:
        // HealthKit has no native support, so we only check custom metadata.
        let sensation = CervicalMucusSensationKey.readOrDefault(from: builder.metadataDict)

        return try CervicalMucusRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            zoneOffsetSeconds: zoneOffset,
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
    /// Only values 1-5 are valid. Value 0 (.notApplicable) causes a runtime crash.
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
        let endDate = startDate // Cervical mucus is an instant observation

        // Build metadata using centralized builder
        var builder = try MetadataBuilder(
            from: metadata)
        builder.set(CervicalMucusAppearanceKey.self, value: appearance)
        builder.set(CervicalMucusSensationKey.self, value: sensation)

        // Determine native HealthKit category value:
        // - Supported types: use actual value
        // - Unsupported (.unusual, .unknown): use .dry as placeholder
        let appearanceHealthKitRawValue: Int =
            appearance.toHealthKit()?.rawValue
                ?? HKCategoryValueCervicalMucusQuality.dry.rawValue

        return HKCategorySample(
            type: categoryType,
            value: appearanceHealthKitRawValue,
            start: startDate,
            end: endDate,
            device: builder.healthDevice,
            metadata: builder.build()
        )
    }
}

// MARK: - Appearance Mapping Helpers

extension HKCategoryValueCervicalMucusQuality {
    /// Converts `HKCategoryValueCervicalMucusQuality` to `CervicalMucusAppearanceDto`.
    ///
    /// The `@unknown default` case handles future HealthKit versions that might add new
    /// appearance types, gracefully degrading to `.unknown`.
    func toCervicalMucusAppearanceDto() -> CervicalMucusAppearanceDto {
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
            return .unknown
        }
    }
}

extension CervicalMucusAppearanceDto {
    /// Converts `CervicalMucusAppearanceDto` to `HKCategoryValueCervicalMucusQuality`.
    ///
    /// Returns `nil` for types without HealthKit equivalents (`.unknown`, `.unusual`),
    /// signaling that a placeholder value should be used in the native field.
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
            nil
        }
    }
}
