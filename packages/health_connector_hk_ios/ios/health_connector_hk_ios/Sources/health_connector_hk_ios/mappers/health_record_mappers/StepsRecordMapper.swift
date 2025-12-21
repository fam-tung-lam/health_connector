import Foundation
import HealthKit

extension StepsRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .stepCount)

        let quantity = HKQuantity(unit: .count(), doubleValue: count.toDouble())
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
    /// Converts this HealthKit sample to a `StepsRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a step count sample.
    func toStepsRecordDto() throws -> StepsRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.stepCount.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected step count quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.stepCount.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let count = Int64(quantity.doubleValue(for: .count()))

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return StepsRecordDto(
            count: count.toNumberDto(),
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
