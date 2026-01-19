import Foundation
import HealthKit

/// Extension for mapping `StepsRecordDto` → `HKQuantitySample`.
extension StepsRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .stepCount)

        let quantity = HKQuantity(unit: .count(), doubleValue: count)
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

        // Create builder with timezone offsets
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: startZoneOffsetSeconds,
            endTimeZoneOffset: endZoneOffsetSeconds
        )

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}

/// Extension for mapping `HKQuantitySample` → `StepsRecordDto`.
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

        let count = quantity.doubleValue(for: .count())

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try StepsRecordDto(
            count: count,
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
