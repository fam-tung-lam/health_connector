import Foundation
import HealthKit

/// Extension for mapping `ElectrodermalActivityRecordDto` → `HKQuantitySample`.
extension ElectrodermalActivityRecordDto {
    /// Converts this DTO to a HealthKit sample.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHKQuantitySample() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .electrodermalActivity)

        let quantity = HKQuantity(unit: .siemen(), doubleValue: conductance)
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

/// Extension for mapping `HKQuantitySample` → `ElectrodermalActivityRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit sample to an `ElectrodermalActivityRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an electrodermal activity sample.
    func toElectrodermalActivityRecordDto() throws -> ElectrodermalActivityRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.electrodermalActivity.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected electrodermal activity quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.electrodermalActivity.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let conductance = quantity.doubleValue(for: .siemen())

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try ElectrodermalActivityRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            conductance: conductance,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
