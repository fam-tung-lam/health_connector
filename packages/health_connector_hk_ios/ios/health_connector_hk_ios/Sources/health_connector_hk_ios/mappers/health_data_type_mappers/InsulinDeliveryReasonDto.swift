import Foundation
import HealthKit

/// Extension for mapping `InsulinDeliveryReasonDto` ↔ `HKInsulinDeliveryReason`.
extension InsulinDeliveryReasonDto {
    /// Converts this DTO to a HealthKit insulin delivery reason.
    var toHKInsulinDeliveryReason: HKInsulinDeliveryReason {
        switch self {
        case .basal:
            .basal
        case .bolus:
            .bolus
        }
    }

    /// Creates an `InsulinDeliveryReasonDto` from a HealthKit insulin delivery reason.
    ///
    /// - Parameter reason: The HealthKit insulin delivery reason.
    /// - Returns: The corresponding `InsulinDeliveryReasonDto`.
    static func from(hkInsulinDeliveryReason reason: HKInsulinDeliveryReason)
        -> InsulinDeliveryReasonDto
    {
        switch reason {
        case .basal:
            return .basal
        case .bolus:
            return .bolus
        @unknown default:
            return .basal
        }
    }
}
