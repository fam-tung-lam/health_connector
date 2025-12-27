import Foundation
import HealthKit

extension PowerDto {
    /// Converts this DTO to a HealthKit `HKQuantity`.
    func toHealthKit() throws -> HKQuantity {
        if #available(iOS 17.0, *) {
            let unit: HKUnit =
                switch self.unit {
                case .watts:
                    .watt()
                case .kilowatts:
                    .wattUnit(with: .kilo)
                }
            return HKQuantity(unit: unit, doubleValue: value)
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Cycling power is only supported on iOS 17.0 and later",
                context: ["dataType": "cyclingPower", "minimumIOSVersion": "17.0"]
            )
        }
    }
}

extension HKQuantity {
    /// Converts this HealthKit quantity to a `PowerDto`.
    ///
    /// Uses watts as the transfer unit for consistency.
    func toPowerDto() throws -> PowerDto {
        if #available(iOS 17.0, *) {
            let watts = doubleValue(for: .watt())
            return PowerDto(unit: .watts, value: watts)
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Cycling power is only supported on iOS 17.0 and later",
                context: ["dataType": "cyclingPower", "minimumIOSVersion": "17.0"]
            )
        }
    }
}
