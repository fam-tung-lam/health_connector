import Foundation
import HealthKit

extension TemperatureDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .celsius:
                .degreeCelsius()
            case .fahrenheit:
                .degreeFahrenheit()
            case .kelvin:
                .kelvin()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `TemperatureDto`.
    ///
    /// Uses celsius as the transfer unit for consistency.
    func toTemperatureDto() -> TemperatureDto {
        let celsius = doubleValue(for: .degreeCelsius())
        return TemperatureDto(unit: .celsius, value: celsius)
    }
}
