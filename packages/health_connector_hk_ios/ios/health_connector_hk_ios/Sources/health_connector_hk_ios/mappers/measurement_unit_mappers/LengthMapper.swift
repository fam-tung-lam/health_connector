import Foundation
import HealthKit

extension LengthDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        HKQuantity(unit: .meter(), doubleValue: meters)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `LengthDto`.
    ///
    /// Uses meters as the transfer unit for consistency.
    func toLengthDto() -> LengthDto {
        let meters = doubleValue(for: .meter())
        return LengthDto(meters: meters)
    }
}
