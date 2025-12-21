import Foundation
import HealthKit

extension MassDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .kilograms:
                .gramUnit(with: .kilo)
            case .grams:
                .gram()
            case .pounds:
                .pound()
            case .ounces:
                .ounce()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `MassDto`.
    ///
    /// Uses kilograms as the transfer unit for consistency.
    func toMassDto() -> MassDto {
        let kilograms = doubleValue(for: .gramUnit(with: .kilo))
        return MassDto(unit: .kilograms, value: kilograms)
    }
}
