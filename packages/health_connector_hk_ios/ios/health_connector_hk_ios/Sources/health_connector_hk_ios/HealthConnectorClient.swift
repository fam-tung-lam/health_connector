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

            guard let baseHandler = handlerRegistry.getHandler(for: request.dataType) else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            guard let handler = baseHandler as? ReadableHealthRecordHandler else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Data type \(request.dataType) does not support read operations"
                )
            }

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

            guard let baseHandler = handlerRegistry.getHandler(for: request.dataType) else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            guard let handler = baseHandler as? ReadableHealthRecordHandler else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Data type \(request.dataType) does not support read operations"
                )
            }

            // Delegate to handler
            let (records, pageToken) = try await handler.readRecords(
                startTime: request.startTime,
                endTime: request.endTime,
                pageToken: request.pageToken,
                pageSize: Int(request.pageSize),
                dataOriginPackageNames: request.dataOriginPackageNames
            )

            let responseDto = ReadRecordsResponseDto(
                nextPageToken: pageToken,
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

            guard let baseHandler = handlerRegistry.getHandler(for: dataType) else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported data type: \(dataType)"
                )
            }

            guard let handler = baseHandler as? WritableHealthRecordHandler else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Data type \(dataType) does not support write operations"
                )
            }

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

    /// Updates a single health record using delete-then-insert pattern.
    ///
    /// HealthKit uses an immutable data model where samples cannot be updated once saved.
    /// This method implements update-like behavior by:
    /// 1. Deleting the old sample using delete(_:withCompletion:)
    /// 2. Inserting a new sample with corrected values using save(_:withCompletion:)
    ///
    /// Since HealthKit assigns a new UUID to each sample, the returned record ID will
    /// be different from the input ID. This is expected HealthKit behavior.
    ///
    /// - Parameter request: Contains the health record to update
    /// - Returns: UpdateRecordResponseDto containing the new record ID (different from input)
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if record ID is invalid or record data is invalid
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
    func updateRecord(request: UpdateRecordRequestDto) async throws -> UpdateRecordResponseDto {
        try await process(operation: "updateRecord", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "updateRecord",
                message: "Updating Health Connect record",
                context: ["request": request]
            )

            let recordId = request.record.id
            let dataType = try request.record.dataType

            if recordId?.isEmpty ?? true {
                throw HealthConnectorError.invalidArgument(
                    message:
                    "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records.",
                    context: ["details": "Record ID: \(recordId ?? "nil")"]
                )
            }

            guard let baseHandler = self.handlerRegistry.getHandler(for: dataType) else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported data type: \(dataType)"
                )
            }

            guard let handler = baseHandler as? UpdatableHealthRecordHandler else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Data type \(dataType) does not support update operations"
                )
            }

            let recordDto = request.record
            guard let recordIdString = recordDto.id else {
                throw HealthConnectorError.invalidArgument(
                    message: "Record ID is required for update operations"
                )
            }

            try await handler.updateRecord(recordDto)

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: "updateRecord",
                message: "Health Connect record updated successfully",
                context: ["request": request]
            )

            return UpdateRecordResponseDto(recordId: recordIdString)
        }
    }

    /// Writes multiple health records.
    ///
    /// Records are grouped by data type and written via their respective handlers.
    /// Record IDs are returned in the same order as the input records.
    ///
    /// **Non-Atomic Operation**: If an error occurs while writing a group of records,
    /// previously written groups will remain committed. This is a HealthKit limitation -
    /// the platform does not provide transaction support for multi-type writes.
    /// For example, if writing 10 steps records succeeds but 5 weight records fail,
    /// the steps will remain in HealthKit while an error is thrown.
    ///
    /// **Order Preservation**: Despite grouping by type internally, the returned record IDs
    /// are guaranteed to be in the exact same order as the input records.
    ///
    /// - Parameter request: Contains the list of health records to write
    /// - Returns: WriteRecordsResponseDto containing the platform-assigned record IDs in input order
    ///
    /// - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if any record data is invalid
    /// - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
    /// - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
    /// - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs or if partial write fails
    func writeRecords(request: WriteRecordsRequestDto) async throws -> WriteRecordsResponseDto {
        try await process(operation: "writeRecords", context: ["request": request]) {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: "writeRecords",
                message: "Writing Health Connect records",
                context: ["request": request]
            )

            // Create result array (same size as input) to maintain order
            var recordIds: [String?] = Array(repeating: nil, count: request.records.count)

            // Group records by type with original indices
            var recordsByType: [HealthDataTypeDto: [(index: Int, record: HealthRecordDto)]] = [:]
            for (index, record) in request.records.enumerated() {
                let dataType = try record.dataType
                recordsByType[dataType, default: []].append((index, record))
            }

            // Write each group and place IDs at correct indices
            for (dataType, indexedRecords) in recordsByType {
                guard let baseHandler = handlerRegistry.getHandler(for: dataType) else {
                    throw HealthConnectorError.unsupportedOperation(
                        message: "Unsupported data type: \(dataType)"
                    )
                }

                guard let handler = baseHandler as? WritableHealthRecordHandler else {
                    throw HealthConnectorError.unsupportedOperation(
                        message: "Data type \(dataType) does not support write operations"
                    )
                }

                let records = indexedRecords.map(\.record)
                let groupIds = try await handler.writeRecords(records)

                // Place each ID at its original index
                for (arrayIndex, (originalIndex, _)) in indexedRecords.enumerated() {
                    recordIds[originalIndex] = groupIds[arrayIndex]
                }
            }

            // Verify all slots filled
            guard recordIds.allSatisfy({ $0 != nil }) else {
                throw HealthConnectorError.unknown(
                    message: "Some records were not written",
                    context: ["details": "Not all record IDs were assigned"]
                )
            }

            let finalRecordIds = recordIds.compactMap { $0 }

            HealthConnectorLogger.info(
                tag: Self.tag,
                operation: "writeRecords",
                message: "Health Connect records written successfully",
                context: ["request": request, "assignedRecordIds": finalRecordIds]
            )

            return WriteRecordsResponseDto(recordIds: finalRecordIds)
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

            // Validate time range
            if request.startTime >= request.endTime {
                throw HealthConnectorError.invalidArgument(
                    message: "Invalid time range: startTime must be before endTime",
                    context: [
                        "details": "startTime=\(request.startTime), endTime=\(request.endTime)",
                    ]
                )
            }

            guard let baseHandler = handlerRegistry.getHandler(for: request.dataType) else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            // Try custom aggregation first (for category types like sleep)
            if let customHandler = baseHandler as? CustomAggregatableHealthRecordHandler {
                let value = try await customHandler.aggregate(
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

            // Fall back to standard aggregation (for quantity types)
            guard let handler = baseHandler as? AggregatableHealthRecordHandler else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Aggregation not supported for data type: \(request.dataType)"
                )
            }

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

            guard let baseHandler = self.handlerRegistry.getHandler(for: request.dataType) else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            guard let handler = baseHandler as? DeletableHealthRecordHandler else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Data type \(request.dataType) does not support delete operations"
                )
            }

            try await handler.deleteRecords(startTime: request.startTime, endTime: request.endTime)

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

            guard let baseHandler = self.handlerRegistry.getHandler(for: request.dataType) else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            guard let handler = baseHandler as? DeletableHealthRecordHandler else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Data type \(request.dataType) does not support delete operations"
                )
            }

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
