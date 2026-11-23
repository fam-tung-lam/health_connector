import Foundation
import HealthKit

extension AggregatableQuantityHealthRecordHandler {
    func aggregateByDay(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date,
        calendar: Calendar
    ) async throws -> [DailyAggregateResultDto] {
        try await dailyAggregates(metric: metric, startTime: startTime, endTime: endTime, calendar: calendar) { query in
            let collection: HKStatisticsCollection? = try await withCheckedThrowingContinuation { continuation in
                query.initialResultsHandler = { _, result, error in
                    if let error = error as? HKError, error.code == .errorNoData {
                        continuation.resume(returning: nil)
                    } else if let error {
                        continuation.resume(throwing: error)
                    } else if let result {
                        continuation.resume(returning: result)
                    } else {
                        continuation
                            .resume(throwing: HealthConnectorError.unknownError(message: "Missing daily statistics"))
                    }
                }
                healthStore.execute(query)
            }
            return { day in
                collection?.statistics(for: day)?.quantity(for: metric)
            }
        }
    }

    func dailyAggregates(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date,
        calendar: Calendar,
        loadQuantities: (HKStatisticsCollectionQuery) async throws -> (Date) -> HKQuantity?
    ) async throws -> [DailyAggregateResultDto] {
        try validateAggregationMetric(metric)
        let options = try statisticsOptions(for: metric)
        guard startTime < endTime,
              calendar.startOfDay(for: startTime) == startTime,
              calendar.startOfDay(for: endTime) == endTime
        else {
            throw HealthConnectorError.invalidArgument(message: "Expected complete local calendar days")
        }
        guard let quantityType = try Self.dataType.toHKSampleType() as? HKQuantityType else {
            throw HealthConnectorError.unsupportedOperation(message: "Daily aggregation requires a quantity type")
        }

        // Include boundary-crossing samples; the calendar intervals own allocation to days.
        let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: [])
        var interval = DateComponents(day: 1)
        interval.calendar = calendar
        interval.timeZone = calendar.timeZone
        // HealthKit repeats the anchor's wall-clock time. A day can start at 01:00 when midnight is skipped.
        guard let midnight = calendar.nextDate(
            after: startTime,
            matching: DateComponents(hour: 0, minute: 0, second: 0),
            matchingPolicy: .strict
        ) else {
            throw HealthConnectorError.invalidArgument(message: "Cannot find a local midnight for daily statistics")
        }
        let query = HKStatisticsCollectionQuery(
            quantityType: quantityType,
            quantitySamplePredicate: predicate,
            options: options,
            anchorDate: midnight,
            intervalComponents: interval
        )
        let quantityAt = try await loadQuantities(query)

        var results: [DailyAggregateResultDto] = []
        var day = startTime
        while day < endTime {
            try Task.checkCancellation()
            guard let nextDay = calendar.dateInterval(of: .day, for: day)?.end, nextDay > day else {
                throw HealthConnectorError.invalidArgument(message: "Cannot advance calendar day")
            }
            let value = try quantityAt(day).map { try convertQuantity($0) }
            results.append(DailyAggregateResultDto(
                startTime: Int64(day.timeIntervalSince1970 * 1000),
                endTime: Int64(nextDay.timeIntervalSince1970 * 1000),
                value: value
            ))
            day = nextDay
        }
        return results
    }
}
