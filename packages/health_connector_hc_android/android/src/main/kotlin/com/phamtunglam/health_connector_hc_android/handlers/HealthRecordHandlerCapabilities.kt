package com.phamtunglam.health_connector_hc_android.handlers

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
 *
 * Each handler is responsible for:
 * - Type identification and categorization
 * - Bidirectional DTO ↔ Record conversion
 * - Implementing capability interfaces for supported operations
 *
 * Handlers are singletons that encapsulate all logic for a specific health data type.
 * The client property provides access to Health Connect SDK for implementing operations.
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
     * - [UnsupportedOperationException] -> [HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION]
     * - [IOException] -> [HealthConnectorErrorCodeDto.REMOTE_ERROR]
     *
     * @param operation Human-readable operation name for logging (e.g., "readRecord", "writeRecords")
     * @param context Additional context for logging (e.g., recordId, time range)
     * @param block The suspending operation to execute
     * @return The result of the block if successful
     * @throws HealthConnectorErrorDto with appropriate error code
     */
    suspend fun <T> process(
        operation: String,
        context: Map<String, Any>? = null,
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
        } catch (e: UnsupportedOperationException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "Unsupported operation while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                "Operation not supported for $dataType: ${e.message}",
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
         * Page size for record reading.
         * Can be overridden by implementations if different page sizes are needed.
         * Default is 1000 records per page.
         */
        const val DEFAULT_PAGE_SIZE: Int = 1000
    }

    /**
     * Reads a single record by ID.
     *
     * @param recordId The unique identifier of the record to read
     * @return The health record DTO
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if record ID invalid
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
    suspend fun readRecord(recordId: String): HealthRecordDto = process(
        operation = "readRecord",
        context = mapOf("recordId" to recordId),
    ) {
        val response = client.readRecord(
            recordType = dataType.toHealthConnectRecordClass(),
            recordId = recordId,
        )

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "readRecord",
            message = "$dataType record read from SDK",
            context = mapOf("recordId" to recordId),
        )

        response.record.toDto()
    }

    /**
     * Reads multiple records within a time range with pagination support.
     *
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if arguments invalid
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
    suspend fun readRecords(
        startTime: Instant,
        endTime: Instant,
        pageSize: Int = DEFAULT_PAGE_SIZE,
        pageToken: String? = null,
        dataOrigins: Set<DataOrigin> = emptySet(),
    ): Pair<List<HealthRecordDto>, String?> = process(
        operation = "readRecords",
        context = mapOf(
            "startTime" to startTime.toString(),
            "endTime" to endTime.toString(),
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

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "readRecords",
            message = "$dataType records read from SDK",
            context = mapOf("count" to dtos.size, "hasMore" to (response.pageToken != null)),
        )

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
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if record data invalid
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
    suspend fun writeRecord(dto: HealthRecordDto): String = process(
        operation = "writeRecord",
        context = mapOf("dto" to dto),
    ) {
        val record = dto.toHealthConnect()
        val response = client.insertRecords(listOf(record))

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "writeRecord",
            message = "$dataType record written to SDK",
            context = mapOf("recordId" to response.recordIdsList.first()),
        )

        response.recordIdsList.first()
    }

    /**
     * Writes multiple records atomically.
     *
     * @param dtos The list of health record DTOs to write
     * @return The list of platform-assigned record IDs
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if record data invalid
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
    suspend fun writeRecords(dtos: List<HealthRecordDto>): List<String> {
        if (dtos.isEmpty()) {
            return emptyList()
        }

        return process(
            operation = "writeRecords",
            context = mapOf("count" to dtos.size),
        ) {
            val records = dtos.map { it.toHealthConnect() }
            val response = client.insertRecords(records)

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "writeRecords",
                message = "$dataType records written to SDK",
                context = mapOf("recordCount" to records.size),
            )

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
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if record ID missing or invalid
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
    suspend fun updateRecord(dto: HealthRecordDto): String = process(
        operation = "updateRecord",
        context = mapOf("recordId" to (dto.id ?: "null")),
    ) {
        require(!dto.id.isNullOrEmpty()) {
            "Record ID must be provided for update operations. Use writeRecord() for new records."
        }

        val record = dto.toHealthConnect()
        client.updateRecords(listOf(record))

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "updateRecord",
            message = "$dataType record updated in SDK",
            context = mapOf("recordId" to dto.id),
        )

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
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if record IDs invalid
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
    suspend fun deleteRecords(recordIds: List<String>) {
        if (recordIds.isEmpty()) {
            HealthConnectorLogger.warning(
                tag = TAG,
                operation = "deleteRecords",
                message = "No records to delete (empty IDs list)",
            )
            return
        }

        process(
            operation = "deleteRecords",
            context = mapOf("recordIds" to recordIds),
        ) {
            client.deleteRecords(
                recordType = dataType.toHealthConnectRecordClass(),
                recordIdsList = recordIds,
                clientRecordIdsList = emptyList(),
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "deleteRecords",
                message = "$dataType records deleted from SDK",
                context = mapOf("recordIds" to recordIds),
            )
        }
    }

    /**
     * Deletes all records within a time range.
     *
     * @param startTime The start of the time range (epoch millis)
     * @param endTime The end of the time range (epoch millis)
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if time range invalid
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
    suspend fun deleteRecordsByTimeRange(startTime: Long, endTime: Long) {
        process(
            operation = "deleteRecordsByTimeRange",
            context = mapOf("startTime" to startTime, "endTime" to endTime),
        ) {
            val timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(startTime),
                Instant.ofEpochMilli(endTime),
            )

            client.deleteRecords(
                recordType = dataType.toHealthConnectRecordClass(),
                timeRangeFilter = timeRangeFilter,
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "deleteRecordsByTimeRange",
                message = "$dataType records deleted from SDK by time range",
                context = mapOf("startTime" to startTime, "endTime" to endTime),
            )
        }
    }
}

/**
 * Capability for handlers that support aggregation operations.
 *
 * This is a marker interface. Handlers should implement either:
 * - [HealthConnectAggregatableHealthRecordHandler] for native Health Connect aggregation
 * - [CustomAggregatableHealthRecordHandler] for custom manual aggregation
 */
