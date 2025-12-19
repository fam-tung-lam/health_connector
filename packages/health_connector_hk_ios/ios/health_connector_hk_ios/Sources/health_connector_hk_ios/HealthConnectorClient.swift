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
        handlerRegistry = HealthRecordHandlerRegistry(healthStore: store)
    }

    /// Gets or creates a `HealthConnectorClient` instance.
    ///
    /// - Returns: A new `HealthConnectorClient` instance wrapping the HealthKit store
    ///
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` when:
    ///          - HealthKit is not available on the device (e.g., iPad without health capabilities)
    ///          - The device is in a restricted mode
    /// - Throws: `HealthConnectorError` with code `INVALID_CONFIGURATION` when required Info.plist keys are missing
    static func getOrCreate() throws -> HealthConnectorClient {
        guard HKHealthStore.isHealthDataAvailable() else {
            HealthConnectorLogger.error(
                tag: tag,
                operation: "getOrCreate",
                message: "HealthKit is not available on this device"
            )
            throw HealthConnectorError.healthProviderUnavailable(
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
        HealthConnectorLogger.debug(
            tag: tag,
            operation: "getHealthPlatformStatus",
            message: "Getting HealthKit availability status"
        )

        let isAvailable = HKHealthStore.isHealthDataAvailable()
        let statusDto =
            isAvailable ? HealthPlatformStatusDto.available : HealthPlatformStatusDto.notAvailable

        HealthConnectorLogger.info(
            tag: tag,
            operation: "getHealthPlatformStatus",
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
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if invalid permission parameters are provided
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit is unavailable
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
    func requestPermissions(healthDataPermissions: [HealthDataPermissionDto]) async throws
        -> [HealthDataPermissionRequestResultDto]
    {
        HealthConnectorLogger.debug(
            tag: HealthConnectorClient.tag,
            operation: "requestPermissions",
            message: "Requesting HealthKit permissions via permission service",
            context: [
                "requested_health_data_permissions": healthDataPermissions,
            ]
        )

        // Delegate to permission service
        return try await permissionService.requestAuthorization(for: healthDataPermissions)
    }

    /// Reads a single health record by ID.
    ///
    /// - Parameter request: Contains the data type and record ID to read
    /// - Returns: ReadRecordResponseDto with the record populated, or nil if not found
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if the record ID format is invalid
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
    func readRecord(request: ReadRecordRequestDto) async throws -> ReadRecordResponseDto? {
        try await process(operation: "readRecord", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "readRecord",
                message: "Reading Health Connect record",
                context: ["request": request]
            )

            let handler = try handlerRegistry.handler(
                for: request.dataType,
                withCapability: ReadableHealthRecordHandler.self
            )

            let recordDto = try await handler.readRecord(id: request.recordId)
            let responseDto = ReadRecordResponseDto(record: recordDto)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: "readRecord",
                message: "Health Connect record read successfully",
                context: ["request": request, "response": responseDto]
            )

            return responseDto
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
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
    func readRecords(request: ReadRecordsRequestDto) async throws -> ReadRecordsResponseDto {
        try await process(operation: "readRecords", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "readRecords",
                message: "Reading Health Connect records",
                context: ["request": request]
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
            let paginationToken: PaginationToken? = if let pageTokenString = request.pageToken {
                try PaginationToken(fromString: pageTokenString)
            } else {
                nil
            }

            // Delegate to handler
            let (records, pageToken) = try await handler.readRecords(
                startTime: request.startTime,
                endTime: request.endTime,
                pageToken: paginationToken,
                pageSize: Int(request.pageSize),
                dataOriginPackageNames: request.dataOriginPackageNames
            )

            // Convert PaginationToken back to string for response DTO
            let nextPageTokenString = pageToken?.toString()

            let responseDto = ReadRecordsResponseDto(
                nextPageToken: nextPageTokenString,
                records: records
            )

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: "readRecords",
                message: "Health Connect records read successfully",
                context: ["request": request, "response": responseDto]
            )

            return responseDto
        }
    }

    /// Writes a single health record.
    ///
    /// - Parameter request: Contains the health record to write
    /// - Returns: WriteRecordResponseDto containing the platform-assigned record ID
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if record data is invalid
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
    func writeRecord(request: WriteRecordRequestDto) async throws -> WriteRecordResponseDto {
        try await process(operation: "writeRecord", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "writeRecord",
                message: "Writing Health Connect record",
                context: ["request": request]
            )

            let dataType = try request.record.dataType

            let handler = try handlerRegistry.handler(
                for: dataType,
                withCapability: WritableHealthRecordHandler.self
            )

            // Delegate to handler
            let recordId = try await handler.writeRecord(request.record)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: "writeRecord",
                message: "Health Connect record written successfully",
                context: ["request": request, "assignedRecordId": recordId]
            )

            return WriteRecordResponseDto(recordId: recordId)
        }
    }

    /// Writes multiple health records atomically.
    ///
    /// All records are saved in a single HealthKit transaction. Either all records
    /// are saved successfully, or none are saved. This ensures data consistency
    /// across different record types.
    ///
    /// - Parameter request: Contains the list of health records to write
    /// - Returns: WriteRecordsResponseDto with platform-assigned record IDs in input order
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if any record data is invalid
    /// - Throws: `HealthConnectorError` with code `UNSUPPORTED_OPERATION` if any type is not writable
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
    func writeRecords(request: WriteRecordsRequestDto) async throws -> WriteRecordsResponseDto {
        try await process(operation: "writeRecords", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "writeRecords",
                message: "Writing Health Connect records atomically",
                context: [
                    "totalRecords": request.records.count,
                    "request": request,
                ]
            )

            guard !request.records.isEmpty else {
                HealthConnectorLogger.debug(
                    tag: Self.tag,
                    operation: "writeRecords",
                    message: "No records to write, returning empty response"
                )
                return WriteRecordsResponseDto(recordIds: [])
            }

            // Validate all records and convert to samples
            var samples: [HKSample] = []
            samples.reserveCapacity(request.records.count)

            for (index, record) in request.records.enumerated() {
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
                operation: "writeRecords",
                message: "All records validated and converted to samples",
                context: [
                    "sampleCount": samples.count,
                ]
            )

            try await healthStore.save(samples)

            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "writeRecords",
                message: "Atomic save completed successfully"
            )

            let recordIds = samples.map(\.uuid.uuidString)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: "writeRecords",
                message: "Health Connect records written successfully",
                context: [
                    "recordCount": recordIds.count,
                    "request": request,
                ]
            )

            return WriteRecordsResponseDto(recordIds: recordIds)
        }
    }

    /// Performs an aggregation query on health records.
    ///
    /// - Parameter request: Contains data type, aggregation metric, and time range
    /// - Returns: AggregateResponseDto with aggregated value and data point count
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if time range or metric is invalid
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
    func aggregate(request: AggregateRequestDto) async throws -> AggregateResponseDto {
        try await process(operation: "aggregate", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "aggregate",
                message: "Aggregating Health Connect data",
                context: ["request": request]
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

            let value = try await handler.aggregate(
                metric: request.aggregationMetric,
                startTime: request.startTime,
                endTime: request.endTime
            )

            let responseDto = AggregateResponseDto(value: value)

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: "aggregate",
                message: "Health Connect data aggregated successfully",
                context: ["request": request, "response": responseDto]
            )

            return responseDto
        }
    }

    /// Deletes all records of a data type within a time range.
    ///
    /// Uses HealthKit's `deleteObjects(of:predicate:withCompletion:)` API.
    ///
    /// - Parameter request: Contains data type and time range for deletion
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if time range is invalid
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if deletion fails
    func deleteRecordsByTimeRange(request: DeleteRecordsByTimeRangeRequestDto) async throws {
        try await process(operation: "deleteRecordsByTimeRange", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "deleteRecordsByTimeRange",
                message: "Deleting Health Connect records by time range",
                context: ["request": request]
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

            let startTime = Date(timeIntervalSince1970: Double(request.startTime) / 1000.0)
            let endTime = Date(timeIntervalSince1970: Double(request.endTime) / 1000.0)

            try await handler.deleteRecords(
                startTime: startTime,
                endTime: endTime
            )

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: "deleteRecordsByTimeRange",
                message: "Health Connect records deleted successfully",
                context: ["request": request]
            )
        }
    }

    /// Deletes specific records by their IDs.
    ///
    /// Uses query-then-delete pattern since HealthKit doesn't support direct UUID deletion.
    ///
    /// - Parameter request: Contains data type and list of record IDs to delete
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if record IDs are invalid
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if deletion fails
    func deleteRecordsByIds(request: DeleteRecordsByIdsRequestDto) async throws {
        try await process(operation: "deleteRecordsByIds", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "deleteRecordsByIds",
                message: "Deleting Health Connect records by IDs",
                context: ["request": request]
            )

            let handler = try handlerRegistry.handler(
                for: request.dataType,
                withCapability: DeletableHealthRecordHandler.self
            )

            try await handler.deleteRecords(ids: request.recordIds)

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: "deleteRecordsByIds",
                message: "Health Connect records deleted successfully",
                context: ["request": request]
            )
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
            throw HealthConnectorError.unknown(
                message: "Failed to \(operation): \(error.localizedDescription)",
                context: ["details": error.localizedDescription]
            )
        }
    }
}
