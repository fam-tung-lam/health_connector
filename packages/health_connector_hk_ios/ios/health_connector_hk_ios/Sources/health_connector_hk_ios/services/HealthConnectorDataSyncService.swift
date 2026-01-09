import Foundation
import HealthKit

/// Internal service responsible for managing HealthKit data synchronization.
// @unchecked Sendable: HKHealthStore is thread-safe.
struct HealthConnectorDataSyncService: @unchecked Sendable, Taggable {
    private let store: HKHealthStore
    private let pageSize: Int

    init(store: HKHealthStore, pageSize: Int = 1000) {
        self.store = store
        self.pageSize = pageSize
    }

    /// Synchronizes health data using Unified Multi-Type Querying.
    func synchronize(
        dataTypes: [HealthDataTypeDto],
        syncToken: HealthDataSyncTokenDto?
    ) async throws -> HealthDataSyncResultDto {
        // 1. Decode Single Unified Anchor
        let anchor = try decodeAnchor(from: syncToken)

        // 2. Prepare Query Descriptors
        // For initial sync (nil anchor), we might apply a 'futurePredicate' to ignore old data,
        // or sync all history. Logic here preserves the original intent (futurePredicate if no anchor).
        let predicate = anchor == nil ? futurePredicate() : nil

        let descriptors = try dataTypes.flatMap { try $0.toHealthKit() }
            .compactMap { sampleType -> HKQueryDescriptor? in
                guard let sampleType = sampleType as? HKSampleType else { return nil }
                return HKQueryDescriptor(sampleType: sampleType, predicate: predicate)
            }

        guard !descriptors.isEmpty else {
            throw HealthConnectorError.invalidArgument(message: "No valid sample types provided")
        }

        // 3. Execute Unified Query
        let (samples, deletions, newAnchor) = try await executeUnifiedQuery(
            descriptors: descriptors,
            anchor: anchor
        )

        // 4. Check HasMore (Peek Strategy)
        // We can reuse the same query logic with limit 1 and the NEW anchor to see if more exists.
        let hasMore = try await checkHasMore(
            descriptors: descriptors,
            anchor: newAnchor
        )

        // 5. Encode Unified Anchor
        let encodedToken = try encodeAnchor(newAnchor)

        // 6. Map Results
        let upsertedRecords = try samples.compactMap { try $0.toDto() }
        let deletedRecordIds = deletions.map(\.uuid.uuidString)

        let nextSyncToken = HealthDataSyncTokenDto(
            token: encodedToken,
            dataTypes: dataTypes,
            createdAtMillis: Int64(Date().timeIntervalSince1970 * 1000)
        )

        return HealthDataSyncResultDto(
            upsertedRecords: upsertedRecords,
            deletedRecordIds: deletedRecordIds,
            hasMore: hasMore,
            nextSyncToken: nextSyncToken
        )
    }

    // MARK: - Core Logic

    private func executeUnifiedQuery(
        descriptors: [HKQueryDescriptor],
        anchor: HKQueryAnchor?
    ) async throws -> (samples: [HKSample], deletions: [HKDeletedObject], newAnchor: HKQueryAnchor) {
        try await withCheckedThrowingContinuation { continuation in
            let query = HKAnchoredObjectQuery(
                queryDescriptors: descriptors,
                anchor: anchor,
                limit: pageSize,
                resultsHandler: { _, samples, deletedObjects, newAnchor, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let newAnchor else {
                        continuation.resume(
                            throwing: HealthConnectorError.unknown(
                                message: "Unified query returned nil anchor"))
                        return
                    }

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

    private func checkHasMore(
        descriptors: [HKQueryDescriptor],
        anchor: HKQueryAnchor
    ) async throws -> Bool {
        try await withCheckedThrowingContinuation { continuation in
            // Peek strictly into the future of the new anchor
            // We strip the predicate from descriptors if we only care about *any* new changes,
            // but usually we want to respect the original predicate (like date ranges).
            // However, for 'hasMore' check on the *same* sync sequence, we use the same descriptors.

            let query = HKAnchoredObjectQuery(
                queryDescriptors: descriptors,
                anchor: anchor,
                limit: 1, // Peek 1
                resultsHandler: { _, samples, _, _, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }
                    let count = samples?.count ?? 0
                    continuation.resume(returning: count > 0)
                }
            )
            store.execute(query)
        }
    }

    // MARK: - Helpers

    private func decodeAnchor(from syncToken: HealthDataSyncTokenDto?) throws -> HKQueryAnchor? {
        guard let syncToken, let data = Data(base64Encoded: syncToken.token) else { return nil }
        // Try decoding single anchor
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: data)
    }

    private func encodeAnchor(_ anchor: HKQueryAnchor) throws -> String {
        let data = try NSKeyedArchiver.archivedData(
            withRootObject: anchor, requiringSecureCoding: true
        )
        return data.base64EncodedString()
    }

    private func futurePredicate() -> NSPredicate {
        HKQuery.predicateForSamples(withStart: Date(), end: nil, options: .strictStartDate)
    }
}
