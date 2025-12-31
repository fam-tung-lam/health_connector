import Foundation
import HealthKit

extension HeartRateVariabilitySDNNRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .heartRateVariabilitySDNN)

        // DTO value is in milliseconds, HealthKit expects seconds
        let val = heartRateVariabilitySDNN.value / 1000.0
        let quantity = HKQuantity(unit: .second(), doubleValue: val)
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

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `HeartRateVariabilitySDNNRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a HRV SDNN sample.
    func toHeartRateVariabilitySDNNRecordDto() throws -> HeartRateVariabilitySDNNRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.heartRateVariabilitySDNN.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected HRV SDNN quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.heartRateVariabilitySDNN.rawValue,
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

        // HealthKit has seconds, DTO expects milliseconds
        let ms = quantity.doubleValue(for: .second()) * 1000.0

        return try HeartRateVariabilitySDNNRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            heartRateVariabilitySDNN: NumberDto(value: ms),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
