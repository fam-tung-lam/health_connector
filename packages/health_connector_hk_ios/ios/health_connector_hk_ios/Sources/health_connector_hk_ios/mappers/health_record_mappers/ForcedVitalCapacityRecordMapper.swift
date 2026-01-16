import Foundation
import HealthKit

extension ForcedVitalCapacityRecordDto {
    /// Converts this DTO to a HealthKit sample.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .forcedVitalCapacity)

        // FVC is measured in liters
        let unit = HKUnit.liter()
        let quantity = HKQuantity(unit: unit, doubleValue: liters)

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
            end: date, // Instant records have same start and end time
            device: builder.healthDevice,
            metadata: builder.metadataDict
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `ForcedVitalCapacityRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a FVC sample.
    func toForcedVitalCapacityRecordDto() throws -> ForcedVitalCapacityRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.forcedVitalCapacity.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected forced vital capacity quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.forcedVitalCapacity.rawValue,
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

        // FVC is measured in liters
        return try ForcedVitalCapacityRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            liters: quantity.doubleValue(for: HKUnit.liter()),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
