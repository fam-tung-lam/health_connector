import Foundation
import HealthKit

/// Extension for mapping `BodyFatPercentageRecordDto` → `HKQuantitySample`.
extension BodyFatPercentageRecordDto {
    /// Converts this `BodyFatPercentageRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bodyFatPercentage)

        let unit = HKUnit.percent()
        let quantity = HKQuantity(unit: unit, doubleValue: percentage)
        let date = Date(millisecondsSince1970: time)

        // Create builder with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: zoneOffsetSeconds
        )

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}

/// Extension for mapping `HKQuantitySample` → `BodyFatPercentageRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `BodyFatPercentageRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a body fat percentage sample.
    func toBodyFatPercentageRecordDto() throws -> BodyFatPercentageRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyFatPercentage.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected body fat percentage quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.bodyFatPercentage.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try BodyFatPercentageRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            percentage: quantity.doubleValue(for: HKUnit.percent()),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
