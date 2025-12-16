import Foundation
import HealthKit

extension FloorsClimbedRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .flightsClimbed)

        let quantity = HKQuantity(unit: .count(), doubleValue: floors.value)
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

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
    /// Converts this HealthKit sample to a `FloorsClimbedRecordDto`.
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
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: startDate.millisecondsSince1970,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
