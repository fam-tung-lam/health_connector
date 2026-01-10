import Foundation
import HealthKit

extension HeartRateRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .heartRate)

        // Heart rate is measured in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: beatsPerMinute.perMinute)
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
    /// Converts this HealthKit sample to a `HeartRateRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a heart rate sample.
    func toHeartRateRecordDto() throws -> HeartRateRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.heartRate.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected heart rate quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.heartRate.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        // Heart rate is in beats per minute (count/minute)
        let unit = HKUnit.count().unitDivided(by: .minute())
        let bpmValue = quantity.doubleValue(for: unit)

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try HeartRateRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            beatsPerMinute: toFrequencyDto(bpmValue),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
