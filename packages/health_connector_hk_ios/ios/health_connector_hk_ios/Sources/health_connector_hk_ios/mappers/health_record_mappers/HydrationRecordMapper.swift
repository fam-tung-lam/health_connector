import Foundation
import HealthKit

/// Extension for mapping `HydrationRecordDto` → `HKQuantitySample`.
extension HydrationRecordDto {
    /// Converts this `HydrationRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .dietaryWater)

        let unit = HKUnit.liter()
        let quantity = HKQuantity(unit: unit, doubleValue: liters)
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

/// Extension for mapping `HKQuantitySample` → `HydrationRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `HydrationRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a hydration sample.
    func toHydrationRecordDto() throws -> HydrationRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryWater.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected dietary water quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.dietaryWater.rawValue,
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

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try HydrationRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            liters: quantity.doubleValue(for: HKUnit.liter()),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
