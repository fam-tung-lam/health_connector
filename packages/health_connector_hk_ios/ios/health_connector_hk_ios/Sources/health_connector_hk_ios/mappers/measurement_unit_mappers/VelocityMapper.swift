import Foundation
import HealthKit

extension VelocityDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit = HKUnit.meter().unitDivided(by: .second())
        return HKQuantity(unit: unit, doubleValue: metersPerSecond)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `VelocityDto`.
    ///
    /// Uses meters per second as the transfer unit for consistency.
    func toVelocityDto() -> VelocityDto {
        let metersPerSecond = doubleValue(for: .meter().unitDivided(by: .second()))
        return VelocityDto(metersPerSecond: metersPerSecond)
    }
}
