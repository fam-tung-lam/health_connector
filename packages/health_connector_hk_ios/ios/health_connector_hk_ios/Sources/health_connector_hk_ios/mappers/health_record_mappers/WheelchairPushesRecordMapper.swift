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

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: startDate,
            end: endDate,
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata(timeZone: TimeZone.current)
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
        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return WheelchairPushesRecordDto(
            pushes: NumberDto(value: wheelchairPushes),
            endTime: endDate.millisecondsSince1970,
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            startTime: startDate.millisecondsSince1970,
            zoneOffsetSeconds: zoneOffset
        )
    }
}
