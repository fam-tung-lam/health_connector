import Foundation
import HealthKit

extension MassDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        HKQuantity(unit: .gramUnit(with: .kilo), doubleValue: kilograms)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `MassDto`.
    ///
    /// Uses kilograms as the transfer unit for consistency.
    func toMassDto() -> MassDto {
        let kilograms = doubleValue(for: .gramUnit(with: .kilo))
        return MassDto(kilograms: kilograms)
    }
}
