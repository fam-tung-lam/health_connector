import Foundation
import HealthKit

/// Extension for mapping `HKWorkout` → `ExerciseSessionRecordDto`.
extension HKWorkout {
    /// Converts `HKWorkout` to `ExerciseSessionRecordDto`.
    func toHKWorkoutDto() throws -> ExerciseSessionRecordDto {
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

        // Convert workout events to DTOs
        let eventDtos = (workoutEvents ?? []).compactMap { $0.toEventDto() }

        return try ExerciseSessionRecordDto(
            id: uuid.uuidString,
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            metadata: builder.toMetadataDto(),
            exerciseType: exerciseType,
            title: title,
            notes: notes,
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset,
            events: eventDtos
        )
    }
}

/// Extension for mapping `ExerciseSessionRecordDto` → `HKWorkout`.
extension ExerciseSessionRecordDto {
    /// Converts `ExerciseSessionRecordDto` to `HKWorkout`.
    ///
    /// - Returns: An `HKWorkout` instance
    /// - Throws: `HealthConnectorError` if the exercise type cannot be converted
    func toHKWorkout() throws -> HKWorkout {
        let activityType = try HKWorkoutActivityType.from(dto: exerciseType)
        let startDate = Date(millisecondsSince1970: startTime)
        let endDate = Date(millisecondsSince1970: endTime)

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

        // Convert event DTOs to HKWorkoutEvent objects
        let hkWorkoutEvents = try events.map { try $0.toHKWorkoutEvent() }

        // Note: We use the deprecated initializer for both iOS 17+ and 17- because:
        // 1. We're creating historical workouts from DTOs, not live workout sessions
        // 2. HKWorkoutBuilder is designed for HKWorkoutSession (live workouts)
        // 3. The deprecated initializer remains functional and appropriate for this use case
        //
        // Version check: iOS 17+ deprecates this initializer in favor of HKWorkoutBuilder,
        // but HKWorkoutBuilder is designed for live workout sessions via HKWorkoutSession.
        // For historical workouts created from DTOs, the deprecated initializer is still
        // the appropriate choice.
        return HKWorkout(
            activityType: activityType,
            start: startDate,
            end: endDate,
            workoutEvents: hkWorkoutEvents,
            totalEnergyBurned: nil,
            totalDistance: nil,
            device: builder.healthDevice,
            metadata: builder.build()
        )
    }
}
