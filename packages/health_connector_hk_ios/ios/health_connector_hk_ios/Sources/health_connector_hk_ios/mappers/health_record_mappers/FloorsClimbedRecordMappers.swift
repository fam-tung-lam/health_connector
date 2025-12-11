import Foundation
import HealthKit

extension FloorsClimbedRecordDto {
    /*
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .flightsClimbed) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create flights climbed quantity type"]
            )
        }

        let quantity = HKQuantity(unit: .count(), doubleValue: floors.value)
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
        )
    }
}

extension HKQuantitySample {
    /*
     * Converts this HealthKit sample to a `FloorsClimbedRecordDto`.
     */
    func toFloorsClimbedRecordDto() -> FloorsClimbedRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.flightsClimbed.rawValue else {
            return nil
        }

        let unit = HKUnit.count()
        let value = quantity.doubleValue(for: unit)

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return FloorsClimbedRecordDto(
            floors: NumericDto(unit: NumericUnitDto.numeric, value: value),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
