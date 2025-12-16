import Foundation
import HealthKit

extension WeightRecordDto {
    /// Converts this DTO to a HealthKit `HKQuantitySample`.
    ///
    /// - Throws: An error if the quantity type cannot be created.
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create body mass quantity type"]
            )
        }

        let quantity = weight.toHealthKit()
        let date = Date(timeIntervalSince1970: TimeInterval(time) / 1000.0)

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
    /// Converts this HealthKit sample to a `WeightRecordDto`.
    ///
    /// Returns `nil` if this sample is not a body mass sample.
    func toWeightRecordDto() -> WeightRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.bodyMass.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)

        return WeightRecordDto(
            id: uuid.uuidString,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            time: Int64(startDate.timeIntervalSince1970 * 1000),
            weight: quantity.toMassDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
