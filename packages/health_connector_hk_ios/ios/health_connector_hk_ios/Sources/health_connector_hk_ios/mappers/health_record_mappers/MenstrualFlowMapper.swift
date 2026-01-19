import Foundation
import HealthKit

// MARK: - Enum Mapping Helpers

/// Extension for mapping `MenstrualFlowDto` → `Int`.
extension MenstrualFlowDto {
    /// Converts `MenstrualFlowDto` to HealthKit menstrual flow value.
    ///
    /// Uses iOS version checks to select appropriate enum:
    /// - iOS 18+: `HKCategoryValueVaginalBleeding`
    /// - iOS ≤17: `HKCategoryValueMenstrualFlow`
    func toHealthKit() -> Int {
        if #available(iOS 18.0, *) {
            // Use HKCategoryValueVaginalBleeding for iOS 18+
            let hkValue: HKCategoryValueVaginalBleeding =
                switch self {
                case .unknown:
                    .unspecified
                case .light:
                    .light
                case .medium:
                    .medium
                case .heavy:
                    .heavy
                }
            return hkValue.rawValue
        } else {
            // Use HKCategoryValueMenstrualFlow for iOS ≤17
            let hkValue: HKCategoryValueMenstrualFlow =
                switch self {
                case .unknown:
                    .unspecified
                case .light:
                    .light
                case .medium:
                    .medium
                case .heavy:
                    .heavy
                }
            return hkValue.rawValue
        }
    }
}

// MARK: - HealthKit to DTO Conversion

/// Extension for mapping `Int` → `MenstrualFlowDto`.
extension Int {
    /// Converts a HealthKit menstrual flow value to `MenstrualFlowDto`.
    ///
    /// Handles both iOS 17 and iOS 18+ enum types, mapping `.none` to `.unknown`.
    func toMenstrualFlowDto() -> MenstrualFlowDto {
        if #available(iOS 18.0, *) {
            // Handle HKCategoryValueVaginalBleeding for iOS 18+
            guard let hkValue = HKCategoryValueVaginalBleeding(rawValue: self) else {
                return .unknown
            }

            switch hkValue {
            case .unspecified:
                return .unknown
            case .none:
                // iOS .none (no bleeding) maps to unknown
                return .unknown
            case .light:
                return .light
            case .medium:
                return .medium
            case .heavy:
                return .heavy
            @unknown default:
                return .unknown
            }
        } else {
            // Handle HKCategoryValueMenstrualFlow for iOS ≤17
            guard let hkValue = HKCategoryValueMenstrualFlow(rawValue: self) else {
                return .unknown
            }

            switch hkValue {
            case .unspecified:
                return .unknown
            case .none:
                // iOS .none (no bleeding) maps to unknown
                return .unknown
            case .light:
                return .light
            case .medium:
                return .medium
            case .heavy:
                return .heavy
            @unknown default:
                return .unknown
            }
        }
    }
}
