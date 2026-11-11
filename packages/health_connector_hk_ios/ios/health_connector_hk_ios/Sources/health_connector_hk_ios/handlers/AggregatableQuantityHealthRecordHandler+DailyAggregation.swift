import Foundation
import HealthKit

extension AggregatableQuantityHealthRecordHandler {
    func aggregateByDay(
        metric: AggregationMetricDto,
        startTime: Date,
        endTime: Date,
        calendar: Calendar
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
        let collection: HKStatisticsCollection? = try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsCollectionQuery(
                quantityType: quantityType,
                quantitySamplePredicate: predicate,
                options: options,
                anchorDate: startTime,
                intervalComponents: interval
            )
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

        var results: [DailyAggregateResultDto] = []
        var day = startTime
        while day < endTime {
            try Task.checkCancellation()
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: day), nextDay > day else {
                throw HealthConnectorError.invalidArgument(message: "Cannot advance calendar day")
            }
            let quantity = collection?.statistics(for: day).flatMap { aggregateQuantity(from: $0, for: metric) }
            let value = try quantity.map { try convertQuantity($0) }
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
