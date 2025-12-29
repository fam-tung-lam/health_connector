import Foundation
import HealthKit

extension HKWorkout {
    /// Convert HKWorkout to ExerciseSessionRecordDto
    ///
    /// This method extracts exercise session data from a HealthKit workout sample,
    /// including exercise type, duration, metadata (title, notes), and timezone information.
    func toExerciseSessionRecordDto() throws -> ExerciseSessionRecordDto {
        let exerciseType = workoutActivityType.toDto()

        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract custom metadata using centralized keys
        let title = ExerciseSessionTitleKey.read(from: builder.metadataDict)
        let notes = ExerciseSessionNotesKey.read(from: builder.metadataDict)

        // Extract timezone offsets
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict) ?? startZoneOffset

        return try ExerciseSessionRecordDto(
            id: uuid.uuidString,
            startTime: Int64(startDate.timeIntervalSince1970 * 1000),
            endTime: Int64(endDate.timeIntervalSince1970 * 1000),
            metadata: builder.toMetadataDto(),
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

        // Build metadata using centralized builder
        var builder = try MetadataBuilder(
            from: metadata, startTimeZoneOffset: startZoneOffsetSeconds
        )

        // Add custom metadata for title and notes using centralized keys
        if let title {
            builder.set(ExerciseSessionTitleKey.self, value: title)
        }
        if let notes {
            builder.set(ExerciseSessionNotesKey.self, value: notes)
        }

        // Add timezone information for start time
        if let startOffset = startZoneOffsetSeconds {
            builder.set(
                standardKey: HKMetadataKeyTimeZone,
                value: TimeZone(secondsFromGMT: Int(startOffset))?.identifier as Any
            )
        }

        // If end offset differs from start, store in custom metadata
        if let endOffset = endZoneOffsetSeconds,
           endOffset != startZoneOffsetSeconds
        {
            builder.set(EndTimeZoneOffsetKey.self, value: endOffset)
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
            device: builder.healthDevice,
            metadata: builder.build()
        )
    }
}
