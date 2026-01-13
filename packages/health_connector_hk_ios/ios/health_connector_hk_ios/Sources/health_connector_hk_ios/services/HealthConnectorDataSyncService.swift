import Foundation
import HealthKit

/// Internal service responsible for managing HealthKit data synchronization.
///
/// @unchecked Sendable: HKHealthStore is thread-safe.
struct HealthConnectorDataSyncService: @unchecked Sendable, Taggable {
    private let store: HKHealthStore

    init(store: HKHealthStore) {
        self.store = store
    }

    /// Synchronizes health data using Unified Multi-Type Querying.
    ///
    /// This method executes a single `HKAnchoredObjectQuery` across multiple health data types,
    /// retrieves changes since the last sync (or all future data for initial sync), and returns
    /// a paginated result with upserted records, deletions, and a continuation token.
    ///
    /// - Parameters:
    ///   - dataTypes: The health data types to synchronize. Must not be empty.
    ///   - syncToken: Optional sync token from a previous synchronization. Pass `nil` for
    ///     initial sync, which will only retrieve data recorded **after** this call (no historical data).
    ///   - pageSize: Maximum number of records to return per sync. Defaults to 1000.
    ///
    /// - Returns: A `HealthDataSyncResultDto` containing:
    ///   - `upsertedRecords`: New or modified health records
    ///   - `deletedRecordIds`: UUIDs of deleted records
    ///   - `hasMore`: `true` if more changes are available beyond the page size
    ///   - `nextSyncToken`: Token to use for the next incremental sync
    ///
    /// - Throws:
    ///   - `HealthConnectorError.invalidArgument` if:
    ///     - `dataTypes` is empty
    ///     - None of the provided `dataTypes` can be converted to valid HealthKit sample types
    ///     - `syncToken` contains corrupted or invalid base64 data
    ///     - `syncToken` anchor cannot be decoded (corrupted anchor)
    ///     - A sample cannot be converted to DTO (if strict mapping is used)
    ///   - `HealthConnectorError.unknownError` if HealthKit returns a `nil` anchor unexpectedly during query execution
    ///   - Underlying HealthKit errors from `HKAnchoredObjectQuery` execution
    func synchronize(
        dataTypes: [HealthDataTypeDto],
        syncToken: HealthDataSyncTokenDto?,
        pageSize: Int = 1000
    ) async throws -> HealthDataSyncResultDto {
        let operation = "synchronize"
        let context: [String: Any] = [
            "data_type_count": dataTypes.count,
            "has_sync_token": syncToken != nil,
            "page_size": pageSize,
        ]

        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: operation,
            message: "Starting HealthKit data synchronization",
            context: context
        )

        // 1. Validate input
        guard !dataTypes.isEmpty else {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: operation,
                message: "Synchronization failed: No data types provided",
                context: context
            )

