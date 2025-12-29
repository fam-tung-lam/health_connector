import Foundation
import HealthKit

extension WheelchairPushesRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .pushCount)

        let quantity = HKQuantity(unit: .count(), doubleValue: pushes.toDouble())
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

        // Create builder with timezone offset
        var builder = try MetadataBuilder(
            from: metadata,
            startTimeZoneOffset: zoneOffsetSeconds
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

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `WheelchairPushesRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a push count sample.
    func toWheelchairPushesRecordDto() throws -> WheelchairPushesRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.pushCount.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected push count quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.pushCount.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let wheelchairPushes = quantity.doubleValue(for: HKUnit.count())
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offset from metadata
        let zoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try WheelchairPushesRecordDto(
            pushes: NumberDto(value: wheelchairPushes),
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
