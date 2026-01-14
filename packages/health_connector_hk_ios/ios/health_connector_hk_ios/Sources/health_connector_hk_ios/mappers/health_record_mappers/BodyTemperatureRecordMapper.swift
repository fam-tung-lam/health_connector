import Foundation
import HealthKit

extension BodyTemperatureRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .bodyTemperature)

        let quantity = HKQuantity(unit: .degreeCelsius(), doubleValue: celsius)
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
    /// Converts this HealthKit sample to a `BodyTemperatureRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a body temperature sample.
    func toBodyTemperatureRecordDto() throws -> BodyTemperatureRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyTemperature.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected body temperature quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.bodyTemperature.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let unit = HKUnit.degreeCelsius()
        let value = quantity.doubleValue(for: unit)

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try BodyTemperatureRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            celsius: value,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
