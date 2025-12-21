import Foundation
import HealthKit

extension VelocityDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .metersPerSecond:
                .meter().unitDivided(by: .second())
            case .kilometersPerHour:
                .meterUnit(with: .kilo).unitDivided(by: .hour())
            case .milesPerHour:
                .mile().unitDivided(by: .hour())
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `VelocityDto`.
    ///
    /// Uses meters per second as the transfer unit for consistency.
    func toVelocityDto() -> VelocityDto {
        let metersPerSecond = doubleValue(for: .meter().unitDivided(by: .second()))
        return VelocityDto(unit: .metersPerSecond, value: metersPerSecond)
    }
}
