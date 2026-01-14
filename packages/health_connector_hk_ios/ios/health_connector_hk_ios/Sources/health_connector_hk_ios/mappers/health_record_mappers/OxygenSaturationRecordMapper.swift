import Foundation
import HealthKit

extension OxygenSaturationRecordDto {
    /// Converts this DTO to a HealthKit sample.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .oxygenSaturation)

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

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `OxygenSaturationRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an oxygen saturation sample.
    func toOxygenSaturationRecordDto() throws -> OxygenSaturationRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.oxygenSaturation.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected oxygen saturation quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.oxygenSaturation.rawValue,
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

        return try OxygenSaturationRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            percentage: quantity.doubleValue(for: HKUnit.percent()),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
