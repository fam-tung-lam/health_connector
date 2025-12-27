import Foundation
import HealthKit

// MARK: - Constants

private enum SessionTypeValue {
    static let unknown = "unknown"
    static let meditation = "meditation"
    static let breathing = "breathing"
    static let music = "music"
    static let movement = "movement"
    static let unguided = "unguided"
}

// MARK: - MindfulnessSessionType Mapper

extension MindfulnessSessionTypeDto {
    /// Converts to a string value for storage in HealthKit metadata.
    ///
    /// Since HealthKit only supports a generic `mindfulSession` category type,
    /// we store the session type as metadata.
    func toMetadataValue() -> String {
        switch self {
        case .unknown:
            SessionTypeValue.unknown
        case .meditation:
            SessionTypeValue.meditation
        case .breathing:
            SessionTypeValue.breathing
        case .music:
            SessionTypeValue.music
        case .movement:
            SessionTypeValue.movement
        case .unguided:
            SessionTypeValue.unguided
        }
    }
}

extension String {
    /// Converts a metadata string value back to a session type DTO.
    func toMindfulnessSessionTypeDto() -> MindfulnessSessionTypeDto {
        switch self {
        case SessionTypeValue.meditation:
            .meditation
        case SessionTypeValue.breathing:
            .breathing
        case SessionTypeValue.music:
            .music
        case SessionTypeValue.movement:
            .movement
        case SessionTypeValue.unguided:
            .unguided
        default:
            .unknown
        }
    }
}

// MARK: - MindfulnessSessionRecord Mapper

/// Metadata key used to store the session type in HealthKit.
private let kSessionTypeMetadataKey = "health_connector_session_type"

extension MindfulnessSessionRecordDto {
    /// Converts the DTO to an HKCategorySample for writing to HealthKit.
    ///
    /// ## Session Type Storage
    ///
    /// Since HealthKit only supports a generic `mindfulSession` category type,
    /// the specific session type (meditation, breathing, etc.) is stored as
    /// custom metadata using the key `health_connector_session_type`.
    func toHealthKit() throws -> HKCategorySample {
        let categoryType = HKObjectType.categoryType(forIdentifier: .mindfulSession)!

        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000)

        var metadataDict: [String: Any] = [:]

        // Store session type in metadata
        metadataDict[kSessionTypeMetadataKey] = sessionType.toMetadataValue()

        // Store title if present
        if let title {
            metadataDict[HKMetadataKeyExternalUUID] = title
        }

        // Store notes if present (using a custom key since there's no standard one)
        if let notes {
            metadataDict["health_connector_notes"] = notes
        }

        return HKCategorySample(
            type: categoryType,
            value: HKCategoryValue.notApplicable.rawValue,
            start: startDate,
            end: endDate,
            metadata: metadataDict.isEmpty ? nil : metadataDict
        )
    }
}

extension HKCategorySample {
    /// Converts an HKCategorySample to MindfulnessSessionRecordDto.
    ///
    /// ## Session Type Retrieval
    ///
    /// The session type is retrieved from custom metadata. If no metadata is found
    /// or the key is missing, the session type defaults to `.unknown`.
    func toMindfulnessSessionDto() -> MindfulnessSessionRecordDto {
        let startTimeMs = Int64(startDate.timeIntervalSince1970 * 1000)
        let endTimeMs = Int64(endDate.timeIntervalSince1970 * 1000)

        // Retrieve session type from metadata
        let sessionType: MindfulnessSessionTypeDto =
            if let typeString = metadata?[kSessionTypeMetadataKey] as? String {
                typeString.toMindfulnessSessionTypeDto()
            } else {
                .unknown
            }

        // Retrieve title from metadata
        let title = metadata?[HKMetadataKeyExternalUUID] as? String

        // Retrieve notes from metadata
        let notes = metadata?["health_connector_notes"] as? String

        // Extract metadata dictionary and convert to DTO
        let metadataDict = metadata ?? [:]

        return MindfulnessSessionRecordDto(
            id: uuid.uuidString,
            startTime: startTimeMs,
            endTime: endTimeMs,
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            sessionType: sessionType,
            title: title,
            notes: notes,
            startZoneOffsetSeconds: nil,
            endZoneOffsetSeconds: nil
        )
    }
}
