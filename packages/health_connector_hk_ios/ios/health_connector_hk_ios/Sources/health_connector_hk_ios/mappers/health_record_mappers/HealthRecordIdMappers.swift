import Foundation

/// Extension providing common property access for HealthRecordDto protocol
///
/// Since Pigeon does not allow defining properties in protocols, this extension
/// provides a computed property to access the `id` field that exists in all
/// HealthRecordDto implementations.
///
/// **Usage:**
/// ```swift
/// let recordId = request.record.id
/// ```
extension HealthRecordDto {
    /// Platform-assigned unique identifier for this health record
    ///
    /// All HealthRecordDto implementations have an `id: String?` property.
    /// This extension provides a type-safe way to access it without needing
    /// to cast to a specific record type.
    ///
    /// - Returns: The record ID if available, nil otherwise
    var id: String? {
        switch self {
        case let record as ActiveCaloriesBurnedRecordDto:
            return record.id
        case let record as DistanceRecordDto:
            return record.id
        case let record as FloorsClimbedRecordDto:
            return record.id
        case let record as StepRecordDto:
            return record.id
        case let record as WeightRecordDto:
            return record.id
        case let record as HeightRecordDto:
            return record.id
        case let record as HydrationRecordDto:
            return record.id
        case let record as LeanBodyMassRecordDto:
            return record.id
        case let record as BodyFatPercentageRecordDto:
            return record.id
        case let record as BodyTemperatureRecordDto:
            return record.id
        case let record as WheelchairPushesRecordDto:
            return record.id
        case let record as HeartRateMeasurementRecordDto:
            return record.id
        case let record as SleepStageRecordDto:
            return record.id
        default:
            return nil
        }
    }
}
