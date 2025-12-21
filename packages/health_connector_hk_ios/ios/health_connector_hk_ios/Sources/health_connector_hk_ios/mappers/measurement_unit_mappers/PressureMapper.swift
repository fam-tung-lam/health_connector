import Foundation
import HealthKit

extension PressureDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        let unit: HKUnit =
            switch self.unit {
            case .millimetersOfMercury:
                .millimeterOfMercury()
            }
        return HKQuantity(unit: unit, doubleValue: value)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PressureDto`.
    ///
    /// Uses millimeters of mercury as the transfer unit.
    func toPressureDto() -> PressureDto {
        let mmHg = doubleValue(for: .millimeterOfMercury())
        return PressureDto(unit: .millimetersOfMercury, value: mmHg)
    }
}
