import Foundation
import HealthKit

extension BloodGlucoseDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        // Molar mass of glucose is 180.16 g/mol
        let unit = HKUnit.moleUnit(with: .milli, molarMass: 180.16)
            .unitDivided(by: .liter())
        return HKQuantity(unit: unit, doubleValue: millimolesPerLiter)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `BloodGlucoseDto`.
    ///
    /// Uses millimoles per liter as the transfer unit for consistency.
    func toBloodGlucoseDto() -> BloodGlucoseDto {
        // Molar mass of glucose is 180.16 g/mol
        let mmolPerL = doubleValue(
            for: HKUnit.moleUnit(with: .milli, molarMass: 180.16)
                .unitDivided(by: .liter()))
        return BloodGlucoseDto(millimolesPerLiter: mmolPerL)
    }
}
