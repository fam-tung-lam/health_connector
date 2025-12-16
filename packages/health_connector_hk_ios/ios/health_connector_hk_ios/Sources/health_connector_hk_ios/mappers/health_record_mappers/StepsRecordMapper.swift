import Foundation
import HealthKit

extension StepRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .stepCount)

        let quantity = HKQuantity(unit: .count(), doubleValue: count.value)
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
    /// Converts this HealthKit sample to a `StepRecordDto`.
    ///
    /// Returns `nil` if this sample is not a step count sample.
    func toStepRecordDto() -> StepRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.stepCount.rawValue else {
            return nil
        }

        let count = Int64(quantity.doubleValue(for: .count()))

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return StepRecordDto(
            count: count.toNumericDto(),
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
