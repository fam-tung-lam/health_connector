import Foundation
import HealthKit

extension VolumeDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .liters:
                .liter()
            case .milliliters:
                .literUnit(with: .milli)
            case .fluidOuncesUs:
                .fluidOunceUS()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `VolumeDto`.
    ///
    /// Uses liters as the transfer unit for consistency.
    func toVolumeDto() -> VolumeDto {
        let liters = doubleValue(for: .liter())
        return VolumeDto(unit: .liters, value: liters)
    }
}