internal interface AggregatableHealthRecordHandler : HealthRecordHandler

/**
 * Capability for handlers that support native Health Connect aggregation using [AggregateRequest].
 */
internal interface HealthConnectAggregatableHealthRecordHandler : AggregatableHealthRecordHandler {

    /**
     * Converts platform aggregation request to Health Connect metric.
     */
    fun toAggregateMetric(request: AggregateRequestDto): AggregateMetric<*>

    /**
     * Extracts aggregation result and converts to platform DTO.
     */
    fun extractAggregateValue(
        result: AggregationResult,
        metric: AggregateMetric<*>,
    ): MeasurementUnitDto

    /**
     * Performs aggregation using native Health Connect SDK.
     *
     * @param request The aggregation request containing data type, metric, and time range
     * @return The aggregation response with the computed value
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if time range invalid
     * @throws HealthConnectorErrorDto with code UNSUPPORTED_OPERATION if metric not supported
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
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

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "aggregate",
            message = "$dataType aggregated from SDK",
            context = mapOf(
                "metric" to request.aggregationMetric,
                "startTime" to request.startTime,
                "endTime" to request.endTime,
            ),
        )

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
     * @throws HealthConnectorErrorDto with code INVALID_ARGUMENT if time range invalid
     * @throws HealthConnectorErrorDto with code UNSUPPORTED_OPERATION if metric not supported
     * @throws HealthConnectorErrorDto with code NOT_AUTHORIZED if permission denied
     * @throws HealthConnectorErrorDto with code UNKNOWN for other errors
     */
    suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto {
        require(request.startTime < request.endTime) {
            "Invalid time range: startTime (${request.startTime}) must be less than endTime (${request.endTime})"
        }

        if (!supportedAggregationMetrics.contains(request.aggregationMetric)) {
            throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                "Aggregation metric ${request.aggregationMetric} not supported for $dataType. " +
                    "Supported metrics: $supportedAggregationMetrics",
            )
        }

        val aggregationResult = paginateAndAggregate(
            startTime = request.startTime,
            endTime = request.endTime,
        )

        if (aggregationResult.count == 0) {
            return AggregateResponseDto(value = wrapAggregationResult(0.0))
        }

        val resultValue = when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> aggregationResult.avg
            AggregationMetricDto.MIN -> aggregationResult.min
            AggregationMetricDto.MAX -> aggregationResult.max
            AggregationMetricDto.COUNT -> aggregationResult.count.toDouble()
            AggregationMetricDto.SUM -> aggregationResult.sum
        }

        return AggregateResponseDto(value = wrapAggregationResult(resultValue))
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
