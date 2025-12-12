import Foundation
import HealthKit

extension RespiratoryRateRecordDto {
    /*
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .respiratoryRate) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create respiratory rate quantity type"]
            )
        }

        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: rate.value)
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

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
    /*
     * Converts this HealthKit sample to a `RespiratoryRateRecordDto`.
     */
    func toRespiratoryRateRecordDto() -> RespiratoryRateRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.respiratoryRate.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let unit = HKUnit.count().unitDivided(by: .minute()) // breaths/min

        return RespiratoryRateRecordDto(
            id: uuid.uuidString,
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            rate: NumericDto(unit: .numeric, value: quantity.doubleValue(for: unit)),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
