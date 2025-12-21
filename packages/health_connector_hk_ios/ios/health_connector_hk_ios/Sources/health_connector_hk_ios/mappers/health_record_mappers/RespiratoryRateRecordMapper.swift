import Foundation
import HealthKit

extension RespiratoryRateRecordDto {
    /// Converts this DTO to a HealthKit sample.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .respiratoryRate)

        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: Double(breathsPerMin.value))
        let date = Date(millisecondsSince1970: time)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `RespiratoryRateRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a respiratory rate sample.
    func toRespiratoryRateRecordDto() throws -> RespiratoryRateRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.respiratoryRate.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected respiratory rate quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.respiratoryRate.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let unit = HKUnit.count().unitDivided(by: .minute()) // breaths/min

        return RespiratoryRateRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            breathsPerMin: NumberDto(value: quantity.doubleValue(for: unit)),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
