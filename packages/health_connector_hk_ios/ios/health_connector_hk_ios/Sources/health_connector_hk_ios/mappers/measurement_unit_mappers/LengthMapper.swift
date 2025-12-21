import Foundation
import HealthKit

extension LengthDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .meters:
                .meter()
            case .kilometers:
                .meterUnit(with: .kilo)
            case .miles:
                .mile()
            case .feet:
                .foot()
            case .inches:
                .inch()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `LengthDto`.
    ///
    /// Uses meters as the transfer unit for consistency.
    func toLengthDto() -> LengthDto {
        let meters = doubleValue(for: .meter())
        return LengthDto(unit: .meters, value: meters)
    }
}
