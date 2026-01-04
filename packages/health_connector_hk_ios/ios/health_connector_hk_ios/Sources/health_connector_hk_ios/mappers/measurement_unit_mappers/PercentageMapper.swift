import Foundation
import HealthKit

extension PercentageDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        HKQuantity(unit: .percent(), doubleValue: decimal)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PercentageDto`.
    ///
    /// Uses decimal as the transfer unit for consistency (0.0 to 1.0).
    func toPercentageDto() -> PercentageDto {
        let decimalValue = doubleValue(for: .percent())
        return PercentageDto(decimal: decimalValue)
    }
}
