import Foundation
import HealthKit

extension CyclingPowerRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        if #available(iOS 17.0, *) {
            let type = try HKQuantityType.make(from: .cyclingPower)

            let quantity = try power.toHealthKit()
            let date = Date(millisecondsSince1970: time)

            return HKQuantitySample(
                type: type,
                quantity: quantity,
                start: date,
                end: date, // Instant records have same start and end
                device: metadata.toHealthKitDevice(),
                metadata: metadata.toHealthKitMetadata()
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Cycling power is only supported on iOS 17.0 and later",
                context: ["dataType": "cyclingPower", "minimumIOSVersion": "17.0"]
            )
        }
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `CyclingPowerRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a cycling power sample.
    func toCyclingPowerRecordDto() throws -> CyclingPowerRecordDto {
        if #available(iOS 17.0, *) {
            guard quantityType.identifier == HKQuantityTypeIdentifier.cyclingPower.rawValue else {
                throw HealthConnectorError.invalidArgument(
                    message: "Expected cycling power quantity type, got \(quantityType.identifier)",
                    context: [
                        "expected": HKQuantityTypeIdentifier.cyclingPower.rawValue,
                        "actual": quantityType.identifier,
                    ]
                )
            }

            let metadataDict = metadata ?? [:]
            let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

            return try CyclingPowerRecordDto(
                id: uuid.uuidString,
                metadata: metadataDict.toMetadataDto(
                    source: sourceRevision.source,
                    device: device
                ),
                time: startDate.millisecondsSince1970,
                power: quantity.toPowerDto(),
                zoneOffsetSeconds: zoneOffset
            )
        } else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Cycling power is only supported on iOS 17.0 and later",
                context: ["dataType": "cyclingPower", "minimumIOSVersion": "17.0"]
            )
        }
    }
}
