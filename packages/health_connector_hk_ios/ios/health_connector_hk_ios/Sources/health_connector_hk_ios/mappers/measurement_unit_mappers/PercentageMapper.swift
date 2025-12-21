import Foundation
import HealthKit

extension PercentageDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let percentValue: Double =
            switch unit {
            case .decimal:
                value
            case .whole:
                value / 100.0
            }
        return HKQuantity(unit: .percent(), doubleValue: percentValue)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PercentageDto`.
    ///
    /// Uses decimal as the transfer unit for consistency (0.0 to 1.0).
    func toPercentageDto() -> PercentageDto {
        let decimalValue = doubleValue(for: .percent())
        return PercentageDto(unit: .decimal, value: decimalValue)
    }
}
