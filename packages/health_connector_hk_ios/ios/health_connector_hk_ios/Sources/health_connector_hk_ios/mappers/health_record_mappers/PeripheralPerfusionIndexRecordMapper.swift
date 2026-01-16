import Foundation
import HealthKit

extension PeripheralPerfusionIndexRecordDto {
    /// Converts this DTO to a HealthKit sample.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .peripheralPerfusionIndex)

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
    /// Converts this HealthKit sample to a `PeripheralPerfusionIndexRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a peripheral perfusion index sample.
    func toPeripheralPerfusionIndexRecordDto() throws -> PeripheralPerfusionIndexRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.peripheralPerfusionIndex.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected peripheral perfusion index quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.peripheralPerfusionIndex.rawValue,
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

        return try PeripheralPerfusionIndexRecordDto(
            percentage: quantity.doubleValue(for: HKUnit.percent()),
            time: startDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            zoneOffsetSeconds: zoneOffset,
            id: uuid.uuidString
        )
    }
}
