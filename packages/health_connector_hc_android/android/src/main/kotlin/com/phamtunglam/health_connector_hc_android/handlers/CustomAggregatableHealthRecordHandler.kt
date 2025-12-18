package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.endTime
import com.phamtunglam.health_connector_hc_android.mappers.startTime
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import java.io.IOException
import java.time.Instant

/**
 * Capability for handlers that support custom manual aggregation logic.
 *
 * Use this when Health Connect native aggregation is not available.
 * This interface provides a default paginated aggregation implementation that eliminates
 * code duplication across handlers.
 *
 * The paginated aggregation handles large datasets efficiently by:
 * - Paginating through records in chunks ([ReadableHealthRecordHandler.DEFAULT_PAGE_SIZE] records per page)
 * - Accumulating statistics (count, sum, min, max) without loading all data into memory
 *
 * @see extractValueForAggregation
 * @see wrapAggregationResult
 */
internal interface CustomAggregatableHealthRecordHandler :
    AggregatableHealthRecordHandler,
    ReadableHealthRecordHandler {

    /**
     * Set of aggregation metrics supported by this handler.
     */
    val supportedAggregationMetrics: Set<AggregationMetricDto>

    /**
     * Extract the numeric value from a specific DTO type for aggregation.
     *
     * This method should perform type checking and value extraction specific
     * to the handler's data type.
     *
     * @param recordDto The health record DTO to extract a value from
     * @return The numeric value if the DTO is of the expected type, null otherwise
     *
     * Example implementations:
     * ```
     * // For OxygenSaturationHandler:
     * override fun extractValueForAggregation(recordDto: HealthRecordDto): Double? {
     *     return (recordDto as? OxygenSaturationRecordDto)?.percentage?.value
     * }
     *
     * // For RespiratoryRateHandler:
     * override fun extractValueForAggregation(recordDto: HealthRecordDto): Double? {
     *     return (recordDto as? RespiratoryRateRecordDto)?.rate?.value
     * }
     * ```
     */
    fun extractValueForAggregation(recordDto: HealthRecordDto): Double?

    /**
     * Wrap the aggregated numeric result into the appropriate response format.
     *
     * Different data types may require different wrapping:
     * - Simple numeric types use toNumericDto()
     * - Complex types with units use specific DTO constructors
     *
     * @param value The aggregated numeric value (AVG, MIN, or MAX)
     * @return The measurement unit DTO appropriate for this data type
     *
     * Example implementations:
     * ```
     * // For simple numeric types (Oxygen Saturation, Respiratory Rate, VO2 Max):
     * override fun wrapAggregationResult(value: Double): MeasurementUnitDto {
     *     return value.toNumericDto()
     * }
     *
     * // For types with units (Blood Glucose):
     * override fun wrapAggregationResult(value: Double): MeasurementUnitDto {
     *     return BloodGlucoseDto(
     *         BloodGlucoseUnitDto.MILLIGRAMS_PER_DECILITER,
     *         value,
     *     )
     * }
     * ```
     */
    fun wrapAggregationResult(value: Double): MeasurementUnitDto

    /**
     * Performs custom paginated aggregation over health records within a time range.
     *
     * This default implementation:
     * 1. Validates the request (time range, supported metrics)
     * 2. Paginates through all records in the time range
     * 3. Accumulates statistics (count, sum, min, max)
     * 4. Calculates the requested metric (AVG, MIN, MAX, COUNT, or SUM)
     * 5. Wraps the result in the appropriate format
     *
     * Supported metrics:
     * - AVG: Average of all values
     * - MIN: Minimum value
     * - MAX: Maximum value
     * - COUNT: Number of records with valid extractable values
     * - SUM: Sum of all values
     *
     * Implementations can override this method if custom aggregation logic is needed,
     * but in most cases, only [extractValueForAggregation] and [wrapAggregationResult]
     * need to be implemented.
     *
     * @param request The aggregation request containing data type, metric, and time range
     * @return The aggregation response with the computed value
     * @throws IllegalArgumentException if [startTime] > [endTime]
     * @throws Exception that can be thrown by [HealthConnectClient.readRecords]
     */
    @Throws(
        IllegalArgumentException::class,
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto = process(
        "custom_aggregate",
        context = mapOf("request" to request),
    ) {
        require(request.startTime < request.endTime) {
            "Invalid time range: startTime (${request.startTime}) must be less than endTime (${request.endTime})"
        }

        require(
            supportedAggregationMetrics.contains(request.aggregationMetric),
        ) {
            "Aggregation metric ${request.aggregationMetric} not supported for $dataType. " +
                "Supported metrics: $supportedAggregationMetrics"
        }

        val aggregationResult = paginateAndAggregate(
            startTime = request.startTime,
            endTime = request.endTime,
        )

        if (aggregationResult.count == 0) {
            return@process AggregateResponseDto(value = wrapAggregationResult(0.0))
        }

        val resultValue = when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> aggregationResult.avg
            AggregationMetricDto.MIN -> aggregationResult.min
            AggregationMetricDto.MAX -> aggregationResult.max
            AggregationMetricDto.COUNT -> aggregationResult.count.toDouble()
            AggregationMetricDto.SUM -> aggregationResult.sum
        }

        AggregateResponseDto(value = wrapAggregationResult(resultValue))
    }

    /**
     * Internal method that performs the actual pagination and aggregation.
     *
     * This method pages through all records in the time range and accumulates
     * statistics without loading all records into memory at once.
     */
    private suspend fun paginateAndAggregate(
        startTime: Long,
        endTime: Long,
    ): PaginatedAggregationResult {
        var pageToken: String? = null
        var count = 0
        var sum = 0.0
        var min = Double.MAX_VALUE
        var max = Double.MIN_VALUE

        do {
            val (records, nextToken) = readRecords(
                startTime = Instant.ofEpochMilli(startTime),
                endTime = Instant.ofEpochMilli(endTime),
                pageToken = pageToken,
            )

            for (recordDto in records) {
                val value = extractValueForAggregation(recordDto) ?: continue
                sum += value
                count++
                if (value < min) min = value
                if (value > max) max = value
            }

            pageToken = nextToken
        } while (!pageToken.isNullOrEmpty())

        return PaginatedAggregationResult(
            avg = sum / count,
            count = count,
            sum = sum,
            min = if (count > 0) min else 0.0,
            max = if (count > 0) max else 0.0,
        )
    }

    /**
     * Internal data class to hold intermediate aggregation results.
     */
    private data class PaginatedAggregationResult(
        val avg: Double,
        val count: Int,
        val sum: Double,
        val min: Double,
        val max: Double,
    )
}
