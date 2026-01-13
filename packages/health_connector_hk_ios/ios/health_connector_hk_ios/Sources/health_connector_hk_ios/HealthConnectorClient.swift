import Foundation
import HealthKit

/// Internal client wrapper for the HealthKit SDK.
///
/// This actor provides a thin orchestration layer that validates requests and
/// delegates all business logic to specialized handler instances.
//
// The client is responsible for:
/// - Validating input parameters (time ranges, record IDs, etc.)
/// - Looking up appropriate handlers from the registry
/// - Delegating operations to handlers
/// - Wrapping results in response DTOs
/// - Logging high-level operation results
///
/// **Thread Safety**: This actor provides compiler-enforced serial access to HealthKit operations.
/// All methods are automatically isolated and safe to call from any concurrency context.
actor HealthConnectorClient: Taggable {
    /// The HealthKit store for direct atomic operations.
    private let healthStore: HKHealthStore

    /// Service for managing HealthKit permissions.
    private let permissionService: HealthConnectorPermissionService

    /// Service for managing HealthKit data synchronization.
    private let syncService: HealthConnectorDataSyncService

    /// Registry for handler instances
    ///
    /// **Changed:** Now stores handler instances (not static singleton)
    private let handlerRegistry: HealthRecordHandlerRegistry

    /// Private initializer to prevent external instantiation.
    ///
    /// - Parameter store: The HealthKit store instance for dependency injection into services
    ///
    /// **Changed:** Creates handler registry with dependency injection
    private init(store: HKHealthStore) {
        healthStore = store
        permissionService = HealthConnectorPermissionService(store: store)
        syncService = HealthConnectorDataSyncService(store: store)
        handlerRegistry = HealthRecordHandlerRegistry(healthStore: store)
    }

    /// Gets or creates a `HealthConnectorClient` instance.
    ///
    /// - Returns: A new `HealthConnectorClient` instance wrapping the HealthKit store
    ///
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` when:
    ///          - HealthKit is not available on the device (e.g., iPad without health capabilities)
    ///          - The device is in a restricted mode
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_DECLARED` when required Info.plist keys are missing
    static func getOrCreate() throws -> HealthConnectorClient {
        guard HKHealthStore.isHealthDataAvailable() else {
            HealthConnectorLogger.error(
                tag: tag,
                operation: "getOrCreate",
                message: "HealthKit is not available on this device"
            )
            throw HealthConnectorError.healthServiceUnavailable(
                message: "HealthKit is not available on this device"
            )
        }

        try HealthConnectorPlistValidator.validateUsageDescriptions()

        return HealthConnectorClient(store: HKHealthStore())
    }

    /// Gets the current status of the HealthKit platform on the device.
    ///
    /// - Returns: The current platform status as a `HealthPlatformStatusDto`
    static func getHealthPlatformStatus() -> HealthPlatformStatusDto {
        let operation = "getHealthPlatformStatus"

        HealthConnectorLogger.debug(
            tag: tag,
            operation: operation,
            message: "Getting HealthKit availability status"
        )

        let isAvailable = HKHealthStore.isHealthDataAvailable()
        let statusDto =
            isAvailable ? HealthPlatformStatusDto.available : HealthPlatformStatusDto.notAvailable

        HealthConnectorLogger.info(
            tag: tag,
            operation: operation,
            message: "HealthKit platform status retrieved",
            context: [
                "isAvailable": isAvailable,
                "statusDto": statusDto,
            ]
        )

        return statusDto
    }

    /// Requests the specified health data permissions from the user.
    ///
    /// - Parameters:
    ///   - healthDataPermissions: List of health data permissions to request.
    ///
    /// - Returns: A list of `HealthDataPermissionRequestResultDto` containing the status for each requested permission.
    ///
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if invalid permission parameters are provided
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit is unavailable
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if an unexpected error occurs
    func requestPermissions(healthDataPermissions: [HealthDataPermissionDto]) async throws
        -> [HealthDataPermissionRequestResultDto]
    {
        let operation = "requestPermissions"
        let context: [String: Any] = [
            "health_data_permission_count": healthDataPermissions.count,
        ]

        HealthConnectorLogger.debug(
            tag: HealthConnectorClient.tag,
            operation: operation,
            message: "Requesting HealthKit permissions via permission service",
            context: context
        )

        // Delegate to permission service
        let result = try await permissionService.requestAuthorization(for: healthDataPermissions)

        HealthConnectorLogger.info(
            tag: HealthConnectorClient.tag,
            operation: operation,
            message: "HealthKit permissions requested successfully",
            context: context
        )

        return result
    }

    /// Gets the current permission status for a specific permission.
    ///
    /// - Parameter permission: The health data permission to check
    /// - Returns: PermissionStatusDto with the current status
    ///
    /// - Note: Read permissions always return `.unknown` due to HealthKit privacy restrictions.
    ///         Only write permissions can return `.granted` or `.denied`.
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if invalid permission is provided
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if an unexpected error occurs
    func getPermissionStatus(permission: HealthDataPermissionDto) async throws
        -> PermissionStatusDto
    {
        let operation = "getPermissionStatus"
        let context: [String: Any] = [
            "permission_type": String(describing: type(of: permission)),
        ]

        HealthConnectorLogger.debug(
            tag: HealthConnectorClient.tag,
            operation: operation,
            message: "Getting HealthKit permission status via permission service",
            context: context
        )

        // Delegate to permission service
        let result = try await permissionService.getPermissionStatus(for: permission)

        HealthConnectorLogger.info(
            tag: HealthConnectorClient.tag,
            operation: operation,
            message: "HealthKit permission status retrieved successfully",
            context: context
        )

        return result
    }

    /// Reads a single health record by ID.
    ///
    /// - Parameter request: Contains the data type and record ID to read
    /// - Returns: HealthRecordDto or nil if not found
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if the record ID format is invalid
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if an unexpected error occurs
    func readRecord(request: ReadRecordRequestDto) async throws -> HealthRecordDto? {
        try await process(
            operation: "readRecord",
            context: [
                "data_type": request.dataType,
                "has_record_id": !request.recordId.isEmpty,
            ]
        ) {
            let operation = "readRecord"
            let context: [String: Any] = [
                "data_type": request.dataType,
                "has_record_id": !request.recordId.isEmpty,
            ]

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Reading HealthKit record",
                context: context
            )

            let handler = try handlerRegistry.handler(
                for: request.dataType,
                withCapability: ReadableHealthRecordHandler.self
            )

            let recordDto = try await handler.readRecord(id: request.recordId)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: operation,
                message: "HealthKit record read successfully",
                context: context.merging([
                    "record_found": true,
                    "record_type": String(describing: type(of: recordDto)),
                ]) { _, new in new }
            )

            return recordDto
        }
    }

    /// Reads multiple health records within a time range.
    ///
    /// ## Pagination Strategy
    ///
    /// HealthKit doesn't provide native pagination tokens, so this method implements
    /// cursor-based pagination using timestamps. To correctly determine if more pages exist,
    /// this method uses an "over-fetch" strategy:
    ///
    /// 1. **Query pageSize + 1 records**: The method queries `pageSize + 1` records from HealthKit
    ///    instead of exactly `pageSize`. This extra record acts as a "lookahead" to determine
    ///    if more data exists beyond the current page.
    ///
    /// 2. **Detect last page**: After receiving results:
    ///    - If `pageSize + 1` records are returned → more pages exist
    ///    - If fewer than `pageSize + 1` records are returned → this is the last page
    ///
    /// 3. **Remove extra record**: If more pages exist, the last record is removed from the
    ///    response before returning to the caller. The caller always receives exactly `pageSize`
    ///    records (or fewer on the last page).
    ///
    /// 4. **Generate nextPageToken**: When more pages exist, `nextPageToken` is generated from
    ///    the timestamp of the last record being returned (not the removed record). Subsequent
    ///    requests use this token to resume pagination from the correct position.
    ///
    /// **Why this approach?**
    ///
    /// Without querying `pageSize + 1`, when HealthKit returns exactly `pageSize` records,
    /// the method cannot distinguish between:
    /// - "This is exactly the last page" (no more records exist)
    /// - "More records exist but weren't returned yet" (another page is needed)
    ///
    /// The extra record eliminates this ambiguity and ensures the last page never incorrectly
    /// includes a `nextPageToken` that leads to empty results.
    ///
    /// - Parameter request: Contains data type, time range, page size, optional page token,
    ///                     and optional data origin package names for filtering
    /// - Returns: ReadRecordsResponseDto with the records list populated and optional next page token.
    ///            The list will contain at most `pageSize` records. `nextPageToken` is nil when no more pages exist.
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if time range or page size is invalid
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if an unexpected error occurs
    func readRecords(request: ReadRecordsRequestDto) async throws -> ReadRecordsResponseDto {
        try await process(
            operation: "readRecords",
            context: [
                "data_type": request.dataType,
                "page_size": request.pageSize,
                "sort_order": request.sortOrder,
            ]
        ) {
            let operation = "readRecords"
            let context: [String: Any] = [
                "data_type": request.dataType,
                "page_size": request.pageSize,
                "has_page_token": request.pageToken != nil,
                "sort_order": request.sortOrder,
            ]

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Reading HealthKit records",
                context: context
            )

            // Validate time range
            if request.startTime >= request.endTime {
                throw HealthConnectorError.invalidArgument(
                    message: "Invalid time range: startTime must be before endTime",
                    context: [
                        "details": "startTime=\(request.startTime), endTime=\(request.endTime)",
                    ]
                )
            }

            let handler = try handlerRegistry.handler(
                for: request.dataType,
                withCapability: ReadableHealthRecordHandler.self
            )

            // Convert string page token to PaginationToken
            let paginationToken: PaginationToken? =
                if let pageTokenString = request.pageToken {
                    try PaginationToken(fromString: pageTokenString)
                } else {
                    nil
                }

            // Convert milliseconds since epoch to Date
            let startTime = Date(millisecondsSince1970: request.startTime)
            let endTime = Date(millisecondsSince1970: request.endTime)

            // Delegate to handler
            let (records, pageToken) = try await handler.readRecords(
                startTime: startTime,
                endTime: endTime,
                pageToken: paginationToken,
                pageSize: Int(request.pageSize),
                dataOriginPackageNames: request.dataOriginPackageNames,
                sortOrder: request.sortOrder
            )

            // Convert PaginationToken back to string for response DTO
            let nextPageTokenString = pageToken?.toString()

            let responseDto = ReadRecordsResponseDto(
                nextPageToken: nextPageTokenString,
                records: records
            )

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: operation,
                message: "HealthKit records read successfully",
                context: context.merging([
                    "record_count": responseDto.records.count,
                    "has_next_page": responseDto.nextPageToken != nil,
                ]) { _, new in new }
            )

            return responseDto
        }
    }

    /// Writes a single health record.
    ///
    /// - Parameter record: The health record to write
    /// - Returns: The platform-assigned record ID
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if record data is invalid
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if an unexpected error occurs
    func writeRecord(record: HealthRecordDto) async throws -> String {
        try await process(
            operation: "writeRecord",
            context: [
                "record_type": String(describing: type(of: record)),
            ]
        ) {
            let operation = "writeRecord"
            let context: [String: Any] = [
                "record_type": String(describing: type(of: record)),
            ]

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Writing HealthKit record",
                context: context
            )

            let dataType = try record.dataType

            let handler = try handlerRegistry.handler(
                for: dataType,
                withCapability: WritableHealthRecordHandler.self
            )

            // Delegate to handler
            let recordId = try await handler.writeRecord(record)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: operation,
                message: "HealthKit record written successfully",
                context: context
            )

            return recordId
        }
    }

    /// Writes multiple health records atomically.
    ///
    /// All records are saved in a single HealthKit transaction. Either all records
    /// are saved successfully, or none are saved. This ensures data consistency
    /// across different record types.
    ///
    /// - Parameter records: The list of health records to write
    /// - Returns: Platform-assigned record IDs in input order
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if any record data is invalid
    /// - Throws: `HealthConnectorError` with code `UNSUPPORTED_OPERATION` if any type is not writable
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if an unexpected error occurs
    func writeRecords(records: [HealthRecordDto]) async throws -> [String] {
        try await process(operation: "writeRecords", context: ["totalRecords": records.count]) {
            let operation = "writeRecords"
            let context: [String: Any] = [
                "totalRecords": records.count,
            ]

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Writing Health Connect records atomically",
                context: context
            )

            guard !records.isEmpty else {
                HealthConnectorLogger.debug(
                    tag: Self.tag,
                    operation: operation,
                    message: "No records to write, returning empty response"
                )
                return []
            }

            // Validate all records and convert to samples
            var samples: [HKSample] = []
            samples.reserveCapacity(records.count)

            for (index, record) in records.enumerated() {
                let dataType = try record.dataType

                // Validate: Handler exists and supports writes
                _ = try handlerRegistry.handler(
                    for: dataType,
                    withCapability: WritableHealthRecordHandler.self
                )

                let sample = try record.toHealthKit()
                samples.append(sample)
            }

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "All records validated and converted to samples",
                context: [
                    "sampleCount": samples.count,
                ]
            )

            try await healthStore.save(samples)

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Atomic save completed successfully"
            )

            let recordIds = samples.map(\.uuid.uuidString)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: operation,
                message: "Health Connect records written successfully",
                context: [
                    "recordCount": recordIds.count,
                ]
            )

            return recordIds
        }
    }

    /// Performs an aggregation query on health records.
    ///
    /// - Parameter request: Contains data type, aggregation metric, and time range
    /// - Returns: MeasurementUnitDto with the aggregated value
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if time range or metric is invalid
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if an unexpected error occurs
    func aggregate(request: AggregateRequestDto) async throws -> MeasurementUnitDto {
        try await process(
            operation: "aggregate",
            context: [
                "data_type": request.dataType,
                "metric_type": request.aggregationMetric,
            ]
        ) {
            let operation = "aggregate"
            let context: [String: Any] = [
                "data_type": request.dataType,
                "metric_type": request.aggregationMetric,
            ]

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Aggregating HealthKit data",
                context: context
            )

            if request.startTime >= request.endTime {
                throw HealthConnectorError.invalidArgument(
                    message: "Invalid time range: startTime must be before endTime",
                    context: [
                        "details": "startTime=\(request.startTime), endTime=\(request.endTime)",
                    ]
                )
            }

            let handler = try handlerRegistry.handler(
                for: request.dataType,
                withCapability: AggregatableHealthRecordHandler.self
            )

            // Convert milliseconds since epoch to Date
            let startTime = Date(millisecondsSince1970: request.startTime)
            let endTime = Date(millisecondsSince1970: request.endTime)

            let value = try await handler.aggregate(
                metric: request.aggregationMetric,
                startTime: startTime,
                endTime: endTime
            )

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: operation,
                message: "HealthKit data aggregated successfully",
                context: context.merging([
                    "result_type": String(describing: type(of: value)),
                ]) { _, new in new }
            )

            return value
        }
    }

    /// Deletes all records of a data type within a time range.
    ///
    /// Uses HealthKit's `deleteObjects(of:predicate:withCompletion:)` API.
    ///
    /// - Parameter request: Contains data type and time range for deletion
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if time range is invalid
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if deletion fails
    func deleteRecordsByTimeRange(request: DeleteRecordsByTimeRangeRequestDto) async throws {
        try await process(
            operation: "deleteRecordsByTimeRange",
            context: ["data_type": request.dataType]
        ) {
            let operation = "deleteRecordsByTimeRange"
            let context: [String: Any] = [
                "data_type": request.dataType,
            ]

            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: operation,
                message: "Deleting HealthKit records by time range",
                context: context
            )

            if request.startTime >= request.endTime {
                throw HealthConnectorError.invalidArgument(
                    message: "Invalid time range: startTime must be before endTime",
                    context: [
                        "details": "startTime=\(request.startTime), endTime=\(request.endTime)",
                    ]
                )
            }

            let handler = try handlerRegistry.handler(
                for: request.dataType,
                withCapability: DeletableHealthRecordHandler.self
            )

            // Convert milliseconds since epoch to Date
            let startTime = Date(millisecondsSince1970: request.startTime)
            let endTime = Date(millisecondsSince1970: request.endTime)

            try await handler.deleteRecords(
                startTime: startTime,
                endTime: endTime
            )

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: operation,
                message: "HealthKit records deleted successfully",
                context: context
            )
        }
    }

    /// Deletes specific records by their IDs.
    ///
    /// Uses query-then-delete pattern since HealthKit doesn't support direct UUID deletion.
    ///
    /// - Parameter request: Contains data type and list of record IDs to delete
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if record IDs are invalid
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if deletion fails
    func deleteRecordsByIds(request: DeleteRecordsByIdsRequestDto) async throws {
        try await process(
            operation: "deleteRecordsByIds",
            context: [
                "data_type": request.dataType,
                "count": request.recordIds.count,
            ]
        ) {
            let operation = "deleteRecordsByIds"
            let context: [String: Any] = [
                "data_type": request.dataType,
                "record_count": request.recordIds.count,
            ]

            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: operation,
                message: "Deleting HealthKit records by IDs",
                context: context
            )

            let handler = try handlerRegistry.handler(
                for: request.dataType,
                withCapability: DeletableHealthRecordHandler.self
            )

            try await handler.deleteRecords(ids: request.recordIds)

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: operation,
                message: "HealthKit records deleted successfully",
                context: context
            )
        }
    }

    /// Synchronizes health data using incremental change tracking.
    ///
    /// - Parameters:
    ///   - dataTypes: Health data types to synchronize
    ///   - syncToken: Token from previous sync, or nil for initial sync
    ///
    /// - Returns: HealthDataSyncResultDto containing changes since last sync
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if parameters are invalid
    /// - Throws: `HealthConnectorError` with code `PERMISSION_NOT_GRANTED` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_SERVICE_UNAVAILABLE` if HealthKit is unavailable
    /// - Throws: `HealthConnectorError` with code `UNKNOWN_ERROR` if an unexpected error occurs
    func synchronize(
        dataTypes: [HealthDataTypeDto],
        syncToken: HealthDataSyncTokenDto?
    ) async throws -> HealthDataSyncResultDto {
        try await process(
            operation: "synchronize",
            context: [
                "data_type_count": dataTypes.count,
                "has_sync_token": syncToken != nil,
            ]
        ) {
            let operation = "synchronize"
            let context: [String: Any] = [
                "data_type_count": dataTypes.count,
                "has_sync_token": syncToken != nil,
            ]

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Synchronizing HealthKit data",
                context: context
            )

            // Delegate to sync service
            let result = try await syncService.synchronize(
                dataTypes: dataTypes,
                syncToken: syncToken
            )

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: operation,
                message: "HealthKit data synchronized successfully",
                context: context.merging([
                    "upserted_count": result.upsertedRecords.count,
                    "deleted_count": result.deletedRecordIds.count,
                    "has_more": result.hasMore,
                ]) { _, new in new }
            )

            return result
        }
    }

    // MARK: - Private Error Handling

    /// Processes an async operation with standardized error handling.
    ///
    /// This method wraps async closures with try-catch, converting errors to `HealthConnectorError`
    /// and logging them consistently. It handles three error types:
    /// 1. `HealthConnectorError` - rethrown as-is
    /// 2. `HKError` / `NSError` - converted to appropriate `HealthConnectorError`
    /// 3. Generic `Error` - wrapped in `HealthConnectorError.unknown`
    ///
    /// - Parameters:
    ///   - operation: The name of the operation for logging purposes
    ///   - context: Optional context dictionary for logging (e.g., request details)
    ///   - action: The async closure to execute
    /// - Returns: The result of the action
    /// - Throws: `HealthConnectorError` representing the failure
    private func process<T>(
        operation: String,
        context: [String: Any] = [:],
        action: () async throws -> T
    ) async throws -> T {
        do {
            return try await action()
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as HKError {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: operation,
                message: "Failed to \(operation)",
                context: context,
                exception: error
            )

            throw HealthConnectorError.create(from: error)
        } catch {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: operation,
                message: "Failed to \(operation)",
                context: context,
                exception: error
            )
            throw HealthConnectorError.unknownError(
                message: "Failed to \(operation): \(error.localizedDescription)",
                cause: error,
                context: ["details": error.localizedDescription]
            )
        }
    }
}
