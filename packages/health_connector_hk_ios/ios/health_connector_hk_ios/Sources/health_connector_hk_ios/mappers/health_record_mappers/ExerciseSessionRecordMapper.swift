import Foundation
import HealthKit

private enum ExerciseSessionMetadataKeys {
    static let title = "WorkoutTitle"
    static let notes = "WorkoutNotes"
}

extension HKWorkout {
    /// Convert HKWorkout to ExerciseSessionRecordDto
    ///
    /// This method extracts exercise session data from a HealthKit workout sample,
    /// including exercise type, duration, metadata (title, notes), and timezone information.
    func toExerciseSessionRecordDto() -> ExerciseSessionRecordDto {
        let exerciseType = workoutActivityType.toDto()
        let metadataDict = metadata ?? [:]

        // Extract custom metadata
        let title = metadataDict[ExerciseSessionMetadataKeys.title] as? String
        let notes = metadataDict[ExerciseSessionMetadataKeys.notes] as? String

        // Extract timezone offsets
        let startZoneOffset = metadataDict.extractTimeZoneOffset(for: startDate)
        let endZoneOffset = metadataDict.extractTimeZoneOffset(for: endDate)

        return ExerciseSessionRecordDto(
            id: uuid.uuidString,
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            metadata: metadataDict.toMetadataDto(
                source: sourceRevision.source,
                device: device
            ),
            exerciseType: exerciseType,
            title: title,
            notes: notes,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}

/// Mappers for converting ExerciseSessionRecordDto to HKWorkout
extension ExerciseSessionRecordDto {
    /// Converts this DTO to a HealthKit workout sample.
    ///
    /// Creates an `HKWorkout` with the specified exercise type, time range, and metadata.
    /// Title and notes are stored in custom metadata keys.
    ///
    /// - Returns: An `HKWorkout` instance
    /// - Throws: `HealthConnectorError` if the exercise type cannot be converted
    func toHealthKit() throws -> HKSample {
        let activityType = try HKWorkoutActivityType.from(dto: exerciseType)
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)
        let duration = endDate.timeIntervalSince(startDate)

        // Build metadata dictionary
        var metadataDict = metadata.toHealthKitMetadata(timeZone: TimeZone.current)

        // Add custom metadata for title and notes
        if let title {
            metadataDict[ExerciseSessionMetadataKeys.title] = title
        }
        if let notes {
            metadataDict[ExerciseSessionMetadataKeys.notes] = notes
        }

        // Add timezone information for start time
        if let startOffset = startZoneOffsetSeconds {
            metadataDict[HKMetadataKeyTimeZone] =
                TimeZone(secondsFromGMT: Int(startOffset))?.identifier
        }

        // If end offset differs from start, note it in custom metadata
        // (HealthKit doesn't have native support for dual timezone offsets)
        if let endOffset = endZoneOffsetSeconds,
           endOffset != startZoneOffsetSeconds
        {
            metadataDict["EndTimeZoneOffset"] = endOffset
        }

        // Create the workout
        // Note: We're not setting totalEnergyBurned or totalDistance as these
        // are typically calculated by HealthKit from the workout data, not
        // stored explicitly in our DTO. Future enhancement could add these fields.
        return HKWorkout(
            activityType: activityType,
            start: startDate,
            end: endDate,
            duration: duration,
            totalEnergyBurned: nil,
            totalDistance: nil,
            device: metadata.toHealthKitDevice(),
            metadata: metadataDict
        )
    }
}
