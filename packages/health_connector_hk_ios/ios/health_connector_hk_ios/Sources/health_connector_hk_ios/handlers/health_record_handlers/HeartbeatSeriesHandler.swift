import Foundation
import HealthKit

/// Handler for heartbeat series data (HKHeartbeatSeriesSample).
///
/// HeartbeatSeries uses a special HealthKit API pattern:
/// - Writing: Must use HKHeartbeatSeriesBuilder (cannot create samples directly)
/// - Reading: Must use HKHeartbeatSeriesQuery to extract beats from series samples
final class HeartbeatSeriesHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    typealias RecordDto = HeartbeatSeriesRecordDto
    typealias SampleType = HKHeartbeatSeriesSample
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static let dataType: HealthDataTypeDto = .heartbeatSeries

    func healthKitType() throws -> HKObjectType {
        // Use the C constant identifier as heartbeat series is exposed via
        // `HKDataTypeIdentifierHeartbeatSeries` in iOS HealthKit framework.
        guard
            let seriesType = HKObjectType.seriesType(
                forIdentifier: HKDataTypeIdentifierHeartbeatSeries)
        else {
            throw HealthConnectorError.unsupportedOperation(
                message: "HeartbeatSeries type is not available on this device"
            )
        }
        return seriesType
    }

    /// Writes a heartbeat series record using HKHeartbeatSeriesBuilder.
    ///
    /// HeartbeatSeries cannot be created directly - it must be built incrementally
    /// using HKHeartbeatSeriesBuilder.
    func writeRecord(_ dto: HealthRecordDto) async throws -> String {
        guard let dto = dto as? HeartbeatSeriesRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Type mismatch: expected HeartbeatSeriesRecordDto, but got \(type(of: dto))",
                context: [
                    "expected_type": "HeartbeatSeriesRecordDto",
                    "actual_type": String(describing: type(of: dto)),
                ]
            )
        }

        let tag = String(describing: type(of: self))
        let operation = "write_record"
        let context: [String: Any] = [
            "data_type": Self.dataType.rawValue,
            "sample_count": dto.samples.count,
        ]

        return try await process(operation: operation, context: context) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to write heartbeat series record",
                context: context
            )

            let startDate = Date(timeIntervalSince1970: Double(dto.startTime) / 1000.0)

            // Create builder without an explicit HKDevice. For heartbeat
            // series, source/device metadata is already captured in the
            // record metadata; HealthKit will associate the current device
            // automatically when `device` is nil.
            let builder = HKHeartbeatSeriesBuilder(
                healthStore: healthStore,
                device: nil,
                start: startDate
            )

            // Add each heartbeat
            for sample in dto.samples {
                let timeInterval = Double(sample.offsetMilliseconds) / 1000.0
                try await builder.addHeartbeat(
                    at: timeInterval,
                    precededByGap: sample.precededByGap
                )
            }

            // Finish and save the series
            let seriesSample = try await builder.finishSeries()
            let recordId = seriesSample.uuid.uuidString

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Heartbeat series record written successfully",
                context: context.merging(["record_id": recordId]) { _, new in new }
            )

            return recordId
        }
    }

    /// Reads a single heartbeat series record by ID.
    ///
    /// First queries for the HKHeartbeatSeriesSample container, then extracts
    /// the beats using HKHeartbeatSeriesQuery.
    func readRecord(id: String) async throws -> HealthRecordDto {
        let tag = String(describing: type(of: self))
        let operation = "read_record"
        let context: [String: Any] = [
            "data_type": Self.dataType.rawValue,
            "record_id": id,
        ]

        return try await process(operation: operation, context: context) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to read single heartbeat series record",
                context: context
            )

            guard let uuid = UUID(uuidString: id) else {
                throw HealthConnectorError.invalidArgument(
                    message: "Invalid UUID format: \(id)"
                )
            }

            let sampleType = try healthKitType()
            guard let sampleType = sampleType as? HKSampleType else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "HeartbeatSeries type does not support querying as HKSampleType"
                )
            }

            let predicate = HKQuery.predicateForObject(with: uuid)

            let recordDto: HealthRecordDto = try await withCheckedThrowingContinuation {
                continuation in
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: predicate,
                    limit: 1,
                    sortDescriptors: nil
                ) { _, samples, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let seriesSample = samples?.first as? HKHeartbeatSeriesSample else {
                        continuation.resume(
                            throwing: HealthConnectorError.invalidArgument(
                                message: "Record not found with ID: \(id)"
                            )
                        )
                        return
                    }

                    Task {
                        do {
                            // Extract beats from the series sample
                            let beats = try await self.queryHeartbeats(from: seriesSample)
                            let dto = try seriesSample.toDto(with: beats)
                            continuation.resume(returning: dto)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                }

                self.healthStore.execute(query)
            }

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Heartbeat series record retrieved successfully",
                context: context
            )

            return recordDto
        }
    }

    /// Reads multiple heartbeat series records within a time range.
    ///
    /// First queries for HKHeartbeatSeriesSample containers, then extracts
    /// beats from each using HKHeartbeatSeriesQuery.
    func readRecords(
        startTime: Date,
        endTime: Date,
        pageToken: PaginationToken? = nil,
        pageSize: Int,
        dataOriginPackageNames: [String] = [],
        sortOrder: SortOrderDto
    ) async throws -> (records: [HealthRecordDto], pageToken: PaginationToken?) {
        let tag = String(describing: type(of: self))
        let operation = "read_records"
        let querySpanDays =
            Calendar.current.dateComponents([.day], from: startTime, to: endTime).day ?? 0
        let context: [String: Any] = [
            "data_type": Self.dataType.rawValue,
            "query_span_days": querySpanDays,
            "page_size": pageSize,
            "has_page_token": pageToken != nil,
        ]

        return try await process(
            operation: operation,
            context: context
        ) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to read heartbeat series records",
                context: context
            )

            let sampleType = try healthKitType()
            guard let sampleType = sampleType as? HKSampleType else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "HeartbeatSeries type does not support querying as HKSampleType"
                )
            }

            // Build time range predicate
            let timePredicate = HKQuery.predicateForSamples(
                withStart: startTime,
                end: endTime,
                options: .strictStartDate
            )

            // Handle data origin filtering
            let predicate: NSPredicate
            if !dataOriginPackageNames.isEmpty {
                let sources = try await self.querySources(
                    forSampleType: sampleType,
                    bundleIdentifiers: dataOriginPackageNames
                )
                if sources.isEmpty {
                    return (records: [], pageToken: nil)
                }

                let sourcePredicate = HKQuery.predicateForObjects(from: sources)
                predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    sourcePredicate, timePredicate,
                ])
            } else {
                predicate = timePredicate
            }

            // Build pagination predicate if needed
            let finalPredicate: NSPredicate
            if let pageToken {
                let pageTokenDate = pageToken.toDate()
                let paginationPredicate = NSPredicate(
                    format: "startDate >= %@", pageTokenDate as NSDate
                )
                finalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    predicate, paginationPredicate,
                ])
            } else {
                finalPredicate = predicate
            }

            // Build sort descriptor
            let (sortIdentifier, ascending) = sortOrder.toHKSampleSortIdentifier()
            let sortDescriptor = NSSortDescriptor(
                key: sortIdentifier,
                ascending: ascending
            )

            // Request one extra record to determine if there are more pages
            let limit = pageSize + 1

            // Step 1: Query for series sample containers
            let seriesSamples: [HKHeartbeatSeriesSample] = try await withCheckedThrowingContinuation {
                continuation in
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: finalPredicate,
                    limit: limit,
                    sortDescriptors: [sortDescriptor]
                ) { _, samples, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let samples else {
                        continuation.resume(returning: [])
                        return
                    }

                    let typedSamples = samples.compactMap { $0 as? HKHeartbeatSeriesSample }
                    continuation.resume(returning: typedSamples)
                }

                self.healthStore.execute(query)
            }

            // Step 2: Extract beats from each series sample
            var recordDtos: [HeartbeatSeriesRecordDto] = []
            for seriesSample in seriesSamples.prefix(pageSize) {
                let beats = try await queryHeartbeats(from: seriesSample)
                let dto = try seriesSample.toDto(with: beats)
                recordDtos.append(dto)
            }

            // Check if there are more pages
            let hasMorePages = seriesSamples.count > pageSize
            let nextPageToken: PaginationToken?
            if hasMorePages {
                let lastSample = seriesSamples[pageSize - 1]
                let timestamp = Int64(lastSample.startDate.timeIntervalSince1970 * 1000)
                let adjustedTimestamp = ascending ? timestamp + 1 : timestamp - 1
                nextPageToken = PaginationToken(timestamp: adjustedTimestamp)
            } else {
                nextPageToken = nil
            }

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Heartbeat series records retrieved successfully",
                context: context.merging([
                    "record_count": recordDtos.count,
                    "has_more": nextPageToken != nil,
                ]) { _, new in new }
            )

            return (records: recordDtos, pageToken: nextPageToken)
        }
    }

    /// Queries heartbeats from a series sample using HKHeartbeatSeriesQuery.
    ///
    /// - Parameter sample: The HKHeartbeatSeriesSample to extract beats from
    /// - Returns: Array of HeartbeatSampleDto
    /// - Throws: HealthConnectorError if query fails
    private func queryHeartbeats(from sample: HKHeartbeatSeriesSample) async throws
        -> [HeartbeatSampleDto]
    {
        try await withCheckedThrowingContinuation { continuation in
            var beats: [HeartbeatSampleDto] = []

            let query =
                HKHeartbeatSeriesQuery(heartbeatSeries: sample) {
                    _, timeSinceStart, precededByGap, done, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    let offsetMs = Int64(timeSinceStart * 1000)
                    beats.append(
                        HeartbeatSampleDto(
                            offsetMilliseconds: offsetMs,
                            precededByGap: precededByGap
                        ))

                    if done {
                        continuation.resume(returning: beats)
                    }
                }

            healthStore.execute(query)
        }
    }
}
