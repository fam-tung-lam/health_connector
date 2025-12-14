import Foundation
import HealthKit

/**
 * Internal client wrapper for the HealthKit SDK.
 */
class HealthConnectorClient {
    /**
     * Tag used for logging throughout the client.
     */
    private static let tag = "HealthConnectorClient"

    /**
     * The underlying HealthKit store instance.
     */
    private let store: HKHealthStore

    /**
     * Private initializer to prevent external instantiation.
     *
     * - Parameter store: The HealthKit store instance.
     */
    private init(store: HKHealthStore) {
        self.store = store
        // Trigger handler registration on first initialization
        _ = HealthKitTypeRegistry.shared
    }

    /**
     * Maps HealthKit errors to HealthConnectorError instances.
     *
     * - Parameter error: The NSError to map
     * - Returns: A HealthConnectorError with the appropriate error code
     */
    static func mapHealthKitError(_ error: NSError) -> HealthConnectorError {
        if error.domain == HKError.errorDomain {
            let hkErrorCode = HKError.Code(rawValue: error.code)
            switch hkErrorCode {
            case .errorAuthorizationDenied:
                return HealthConnectorErrors.notAuthorized(
                    message: error.localizedDescription,
                    details: error.localizedDescription
                )
            case .errorInvalidArgument:
                return HealthConnectorErrors.invalidArgument(
                    message: error.localizedDescription,
                    details: error.localizedDescription
                )
            case .errorHealthDataUnavailable, .errorDatabaseInaccessible:
                return HealthConnectorErrors.healthProviderUnavailable(
                    message: error.localizedDescription,
                    details: error.localizedDescription
                )
            default:
                return HealthConnectorErrors.unknown(
                    message: error.localizedDescription,
                    details: error.localizedDescription
                )
            }
        } else {
            return HealthConnectorErrors.unknown(
                message: error.localizedDescription,
                details: error.localizedDescription
            )
        }
    }

    /**
     * Gets or creates a `HealthConnectorClient` instance.
     *
     * - Returns: A new `HealthConnectorClient` instance wrapping the HealthKit store
     *
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` when:
     *          - HealthKit is not available on the device (e.g., iPad without health capabilities)
     *          - The device is in a restricted mode
     */
    static func getOrCreate() throws -> HealthConnectorClient {
        guard HKHealthStore.isHealthDataAvailable() else {
            HealthConnectorLogger.error(
                tag: tag,
                operation: "getOrCreate",
                message: "HealthKit is not available on this device"
            )
            throw HealthConnectorErrors.healthProviderUnavailable(
                message: nil,
                details: nil
            )
        }

        let store = HKHealthStore()
        return HealthConnectorClient(store: store)
    }

    /**
     * Gets the current status of the HealthKit platform on the device.
     *
     * - Returns: The current platform status as a `HealthPlatformStatusDto`
     */
    static func getHealthPlatformStatus() -> HealthPlatformStatusDto {
        HealthConnectorLogger.debug(
            tag: tag,
            operation: "getHealthPlatformStatus",
            message: "Getting HealthKit availability status"
        )

        let isAvailable = HKHealthStore.isHealthDataAvailable()

        let statusDto = HealthPlatformStatusDto.fromHealthKitAvailability(isAvailable)
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

    /**
     * Requests the specified health data permissions from the user.
     *
     * - Parameters:
     *   - healthDataPermissions: List of health data permissions to request.
     *
     * - Returns: A list of `HealthDataPermissionRequestResultDto` containing the status for each requested permission.
     *
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if invalid permission parameters are provided
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit is unavailable
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
     */
    func requestPermissions(healthDataPermissions: [HealthDataPermissionDto]) async throws
        -> [HealthDataPermissionRequestResultDto]
    {
        do {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "requestPermissions",
                message: "Requesting Health Connect permissions",
                context: [
                    "requested_health_data_permissions": healthDataPermissions,
                ]
            )

            // Separate permissions into read and write sets
            var typesToRead = Set<HKObjectType>()
            var typesToWrite = Set<HKSampleType>()

            for permission in healthDataPermissions {
                let objectTypes = try permission.toHealthKitObjectTypes()

                for objectType in objectTypes {
                    switch permission.accessType {
                    case .read:
                        typesToRead.insert(objectType)
                    case .write:
                        if let sampleType = objectType as? HKSampleType {
                            typesToWrite.insert(sampleType)
                        }
                    }
                }
            }

            try await store.requestAuthorization(toShare: typesToWrite, read: typesToRead)

            let results = try healthDataPermissions.map {
                permissionDto -> HealthDataPermissionRequestResultDto in
                let objectTypes = try permissionDto.toHealthKitObjectTypes()
                let status: PermissionStatusDto

                switch permissionDto.accessType {
                case .read:
                    // HealthKit never reveals read permission status for privacy reasons
                    status = .unknown

                case .write:
                    // Check authorization status for all object types
                    let sampleTypes = objectTypes.compactMap {
                        $0 as? HKSampleType
                    }

                    if sampleTypes.isEmpty {
                        status = .unknown
                    } else {
                        let authStatuses = sampleTypes.map {
                            store.authorizationStatus(for: $0)
                        }

                        let allAuthorized = authStatuses.allSatisfy {
                            $0 == .sharingAuthorized
                        }
                        let allDenied = authStatuses.allSatisfy {
                            $0 == .sharingDenied
                        }

                        if allAuthorized {
                            status = .granted
                        } else if allDenied {
                            status = .denied
                        } else {
                            status = .unknown
                        }
                    }
                }

                return HealthDataPermissionRequestResultDto(permission: permissionDto, status: status)
            }

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: "requestPermissions",
                message: "Health Connect permissions requested successfully",
                context: [
                    "granted_health_data_permissions": results,
                ]
            )

            return results

        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "requestPermissions",
                message: "Failed to request Health Connect permissions",
                context: [
                    "requested_permissions": healthDataPermissions,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(healthDataPermissions): \(baseError.message ?? "Unknown error")",
                details: baseError.details
            )
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "requestPermissions",
                message: "Failed to request Health Connect permissions",
                context: [
                    "requested_permissions": healthDataPermissions,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(healthDataPermissions): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }

    /**
     * Reads a single health record by ID.
     *
     * - Parameter request: Contains the data type and record ID to read
     * - Returns: ReadRecordResponseDto with the record populated, or nil if not found
     *
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if the record ID format is invalid
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
     */
    func readRecord(request: ReadRecordRequestDto) async throws -> ReadRecordResponseDto? {
        do {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "readRecord",
                message: "Reading Health Connect record",
                context: [
                    "request": request,
                ]
            )

            guard let handler = HealthKitTypeRegistry.getSampleHandler(for: request.dataType) else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            guard let recordUUID = UUID(uuidString: request.recordId) else {
                HealthConnectorLogger.error(
                    tag: HealthConnectorClient.tag,
                    operation: "readRecord",
                    message: "Invalid record ID format",
                    context: [
                        "dataType": String(describing: request.dataType),
                        "recordId": request.recordId,
                    ]
                )
                throw HealthConnectorErrors.invalidArgument(
                    message: "Invalid record ID format: \(request.recordId)",
                    details: "Record ID must be a valid UUID string"
                )
            }

            let predicate = HKQuery.predicateForObject(with: recordUUID)
            let sampleType = try handler.getSampleType()

            let responseDto = try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<ReadRecordResponseDto?, Error>) in
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: predicate,
                    limit: 1,
                    sortDescriptors: nil
                ) {
                    _, samples, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let sample = samples?.first else {
                        continuation.resume(returning: nil)
                        return
                    }

                    do {
                        let recordDto = try handler.toDTO(sample)
                        let responseDto = ReadRecordResponseDto(record: recordDto)
                        continuation.resume(returning: responseDto)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }

                self.store.execute(query)
            }

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: "readRecord",

