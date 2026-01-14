import Foundation
import HealthKit

extension FloorsClimbedRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .flightsClimbed)

        let quantity = HKQuantity(unit: .count(), doubleValue: floors)
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

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `FloorsClimbedRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a floors climbed sample.
    func toFloorsClimbedRecordDto() throws -> FloorsClimbedRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.flightsClimbed.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected flights climbed quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.flightsClimbed.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let floorsClimbed = quantity.doubleValue(for: HKUnit.count())
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try FloorsClimbedRecordDto(
            floors: floorsClimbed,
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
