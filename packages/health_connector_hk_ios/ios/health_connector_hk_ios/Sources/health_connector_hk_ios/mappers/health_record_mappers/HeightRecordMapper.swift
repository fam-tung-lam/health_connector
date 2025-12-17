import Foundation
import HealthKit

extension HeightRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    func toHealthKit() throws -> HKQuantitySample {
        let type = try HKQuantityType.make(from: .height)

        let quantity = height.toHealthKit()
        let date = Date(millisecondsSince1970: time)

        return HKQuantitySample(
            type: type,
            quantity: quantity,
            start: date,
            end: date, // Instant records have same start and end
            device: metadata.toHealthKitDevice(),
            metadata: metadata.toHealthKitMetadata()
        )
    }
}

extension HKQuantitySample {
    /// Converts this HealthKit sample to a `HeightRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not a height sample.
    func toHeightRecordDto() throws -> HeightRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.height.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected height quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.height.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return HeightRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: startDate.millisecondsSince1970,
            height: quantity.toLengthDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
