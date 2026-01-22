import Foundation
import HealthKit

/// Extension for mapping `InhalerUsageRecordDto` → `HKQuantitySample`.
extension InhalerUsageRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .inhalerUsage)

        let quantity = HKQuantity(unit: .count(), doubleValue: puffs)
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

/// Extension for mapping `HKQuantitySample` → `InhalerUsageRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to an `InhalerUsageRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an inhaler usage sample.
    func toInhalerUsageRecordDto() throws -> InhalerUsageRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.inhalerUsage.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected inhaler usage quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.inhalerUsage.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let puffs = quantity.doubleValue(for: .count())

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try InhalerUsageRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            puffs: puffs,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
