import Foundation

/**
 * HealthKit doesn't have a dedicated meal type enum, so we store meal type
 * information as metadata on nutrition samples.
 */
extension MealTypeDto {
    /**
     * Converts this MealTypeDto to a string representation for HealthKit metadata.
     */
    func toString() -> String {
        switch self {
        case .unknown:
            "unknown"
        case .breakfast:
            "breakfast"
        case .lunch:
            "lunch"
        case .dinner:
            "dinner"
        case .snack:
            "snack"
        }
    }

    /**
     * Creates a MealTypeDto from a string representation.
     */
    static func fromString(_ string: String?) -> MealTypeDto {
        guard let string else {
            return .unknown
        }

        switch string.lowercased() {
        case "breakfast":
            return .breakfast
        case "lunch":
            return .lunch
        case "dinner":
            return .dinner
        case "snack":
            return .snack
        default:
            return .unknown
        }
    }
}
