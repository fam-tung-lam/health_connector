import Foundation
import HealthKit

extension OxygenSaturationRecordDto {
    /// Converts this DTO to a HealthKit sample.
    func toHealthKit() throws -> HKSample {
        let type = try HKQuantityType.make(from: .oxygenSaturation)

        let quantity = percentage.toHealthKit()
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
    /// Converts this HealthKit sample to a `OxygenSaturationRecordDto`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if this sample is not an oxygen saturation sample.
    func toOxygenSaturationRecordDto() throws -> OxygenSaturationRecordDto {
        guard quantityType.identifier == HKQuantityTypeIdentifier.oxygenSaturation.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected oxygen saturation quantity type, got \(quantityType.identifier)",
                context: [
                    "expected": HKQuantityTypeIdentifier.oxygenSaturation.rawValue,
                    "actual": quantityType.identifier,
                ]
            )
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return OxygenSaturationRecordDto(
            id: uuid.uuidString,
            time: startDate.millisecondsSince1970,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            percentage: quantity.toPercentageDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
