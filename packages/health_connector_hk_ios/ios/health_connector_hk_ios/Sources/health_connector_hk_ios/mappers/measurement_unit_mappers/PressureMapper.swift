import Foundation
import HealthKit

extension PressureDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() -> HKQuantity {
        HKQuantity(unit: .millimeterOfMercury(), doubleValue: millimetersOfMercury)
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PressureDto`.
    ///
    /// Uses millimeters of mercury as the transfer unit.
    func toPressureDto() -> PressureDto {
        let mmHg = doubleValue(for: .millimeterOfMercury())
        return PressureDto(millimetersOfMercury: mmHg)
    }
}
