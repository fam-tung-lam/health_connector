import Flutter
import HealthKit
import UIKit

/// Flutter plugin for accessing HealthKit on iOS devices.
///
/// **Thread Safety**: Uses actor-based HealthConnectorClient for compiler-enforced serial access.
/// Initialization is protected by NSLock to prevent race conditions.
public class HealthConnectorHkIosPlugin: NSObject, FlutterPlugin, HealthConnectorHKIOSApi {
    /// Lock for thread-safe initialization of `healthClient`.
    private let initLock = NSLock()

    /// Cached instance of the HealthKit client actor.
    private var healthClient: HealthConnectorClient!

    /// Registers the plugin with the Flutter engine.
    ///
    /// - Parameter registrar: Provides access to the Flutter engine and binary messenger
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = HealthConnectorHkIosPlugin()
        HealthConnectorHKIOSApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
        HealthConnectorLogger.initialize(binaryMessenger: registrar.messenger())
    }

    /// Initializes the Health Connector client with the provided configuration.
    ///
    /// This method must be called before any other Health Connector operations
    /// to properly configure the native platform code, including logger settings.
    ///
    /// - Parameters:
    ///   - config: Configuration settings for the Health Connector
    ///   - completion: Called with a `Result` indicating success or failure
    func initialize(
        config: HealthConnectorConfigDto,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let operation = "initialize"
        // Note: isLoggerEnabled context is valuable here
        let context: [String: Any] = ["isLoggerEnabled": String(config.isLoggerEnabled)]

        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: operation,
            message: "Initializing HealthConnectorClient...",
            context: context
        )

        do {
            // Thread-safe initialization using NSLock
            initLock.lock()
            defer { initLock.unlock() }

            if healthClient == nil {
                healthClient = try HealthConnectorClient.getOrCreate()
            }

            // Configure the native logger based on the provided configuration
            HealthConnectorLogger.isEnabled = config.isLoggerEnabled

            HealthConnectorLogger.info(
                tag: HealthConnectorHkIosPlugin.tag,
                operation: operation,
                message: "HealthConnector initialized successfully",
                context: context
            )

            completion(.success(()))
        } catch {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: operation,
                message: "Failed to create HealthConnectorClient",
                context: context,
                exception: error
            )
            completion(
                .failure(
                    HealthConnectorError.unknownError(
                        message: error.localizedDescription,
                        cause: error
                    ).toErrorDto()))
        }
    }

    /// Gets the current status of the HealthKit platform on the device.
    ///
    /// - Parameter completion: Called with a `Result` containing the platform status
    func getHealthPlatformStatus(
        completion: @escaping (Result<HealthPlatformStatusDto, Error>) -> Void
    ) {
        let statusDto = HealthConnectorClient.getHealthPlatformStatus()
        completion(.success(statusDto))
    }

    /// Requests permissions from the user.
    ///
    /// - Parameters:
    ///   - request: Contains list of polymorphic permission requests (health data or exercise route).
    ///   - completion: Called with a `Result` containing the permission request results.
    ///
    /// - Throws: `HealthConnectorError.healthServiceUnavailable` if HealthKit is unavailable
    /// - Throws: `HealthConnectorError.unknownError` for unexpected errors
    func requestPermissions(
        request: PermissionsRequestDto,
        completion: @escaping (Result<[PermissionRequestResultDto], Error>) -> Void
    ) {
        let operation = "requestPermissions"
        let context: [String: Any] = [
            "permission_count": request.permissionRequests.count,
        ]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient
                .requestPermissions(permissions: request.permissionRequests)
        }
    }

    /// Gets the current permission status for a specific permission.
    ///
    /// - Parameters:
    ///   - permission: The polymorphic permission to check (health data or exercise route)
    ///   - completion: Called with a `Result` containing the permission status
    ///
    /// - Note: Read permissions always return `.unknown` due to HealthKit privacy restrictions
    func getPermissionStatus(
        permission: PermissionRequestDto,
        completion: @escaping (Result<PermissionStatusDto, Error>) -> Void
    ) {
        let operation = "getPermissionStatus"
        let context: [String: Any] = [
            "permission_type": String(describing: type(of: permission)),
        ]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient.getPermissionStatus(permission: permission)
        }
    }

    /// Reads a single health record by ID.
    ///
    /// - Parameters:
    ///   - request: Contains the data type and record ID to read
    ///   - completion: Called with a `Result` containing the health record or nil if not found
    func readRecord(
        request: ReadRecordRequestDto,
        completion: @escaping (Result<HealthRecordDto?, Error>) -> Void
    ) {
        let operation = "readRecord"
        let context: [String: Any] = [
            "data_type": request.dataType.rawValue,
            "id": request.recordId,
        ]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient.readRecord(request: request)
        }
    }

    /// Reads multiple health records within a time range.
    ///
    /// - Parameters:
    ///   - request: Contains data type, time range, page size, and optional page token
    ///   - completion: Called with a `Result` containing the read records response
    func readRecords(
        request: ReadRecordsRequestDto,
        completion: @escaping (Result<ReadRecordsResponseDto, Error>) -> Void
    ) {
        let operation = "readRecords"
        let context: [String: Any] = [
            "data_type": request.dataType.rawValue,
            "limit": request.pageSize,
            "has_page_token": request.pageToken != nil,
        ]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient.readRecords(request: request)
        }
    }

    /// Write a single health record.
    ///
    /// - Parameters:
    ///   - record: The health record to write.
    ///   - completion: Called with a `Result` containing the ID of the written record.
    func writeRecord(
        record: HealthRecordDto,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let operation = "writeRecord"
        var context: [String: Any] = [:]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient.writeRecord(record: record)
        }
    }

    /// Writes multiple health records atomically.
    ///
    /// - Parameters:
    ///   - records: The list of health records to write.
    ///   - completion: Called with a `Result` containing the IDs of the written records.
    func writeRecords(
        records: [HealthRecordDto],
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        let operation = "writeRecords"
        let context: [String: Any] = [
            "count": records.count,
        ]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient.writeRecords(records: records)
        }
    }

    /// Performs an aggregation query on health records.
    ///
    /// - Parameters:
    ///   - request: Contains data type, aggregation metric, and time range
    ///   - completion: Called with a `Result` containing the aggregated measurement unit
    func aggregate(
        request: AggregateRequestDto,
        completion: @escaping (Result<Double, Error>) -> Void
    ) {
        let operation = "aggregate"
        let context: [String: Any] = [
            "data_type": request.dataType.rawValue,
            "metrics": [request.aggregationMetric.rawValue],
        ]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient.aggregate(request: request)
        }
    }

    /// Deletes health records based on the request type.
    ///
    /// - Parameters:
    ///   - request: The deletion request (either by IDs or time range)
    ///   - completion: Called with a `Result` indicating success or failure
    func deleteRecords(
        request: DeleteRecordsRequestDto,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let operation = "deleteRecords"
        var context: [String: Any] = [:]

        if let idsRequest = request as? DeleteRecordsByIdsRequestDto {
            context["data_type"] = idsRequest.dataType.rawValue
            context["delete_type"] = "ids"
            context["count"] = idsRequest.recordIds.count
        } else if let timeRangeRequest = request as? DeleteRecordsByTimeRangeRequestDto {
            context["data_type"] = timeRangeRequest.dataType.rawValue
            context["delete_type"] = "time_range"
        }

        process(operation: operation, context: context, completion: completion) {
            if let idsRequest = request as? DeleteRecordsByIdsRequestDto {
                try await self.healthClient.deleteRecordsByIds(request: idsRequest)
            } else if let timeRangeRequest = request as? DeleteRecordsByTimeRangeRequestDto {
                try await self.healthClient.deleteRecordsByTimeRange(request: timeRangeRequest)
            } else {
                throw HealthConnectorError.invalidArgument(
                    message: "Unknown delete request type: \(type(of: request))"
                )
            }
        }
    }

    /// Synchronizes health data using incremental change tracking.
    ///
    /// - Parameters:
    ///   - dataTypes: Health data types to synchronize
    ///   - syncToken: Token from previous sync, or nil for initial sync
    ///   - completion: Called with a `Result` containing the synchronization result
    func synchronize(
        dataTypes: [HealthDataTypeDto],
        syncToken: HealthDataSyncTokenDto?,
        completion: @escaping (Result<HealthDataSyncResultDto, Error>) -> Void
    ) {
        let operation = "synchronize"
        let context: [String: Any] = [
            "data_type_count": dataTypes.count,
            "has_sync_token": syncToken != nil,
        ]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient.synchronize(
                dataTypes: dataTypes,
                syncToken: syncToken
            )
        }
    }

    /// Reads the exercise route for a workout session.
    ///
    /// - Parameters:
    ///   - exerciseSessionId: The UUID of the workout
    ///   - completion: Called with a `Result` containing the exercise route or nil
    func readExerciseRoute(
        exerciseSessionId: String,
        completion: @escaping (Result<ExerciseRouteDto?, Error>) -> Void
    ) {
        let operation = "readExerciseRoute"
        let context: [String: Any] = [
            "exerciseSessionId": exerciseSessionId,
        ]

        process(operation: operation, context: context, completion: completion) {
            try await self.healthClient.readExerciseRoute(exerciseSessionId: exerciseSessionId)
        }
    }

    /// Processes an async operation with standardized error handling and logging.
    ///
    /// This method wraps async closures with try-catch, converting errors to DTOs and
    /// dispatching results to the main thread via the completion handler. It also handles
    /// standardized logging for the operation lifecycle.
    ///
    /// - Parameters:
    ///   - operation: The name of the operation for logging purposes
    ///   - context: Optional context dictionary for logging additional details
    ///   - completion: The Pigeon-generated completion handler to invoke
    ///   - action: The async closure to execute
    private func process<T>(
        operation: String,
        context: [String: Any] = [:],
        completion: @escaping (Result<T, Error>) -> Void,
        action: @escaping () async throws -> T
    ) {
        Task {
            // Log start of operation
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Starting \(operation)",
                context: context
            )

            do {
                let result = try await action()

                // Log successful completion
                HealthConnectorLogger.info(
                    tag: Self.tag,
                    operation: operation,
                    message: "Completed \(operation) successfully",
                    context: context
                )

                self.complete(completion, with: .success(result))
            } catch let error as HealthConnectorError {
                // Log known error
                let errorContext = context.merging([
                    "error_code": String(describing: error.code),
                    "error_message": error.message ?? "no message",
                ]) { _, new in new }

                HealthConnectorLogger.error(
                    tag: Self.tag,
                    operation: operation,
                    message: "Failed to \(operation)",
                    context: errorContext,
                    exception: error
                )
                self.complete(completion, with: .failure(error.toErrorDto()))
            } catch {
                // Log unknown error
                HealthConnectorLogger.error(
                    tag: Self.tag,
                    operation: operation,
                    message: "Failed to \(operation)",
                    context: context,
                    exception: error
                )
                self.complete(
                    completion,
                    with: .failure(
                        HealthConnectorError.unknownError(
                            message: error.localizedDescription,
                            cause: error
                        ).toErrorDto())
                )
            }
        }
    }

    /// Dispatches a Pigeon completion handler to the main thread.
    ///
    /// This method **must** be used for all Pigeon API completion handlers called from
    /// within `Task { }` blocks or any asynchronous context.
    ///
    /// ## Why This Is Required
    ///
    /// When Pigeon's generated code calls `completion()`, it triggers a chain that ultimately
    /// invokes `FlutterStandardWriter.writeValue()` to serialize the response back to Dart.
    /// Flutter's binary messenger (`FlutterBinaryMessenger`) is **not thread-safe**, and
    /// calling it from a background thread can cause `EXC_BAD_ACCESS` crashes due to:
    ///
    /// 1. **Unsafe memory access**: The `FlutterStandardWriter` writes to `NSMutableData`
    ///    while the Flutter engine may be reading/writing from the main thread.
    /// 2. **Flutter engine assumptions**: The Flutter engine expects platform channel
    ///    responses to arrive on the main thread (the thread where the engine runs).
    ///
    /// ## Example
    ///
    /// ```swift
    /// Task {
    ///     let result = try await client.readRecords(request: request)
    ///     complete(completion, with: .success(result))
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - completion: The Pigeon-generated completion handler to invoke.
    ///   - result: The `Result` to pass to the completion handler.
    private func complete<T>(
        _ completion: @escaping (Result<T, Error>) -> Void,
        with result: Result<T, Error>
    ) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
