import Foundation
import HealthKit

/// Extension for mapping `AlcoholicBeveragesRecordDto` → `HKQuantitySample`.
extension AlcoholicBeveragesRecordDto {
    /// Converts this `AlcoholicBeveragesRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .numberOfAlcoholicBeverages)

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

/// Extension for mapping `HKQuantitySample` → `AlcoholicBeveragesRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to an `AlcoholicBeveragesRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an alcoholic beverages sample.
    func toAlcoholicBeveragesRecordDto() throws -> AlcoholicBeveragesRecordDto {
        guard
            quantityType.identifier == HKQuantityTypeIdentifier.numberOfAlcoholicBeverages.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected alcoholic beverages quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.numberOfAlcoholicBeverages.rawValue,
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

        return try AlcoholicBeveragesRecordDto(
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
