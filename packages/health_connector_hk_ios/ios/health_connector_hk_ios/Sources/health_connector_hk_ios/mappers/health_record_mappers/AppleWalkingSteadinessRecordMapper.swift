import Foundation
import HealthKit

extension WalkingSteadinessRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .appleWalkingSteadiness)

        let quantity = HKQuantity(unit: .percent(), doubleValue: percentage)
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
    /// Converts this HealthKit sample to a `WalkingSteadinessRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an apple walking steadiness sample.
    func toWalkingSteadinessRecordDto() throws -> WalkingSteadinessRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.appleWalkingSteadiness.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected apple walking steadiness quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.appleWalkingSteadiness.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Convert quantity to percentage (stored as decimal 0.0-1.0)
        let percentage = quantity.doubleValue(for: .percent())

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try WalkingSteadinessRecordDto(
            percentage: percentage,
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
