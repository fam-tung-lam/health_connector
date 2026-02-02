import CoreLocation
import Foundation
import HealthKit

/// Handler for exercise session data (HKWorkout)
///
/// This handler manages exercise sessions recorded in HealthKit.
/// It supports reading, writing, deleting, and aggregating workout data.
///
/// **Supported Operations:**
/// - Read: Query workout sessions in a date range
/// - Write: Create new workout sessions
/// - Delete: Remove workout sessions by ID
/// - Aggregate: Calculate total duration or count of workouts
///
/// **Aggregation Metrics:**
/// - `.sum`: Total workout duration in seconds across all sessions
/// - `.count`: Number of workout sessions
final class ExerciseSessionHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    typealias RecordDto = ExerciseSessionRecordDto
    typealias SampleType = HKWorkout
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .exerciseSession

    // Exercise sessions only support sum aggregation (total duration)
    // For counting workouts, use sum with duration as the metric
    static let supportedAggregationMetrics: Set<AggregationMetricDto> = [.sum]
}

// MARK: - Write Record with Route Support

extension ExerciseSessionHandler {
    /// Writes an exercise session record to HealthKit, optionally including a workout route.
    ///
    /// This method overrides the default `writeRecord` implementation to support
    /// attaching GPS route data via `HKWorkoutRouteBuilder`. The workflow is:
    /// 1. Save the `HKWorkout` first (required by HealthKit)
    /// 2. If route data is provided, attach it using `HKWorkoutRouteBuilder`
    ///
    /// - Parameter dto: The exercise session DTO to write
    /// - Returns: The UUID string of the created workout
    /// - Throws: `HealthConnectorError` if the workout save fails
    ///
    /// - Note: Route save failures are logged but do not fail the overall operation,
    ///         since the workout is the primary entity.
    func writeRecord(_ dto: HealthRecordDto) async throws -> String {
        guard let exerciseDto = dto as? ExerciseSessionRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Type mismatch: expected ExerciseSessionRecordDto, but got \(type(of: dto))",
                context: [
                    "expected_type": "ExerciseSessionRecordDto",
                    "actual_type": String(describing: type(of: dto)),
                    "handler_type": "ExerciseSessionHandler",
                ]
            )
        }

        let tag = "ExerciseSessionHandler"
        let operation = "write_record"
        let context: [String: Any] = [
            "data_type": Self.dataType.rawValue,
            "has_route": exerciseDto.exerciseRoute != nil,
            "route_location_count": exerciseDto.exerciseRoute?.locations.count ?? 0,
        ]

        return try await process(operation: operation, context: context) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to write exercise session record",
                context: context
            )

            // Validate route write permissions if route is provided
            if let routeDto = exerciseDto.exerciseRoute, !routeDto.locations.isEmpty {
                try self.validateRouteWritePermissions()
            }

            // Step 1: Save workout first (required before attaching route)
            let workout = try exerciseDto.toHKWorkout()
            try await self.healthStore.save(workout)
            let workoutId = workout.uuid.uuidString

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Exercise session saved successfully",
                context: ["workout_id": workoutId]
            )

            // Step 2: Attach route if provided
            if let routeDto = exerciseDto.exerciseRoute {
                await self.attachRoute(routeDto, to: workout)
            }

            return workoutId
        }
    }

    /// Attaches a workout route to a saved workout.
    ///
    /// This method uses `HKWorkoutRouteBuilder` to create and associate GPS route data
    /// with the workout. Route save failures are logged but do not propagate, since
    /// the workout is the primary entity.
    ///
    /// - Parameters:
    ///   - routeDto: The exercise route DTO containing GPS location data
    ///   - workout: The saved `HKWorkout` to attach the route to
    private func attachRoute(_ routeDto: ExerciseRouteDto, to workout: HKWorkout) async {
        let tag = "ExerciseSessionHandler"
        let operation = "attach_route"
        let locationCount = routeDto.locations.count

        guard locationCount > 0 else {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Skipping route attachment - no locations provided",
                context: ["workout_id": workout.uuid.uuidString]
            )
            return
        }

        let context: [String: Any] = [
            "workout_id": workout.uuid.uuidString,
            "location_count": locationCount,
        ]

        HealthConnectorLogger.debug(
            tag: tag,
            operation: operation,
            message: "Attaching route to workout",
            context: context
        )

        do {
            let routeBuilder = HKWorkoutRouteBuilder(
                healthStore: healthStore,
                device: workout.device
            )
            let locations = routeDto.toCLLocations()

            try await routeBuilder.insertRouteData(locations)
            try await routeBuilder.finishRoute(with: workout, metadata: nil)

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Route attached successfully",
                context: context
            )
        } catch {
            HealthConnectorLogger.error(
                tag: tag,
                operation: operation,
                message: "Failed to attach route - workout saved but route was not",
                context: context.merging(["error": error.localizedDescription]) { _, new in new },
                exception: error
            )
        }
    }

    /// Validates that write permissions are granted for workout routes.
    ///
    /// This method checks authorization status for both workout type and workout route type.
    /// If either permission is denied, it throws an authorization error immediately.
    ///
    /// - Throws: `HealthConnectorError.permissionNotGranted` if route write permission is denied
    private func validateRouteWritePermissions() throws {
        let workoutType = HKObjectType.workoutType()
        let routeType = HKSeriesType.workoutRoute()

        let workoutStatus = healthStore.authorizationStatus(for: workoutType)
        let routeStatus = healthStore.authorizationStatus(for: routeType)

        // Check if workout write permission is denied
        if workoutStatus == .sharingDenied {
            HealthConnectorLogger.warning(
                tag: "ExerciseSessionHandler",
                operation: "validate_route_permissions",
                message: "Workout write permission denied",
                context: ["permission_type": "workout"]
            )
            throw HealthConnectorError.permissionNotGranted(
                message: "Write permission for exercise sessions is denied",
                context: ["permission_type": "exerciseSession"]
            )
        }

        // Check if route write permission is denied
        if routeStatus == .sharingDenied {
            HealthConnectorLogger.warning(
                tag: "ExerciseSessionHandler",
                operation: "validate_route_permissions",
                message: "Workout route write permission denied",
                context: ["permission_type": "workoutRoute"]
            )
            throw HealthConnectorError.permissionNotGranted(
                message: "Write permission for exercise routes is denied",
                context: ["permission_type": "exerciseRoute"]
            )
        }

        HealthConnectorLogger.debug(
            tag: "ExerciseSessionHandler",
            operation: "validate_route_permissions",
            message: "Route write permissions validated",
            context: [
                "workout_status": String(describing: workoutStatus),
                "route_status": String(describing: routeStatus),
            ]
        )
    }
}

