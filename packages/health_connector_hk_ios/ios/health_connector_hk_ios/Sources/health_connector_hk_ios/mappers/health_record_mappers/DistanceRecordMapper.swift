import Foundation
import HealthKit

extension DistanceRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .distanceWalkingRunning)

        let quantity = distance.toHealthKit()
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
    /// Converts this HealthKit sample to a `DistanceRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a distance sample.
    func toDistanceRecordDto() throws -> DistanceRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected distance walking/running quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return DistanceRecordDto(
            distance: quantity.toLengthDto(),
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
