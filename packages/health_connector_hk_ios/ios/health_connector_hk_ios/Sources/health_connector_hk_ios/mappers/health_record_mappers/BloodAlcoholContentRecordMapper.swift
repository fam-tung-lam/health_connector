import Foundation
import HealthKit

/// Extension for mapping `BloodAlcoholContentRecordDto` → `HKQuantitySample`.
extension BloodAlcoholContentRecordDto {
    /// Converts this `BloodAlcoholContentRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bloodAlcoholContent)

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

/// Extension for mapping `HKQuantitySample` → `BloodAlcoholContentRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `BloodAlcoholContentRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a blood alcohol content sample.
    func toBloodAlcoholContentRecordDto() throws -> BloodAlcoholContentRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bloodAlcoholContent.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected blood alcohol content quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.bloodAlcoholContent.rawValue,
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

        return try BloodAlcoholContentRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            zoneOffsetSeconds: zoneOffset,
            percentage: quantity.doubleValue(for: HKUnit.percent())
        )
    }
}
