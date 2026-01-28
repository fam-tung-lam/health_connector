import Foundation
import HealthKit

/// Extension for mapping `HKHeartbeatSeriesSample` → `HeartbeatSeriesRecordDto`.
extension HKHeartbeatSeriesSample {
    /// Converts this `HKHeartbeatSeriesSample` to its corresponding `HeartbeatSeriesRecordDto`.
    ///
    /// - Parameter beats: Array of HeartbeatSampleDto extracted from the series
    /// - Returns: The corresponding `HeartbeatSeriesRecordDto`
    /// - Throws: HealthConnectorError if conversion fails
    func toDto(with beats: [HeartbeatSampleDto]) throws -> HeartbeatSeriesRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        return try HeartbeatSeriesRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            samples: beats,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}