            throw HealthConnectorError.invalidArgument(
                message: "No data types provided for synchronization",
                context: context
            )
        }

        // 2. Decode Single Unified Anchor
        let anchor: HKQueryAnchor?
        if let syncToken {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Decoding sync anchor from token",
                context: context.merging([
                    "token_created_at": syncToken.createdAtMillis,
                ]) { _, new in new }
            )

            anchor = try decodeAnchor(from: syncToken)
        } else {
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Initial sync - no anchor provided",
                context: context
            )
            anchor = nil
        }

        // 3. Prepare Query Descriptors
        // For initial sync (nil anchor), we apply a 'futureOnlyPredicate' to only sync future data,
        // intentionally ignoring all historical data in HealthKit.
        let predicate = anchor == nil ? futureOnlyPredicate() : nil

        let descriptors =
            try dataTypes
                .flatMap { try $0.toHealthKit() }
                .map { element in
                    guard let sampleType = element as? HKSampleType else {
                        HealthConnectorLogger.error(
                            tag: Self.tag,
                            operation: operation,
                            message: "Data type conversion failed",
                            context: [
                                "type_received": String(describing: type(of: element)),
                            ]
                        )

                        throw HealthConnectorError.invalidArgument(
                            message:
                            "Data type converted to unsupported HealthKit type (not HKSampleType)",
                            context: [
                                "type_received": String(describing: type(of: element)),
                            ]
                        )
                    }

                    return HKQueryDescriptor(sampleType: sampleType, predicate: predicate)
                }

        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: operation,
            message: "Prepared query descriptors",
            context: [
                "descriptor_count": descriptors.count,
                "has_anchor": anchor != nil,
            ]
        )

        // 4. Execute Unified Query
        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: operation,
            message: "Executing unified HealthKit query",
            context: [
                "page_size": pageSize,
            ]
        )

        let (samples, deletions, newAnchor) = try await executeUnifiedQuery(
            descriptors: descriptors,
            anchor: anchor,
            pageSize: pageSize
        )

        HealthConnectorLogger.info(
            tag: Self.tag,
            operation: operation,
            message: "Query completed",
            context: [
                "samples_received": samples.count,
                "deletions_received": deletions.count,
            ]
        )

        // 5. Check HasMore (Peek Strategy)
        let hasMore = try await checkHasMore(
            descriptors: descriptors,
            anchor: newAnchor
        )

        HealthConnectorLogger.debug(
            tag: Self.tag,
            operation: operation,
            message: "Checked for additional data",
            context: [
                "has_more": hasMore,
            ]
        )

        // 6. Encode Unified Anchor
        let encodedToken = try encodeAnchor(newAnchor)

        // 7. Map Results
        let upsertedRecords = try samples.compactMap { try $0.toDto() }
        let deletedRecordIds = deletions.map(\.uuid.uuidString)
        let nextSyncToken = HealthDataSyncTokenDto(
            token: encodedToken,
            dataTypes: dataTypes,
            createdAtMillis: Int64(Date().timeIntervalSince1970 * 1000)
        )

        HealthConnectorLogger.info(
            tag: Self.tag,
            operation: operation,
            message: "Synchronization completed successfully",
            context: [
                "upserted_records": upsertedRecords.count,
                "deleted_records": deletedRecordIds.count,
                "has_more": hasMore,
            ]
        )

        return HealthDataSyncResultDto(
            upsertedRecords: upsertedRecords,
            deletedRecordIds: deletedRecordIds,
            hasMore: hasMore,
            nextSyncToken: nextSyncToken
        )
    }

    // MARK: - Core Logic

    // MARK: - Core Query Logic

    /// Executes a unified HealthKit anchored object query across multiple data types.
    ///
    /// This method uses `HKAnchoredObjectQuery` to efficiently retrieve changes from HealthKit
    /// since the last known anchor position. The query returns both new/modified samples and
    /// deleted objects, along with a new anchor to use for subsequent queries.
    ///
    /// - Parameters:
    ///   - descriptors: Query descriptors defining which sample types and predicates to query.
    ///                  Each descriptor represents a data type (e.g., steps, heart rate) with
    ///                  optional filtering predicates.
    ///   - anchor: The anchor from a previous query, or `nil` to retrieve all matching data.
    ///             Anchors act as bookmarks, allowing incremental synchronization.
    ///
    /// - Returns: A tuple containing:
    ///   - `samples`: Array of new or modified HealthKit samples since the anchor
    ///   - `deletions`: Array of deleted objects (identified by UUID) since the anchor
    ///   - `newAnchor`: New anchor representing the current query position, to be used in subsequent queries
    ///
    /// - Throws:
    ///   - `HealthConnectorError.unknownError` if HealthKit returns a `nil` anchor (should never happen)
    ///   - Underlying HealthKit errors (e.g., authorization failures, database errors)
    private func executeUnifiedQuery(
        descriptors: [HKQueryDescriptor],
        anchor: HKQueryAnchor?,
        pageSize: Int
    ) async throws -> (samples: [HKSample], deletions: [HKDeletedObject], newAnchor: HKQueryAnchor) {
        try await withCheckedThrowingContinuation { continuation in
            let query = HKAnchoredObjectQuery(
                queryDescriptors: descriptors,
                anchor: anchor,
                limit: pageSize,
                resultsHandler: { _, samples, deletedObjects, newAnchor, error in
                    // Handle errors first
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    // HealthKit should always provide a new anchor, even for empty results
                    guard let newAnchor else {
                        continuation.resume(
                            throwing: HealthConnectorError.unknownError(
                                message: "Unified query returned nil anchor"))
                        return
                    }

                    // Return results, defaulting to empty arrays if nil
                    continuation.resume(
                        returning: (
                            samples ?? [],
                            deletedObjects ?? [],
                            newAnchor
                        ))
                }
            )
            store.execute(query)
        }
    }

    /// Checks if more data is available beyond the current anchor by executing a peek query.
    ///
    /// This method performs a lightweight query with `limit=1` to detect if additional
    /// changes exist in HealthKit beyond the provided anchor. It checks for both new samples
    /// and deletions to accurately determine if pagination should continue.
    ///
    /// **Why This Is Needed:** HealthKit's `HKAnchoredObjectQuery` doesn't provide a built-in
    /// "hasMore" flag. This peek strategy allows the synchronization API to accurately report
    /// whether additional pages are available without over-fetching data.
    ///
    /// - Parameters:
    ///   - descriptors: The same query descriptors used in the main sync query. This ensures
    ///                  the peek query respects the same filters (e.g., date ranges, data types).
    ///   - anchor: The anchor returned from the previous query. The peek looks for changes
    ///             strictly after this anchor position.
    ///
    /// - Returns: `true` if at least one sample or deletion exists beyond the anchor,
    ///            `false` if no more data is available.
    ///
    /// - Throws: Underlying HealthKit errors from query execution
    private func checkHasMore(
        descriptors: [HKQueryDescriptor],
        anchor: HKQueryAnchor
    ) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            let query = HKAnchoredObjectQuery(
                queryDescriptors: descriptors,
                anchor: anchor,
                limit: 1, // Peek with minimal overhead
                resultsHandler: { _, samples, deletedObjects, _, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    // Check both samples and deletions - hasMore is true if either has data
                    let hasMoreSamples = (samples?.count ?? 0) > 0
                    let hasMoreDeletions = (deletedObjects?.count ?? 0) > 0
                    continuation.resume(returning: hasMoreSamples || hasMoreDeletions)
                }
            )
            store.execute(query)
        }
    }

    // MARK: - Anchor Serialization

    /// Decodes an `HKQueryAnchor` from a sync token's base64-encoded data.
    ///
    /// HealthKit anchors are opaque objects that must be serialized for storage and
    /// transmission. This method reverses the encoding process, converting the base64
    /// string back into an `HKQueryAnchor` using `NSKeyedUnarchiver`.
    ///
    /// - Parameter syncToken: The sync token containing the encoded anchor
    ///
    /// - Returns: The decoded `HKQueryAnchor`
    ///
    /// - Throws:
    ///   - `HealthConnectorError.invalidArgument` if:
    ///     - The token contains invalid base64 data
    ///     - The anchor data is corrupted and cannot be decoded
    private func decodeAnchor(from syncToken: HealthDataSyncTokenDto) throws -> HKQueryAnchor {
        let operation = "decodeAnchor"

        // Decode base64 string to binary data
        guard let data = Data(base64Encoded: syncToken.token) else {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: operation,
                message: "Failed to decode base64 data from sync token",
                context: [
                    "token_length": syncToken.token.count,
                ]
            )

            throw HealthConnectorError.invalidArgument(
                message: "Sync token contains invalid base64-encoded data",
                context: ["token_length": syncToken.token.count]
            )
        }

        // Unarchive the HKQueryAnchor from binary data
        do {
            let anchor = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: HKQueryAnchor.self, from: data
            )
            HealthConnectorLogger.debug(
                tag: Self.tag,
                operation: operation,
                message: "Successfully decoded anchor from sync token"
            )

            guard let anchor else {
                throw HealthConnectorError.invalidArgument(
                    message: "Failed to decode anchor from sync token"
                )
            }

            return anchor
        } catch {
            HealthConnectorLogger.error(
                tag: Self.tag,
                operation: operation,
                message: "Failed to unarchive HKQueryAnchor",
                context: [
                    "token_created_at": syncToken.createdAtMillis,
                ],
                exception: error
            )

            throw HealthConnectorError.invalidArgument(
                message:
                "Failed to decode HKQueryAnchor from sync token. The token may be corrupted.",
                context: [
                    "underlying_error": error.localizedDescription,
                    "token_created_at": syncToken.createdAtMillis,
                ]
            )
        }
    }

    /// Encodes an `HKQueryAnchor` into a base64 string for storage and transmission.
    ///
    /// HealthKit anchors are opaque objects that cannot be directly serialized to JSON.
    /// This method uses `NSKeyedArchiver` with secure coding to convert the anchor to
    /// binary data, then encodes it as a base64 string for safe transmission.
    ///
    /// - Parameter anchor: The HealthKit query anchor to encode
    ///
    /// - Returns: A base64-encoded string representation of the anchor
    ///
    /// - Throws: Archiving errors if the anchor cannot be serialized (rare - should not happen)
    private func encodeAnchor(_ anchor: HKQueryAnchor) throws -> String {
        // Archive the anchor to binary data using secure coding
        let data = try NSKeyedArchiver.archivedData(
            withRootObject: anchor,
            requiringSecureCoding: true
        )

        // Convert binary data to base64 string for safe transmission
        return data.base64EncodedString()
    }

    /// Creates a predicate for initial sync that only includes health data samples
    /// recorded **after** the sync operation begins.
    ///
    /// This intentionally excludes all historical data from HealthKit. Only samples
    /// with a start date strictly after the current time (`Date()`) will be included
    /// in the synchronization.
    ///
    /// **Important**: Historical health data will **never** be synchronized when using
    /// this predicate.
    ///
    /// - Returns: A predicate that filters samples to only those recorded in the future.
    private func futureOnlyPredicate() -> NSPredicate {
        HKQuery.predicateForSamples(withStart: Date(), end: nil, options: .strictStartDate)
    }
}
