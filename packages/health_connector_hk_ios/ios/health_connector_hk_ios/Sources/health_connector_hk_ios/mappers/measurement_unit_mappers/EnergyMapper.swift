import Foundation
import HealthKit

extension EnergyDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .kilocalories:
                .kilocalorie()
            case .kilojoules:
                .jouleUnit(with: .kilo)
            case .calories:
                .smallCalorie()
            case .joules:
                .joule()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to an `EnergyDto`.
    ///
    /// Uses kilocalories as the transfer unit for consistency.
    func toEnergyDto() -> EnergyDto {
        let kilocalories = doubleValue(for: .kilocalorie())
        return EnergyDto(unit: .kilocalories, value: kilocalories)
    }
}
