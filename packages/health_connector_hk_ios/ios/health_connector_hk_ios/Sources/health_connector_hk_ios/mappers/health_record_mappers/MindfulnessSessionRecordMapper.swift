import Foundation
import HealthKit

// MARK: - Constants

private enum SessionTypeValue: String {
    case unknown
    case meditation
    case breathing
    case music
    case movement
    case unguided
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
            SessionTypeValue.unknown.rawValue
        case .meditation:
            SessionTypeValue.meditation.rawValue
        case .breathing:
            SessionTypeValue.breathing.rawValue
        case .music:
            SessionTypeValue.music.rawValue
        case .movement:
            SessionTypeValue.movement.rawValue
        case .unguided:
            SessionTypeValue.unguided.rawValue
        }
    }
}

extension String {
    /// Converts a metadata string value back to a session type DTO.
    func toMindfulnessSessionTypeDto() -> MindfulnessSessionTypeDto {
        switch self {
        case SessionTypeValue.meditation.rawValue:
            .meditation
        case SessionTypeValue.breathing.rawValue:
            .breathing
        case SessionTypeValue.music.rawValue:
            .music
        case SessionTypeValue.movement.rawValue:
            .movement
        case SessionTypeValue.unguided.rawValue:
            .unguided
        default:
            .unknown
        }
    }
}

// MARK: - MindfulnessSessionRecord Mapper

/// Metadata key used to store the session type in HealthKit.
private let kSessionTypeMetadataKey =
    "\(hkMetadataKeyPrefix)session_type"

/// Metadata key used to store session notes in HealthKit.
private let kSessionNotesMetadataKey =
    "\(hkMetadataKeyPrefix)session_notes"

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
            metadataDict[kSessionNotesMetadataKey] = notes
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
        let notes = metadata?[kSessionNotesMetadataKey] as? String

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
