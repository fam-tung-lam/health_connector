import Foundation
import HealthKit

// MARK: - HKWorkoutEvent → DTO Extensions

extension HKWorkoutEvent {
    /// Converts this `HKWorkoutEvent` to an `ExerciseSessionStateTransitionEventDto` if it's a state transition event.
    func toStateTransitionDto() -> ExerciseSessionStateTransitionEventDto? {
        guard let transitionType = type.toStateTransitionTypeDto() else {
            return nil
        }
        return ExerciseSessionStateTransitionEventDto(
            time: dateInterval.start.millisecondsSince1970,
            type: transitionType
        )
    }

    /// Converts this `HKWorkoutEvent` to an `ExerciseSessionMarkerEventDto` if it's a marker event.
    func toMarkerDto() -> ExerciseSessionMarkerEventDto? {
        guard type == .marker else {
            return nil
        }
        return ExerciseSessionMarkerEventDto(
            time: dateInterval.start.millisecondsSince1970
        )
    }

    /// Converts this `HKWorkoutEvent` to an `ExerciseSessionLapEventDto` if it's a lap event.
    func toLapDto() -> ExerciseSessionLapEventDto? {
        guard type == .lap else {
            return nil
        }
        let distance = ExerciseLapDistanceKey.read(from: metadata)
        return ExerciseSessionLapEventDto(
            startTime: dateInterval.start.millisecondsSince1970,
            endTime: dateInterval.end.millisecondsSince1970,
            distanceMeters: distance
        )
    }

    /// Converts this `HKWorkoutEvent` to an `ExerciseSessionSegmentEventDto` if it's a segment event.
    func toSegmentDto() -> ExerciseSessionSegmentEventDto? {
        guard type == .segment else {
            return nil
        }
        let segmentType = ExerciseSegmentTypeKey.readOrDefault(from: metadata)
        let repetitions = ExerciseSegmentRepetitionsKey.read(from: metadata).map { Int64($0) }
        return ExerciseSessionSegmentEventDto(
            startTime: dateInterval.start.millisecondsSince1970,
            endTime: dateInterval.end.millisecondsSince1970,
            segmentType: segmentType,
            repetitions: repetitions
        )
    }

    /// Converts this `HKWorkoutEvent` to the appropriate `ExerciseSessionEventDto`.
    ///
    /// Returns `nil` if the event type is not supported.
    func toEventDto() -> ExerciseSessionEventDto? {
        if let dto = toStateTransitionDto() {
            return dto
        }
        if let dto = toMarkerDto() {
            return dto
        }
        if let dto = toLapDto() {
            return dto
        }
        if let dto = toSegmentDto() {
            return dto
        }
        return nil
    }
}

// MARK: - HKWorkoutEventType → DTO Extensions

extension HKWorkoutEventType {
    /// Converts this `HKWorkoutEventType` to an `ExerciseSessionStateTransitionTypeDto` if it's a state transition
    /// type.
    func toStateTransitionTypeDto() -> ExerciseSessionStateTransitionTypeDto? {
        switch self {
        case .pause:
            .pause
        case .resume:
            .resume
        case .motionPaused:
            .motionPaused
        case .motionResumed:
            .motionResumed
        case .pauseOrResumeRequest:
            .pauseOrResumeRequest
        default:
            nil
        }
    }
}

// MARK: - DTO → HKWorkoutEvent Extensions

extension ExerciseSessionStateTransitionEventDto {
    /// Converts this DTO to an `HKWorkoutEvent`.
    ///
    /// State transition events represent instant points in time when the workout state changes.
    /// HealthKit requires these events to have **zero duration** (start == end).
    func toHKWorkoutEvent() -> HKWorkoutEvent {
        let eventType = type.toHKWorkoutEventType()
        let eventDate = Date(millisecondsSince1970: time)
        return HKWorkoutEvent(
            type: eventType,
            dateInterval: DateInterval(
                start: eventDate,
                end: eventDate // Zero duration required by HealthKit for state transition events
            ),
            metadata: nil
        )
    }
}

extension ExerciseSessionMarkerEventDto {
    /// Converts this DTO to an `HKWorkoutEvent`.
    ///
    /// Marker events represent instant points of interest during a workout session.
    /// HealthKit requires marker events to have **zero duration** (start == end).
    func toHKWorkoutEvent() -> HKWorkoutEvent {
        let eventDate = Date(millisecondsSince1970: time)
        return HKWorkoutEvent(
            type: .marker,
            dateInterval: DateInterval(
                start: eventDate,
                end: eventDate // Zero duration required by HealthKit for marker events
            ),
            metadata: nil
        )
    }
}

extension ExerciseSessionLapEventDto {
    /// Converts this DTO to an `HKWorkoutEvent`.
    func toHKWorkoutEvent() -> HKWorkoutEvent {
        var metadata: [String: Any] = [:]
        if let distanceMeters {
            ExerciseLapDistanceKey.write(distanceMeters, to: &metadata)
        }
        return HKWorkoutEvent(
            type: .lap,
            dateInterval: DateInterval(
                start: Date(millisecondsSince1970: startTime),
                end: Date(millisecondsSince1970: endTime)
            ),
            metadata: metadata.isEmpty ? nil : metadata
        )
    }
}

extension ExerciseSessionSegmentEventDto {
    /// Converts this DTO to an `HKWorkoutEvent`.
    func toHKWorkoutEvent() -> HKWorkoutEvent {
        var metadata: [String: Any] = [:]
        ExerciseSegmentTypeKey.write(segmentType, to: &metadata)
        if let repetitions {
            ExerciseSegmentRepetitionsKey.write(Int(truncatingIfNeeded: repetitions), to: &metadata)
        }
        return HKWorkoutEvent(
            type: .segment,
            dateInterval: DateInterval(
                start: Date(millisecondsSince1970: startTime),
                end: Date(millisecondsSince1970: endTime)
            ),
            metadata: metadata
        )
    }
}

extension ExerciseSessionEventDto {
    /// Converts this DTO to an `HKWorkoutEvent`.
    ///
    /// - Throws: `HealthConnectorError.invalidArgument` if the event type is not supported
    func toHKWorkoutEvent() throws -> HKWorkoutEvent {
        switch self {
        case let event as ExerciseSessionStateTransitionEventDto:
            return event.toHKWorkoutEvent()
        case let event as ExerciseSessionMarkerEventDto:
            return event.toHKWorkoutEvent()
        case let event as ExerciseSessionLapEventDto:
            return event.toHKWorkoutEvent()
        case let event as ExerciseSessionSegmentEventDto:
            return event.toHKWorkoutEvent()
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Unsupported exercise session event type: \(type(of: self))",
                context: ["eventType": String(describing: type(of: self))]
            )
        }
    }
}

// MARK: - ExerciseSessionStateTransitionTypeDto → HKWorkoutEventType

extension ExerciseSessionStateTransitionTypeDto {
    /// Converts this DTO to an `HKWorkoutEventType`.
    func toHKWorkoutEventType() -> HKWorkoutEventType {
        switch self {
        case .pause:
            .pause
        case .resume:
            .resume
        case .motionPaused:
            .motionPaused
        case .motionResumed:
            .motionResumed
        case .pauseOrResumeRequest:
            .pauseOrResumeRequest
        }
    }
}