                message: "Health Connect record read successfully",
                context: [
                    "request": request,
                    "response": responseDto,
                ]
            )

            return responseDto
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "readRecord",

                message: "Failed to read Health Connect record",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorError(
                code: baseError.code,
                message: "Failed to process \(request): \(baseError.message ?? "Unknown error")",
                details: baseError.details
            )
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "readRecord",

                message: "Failed to read Health Connect record",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(request): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }

    /**
     * Reads multiple health records within a time range.
     *
     * ## Pagination Strategy
     *
     * HealthKit doesn't provide native pagination tokens, so this method implements
     * cursor-based pagination using timestamps. To correctly determine if more pages exist,
     * this method uses an "over-fetch" strategy:
     *
     * 1. **Query pageSize + 1 records**: The method queries `pageSize + 1` records from HealthKit
     *    instead of exactly `pageSize`. This extra record acts as a "lookahead" to determine
     *    if more data exists beyond the current page.
     *
     * 2. **Detect last page**: After receiving results:
     *    - If `pageSize + 1` records are returned → more pages exist
     *    - If fewer than `pageSize + 1` records are returned → this is the last page
     *
     * 3. **Remove extra record**: If more pages exist, the last record is removed from the
     *    response before returning to the caller. The caller always receives exactly `pageSize`
     *    records (or fewer on the last page).
     *
     * 4. **Generate nextPageToken**: When more pages exist, `nextPageToken` is generated from
     *    the timestamp of the last record being returned (not the removed record). Subsequent
     *    requests use this token to resume pagination from the correct position.
     *
     * **Why this approach?**
     *
     * Without querying `pageSize + 1`, when HealthKit returns exactly `pageSize` records,
     * the method cannot distinguish between:
     * - "This is exactly the last page" (no more records exist)
     * - "More records exist but weren't returned yet" (another page is needed)
     *
     * The extra record eliminates this ambiguity and ensures the last page never incorrectly
     * includes a `nextPageToken` that leads to empty results.
     *
     * - Parameter request: Contains data type, time range, page size, optional page token,
     *                     and optional data origin package names for filtering
     * - Returns: ReadRecordsResponseDto with the records list populated and optional next page token.
     *            The list will contain at most `pageSize` records. `nextPageToken` is nil when no more pages exist.
     *
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if time range or page size is invalid
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
     */
    func readRecords(request: ReadRecordsRequestDto) async throws -> ReadRecordsResponseDto {
        do {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "readRecords",

                message: "Reading Health Connect records",
                context: [
                    "request": request,
                ]
            )

            // Validate time range
            if request.startTime >= request.endTime {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Invalid time range: startTime must be before endTime",
                    details: "startTime=\(request.startTime), endTime=\(request.endTime)"
                )
            }

            // Parse pageToken if present and adjust startTime for pagination
            var effectiveStartTime = request.startTime
            if let pageToken = request.pageToken, !pageToken.isEmpty {
                // Parse pageToken as timestamp (milliseconds since epoch)
                if let tokenTimestamp = Int64(pageToken) {
                    // Use tokenTimestamp + 1ms as new startTime (exclusive to avoid duplicates)
                    effectiveStartTime = tokenTimestamp + 1

                    // Validate that adjusted startTime is still before endTime
                    if effectiveStartTime >= request.endTime {
                        // Invalid pagination token, return empty result
                        HealthConnectorLogger.warning(
                            tag: HealthConnectorClient.tag,
                            operation: "readRecords",

                            message: "Invalid pageToken: adjusted startTime >= endTime",
                            context: [
                                "adjustedStartTime": effectiveStartTime,
                                "endTime": request.endTime,
                            ]
                        )
                        return createEmptyResponse()
                    }

                    HealthConnectorLogger.debug(
                        tag: HealthConnectorClient.tag,
                        operation: "readRecords",

                        message: "Using pageToken for pagination",
                        context: [
                            "originalStartTime": request.startTime,
                            "adjustedStartTime": effectiveStartTime,
                        ]
                    )
                } else {
                    // Invalid pageToken format, log warning but continue with original startTime
                    HealthConnectorLogger.warning(
                        tag: HealthConnectorClient.tag,
                        operation: "readRecords",

                        message: "Invalid pageToken format, using original startTime",
                        context: [
                            "pageToken": pageToken,
                        ]
                    )
                }
            }

            // Get handler for this data type
            guard let handler = HealthKitTypeRegistry.getSampleHandler(for: request.dataType) else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            // Create time range predicate using effective startTime
            let startDate = Date(timeIntervalSince1970: TimeInterval(effectiveStartTime) / 1000.0)
            let endDate = Date(timeIntervalSince1970: TimeInterval(request.endTime) / 1000.0)
            let timePredicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: .strictStartDate
            )

            // Get sample type before creating closure
            let sampleType = try handler.getSampleType()

            // Create compound predicate for data origin filtering if needed
            let predicate: NSPredicate
            if !request.dataOriginPackageNames.isEmpty {
                // Query for sources to get HKSource objects from bundle identifiers
                let sources = try await querySources(
                    forSampleType: sampleType,
                    bundleIdentifiers: request.dataOriginPackageNames
                )

                if sources.isEmpty {
                    HealthConnectorLogger.warning(
                        tag: HealthConnectorClient.tag,
                        operation: "readRecords",

                        message: "No sources found for bundle identifiers",
                        context: [
                            "bundleIdentifiers": request.dataOriginPackageNames,
                        ]
                    )
                    return createEmptyResponse()
                }

                // Create individual predicates for each source
                let sourcePredicates = sources.map {
                    source in
                    HKQuery.predicateForObjects(from: source)
                }

                // Combine source predicates with OR logic
                let sourcePredicate = NSCompoundPredicate(orPredicateWithSubpredicates: sourcePredicates)

                // Combine source and time predicates with AND logic
                predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [sourcePredicate, timePredicate])
            } else {
                // No source filtering, use only time predicate
                predicate = timePredicate
            }

            // Use async continuation to bridge the callback-based API
            let responseDto = try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<ReadRecordsResponseDto, Error>) in
                // Query pageSize + 1 records to determine if more pages exist.
                //
                // Rationale: HealthKit doesn't provide a way to check if more records exist beyond
                // the current page. By querying one extra record, we can distinguish between:
                // - Exactly pageSize records returned → last page (no more data)
                // - pageSize + 1 records returned → more pages exist
                //
                // The extra record will be removed before returning results to the caller,
                // ensuring they always receive at most pageSize records.
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: predicate,
                    limit: Int(request.pageSize) + 1,
                    sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]
                ) {
                    _, samples, error in
                    if let error {
                        if let nsError = error as NSError? {
                            continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to read records: \(error.localizedDescription)",
                                    details: error.localizedDescription
                                )
                            )
                        }
                        return
                    }

                    let samples = samples ?? []

                    // Convert all samples using handler - single dispatch point!
                    do {
                        let recordDtos = try samples.map {
                            try handler.toDTO($0)
                        }

                        // Apply pagination using handler's timestamp extractor
                        let (trimmedRecords, nextPageToken) = try self.applyPagination(
                            records: recordDtos,
                            pageSize: request.pageSize,
                            timestampExtractor: {
                                try handler.extractTimestamp($0)
                            } // Type-aware!
                        )

                        let responseDto = ReadRecordsResponseDto(
                            nextPageToken: nextPageToken,
                            records: trimmedRecords
                        )
                        continuation.resume(returning: responseDto)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }

                self.store.execute(query)
            }

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: "readRecords",

                message: "Health Connect records read successfully",
                context: [
                    "request": request,
                    "response": responseDto,
                ]
            )

            return responseDto
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "readRecords",

                message: "Failed to read Health Connect records",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw baseError
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "readRecords",

                message: "Failed to read Health Connect records",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(request): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }

    /**
     * Applies pagination logic to records array.
     *
     * This helper implements the "over-fetch" pagination strategy:
     *
     * - **Input**: Records array that may contain `pageSize + 1` items (due to querying one extra)
     * - **Output**: Exactly `pageSize` records (or fewer if last page) with optional `nextPageToken`
     *
     * **Why remove the last record?**
     *
     * When we query `pageSize + 1` records and receive that many, it means more data exists.
     * However, we must return exactly `pageSize` records to the caller. The extra (last) record
     * was only used as a "lookahead" indicator. We remove it and generate `nextPageToken` from
     * the actual last record being returned, so the next page starts from the correct position.
     *
     * If we receive `pageSize` or fewer records, all records are returned and no `nextPageToken`
     * is generated, indicating this is the last page.
     *
     * - Parameters:
     *   - records: Array of records (may contain pageSize + 1 items as a result of over-fetching)
     *   - pageSize: Requested page size (the maximum number of records to return)
     *   - timestampExtractor: Closure to extract timestamp from record for pagination token
     * - Returns: Tuple of (trimmed records array with at most pageSize items, optional nextPageToken)
     */
    private func applyPagination<T>(
        records: [T],
        pageSize: Int64,
        timestampExtractor: (T) throws -> Int64
    ) throws
        -> (records: [T], nextPageToken: String?)
    {
        var mutableRecords = records
        let nextPageToken: String?

        if mutableRecords.count > pageSize {
            // Remove the extra record that was only used to detect if more pages exist.
            // This ensures we return exactly pageSize records to the caller.
            mutableRecords.removeLast()

            // Generate nextPageToken from the last record we're actually returning (not the removed one).
            // We know mutableRecords is not empty because we just removed one element and count > pageSize (> 0)
            guard let lastRecord = mutableRecords.last else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Unexpected empty records array after pagination removal"
                )
            }
            nextPageToken = try String(timestampExtractor(lastRecord))
        } else {
            // This is the last page: we received pageSize or fewer records, meaning no more data exists.
            // Return all records as-is and indicate no more pages with nil nextPageToken.
            nextPageToken = nil
        }

        return (mutableRecords, nextPageToken)
    }

    /**
     * Queries HealthKit for sources matching the given bundle identifiers.
     *
     * This helper method queries a sample of records for a given sample type to
     * collect HKSource objects, then filters them by bundle identifier. This is
     * necessary because HealthKit doesn't provide a direct API to get sources by
     * bundle identifier - sources must be obtained from existing samples.
     *
     * To improve efficiency, we query a reasonable number of samples (up to 1000)
     * to collect unique sources. If all requested bundle identifiers are found
     * before reaching the limit, we can return early.
     *
     * - Parameters:
     *   - sampleType: The HealthKit sample type to query sources for
     *   - bundleIdentifiers: List of bundle identifiers to filter sources by
     * - Returns: Set of HKSource objects matching the bundle identifiers
     * - Throws: Errors from HealthKit queries
     */
    private func querySources(forSampleType: HKSampleType, bundleIdentifiers: [String]) async throws -> Set<HKSource> {
        try await withCheckedThrowingContinuation {
            continuation in
            // Query a sample of records to collect sources
            // Use a reasonable limit to balance between completeness and performance
            let query = HKSampleQuery(
                sampleType: forSampleType,
                predicate: nil,
                limit: 1000,
                sortDescriptors: nil
            ) {
                _, samples, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                // Extract unique sources that match the bundle identifiers
                let matchingSources = Set((samples ?? []).compactMap(\.sourceRevision.source).filter {
                    bundleIdentifiers.contains($0.bundleIdentifier)
                })

                continuation.resume(returning: matchingSources)
            }

            self.store.execute(query)
        }
    }

    /**
     * Creates an empty response DTO for the given data type.
     *
     * - Parameter dataType: The data type for the empty response
     * - Returns: ReadRecordsResponseDto with empty records list
     */
    private func createEmptyResponse() -> ReadRecordsResponseDto {
        ReadRecordsResponseDto(nextPageToken: nil, records: [])
    }

    /**
     * Writes a single health record.
     *
     * - Parameter request: Contains the health record to write
     * - Returns: WriteRecordResponseDto containing the platform-assigned record ID
     *
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if record data is invalid
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
     */
    func writeRecord(request: WriteRecordRequestDto) async throws -> WriteRecordResponseDto {
        do {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "writeRecord",

                message: "Writing Health Connect record",
                context: [
                    "request": request,
                ]
            )

            // Infer data type from DTO runtime type
            let dataType = try request.record.dataType

            // Get handler for this data type
            guard let handler = HealthKitTypeRegistry.getSampleHandler(for: dataType) else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Unsupported data type: \(dataType)"
                )
            }

            // Convert DTO to HealthKit sample using handler
            let sample = try handler.toHealthKit(request.record)

            // Write to HealthKit using pseudo-atomic transaction
            return try await withCheckedThrowingContinuation {
                continuation in
                store.save(sample) {
                    success, error in
                    if let error {
                        if let nsError = error as NSError? {
                            continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to write record: \(error.localizedDescription)",
                                    details: error.localizedDescription
                                )
                            )
                        }
                        return
                    }

                    if success {
                        let recordId = sample.uuid.uuidString
                        let responseDto = WriteRecordResponseDto(recordId: recordId)
                        HealthConnectorLogger.info(
                            tag: HealthConnectorClient.tag,
                            operation: "writeRecord",

                            message: "Health Connect record written successfully",
                            context: [
                                "request": request,
                                "assignedRecordId": recordId,
                            ]
                        )
                        continuation.resume(returning: responseDto)
                    } else {
                        continuation.resume(
                            throwing: HealthConnectorErrors.unknown(
                                message: "Failed to write record",
                                details: "HealthKit save returned false"
                            )
                        )
                    }
                }
            }
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "writeRecord",

                message: "Failed to write Health Connect record",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw baseError
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "writeRecord",

                message: "Failed to write Health Connect record",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(request): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }

    /**
     * Updates a single health record using delete-then-insert pattern.
     *
     * HealthKit uses an immutable data model where samples cannot be updated once saved.
     * This method implements update-like behavior by:
     * 1. Deleting the old sample using delete(_:withCompletion:)
     * 2. Inserting a new sample with corrected values using save(_:withCompletion:)
     *
     * Since HealthKit assigns a new UUID to each sample, the returned record ID will
     * be different from the input ID. This is expected HealthKit behavior.
     *
     * - Parameter request: Contains the health record to update
     * - Returns: UpdateRecordResponseDto containing the new record ID (different from input)
     *
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if record ID is invalid or record data is invalid
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
     */
    func updateRecord(request: UpdateRecordRequestDto) async throws -> UpdateRecordResponseDto {
        do {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "updateRecord",

                message: "Updating Health Connect record",
                context: [
                    "request": request,
                ]
            )

            // Extract record ID and infer data type using registry pattern
            let recordId = request.record.id
            let dataType = try request.record.dataType

            // Validate record ID is not empty
            if recordId?.isEmpty ?? true {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records.",
                    details: "Record ID: \(recordId ?? "nil")"
                )
            }

            // Convert record ID to UUID
            guard let recordIdString = recordId,
                  let recordUUID = UUID(uuidString: recordIdString)
            else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Invalid record ID format: \(recordId ?? "nil")",
                    details: "Record ID must be a valid UUID string"
                )
            }

            // Get handler for this data type (used for querying)
            guard let handler = HealthKitTypeRegistry.getSampleHandler(for: dataType) else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Unsupported data type: \(dataType)"
                )
            }

            // Step 1: Read existing record to verify it exists and get the sample object
            let sampleType = try handler.getSampleType()
            let existingSample: HKSample = try await withCheckedThrowingContinuation {
                continuation in
                let predicate = HKQuery.predicateForObject(with: recordUUID)
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: predicate,
                    limit: 1,
                    sortDescriptors: nil
                ) {
                    _, samples, error in
                    if let error {
                        if let nsError = error as NSError? {
                            continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to read existing record: \(error.localizedDescription)",
                                    details: error.localizedDescription
                                )
                            )
                        }
                        return
                    }

                    guard let sample = samples?.first else {
                        continuation.resume(
                            throwing: HealthConnectorErrors.invalidArgument(
                                message: "Record not found: \(recordIdString)",
                                details: "No record found with ID \(recordIdString) for dataType \(dataType)"
                            )
                        )
                        return
                    }

                    continuation.resume(returning: sample)
                }

                self.store.execute(query)
            }

            // Step 2: Convert record to HealthKit sample using handler dispatch
            // (handler already retrieved above for querying)
            let newSample = try handler.toHealthKit(request.record)

            // Step 3: Delete the old sample
            try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<Void, Error>) in
                store.delete(existingSample) {
                    success, error in
                    if let error {
                        if let nsError = error as NSError? {
                            continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to delete existing record: \(error.localizedDescription)",
                                    details: error.localizedDescription
                                )
                            )
                        }
                        return
                    }

                    if !success {
                        continuation.resume(
                            throwing: HealthConnectorErrors.unknown(
                                message: "Failed to delete existing record",
                                details: "HealthKit delete returned false"
                            )
                        )
                        return
                    }

                    continuation.resume(returning: ())
                }
            }

            // Step 4: Write the new sample
            let newRecordId = try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<String, Error>) in
                store.save(newSample) {
                    success, error in
                    if let error {
                        if let nsError = error as NSError? {
                            continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to write new record after delete: \(error.localizedDescription)",
                                    details: error.localizedDescription
                                )
                            )
                        }
                        return
                    }

                    if success {
                        let newRecordId = newSample.uuid.uuidString
                        HealthConnectorLogger.info(
                            tag: HealthConnectorClient.tag,
                            operation: "updateRecord",

                            message: "Health Connect record updated successfully",
                            context: [
                                "request": request,
                            ]
                        )
                        continuation.resume(returning: newRecordId)
                    } else {
                        continuation.resume(
                            throwing: HealthConnectorErrors.unknown(
                                message: "Failed to write new record after delete",
                                details: "HealthKit save returned false. Old record was already deleted."
                            )
                        )
                    }
                }
            }

            return UpdateRecordResponseDto(recordId: newRecordId)
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "updateRecord",

                message: "Failed to update Health Connect record",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw baseError
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "updateRecord",

                message: "Failed to update Health Connect record",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(request): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }

    /**
     * Writes multiple health records atomically.
     *
     * - Parameter request: Contains the list of health records to write
     * - Returns: WriteRecordsResponseDto containing the platform-assigned record IDs
     *
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if any record data is invalid
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
     */
    func writeRecords(request: WriteRecordsRequestDto) async throws -> WriteRecordsResponseDto {
        do {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "writeRecords",

                message: "Writing Health Connect records",
                context: [
                    "request": request,
                ]
            )

            // Convert all records to HealthKit samples using handlers
            var samples: [HKSample] = []

            for recordDto in request.records {
                // Infer data type from DTO
                let dataType = try recordDto.dataType

                // Get handler for this data type
                guard let handler = HealthKitTypeRegistry.getSampleHandler(for: dataType) else {
                    throw HealthConnectorErrors.invalidArgument(
                        message: "Unsupported data type: \(dataType)"
                    )
                }

                // Convert using handler
                let sample = try handler.toHealthKit(recordDto)
                samples.append(sample)
            }

            // Atomic batch write using HealthKit's pseudo-atomic transaction
            return try await withCheckedThrowingContinuation {
                continuation in
                store.save(samples) {
                    success, error in
                    if let error {
                        if let nsError = error as NSError? {
                            continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to write records: \(error.localizedDescription)",
                                    details: error.localizedDescription
                                )
                            )
                        }
                        return
                    }

                    if success {
                        let recordIds = samples.map(\.uuid.uuidString)
                        let responseDto = WriteRecordsResponseDto(recordIds: recordIds)
                        HealthConnectorLogger.info(
                            tag: HealthConnectorClient.tag,
                            operation: "writeRecords",

                            message: "Health Connect records written successfully",
                            context: [
                                "request": request,
                                "assignedRecordIds": recordIds,
                            ]
                        )
                        continuation.resume(returning: responseDto)
                    } else {
                        continuation.resume(
                            throwing: HealthConnectorErrors.unknown(
                                message: "Failed to write records",
                                details: "HealthKit save returned false"
                            )
                        )
                    }
                }
            }
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "writeRecords",

                message: "Failed to write Health Connect records",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw baseError
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "writeRecords",

                message: "Failed to write Health Connect records",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(request): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }

    /**
     * Performs an aggregation query on health records.
     *
     * - Parameter request: Contains data type, aggregation metric, and time range
     * - Returns: AggregateResponseDto with aggregated value and data point count
     *
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if time range or metric is invalid
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if an unexpected error occurs
     */
    func aggregate(request: AggregateRequestDto) async throws -> AggregateResponseDto {
        do {
            HealthConnectorLogger.debug(
                tag: HealthConnectorClient.tag,
                operation: "aggregate",

                message: "Aggregating Health Connect data",
                context: [
                    "request": request,
                ]
            )

            // Validate time range
            if request.startTime >= request.endTime {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Invalid time range: startTime must be before endTime",
                    details: "startTime=\(request.startTime), endTime=\(request.endTime)"
                )
            }

            // Special handling for sleep stage aggregation (category sample)
            if request.dataType == .sleepStageRecord {
                return try await aggregateSleepStages(request: request)
            }

            // Get handler for this data type (quantity types only beyond this point)
            guard let handler = HealthKitTypeRegistry.getQuantityHandler(for: request.dataType) else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Aggregation not supported for data type: \(request.dataType)"
                )
            }

            // Get HealthKit quantity type from handler
            guard let quantityType = try handler.getSampleType() as? HKQuantityType else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Data type \(request.dataType) is not a quantity type"
                )
            }

            // Create time range predicate
            let startDate = Date(timeIntervalSince1970: TimeInterval(request.startTime) / 1000.0)
            let endDate = Date(timeIntervalSince1970: TimeInterval(request.endTime) / 1000.0)
            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: .strictStartDate
            )

            // Use HKStatisticsQuery with handler's statistics options
            let responseDto = try await aggregateWithStatisticsQuery(
                quantityType: quantityType,
                predicate: predicate,
                metric: request.aggregationMetric,
                dataType: request.dataType,
                handler: handler
            )

            HealthConnectorLogger.info(
                tag: HealthConnectorClient.tag,
                operation: "aggregate",

                message: "Health Connect data aggregated successfully",
                context: [
                    "request": request,
                    "response": responseDto,
                ]
            )

            return responseDto
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "aggregate",

                message: "Failed to aggregate Health Connect data",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw baseError
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "aggregate",

                message: "Failed to aggregate Health Connect data",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(request): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }

    /**
     * Performs aggregation using HKStatisticsQuery for metrics supported by HealthKit statistics.
     *
     * - Parameters:
     *   - quantityType: The HealthKit quantity type to aggregate
     *   - predicate: The time range predicate
     *   - metric: The aggregation metric
     *   - dataType: The health data type
     *   - handler: The quantity handler for this data type
     * - Returns: AggregateResponseDto with aggregated result
     */
    private func extractAggregateResponse(
        from statistics: HKStatistics,
        dataType: HealthDataTypeDto,
        metric: AggregationMetricDto
    ) -> AggregateResponseDto {
        switch dataType {
        case .activeCaloriesBurned:
            guard let sumQuantity = statistics.sumQuantity() else {
                return AggregateResponseDto(value: EnergyDto(unit: .kilocalories, value: 0.0))
            }
            return AggregateResponseDto(value: sumQuantity.toEnergyDto())

        case .steps:
            guard let sumQuantity = statistics.sumQuantity() else {
                return AggregateResponseDto(value: NumericDto(unit: .numeric, value: 0.0))
            }
            let stepCount = Int64(sumQuantity.doubleValue(for: .count()))
            return AggregateResponseDto(value: stepCount.toNumericDto())

        case .weight:
            let weightQuantity: HKQuantity? = switch metric {
            case .avg: statistics.averageQuantity()
            case .min: statistics.minimumQuantity()
            case .max: statistics.maximumQuantity()
            default: nil
            }
            guard let quantity = weightQuantity else {
                return AggregateResponseDto(value: MassDto(unit: .kilograms, value: 0.0))
            }
            return AggregateResponseDto(value: quantity.toMassDto())

        case .height:
            let heightQuantity: HKQuantity? = switch metric {
            case .avg: statistics.averageQuantity()
            case .min: statistics.minimumQuantity()
            case .max: statistics.maximumQuantity()
            default: nil
            }
            guard let quantity = heightQuantity else {
                return AggregateResponseDto(value: LengthDto(unit: .meters, value: 0.0))
            }
            return AggregateResponseDto(value: quantity.toLengthDto())

        case .hydration:
            guard let quantity = statistics.sumQuantity() else {
                return AggregateResponseDto(value: VolumeDto(unit: .liters, value: 0.0))
            }
            return AggregateResponseDto(value: quantity.toVolumeDto())

        case .leanBodyMass:
            let leanBodyMassQuantity: HKQuantity? = switch metric {
            case .avg: statistics.averageQuantity()
            case .min: statistics.minimumQuantity()
            case .max: statistics.maximumQuantity()
            default: nil
            }
            guard let quantity = leanBodyMassQuantity else {
                return AggregateResponseDto(value: MassDto(unit: .kilograms, value: 0.0))
            }
            return AggregateResponseDto(value: quantity.toMassDto())

        case .distance:
            guard let sumQuantity = statistics.sumQuantity() else {
                return AggregateResponseDto(value: LengthDto(unit: .meters, value: 0.0))
            }
            return AggregateResponseDto(value: sumQuantity.toLengthDto())

        case .floorsClimbed:
            guard let sumQuantity = statistics.sumQuantity() else {
                return AggregateResponseDto(value: NumericDto(unit: .numeric, value: 0.0))
            }
            let floorsCount = sumQuantity.doubleValue(for: .count())
            return AggregateResponseDto(value: NumericDto(unit: .numeric, value: floorsCount))

        case .wheelchairPushes:
            guard let sumQuantity = statistics.sumQuantity() else {
                return AggregateResponseDto(value: NumericDto(unit: .numeric, value: 0.0))
            }
            let pushesCount = Int64(sumQuantity.doubleValue(for: .count()))
            return AggregateResponseDto(value: pushesCount.toNumericDto())

        case .heartRateMeasurementRecord:
            let heartRateQuantity: HKQuantity? = switch metric {
            case .avg: statistics.averageQuantity()
            case .min: statistics.minimumQuantity()
            case .max: statistics.maximumQuantity()
            default: nil
            }
            guard let quantity = heartRateQuantity else {
                return AggregateResponseDto(value: NumericDto(unit: .numeric, value: 0.0))
            }
            let unit = HKUnit.count().unitDivided(by: .minute())
            let bpmValue = quantity.doubleValue(for: unit)
            return AggregateResponseDto(value: NumericDto(unit: .numeric, value: bpmValue))

        case .bodyTemperature:
            let temperatureQuantity: HKQuantity? = switch metric {
            case .avg: statistics.averageQuantity()
            case .min: statistics.minimumQuantity()
            case .max: statistics.maximumQuantity()
            default: nil
            }
            guard let quantity = temperatureQuantity else {
                return AggregateResponseDto(value: TemperatureDto(unit: .celsius, value: 0.0))
            }
            return AggregateResponseDto(value: quantity.toTemperatureDto())

        case .bodyFatPercentage:
            return AggregateResponseDto(value: PercentageDto(unit: .decimal, value: 0.0))

        case .energyNutrient:
            guard let sumQuantity = statistics.sumQuantity() else {
                return AggregateResponseDto(value: EnergyDto(unit: .kilocalories, value: 0.0))
            }
            return AggregateResponseDto(value: sumQuantity.toEnergyDto())

        case .caffeine, .protein, .totalCarbohydrate, .totalFat, .saturatedFat,
             .monounsaturatedFat, .polyunsaturatedFat, .cholesterol, .dietaryFiber, .sugar,
             .vitaminA, .vitaminB6, .vitaminB12, .vitaminC, .vitaminD, .vitaminE, .vitaminK,
             .thiamin, .riboflavin, .niacin, .folate, .biotin, .pantothenicAcid,
             .calcium, .iron, .magnesium, .manganese, .phosphorus, .potassium, .selenium, .sodium, .zinc:
            guard let sumQuantity = statistics.sumQuantity() else {
                return AggregateResponseDto(value: MassDto(unit: .grams, value: 0.0))
            }
            return AggregateResponseDto(value: sumQuantity.toMassDto())

        case .sleepStageRecord:
            fatalError(
                "`HealthDataTypeDto.sleepStageRecord` aggregation must be handled by the `aggregateSleepStages()`."
            )

        case .nutrition:
            fatalError("`HealthDataTypeDto.nutrition` records do not support aggregation.")

        case .bloodPressure:
            fatalError("`HealthDataTypeDto.bloodPressure` records do not support aggregation.")

        case .systolicBloodPressure:
            let systolicQuantity: HKQuantity? = switch metric {
            case .avg: statistics.averageQuantity()
            case .min: statistics.minimumQuantity()
            case .max: statistics.maximumQuantity()
            default: nil
            }
            guard let quantity = systolicQuantity else {
                return AggregateResponseDto(value: PressureDto(unit: .millimetersOfMercury, value: 0.0))
            }
            return AggregateResponseDto(value: quantity.toPressureDto())

        case .diastolicBloodPressure:
            let diastolicQuantity: HKQuantity? = switch metric {
            case .avg: statistics.averageQuantity()
            case .min: statistics.minimumQuantity()
            case .max: statistics.maximumQuantity()
            default: nil
            }
            guard let quantity = diastolicQuantity else {
                return AggregateResponseDto(value: PressureDto(unit: .millimetersOfMercury, value: 0.0))
            }
            return AggregateResponseDto(value: quantity.toPressureDto())

        default:
            return AggregateResponseDto(value: NumericDto(unit: .numeric, value: 0.0))
        }
    }

    private func aggregateWithStatisticsQuery(
        quantityType: HKQuantityType,
        predicate: NSPredicate,
        metric: AggregationMetricDto,
        dataType: HealthDataTypeDto,
        handler: HealthKitQuantityHandler
            .Type
    ) async throws -> AggregateResponseDto {
        let options = try handler.toStatisticsOptions(metric)

        return try await withCheckedThrowingContinuation {
            continuation in
            let query = HKStatisticsQuery(
                quantityType: quantityType,
                quantitySamplePredicate: predicate,
                options: options
            ) {
                _, statistics, error in
                if let error {
                    if let nsError = error as NSError? {
                        continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                    } else {
                        continuation.resume(
                            throwing: HealthConnectorErrors.unknown(
                                message: "Failed to aggregate records: \(error.localizedDescription)",
                                details: error.localizedDescription
                            )
                        )
                    }
                    return
                }

                guard let statistics else {
                    // No data available - create empty numeric value
                    let emptyNumericDto = NumericDto(unit: .numeric, value: 0.0)
                    let response = AggregateResponseDto(value: emptyNumericDto)
                    continuation.resume(returning: response)
                    return
                }

                // Extract aggregated value based on data type and metric
                let response = self.extractAggregateResponse(
                    from: statistics,
                    dataType: dataType,
                    metric: metric
                )

                continuation.resume(returning: response)
            }

            self.store.execute(query)
        }
    }

    /**
     * Performs aggregation for sleep stage records.
     *
     * Since category samples don't support HKStatisticsQuery, we query all sleep
     * stage records in the time range and calculate the sum of sleep durations manually.
     *
     * **Supported Metrics:**
     * - `.sum` - Total sleep time in seconds across all sleep stages
     *
     * **Sleep Stage Filtering:**
     * Only counts actual sleep stages (excludes awake, inBed, outOfBed states).
     * Includes: sleeping, light, deep, rem
     *
     * - Parameter request: The aggregation request
     * - Returns: AggregateResponseDto with total sleep duration in seconds
     * - Throws: HealthConnectorError if query fails or metric is unsupported
     */
    private func aggregateSleepStages(request: AggregateRequestDto) async throws -> AggregateResponseDto {
        // Validate metric - only sum is supported for sleep stages
        guard request.aggregationMetric == .sum else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Only sum aggregation is supported for sleep stage records",
                details: "Supported metrics: [sum]. Requested: \(request.aggregationMetric)"
            )
        }

        // Get the sleep analysis category type
        guard let categoryType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else {
            throw HealthConnectorErrors.unknown(
                message: "Failed to create sleep analysis category type"
            )
        }

        // Create time range predicate
        let startDate = Date(timeIntervalSince1970: TimeInterval(request.startTime) / 1000.0)
        let endDate = Date(timeIntervalSince1970: TimeInterval(request.endTime) / 1000.0)
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: .strictStartDate
        )

        // Query all sleep stage samples in the time range
        let samples = try await withCheckedThrowingContinuation {
            (continuation: CheckedContinuation<[HKCategorySample], Error>) in
            let query = HKSampleQuery(
                sampleType: categoryType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil
            ) {
                _, samples, error in
                if let error {
                    if let nsError = error as NSError? {
                        continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                    } else {
                        continuation.resume(
                            throwing: HealthConnectorErrors.unknown(
                                message: "Failed to query sleep stages: \(error.localizedDescription)",
                                details: error.localizedDescription
                            )
                        )
                    }
                    return
                }

                guard let samples else {
                    continuation.resume(returning: [])
                    return
                }

                // Filter to only category samples
                let categorySamples = samples.compactMap {
                    $0 as? HKCategorySample
                }
                continuation.resume(returning: categorySamples)
            }

            self.store.execute(query)
        }

        // Calculate total sleep duration
        var totalSleepSeconds: TimeInterval = 0.0

        for sample in samples {
            // Only count actual sleep stages (exclude awake, inBed, outOfBed)
            let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value)

            // Define which stages count as "actual sleep"
            let isActualSleep = switch sleepValue {
            case .asleep:
                // Generic sleep (iOS 15 and earlier)
                true
            case .awake, .inBed:
                // Not sleeping
                false
            default:
                // For iOS 16+ detailed stages (core/light, deep, REM)
                // Check raw values: .core=5, .deep=3, .REM=4
                if #available(iOS 16.0, *) {
                    switch sample.value {
                    case 3, 4, 5: // deep, REM, core
                        true
                    default:
                        false
                    }
                } else {
                    false
                }
            }

            if isActualSleep {
                // Calculate duration for this sleep stage
                let duration = sample.endDate.timeIntervalSince(sample.startDate)
                totalSleepSeconds += duration
            }
        }

        // Return total sleep time as NumericDto (value in seconds)
        let numericDto = NumericDto(unit: .numeric, value: totalSleepSeconds)
        return AggregateResponseDto(value: numericDto)
    }

    /**
     * Deletes all records of a data type within a time range.
     *
     * Uses HealthKit's `deleteObjects(of:predicate:withCompletion:)` API.
     *
     * - Parameter request: Contains data type and time range for deletion
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if time range is invalid
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if deletion fails
     */
    func deleteRecordsByTimeRange(request: DeleteRecordsByTimeRangeRequestDto) async throws {
        HealthConnectorLogger.debug(
            tag: HealthConnectorClient.tag,
            operation: "deleteRecordsByTimeRange",

            message: "Deleting Health Connect records by time range",
            context: [
                "request": request,
            ]
        )

        do {
            // Validate time range
            if request.startTime >= request.endTime {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Invalid time range: startTime must be before endTime",
                    details: "startTime=\(request.startTime), endTime=\(request.endTime)"
                )
            }

            // Get handler for this data type
            guard let handler = HealthKitTypeRegistry.getSampleHandler(for: request.dataType) else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            let sampleType = try handler.getSampleType()
            let startDate = Date(timeIntervalSince1970: TimeInterval(request.startTime) / 1000.0)
            let endDate = Date(timeIntervalSince1970: TimeInterval(request.endTime) / 1000.0)

            // Create time range predicate
            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: [.strictStartDate, .strictEndDate]
            )

            // Delete objects matching the predicate
            try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<Void, Error>) in
                store.deleteObjects(of: sampleType, predicate: predicate) {
                    success, _, error in
                    if let error {
                        if let nsError = error as NSError? {
                            continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to delete records: \(error.localizedDescription)",
                                    details: error.localizedDescription
                                )
                            )
                        }
                        return
                    }

                    if success {
                        HealthConnectorLogger.info(
                            tag: HealthConnectorClient.tag,
                            operation: "deleteRecordsByTimeRange",

                            message: "Health Connect records deleted successfully",
                            context: [
                                "request": request,
                            ]
                        )
                        continuation.resume(returning: ())
                    } else {
                        continuation.resume(
                            throwing: HealthConnectorErrors.unknown(
                                message: "Failed to delete records",
                                details: "HealthKit delete returned false"
                            )
                        )
                    }
                }
            }
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "deleteRecordsByTimeRange",

                message: "Failed to delete Health Connect records by time range",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw baseError
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "deleteRecordsByTimeRange",

                message: "Failed to delete Health Connect records by time range",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(request): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }

    /**
     * Deletes specific records by their IDs.
     *
     * Uses query-then-delete pattern since HealthKit doesn't support direct UUID deletion.
     *
     * - Parameter request: Contains data type and list of record IDs to delete
     * - Throws: `HealthConnectorError` with code `INVALID_ARGUMENT` if record IDs are invalid
     * - Throws: `HealthConnectorError` with code `SECURITY_ERROR` if authorization is denied
     * - Throws: `HealthConnectorError` with code `HEALTH_PLATFORM_UNAVAILABLE` if HealthKit database is inaccessible
     * - Throws: `HealthConnectorError` with code `UNKNOWN` if deletion fails
     */
    func deleteRecordsByIds(request: DeleteRecordsByIdsRequestDto) async throws {
        HealthConnectorLogger.debug(
            tag: HealthConnectorClient.tag,
            operation: "deleteRecordsByIds",

            message: "Deleting Health Connect records by IDs",
            context: [
                "request": request,
            ]
        )

        do {
            guard let handler = HealthKitTypeRegistry.getSampleHandler(for: request.dataType) else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Unsupported data type: \(request.dataType)"
                )
            }

            let sampleType = try handler.getSampleType()

            // Convert string IDs to UUIDs
            let uuids = request.recordIds.compactMap {
                UUID(uuidString: $0)
            }
            guard uuids.count == request.recordIds.count else {
                throw HealthConnectorErrors.invalidArgument(
                    message: "Invalid record IDs provided",
                    details: "Some record IDs are not valid UUIDs"
                )
            }

            // Step 1: Query for objects with specific UUIDs
            let samples = try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<[HKSample], Error>) in
                let uuidPredicate = HKQuery.predicateForObjects(with: Set(uuids))

                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: uuidPredicate,
                    limit: HKObjectQueryNoLimit,
                    sortDescriptors: nil
                ) {
                    _, samples, error in
                    if let error {
                        if let nsError = error as NSError? {
                            continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to query records: \(error.localizedDescription)",
                                    details: error.localizedDescription
                                )
                            )
                        }
                        return
                    }

                    guard let samples else {
                        continuation.resume(returning: [])
                        return
                    }

                    continuation.resume(returning: samples)
                }

                store.execute(query)
            }

            // Step 2: Delete the retrieved samples
            if !samples.isEmpty {
                try await withCheckedThrowingContinuation {
                    (continuation: CheckedContinuation<Void, Error>) in
                    store.delete(samples) {
                        success, error in
                        if let error {
                            if let nsError = error as NSError? {
                                continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                            } else {
                                continuation.resume(
                                    throwing: HealthConnectorErrors.unknown(
                                        message: "Failed to delete records: \(error.localizedDescription)",
                                        details: error.localizedDescription
                                    )
                                )
                            }
                            return
                        }

                        if success {
                            HealthConnectorLogger.info(
                                tag: HealthConnectorClient.tag,
                                operation: "deleteRecordsByIds",

                                message: "Health Connect records deleted successfully",
                                context: [
                                    "request": request,
                                ]
                            )
                            continuation.resume(returning: ())
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorErrors.unknown(
                                    message: "Failed to delete records",
                                    details: "HealthKit delete returned false"
                                )
                            )
                        }
                    }
                }
            } else {
                HealthConnectorLogger.warning(
                    tag: HealthConnectorClient.tag,
                    operation: "deleteRecordsByIds",

                    message: "No records to delete (empty IDs list)"
                )
            }
        } catch let error as HealthConnectorError {
            throw error
        } catch let error as NSError {
            let baseError = HealthConnectorClient.mapHealthKitError(error)
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "deleteRecordsByIds",

                message: "Failed to delete Health Connect records by IDs",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw baseError
        } catch {
            HealthConnectorLogger.error(
                tag: HealthConnectorClient.tag,
                operation: "deleteRecordsByIds",

                message: "Failed to delete Health Connect records by IDs",
                context: [
                    "request": request,
                ],
                exception: error
            )
            throw HealthConnectorErrors.unknown(
                message: "Failed to process \(request): \(error.localizedDescription)",
                details: error.localizedDescription
            )
        }
    }
}
