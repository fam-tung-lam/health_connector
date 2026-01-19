import Foundation

// MARK: - StringSerializable Conformance

extension CervicalMucusAppearanceDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let dry = "dry"
        static let sticky = "sticky"
        static let creamy = "creamy"
        static let watery = "watery"
        static let eggWhite = "eggWhite"
        static let unusual = "unusual"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .dry: Constants.dry
        case .sticky: Constants.sticky
        case .creamy: Constants.creamy
        case .watery: Constants.watery
        case .eggWhite: Constants.eggWhite
        case .unusual: Constants.unusual
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.dry: .dry
        case Constants.sticky: .sticky
        case Constants.creamy: .creamy
        case Constants.watery: .watery
        case Constants.eggWhite: .eggWhite
        case Constants.unusual: .unusual
        default: nil
        }
    }
}

extension CervicalMucusSensationDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let light = "light"
        static let medium = "medium"
        static let heavy = "heavy"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .light: Constants.light
        case .medium: Constants.medium
        case .heavy: Constants.heavy
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.light: .light
        case Constants.medium: .medium
        case Constants.heavy: .heavy
        default: nil
        }
    }
}

// MARK: - Metadata Keys

/// Custom metadata key for storing cervical mucus appearance type as a string.
///
/// ## Why this exists
///
/// HealthKit's `HKCategoryValueCervicalMucusQuality` only supports 5 appearance types
/// (dry, sticky, creamy, watery, eggWhite), but Android Health Connect supports 7 types
/// (including `unusual` and `unknown`). To maintain cross-platform parity and avoid data loss,
/// we store the complete appearance information in custom metadata.
///
/// ## Storage strategy
///
/// - All 7 appearance types are stored as strings in this metadata key
/// - Native HealthKit values are used when available (dry, sticky, creamy, watery, eggWhite)
/// - For `.unusual` and `.unknown`, we use `.dry` (value 1) as a placeholder in the native
///   field since HealthKit doesn't accept invalid values for cervical mucus quality
/// - On read, custom metadata takes priority over native HealthKit values to ensure
///   we always retrieve the correct appearance type
enum CervicalMucusAppearanceKey: StringEnumMetadataKey {
    typealias Value = CervicalMucusAppearanceDto

    static let keySuffix = "cervical_mucus_appearance_type"
    static let defaultValue: CervicalMucusAppearanceDto = .unknown
}

/// Custom metadata key for storing cervical mucus sensation type as a string.
///
/// ## Why this exists
///
/// HealthKit's `HKCategoryTypeIdentifier.cervicalMucusQuality` exclusively tracks appearance
/// and has **no support whatsoever** for sensation (light, medium, heavy). Android Health Connect,
/// however, fully supports sensation tracking. To maintain cross-platform parity, we must store
/// sensation information in custom metadata.
///
/// ## Storage strategy
///
/// - All sensation values are stored as strings in this metadata key
/// - On read, we parse the string back to the DTO enum, defaulting to `.unknown` if absent
enum CervicalMucusSensationKey: StringEnumMetadataKey {
    typealias Value = CervicalMucusSensationDto

    static let keySuffix = "cervical_mucus_sensation_type"
    static let defaultValue: CervicalMucusSensationDto = .unknown
}
