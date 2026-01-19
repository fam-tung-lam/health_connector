import Foundation
import HealthKit

/// Extension for mapping `BasalEnergyBurnedRecordDto` → `HKQuantitySample`.
extension BasalEnergyBurnedRecordDto {
    /// Converts this `BasalEnergyBurnedRecordDto` to its corresponding `HKQuantitySample`.
    ///
    /// - Returns: The corresponding `HKQuantitySample`
    /// - Throws: `HealthConnectorError` if the quantity type cannot be created
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .basalEnergyBurned)

        let unit = HKUnit.kilocalorie()
        let quantity = HKQuantity(unit: unit, doubleValue: kilocalories)
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

/// Extension for mapping `HKQuantitySample` → `BasalEnergyBurnedRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to a `BasalEnergyBurnedRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a basal energy burned sample.
    func toBasalEnergyBurnedRecordDto() throws -> BasalEnergyBurnedRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.basalEnergyBurned.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected basal energy burned quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.basalEnergyBurned.rawValue,
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

        return try BasalEnergyBurnedRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset,
            kilocalories: quantity.doubleValue(for: HKUnit.kilocalorie())
        )
    }
}