// MARK: - Aggregation

extension ExerciseSessionHandler {
    /// Performs aggregation for exercise session records.
    ///
    /// Since HKWorkout doesn't support HKStatisticsQuery, we query all workout
    /// sessions in the time range and calculate the sum or count manually.
    ///
    /// **Supported Metrics:**
    /// - `.sum` - Total workout duration in seconds across all sessions
    ///
    /// - Parameters:
    ///   - metric: The aggregation metric (.sum)
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Returns: TimeDurationDto with the aggregated value in seconds
    /// - Throws: HealthConnectorError if query fails or metric is unsupported
    func aggregate(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date
    ) async throws -> Double {
        try await process(
            operation: "aggregate",
            context: [
                "metric": metric.rawValue,
                "start_time": startTime,
                "end_time": endTime,
            ]
        ) {
            try validateAggregationMetric(metric)

            let workouts = try await readAllRecords(startTime: startTime, endTime: endTime)

            let result: Double
            switch metric {
            case .sum:
                // Calculate total workout duration in seconds
                result = workouts.reduce(0) { total, workout in
                    total + workout.duration
                }
            default:
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported aggregation metric: \(metric.rawValue)",
                    context: [
                        "metric": metric.rawValue,
                        "supported_metrics": Self.supportedAggregationMetrics.map {
                            String($0.rawValue)
                        }.joined(separator: ", "),
                    ]
                )
            }

            return result
        }
    }
}

// MARK: - HealthKit Type Configuration

extension ExerciseSessionHandler {
    /// Returns the HealthKit workout type
    ///
    /// Exercise sessions use the special HKWorkoutType, not a regular quantity
    /// or category type.
    func healthKitType() throws -> HKObjectType {
        HKObjectType.workoutType()
    }
}
