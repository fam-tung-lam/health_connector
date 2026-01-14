import Foundation
import HealthKit

extension LeanBodyMassRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .leanBodyMass)

        let unit = HKUnit.gramUnit(with: .kilo)
        let quantity = HKQuantity(unit: unit, doubleValue: kilograms)
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
    /// Converts this HealthKit sample to a `LeanBodyMassRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a lean body mass sample.
    func toLeanBodyMassRecordDto() throws -> LeanBodyMassRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.leanBodyMass.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected lean body mass quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.leanBodyMass.rawValue,
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

        return try LeanBodyMassRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            time: startDate.millisecondsSince1970,
            kilograms: quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo)),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
