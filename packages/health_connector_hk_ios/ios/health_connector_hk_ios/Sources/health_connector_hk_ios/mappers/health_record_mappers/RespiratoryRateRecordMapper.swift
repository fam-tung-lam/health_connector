import Foundation
import HealthKit

extension RespiratoryRateRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .respiratoryRate)

        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: rate.value)
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
    func toRespiratoryRateRecordDto() -> RespiratoryRateRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.respiratoryRate.rawValue else {
            return nil
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
            rate: NumericDto(unit: .numeric, value: quantity.doubleValue(for: unit)),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
