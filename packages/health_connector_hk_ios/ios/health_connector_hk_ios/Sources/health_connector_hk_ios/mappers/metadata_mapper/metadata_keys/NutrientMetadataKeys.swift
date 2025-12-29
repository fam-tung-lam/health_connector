import Foundation

// MARK: - StringSerializable Conformance

extension MealTypeDto: StringSerializable {
    private enum Constants {
        static let unknown = "unknown"
        static let breakfast = "breakfast"
        static let lunch = "lunch"
        static let dinner = "dinner"
        static let snack = "snack"
    }

    func toMetadataString() -> String {
        switch self {
        case .unknown: Constants.unknown
        case .breakfast: Constants.breakfast
        case .lunch: Constants.lunch
        case .dinner: Constants.dinner
        case .snack: Constants.snack
        }
    }

    static func fromMetadataString(_ string: String) -> Self? {
        switch string {
        case Constants.unknown: .unknown
        case Constants.breakfast: .breakfast
        case Constants.lunch: .lunch
        case Constants.dinner: .dinner
        case Constants.snack: .snack
        default: nil
        }
    }
}

// MARK: - Metadata Keys

/// Custom metadata key for storing meal type on nutrient records.
///
/// **Why this exists:**
/// HealthKit does not have a standard metadata key for meal type context on
/// individual nutrient quantity samples. We use a custom key to preserve
/// meal context from the nutrition record.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_meal_type`
///
/// **Note:** This uses the same key suffix as `BloodGlucoseMealTypeKey` because
/// both represent the same concept and use the same `MealTypeDto` enum.
enum NutrientMealTypeKey: StringEnumMetadataKey {
    typealias Value = MealTypeDto

    static let keySuffix = "meal_type"
    static let defaultValue: MealTypeDto = .unknown
}

/// Custom metadata key for storing food name on nutrient records.
///
/// **Why this exists:**
/// HealthKit does not associate a food name with individual nutrient samples.
/// We preserve the food name from the original nutrition record in custom metadata.
///
/// **Key:** `com.phamtunglam.health_connector_hk_ios.hk_metadata_key_food_name`
enum NutrientFoodNameKey: CustomMetadataKey {
    typealias Value = String

    static let keySuffix = "food_name"

    static func serialize(_ value: String) -> Any {
        value
    }

    static func deserialize(_ rawValue: Any?) -> String? {
        rawValue as? String
    }
}
