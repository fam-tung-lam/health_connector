import Foundation
import HealthKit

extension BodyMassIndexRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bodyMassIndex)

        // Body Mass Index is a count unit
        let quantity = HKQuantity(unit: .count(), doubleValue: bodyMassIndex.value)
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
    /// Converts this HealthKit sample to a `BodyMassIndexRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a BMI sample.
    func toBodyMassIndexRecordDto() throws -> BodyMassIndexRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyMassIndex.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected BMI quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.bodyMassIndex.rawValue,
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

        return try BodyMassIndexRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            bodyMassIndex: NumberDto(value: quantity.doubleValue(for: .count())),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
