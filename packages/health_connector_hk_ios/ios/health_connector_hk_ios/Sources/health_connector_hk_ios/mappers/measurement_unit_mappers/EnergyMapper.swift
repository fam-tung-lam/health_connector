import Foundation
import HealthKit

extension EnergyDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        HKQuantity(unit: .kilocalorie(), doubleValue: kilocalories)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to an `EnergyDto`.
    ///
    /// Uses kilocalories as the transfer unit for consistency.
    func toEnergyDto() -> EnergyDto {
        let kilocalories = doubleValue(for: .kilocalorie())
        return EnergyDto(kilocalories: kilocalories)
    }
}
