import Foundation
import HealthKit

extension RespiratoryRateRecordDto {
    /// Converts this DTO to a HealthKit sample.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .respiratoryRate)

        let unit = HKUnit.count().unitDivided(by: .minute())
        let quantity = HKQuantity(unit: unit, doubleValue: breathsPerMinute)
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
    /// Converts this HealthKit sample to a `RespiratoryRateRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a respiratory rate sample.
    func toRespiratoryRateRecordDto() throws -> RespiratoryRateRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.respiratoryRate.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected respiratory rate quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.respiratoryRate.rawValue,
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
        let unit = HKUnit.count().unitDivided(by: .minute()) // breaths/min

        return try RespiratoryRateRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            breathsPerMinute: quantity.doubleValue(for: unit),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
