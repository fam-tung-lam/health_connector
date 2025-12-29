import Foundation

// MARK: - StringSerializable Conformance

extension BloodGlucoseRelationToMealDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let general = "general"
        static let fasting = "fasting"
        static let beforeMeal = "beforeMeal"
        static let afterMeal = "afterMeal"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .general: Constants.general
        case .fasting: Constants.fasting
        case .beforeMeal: Constants.beforeMeal
        case .afterMeal: Constants.afterMeal
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.general: .general
        case Constants.fasting: .fasting
        case Constants.beforeMeal: .beforeMeal
        case Constants.afterMeal: .afterMeal
        default: nil
        }
    }
}

extension BloodGlucoseSpecimenSourceDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let interstitialFluid = "interstitialFluid"
        static let capillaryBlood = "capillaryBlood"
        static let plasma = "plasma"
        static let serum = "serum"
        static let tears = "tears"
        static let wholeBlood = "wholeBlood"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .interstitialFluid: Constants.interstitialFluid
        case .capillaryBlood: Constants.capillaryBlood
        case .plasma: Constants.plasma
        case .serum: Constants.serum
        case .tears: Constants.tears
        case .wholeBlood: Constants.wholeBlood
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.interstitialFluid: .interstitialFluid
        case Constants.capillaryBlood: .capillaryBlood
        case Constants.plasma: .plasma
        case Constants.serum: .serum
        case Constants.tears: .tears
        case Constants.wholeBlood: .wholeBlood
        default: nil
        }
    }
}

// MARK: - Metadata Keys

/// Custom metadata key for storing blood glucose relation to meal.
///
/// **Why this exists:**
/// HealthKit's `HKMetadataKeyBloodGlucoseMealTime` only supports `preprandial` (before meal)
/// and `postprandial` (after meal). We need to support additional states from Android Health
/// Connect: `unknown`, `general`, and `fasting`.
///
/// **Storage strategy:**
/// - Write: Store full string value in custom metadata + native HK key when mappable
/// - Read: Priority 1 = custom metadata, Priority 2 = native HK key, Priority 3 = unknown
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_relation_to_meal`
enum BloodGlucoseRelationToMealKey: StringEnumMetadataKey {
    typealias Value = BloodGlucoseRelationToMealDto

    static let keySuffix = "relation_to_meal"
    static let defaultValue: BloodGlucoseRelationToMealDto = .unknown
}

/// Custom metadata key for storing blood glucose specimen source.
///
/// **Why this exists:**
/// HealthKit has no native support for specimen source. This information is important
/// for clinical accuracy of blood glucose readings.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_specimen_source`
enum BloodGlucoseSpecimenSourceKey: StringEnumMetadataKey {
    typealias Value = BloodGlucoseSpecimenSourceDto

    static let keySuffix = "specimen_source"
    static let defaultValue: BloodGlucoseSpecimenSourceDto = .unknown
}

/// Custom metadata key for storing blood glucose meal type.
///
/// **Why this exists:**
/// HealthKit has no native support for meal type context on blood glucose readings.
/// This allows tracking which meal the reading was associated with.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_meal_type`
///
/// **Note:** This key is shared with `NutrientMealTypeKey` and uses the same
/// serialization format for consistency.
enum BloodGlucoseMealTypeKey: StringEnumMetadataKey {
    typealias Value = MealTypeDto

    static let keySuffix = "meal_type"
    static let defaultValue: MealTypeDto = .unknown
}
