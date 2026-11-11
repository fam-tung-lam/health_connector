import Foundation

extension HealthConnectorClient {
    /// Aggregates supported native quantities into complete local calendar days.
    func aggregateByDay(request: AggregateRequestDto) async throws -> [DailyAggregateResultDto] {
        try await process(operation: "aggregateByDay") {
            guard let request = request as? StandardAggregateRequestDto else {
                throw HealthConnectorError
                    .unsupportedOperation(message: "Saved workout aggregation cannot be grouped by day")
            }
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = .current
            let handler = try handlerRegistry.handler(
                for: request.dataType,
                withCapability: AggregatableQuantityHealthRecordHandler.self
            )
            return try await handler.aggregateByDay(
                metric: request.aggregationMetric,
                startTime: Date(millisecondsSince1970: request.startTime),
                endTime: Date(millisecondsSince1970: request.endTime),
                calendar: calendar
            )
        }
    }
}
