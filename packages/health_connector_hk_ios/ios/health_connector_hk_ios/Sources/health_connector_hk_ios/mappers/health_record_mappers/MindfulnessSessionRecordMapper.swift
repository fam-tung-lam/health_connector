import Foundation
import HealthKit

// MARK: - MindfulnessSessionRecord Mapper

/// Extension for mapping `MindfulnessSessionRecordDto` → `HKCategorySample`.
extension MindfulnessSessionRecordDto {
    /// Converts the DTO to an HKCategorySample for writing to HealthKit.
    ///
    /// ## Session Type Storage
    ///
    /// Since HealthKit only supports a generic `mindfulSession` category type,
    /// the specific session type (meditation, breathing, etc.) is stored as
    /// custom metadata using `MindfulnessSessionTypeKey`.
    ///
    /// ## Notes Storage
    ///
    /// Session notes are stored using `MindfulnessSessionNotesKey` since HealthKit
    /// has no standard key for this purpose.
    func toHKCategorySample() throws -> HKCategorySample {
        let categoryType = HKObjectType.categoryType(forIdentifier: .mindfulSession)!

        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000)

        // Build metadata using the centralized builder
        var builder = MetadataBuilder()
        builder.set(MindfulnessSessionTypeKey.self, value: sessionType)

        // Store title using standard HK key
        if let title {
            builder.set(standardKey: HKMetadataKeyExternalUUID, value: title)
        }

        // Store notes using custom key
        if let notes {
            builder.set(MindfulnessSessionNotesKey.self, value: notes)
        }

        return HKCategorySample(
            type: categoryType,
            value: HKCategoryValue.notApplicable.rawValue,
            start: startDate,
            end: endDate,
            metadata: builder.build()
        )
    }
}

/// Extension for mapping `HKCategorySample` → `MindfulnessSessionRecordDto`.
extension HKCategorySample {
    /// Converts an HKCategorySample to MindfulnessSessionRecordDto.
    ///
    /// ## Session Type Retrieval
    ///
    /// The session type is retrieved from custom metadata using `MindfulnessSessionTypeKey`.
    /// If metadata is missing or invalid, defaults to `.unknown`.
    func toMindfulnessSessionDto() throws -> MindfulnessSessionRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Read session type using centralized key
        let sessionType = MindfulnessSessionTypeKey.readOrDefault(from: builder.metadataDict)

        // Read title from standard HK key
        let title = builder.metadataDict[HKMetadataKeyExternalUUID] as? String

        // Read notes using centralized key
        let notes = MindfulnessSessionNotesKey.read(from: builder.metadataDict)

        return try MindfulnessSessionRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            sessionType: sessionType,
            title: title,
            notes: notes,
            startZoneOffsetSeconds: nil,
            endZoneOffsetSeconds: nil
        )
    }
}
