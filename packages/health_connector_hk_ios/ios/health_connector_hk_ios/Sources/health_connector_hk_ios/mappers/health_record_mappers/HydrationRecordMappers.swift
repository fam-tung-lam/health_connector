import Foundation
import HealthKit

// ==================== HYDRATION RECORD MAPPERS ====================

extension HydrationRecordDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantitySample`.
     *
     * - Throws: An error if the quantity type cannot be created.
     */
    func toHealthKit() throws -> HKQuantitySample {
        guard let type = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else {
            throw NSError(
                domain: "HealthConnectorError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to create dietary water quantity type"]
            )
        }

        let quantity = volume.toHealthKit()
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000.0)

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
    /**
     * Converts this HealthKit sample to a `HydrationRecordDto`.
     *
     * Returns `nil` if this sample is not a dietary water sample.
     */
    func toHydrationRecordDto() -> HydrationRecordDto? {
        guard quantityType.identifier == HKQuantityTypeIdentifier.dietaryWater.rawValue else {
            return nil
        }

        let metadataDict = metadata ?? [:]
        let zoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        
        return HydrationRecordDto(
            id: uuid.uuidString,
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            volume: quantity.toVolumeDto(),
            zoneOffsetSeconds: zoneOffset
        )
    }
}
