import Foundation

// MARK: - MealTypeDto to String Mapping

extension MealTypeDto {
    /**
     * Converts this MealTypeDto to a string representation for HealthKit metadata.
     *
     * HealthKit doesn't have a dedicated meal type enum, but we store meal type
     * information as metadata on nutrition samples.
     *
     * - Returns: String representation of the meal type.
     */
    func toString() -> String {
        switch self {
        case .unknown:
            return "unknown"
        case .breakfast:
            return "breakfast"
        case .lunch:
            return "lunch"
        case .dinner:
            return "dinner"
        case .snack:
            return "snack"
        }
    }

    /**
     * Creates a MealTypeDto from a string representation.
     *
     * - Parameter string: The string representation of the meal type
     * - Returns: The corresponding MealTypeDto, defaulting to .unknown if not recognized
     */
    static func fromString(_ string: String?) -> MealTypeDto {
        guard let string = string else {
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
