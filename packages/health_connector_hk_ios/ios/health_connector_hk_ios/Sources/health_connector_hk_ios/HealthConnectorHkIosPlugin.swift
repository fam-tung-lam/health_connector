import Flutter
import HealthKit
import UIKit

/// Flutter plugin for accessing HealthKit on iOS devices.
///
/// **Thread Safety**: Uses actor-based HealthConnectorClient for compiler-enforced serial access.
public class HealthConnectorHkIosPlugin: NSObject, FlutterPlugin, HealthConnectorHKIOSApi {
    /// Cached instance of the HealthKit client actor.
    private var healthClient: HealthConnectorClient!

    /// Registers the plugin with the Flutter engine.
    ///
    /// - Parameter registrar: Provides access to the Flutter engine and binary messenger
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = HealthConnectorHkIosPlugin()
        HealthConnectorHKIOSApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
    }

    /// Initializes the Health Connector client with the provided configuration.
    ///
    /// This method must be called before any other Health Connector operations
    /// to properly configure the native platform code, including logger settings.
    ///
    /// - Parameters:
    ///   - config: Configuration settings for the Health Connector
    ///   - completion: Called with a `Result` indicating success or failure
    public func initialize(
        config: HealthConnectorConfigDto,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: "create",
            message: "Creating HealthConnectorClient...",
            context: ["isLoggerEnabled": String(config.isLoggerEnabled)]
        )

        do {
            if healthClient == nil {
                healthClient = try HealthConnectorClient.getOrCreate()
            }

            // Configure the native logger based on the provided configuration
            HealthConnectorLogger.isEnabled = config.isLoggerEnabled

            HealthConnectorLogger.debug(
                tag: HealthConnectorHkIosPlugin.tag,
                operation: "create",
                message: "HealthConnector initialized successfully",
                context: ["isLoggerEnabled": String(config.isLoggerEnabled)]
            )

            completion(.success(()))
        } catch {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: "create",
                message: "Failed to create HealthConnectorClient",
                exception: error
            )
            completion(
                .failure(
                    HealthConnectorError.unknown(
                        message: error.localizedDescription,
                        cause: error
                    ).toDto()))
        }
    }

    /// Gets the current status of the HealthKit platform on the device.
    ///
    /// - Parameter completion: Called with a `Result` containing the platform status
    public func getHealthPlatformStatus(
        completion: @escaping (Result<HealthPlatformStatusDto, Error>) -> Void
    ) {
        let statusDto = HealthConnectorClient.getHealthPlatformStatus()
        completion(.success(statusDto))
    }

    /// Requests permissions from the user.
    ///
    /// - Parameters:
    ///   - request: Contains lists of health data permissions and feature permissions to request.
    ///   - completion: Called with a `Result` containing the permission request results.
    ///
    /// - Throws: `HealthConnectorError.healthPlatformUnavailable` if HealthKit is unavailable
    /// - Throws: `HealthConnectorError.unknown` for unexpected errors
    public func requestPermissions(
        request: PermissionsRequestDto,
        completion: @escaping (Result<PermissionsRequestResponseDto, Error>) -> Void
    ) {
        process(operation: "requestPermissions", completion: completion) {
            let healthDataResults = try await self.healthClient
                .requestPermissions(healthDataPermissions: request.healthDataPermissions)
            return PermissionsRequestResponseDto(
                healthDataPermissionResults: healthDataResults
            )
        }
    }

    /// Reads a single health record by ID.
    ///
    /// - Parameters:
    ///   - request: Contains the data type and record ID to read
    ///   - completion: Called with a `Result` containing the read record response or nil if not found
    public func readRecord(
        request: ReadRecordRequestDto,
        completion: @escaping (Result<ReadRecordResponseDto?, Error>) -> Void
    ) {
        process(operation: "readRecord", completion: completion) {
            try await self.healthClient.readRecord(request: request)
        }
    }

    /// Reads multiple health records within a time range.
    ///
    /// - Parameters:
    ///   - request: Contains data type, time range, page size, and optional page token
    ///   - completion: Called with a `Result` containing the read records response
    public func readRecords(
        request: ReadRecordsRequestDto,
        completion: @escaping (Result<ReadRecordsResponseDto, Error>) -> Void
    ) {
        process(operation: "readRecords", completion: completion) {
            try await self.healthClient.readRecords(request: request)
        }
    }

    /// Writes a single health record.
    ///
    /// - Parameters:
    ///   - request: Contains the data type and the typed record to write
    ///   - completion: Called with a `Result` containing the write record response
    public func writeRecord(
        request: WriteRecordRequestDto,
        completion: @escaping (Result<WriteRecordResponseDto, Error>) -> Void
    ) {
        process(operation: "writeRecord", completion: completion) {
            try await self.healthClient.writeRecord(request: request)
        }
    }

    /// Writes multiple health records atomically.
    ///
    /// - Parameters:
    ///   - request: Contains the data types and the list of typed records to write
    ///   - completion: Called with a `Result` containing the write records response
    public func writeRecords(
        request: WriteRecordsRequestDto,
        completion: @escaping (Result<WriteRecordsResponseDto, Error>) -> Void
    ) {
        process(operation: "writeRecords", completion: completion) {
            try await self.healthClient.writeRecords(request: request)
        }
    }

    /// Updates a single health record using delete-then-insert pattern.
    ///
    /// - Parameters:
    ///   - request: Contains the data type and the typed record to update
    ///   - completion: Called with a `Result` containing the update record response
    public func updateRecord(
        request: UpdateRecordRequestDto,
        completion: @escaping (Result<UpdateRecordResponseDto, Error>) -> Void
    ) {
        process(operation: "updateRecord", completion: completion) {
            try await self.healthClient.updateRecord(request: request)
        }
    }

    /// Performs an aggregation query on health records.
    ///
    /// - Parameters:
    ///   - request: Contains data type, aggregation metric, and time range
    ///   - completion: Called with a `Result` containing the aggregation response
    public func aggregate(
        request: AggregateRequestDto,
        completion: @escaping (Result<AggregateResponseDto, Error>) -> Void
    ) {
        process(operation: "aggregate", completion: completion) {
            try await self.healthClient.aggregate(request: request)
        }
    }

    /// Deletes health records by their IDs.
    ///
    /// Uses query-then-delete pattern since HealthKit doesn't support direct deletion by UUID.
    ///
    /// - Parameters:
    ///   - request: Contains the data type and list of record IDs to delete
    ///   - completion: Called with a `Result` indicating success or failure
    public func deleteRecordsByIds(
        request: DeleteRecordsByIdsRequestDto,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        process(operation: "deleteRecordsByIds", completion: completion) {
            try await self.healthClient.deleteRecordsByIds(request: request)
        }
    }

    /// Deletes health records within a time range.
    ///
    /// - Parameters:
    ///   - request: Contains the data type, start time, and end time
    ///   - completion: Called with a `Result` indicating success or failure
    public func deleteRecordsByTimeRange(
        request: DeleteRecordsByTimeRangeRequestDto,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        process(operation: "deleteRecordsByTimeRange", completion: completion) {
            try await self.healthClient.deleteRecordsByTimeRange(request: request)
        }
    }

    /// Processes an async operation with standardized error handling.
    ///
    /// This method wraps async closures with try-catch, converting errors to DTOs and
    /// dispatching results to the main thread via the completion handler.
    ///
    /// - Parameters:
    ///   - operation: The name of the operation for logging purposes
    ///   - completion: The Pigeon-generated completion handler to invoke
    ///   - action: The async closure to execute
    private func process<T>(
        operation: String,
        completion: @escaping (Result<T, Error>) -> Void,
        action: @escaping () async throws -> T
    ) {
        Task {
            do {
                let result = try await action()
                self.complete(completion, with: .success(result))
            } catch let error as HealthConnectorError {
                HealthConnectorLogger.error(
                    tag: Self.tag,
                    operation: operation,
                    message: "Failed to \(operation)",
                    context: [
                        "error_code": String(describing: error.code),
                        "error_message": error.message ?? "no message",
                    ],
                    exception: error
                )
                self.complete(completion, with: .failure(error.toDto()))
            } catch {
                HealthConnectorLogger.error(
                    tag: Self.tag,
                    operation: operation,
                    message: "Failed to \(operation)",
                    exception: error
                )
                self.complete(
                    completion,
                    with: .failure(
                        HealthConnectorError.unknown(
                            message: error.localizedDescription,
                            cause: error
                        ).toDto())
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
