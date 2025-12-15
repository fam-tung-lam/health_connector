package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.metadata.DataOrigin
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.logger.TAG
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.endTime
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.id
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.startTime
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import java.io.IOException
import java.time.Instant

/**
 * Base interface for all Health Connect record handlers.
 */
internal interface HealthRecordHandler {
    /**
     * The health data type this handler supports.
     */
    val dataType: HealthDataTypeDto

    /**
     * Health Connect SDK client for performing operations.
     */
    val client: HealthConnectClient

    /**
     * Centralized exception handling wrapper for handler operations.
     *
     * This method wraps handler calls with consistent exception handling,
     * mapping SDK exceptions to [HealthConnectorErrorDto] with appropriate error codes.
     *
     * Exception mappings:
     * - [SecurityException] -> [HealthConnectorErrorCodeDto.NOT_AUTHORIZED]
     * - [IllegalArgumentException] -> [HealthConnectorErrorCodeDto.INVALID_ARGUMENT]
     * - [IllegalStateException] -> [HealthConnectorErrorCodeDto.INVALID_ARGUMENT]
     * - [IOException] -> [HealthConnectorErrorCodeDto.REMOTE_ERROR]
     *
     * @param operation Human-readable operation name for logging (e.g., "readRecord", "writeRecords")
     * @param context Additional context for logging (e.g., recordId, time range)
     * @param block The suspending operation to execute
     * @return The result of the block if successful
     * @throws HealthConnectorErrorDto with appropriate error code
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun <T> process(
        operation: String,
        context: Map<String, Any?>? = null,
        block: suspend () -> T,
    ): T {
        try {
            return block()
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "Permission denied while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.NOT_AUTHORIZED.toError(
                "Permission denied for $dataType: ${e.message ?: "Access denied"}",
            )
        } catch (e: IllegalArgumentException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "Invalid argument while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                "Invalid argument for $dataType: ${e.message}",
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "Invalid state while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                "Invalid state for $dataType: ${e.message}",
            )
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "I/O error while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.REMOTE_ERROR.toError(
                "I/O error for $dataType: ${e.message ?: "I/O error"}",
            )
        }
    }
}

/**
 * Capability for handlers that support reading records.
 */
internal interface ReadableHealthRecordHandler : HealthRecordHandler {

    companion object {
        /**
         * Default page size for record reading.
         */
        const val DEFAULT_PAGE_SIZE: Int = 1000
    }

