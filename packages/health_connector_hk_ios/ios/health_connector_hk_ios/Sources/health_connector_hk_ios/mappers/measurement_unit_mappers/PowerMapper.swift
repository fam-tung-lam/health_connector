import Foundation
import HealthKit

extension PowerDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    @available(iOS 16.0, *)
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .watts:
                .watt()
            case .kilowatts:
                .wattUnit(with: .kilo)
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PowerDto`.
    ///
    /// Uses watts as the transfer unit for consistency.
    @available(iOS 16.0, *)
    func toPowerDto() -> PowerDto {
        let watts = doubleValue(for: .watt())
        return PowerDto(unit: .watts, value: watts)
    }
}
