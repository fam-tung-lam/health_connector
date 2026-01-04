import Foundation
import HealthKit

extension TemperatureDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        HKQuantity(unit: .degreeCelsius(), doubleValue: celsius)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `TemperatureDto`.
    ///
    /// Uses celsius as the transfer unit for consistency.
    func toTemperatureDto() -> TemperatureDto {
        let celsius = doubleValue(for: .degreeCelsius())
        return TemperatureDto(celsius: celsius)
    }
}
