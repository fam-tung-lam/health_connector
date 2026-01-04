import Foundation
import HealthKit

extension VolumeDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        HKQuantity(unit: .liter(), doubleValue: liters)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `VolumeDto`.
    ///
    /// Uses liters as the transfer unit for consistency.
    func toVolumeDto() -> VolumeDto {
        let liters = doubleValue(for: .liter())
        return VolumeDto(liters: liters)
    }
}
