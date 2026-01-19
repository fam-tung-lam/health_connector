import Foundation
import HealthKit

/// Extension for mapping `WaistCircumferenceRecordDto` → `HKQuantitySample`.
extension WaistCircumferenceRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .waistCircumference)

        let quantity = HKQuantity(unit: .meter(), doubleValue: meters)
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

/// Extension for mapping `HKQuantitySample` → `WaistCircumferenceRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `WaistCircumferenceRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a waist circumference sample.
    func toWaistCircumferenceRecordDto() throws -> WaistCircumferenceRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.waistCircumference.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected waist circumference quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.waistCircumference.rawValue,
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

        return try WaistCircumferenceRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            meters: quantity.doubleValue(for: HKUnit.meter()),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
