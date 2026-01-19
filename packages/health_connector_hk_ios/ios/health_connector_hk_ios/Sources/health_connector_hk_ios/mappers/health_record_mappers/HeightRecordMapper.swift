import Foundation
import HealthKit

/// Extension for mapping `HeightRecordDto` → `HKQuantitySample`.
extension HeightRecordDto {
    /// Converts this `HeightRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .height)

        let unit = HKUnit.meter()
        let quantity = HKQuantity(unit: unit, doubleValue: meters)
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

/// Extension for mapping `HKQuantitySample` → `HeightRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `HeightRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a height sample.
    func toHeightRecordDto() throws -> HeightRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.height.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected height quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.height.rawValue,
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

        return try HeightRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            meters: quantity.doubleValue(for: HKUnit.meter()),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
