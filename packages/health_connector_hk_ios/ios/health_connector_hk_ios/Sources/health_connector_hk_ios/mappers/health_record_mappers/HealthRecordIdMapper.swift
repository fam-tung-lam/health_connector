import Foundation

/// Extension providing common property access for `HealthRecordDto` protocol
///
/// ## Pigeon Base Class Limitation
///
/// Pigeon does not allow defining properties in base classes and interfaces, this extension
/// provides a computed property to access fields that exist in all `HealthRecordDto` implementations.
extension HealthRecordDto {
    /// Platform-assigned unique identifier for this health record
    var id: String? {
        switch self {
        case let record as ActiveCaloriesBurnedRecordDto:
            record.id
        case let record as DistanceRecordDto:
            record.id
        case let record as FloorsClimbedRecordDto:
            record.id
        case let record as StepRecordDto:
            record.id
        case let record as WeightRecordDto:
            record.id
        case let record as HeightRecordDto:
            record.id
        case let record as HydrationRecordDto:
            record.id
        case let record as LeanBodyMassRecordDto:
            record.id
        case let record as BodyFatPercentageRecordDto:
            record.id
        case let record as BodyTemperatureRecordDto:
            record.id
        case let record as WheelchairPushesRecordDto:
            record.id
        case let record as HeartRateMeasurementRecordDto:
            record.id
        case let record as SleepStageRecordDto:
            record.id
        default:
            nil
        }
    }
}