    /**
     * Reads a single record by ID.
     *
     * @param recordId The unique identifier of the record to read
     * @return The health record DTO
     * @throws Exception that can be thrown by [HealthConnectClient.readRecords]
     */
    @Throws(
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun readRecord(recordId: String): HealthRecordDto = process(
        operation = "read_record",
        context = mapOf("record_id" to recordId),
    ) {
        val response = client.readRecord(
            recordType = dataType.toHealthConnectRecordClass(),
            recordId = recordId,
        )

        response.record.toDto()
    }

    /**
     * Reads multiple records within a time range with pagination support.
     *
     * @throws Exception that can be thrown by [HealthConnectClient.readRecords]
     */
    @Throws(
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun readRecords(
        startTime: Instant,
        endTime: Instant,
        pageSize: Int = DEFAULT_PAGE_SIZE,
        pageToken: String? = null,
        dataOrigins: Set<DataOrigin> = emptySet(),
    ): Pair<List<HealthRecordDto>, String?> = process(
        operation = "read_records",
        context = mapOf(
            "start_time" to startTime.toString(),
            "end_time" to endTime.toString(),
        ),
    ) {
        val request = ReadRecordsRequest(
            recordType = dataType.toHealthConnectRecordClass(),
            timeRangeFilter = TimeRangeFilter.between(startTime, endTime),
            pageSize = pageSize,
            pageToken = pageToken,
            dataOriginFilter = dataOrigins,
        )

        val response = client.readRecords(request)
        val dtos = response.records.map { record -> record.toDto() }

        Pair(dtos, response.pageToken)
    }
}

/**
 * Capability for handlers that support writing records.
 */
internal interface WritableHealthRecordHandler : HealthRecordHandler {
    /**
     * Writes a single record.
     *
     * @param dto The health record DTO to write
     * @return The platform-assigned record ID
     * @throws Exception that can be thrown by [HealthConnectClient.insertRecords]
     */
    @Throws(
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun writeRecord(dto: HealthRecordDto): String = process(
        operation = "write_record",
        context = mapOf("dto" to dto),
    ) {
        val record = dto.toHealthConnect()

        val response = client.insertRecords(listOf(record))

        response.recordIdsList.first()
    }

    /**
     * Writes multiple records atomically.
     *
     * @param dtos The list of health record DTOs to write
     * @return The list of platform-assigned record IDs
     * @throws Exception that can be thrown by [HealthConnectClient.insertRecords]
     */
    @Throws(
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun writeRecords(dtos: List<HealthRecordDto>): List<String> {
        if (dtos.isEmpty()) {
            return emptyList()
        }

        return process(
            operation = "write_records",
            context = mapOf("count" to dtos.size),
        ) {
            val records = dtos.map { it.toHealthConnect() }

            val response = client.insertRecords(records)

            response.recordIdsList
        }
    }
}

/**
 * Capability for handlers that support updating records.
 */
internal interface UpdatableHealthRecordHandler : HealthRecordHandler {
    /**
     * Updates a single record.
     *
     * @param dto The health record DTO to update (must contain valid ID)
     * @return The record ID
     * @throws IllegalArgumentException if the [HealthRecordDto.id] is null or empty
     * @throws Exception that can be thrown by [HealthConnectClient.updateRecords]
     */
    @Throws(
        IllegalArgumentException::class,
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun updateRecord(dto: HealthRecordDto): String = process(
        operation = "update_record",
        context = mapOf("record_id" to dto.id),
    ) {
        require(!dto.id.isNullOrEmpty()) {
            "Record ID must be provided for update operations. Use `writeRecord()` for new records."
        }

        val record = dto.toHealthConnect()

        client.updateRecords(listOf(record))

        dto.id!!
    }
}

/**
 * Capability for handlers that support deleting records.
 */
internal interface DeletableHealthRecordHandler : HealthRecordHandler {
    /**
     * Deletes specific records by their IDs.
     *
     * @param recordIds The list of record IDs to delete
     * @throws Exception that can be thrown by [HealthConnectClient.deleteRecords]
     */
    @Throws(
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun deleteRecords(recordIds: List<String>) {
        if (recordIds.isEmpty()) {
            return
        }

        process(
            operation = "delete_records",
            context = mapOf("record_ids" to recordIds),
        ) {
            client.deleteRecords(
                recordType = dataType.toHealthConnectRecordClass(),
                recordIdsList = recordIds,
                clientRecordIdsList = emptyList(),
            )
        }
    }

    /**
     * Deletes all records within a time range.
     *
     * @param startTime The start of the time range (epoch millis)
     * @param endTime The end of the time range (epoch millis)
     * @throws IllegalArgumentException if [startTime] > [endTime]
     * @throws Exception that can be thrown by [HealthConnectClient.deleteRecords]
     */
    @Throws(
        IllegalArgumentException::class,
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun deleteRecordsByTimeRange(startTime: Instant, endTime: Instant) {
        process(
            operation = "delete_records_by_time_range",
            context = mapOf("start_time" to startTime, "end_time" to endTime),
        ) {
            require(startTime < endTime) {
                "Invalid time range: startTime must be before endTime"
            }

            client.deleteRecords(
                recordType = dataType.toHealthConnectRecordClass(),
                timeRangeFilter = TimeRangeFilter.between(startTime, endTime),
            )
        }
    }
}

/**
 * Capability for handlers that support aggregation operations.
 */
internal interface AggregatableHealthRecordHandler : HealthRecordHandler

/**
 * Capability for handlers that support native Health Connect aggregation using [AggregateRequest].
 */
internal interface HealthConnectAggregatableHealthRecordHandler : AggregatableHealthRecordHandler {

    /**
     * Converts a platform aggregation request to a Health Connect metric.
     *
     * Validates that the requested [request] metric is compatible with the health data type.
     * For example, steps only supports [AggregationMetricDto.SUM], while weight supports AVG, MIN, and MAX.
     *
     * @param request The aggregation request containing the metric type to map.
     * @return The native Health Connect [AggregateMetric].
     * @throws IllegalArgumentException If the [request] contains a metric type that is
     *         incompatible with this specific health data type.
     */
    @Throws(IllegalArgumentException::class)
    fun toAggregateMetric(request: AggregateRequestDto): AggregateMetric<*>

    /**
     * Extracts aggregation result from Health Connect and converts to platform DTO.
     *
     * This method retrieves the aggregated value for a specific metric from the Health Connect
     * AggregationResult and wraps it in the appropriate measurement unit DTO.
     *
     * @param result The aggregation result from Health Connect SDK
     * @param metric The specific metric to extract from the result
     * @return The measurement unit DTO containing the aggregated value
     * @throws IllegalArgumentException if the metric is not recognized/supported
     * @throws IllegalStateException if the aggregation result is unexpectedly null
     */
    @Throws(IllegalArgumentException::class, IllegalStateException::class)
    fun extractAggregateValue(
        result: AggregationResult,
        metric: AggregateMetric<*>,
    ): MeasurementUnitDto

    /**
     * Performs aggregation using native Health Connect SDK.
     *
     * @param request The aggregation request containing data type, metric, and time range
     * @return The aggregation response with the computed value
     * @throws IllegalArgumentException if [startTime] > [endTime]
     * @throws Exception that can be thrown by [HealthConnectClient.deleteRecords]
     */
    @Throws(
        IllegalArgumentException::class,
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto = process(
        operation = "aggregate",
        context = mapOf("request" to request),
    ) {
        require(request.startTime < request.endTime) {
            "Invalid time range: startTime must be before endTime"
        }

        val metric = toAggregateMetric(request)
        val aggregateRequest = AggregateRequest(
            metrics = setOf(metric),
            timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime),
                Instant.ofEpochMilli(request.endTime),
            ),
        )

        val result = client.aggregate(aggregateRequest)

        val valueDto = extractAggregateValue(result, metric)

        AggregateResponseDto(value = valueDto)
    }
}

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
            AggregateResponseDto(value = wrapAggregationResult(0.0))
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
