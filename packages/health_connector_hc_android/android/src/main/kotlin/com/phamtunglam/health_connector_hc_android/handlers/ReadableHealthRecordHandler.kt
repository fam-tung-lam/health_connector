package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.metadata.DataOrigin
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.isAscending
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SortOrderDto
import java.io.IOException
import java.time.Duration
import java.time.Instant

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
    suspend fun readRecord(recordId: String): HealthRecordDto {
        val operation = "read_record"
        val context = mapOf(
            "data_type" to dataType.name,
        )

        return process(
            operation = operation,
            context = context,
        ) {
            HealthConnectorLogger.debug(
                tag = tag,
                operation = operation,
                message = "Preparing to read single record",
                context = context,
            )

            val response = client.readRecord(
                recordType = dataType.toHealthConnectRecordClass(),
                recordId = recordId,
            )

            val recordDto = response.record.toDto()

            HealthConnectorLogger.info(
                tag = tag,
                operation = operation,
                message = "Record retrieved successfully",
                context = context,
            )

            recordDto
        }
    }

    /**
     * Reads multiple records within a time range with pagination support.
     *
     * @param sortOrder Sort order for the query results
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
        sortOrder: SortOrderDto = SortOrderDto.TIME_ASCENDING,
    ): Pair<List<HealthRecordDto>, String?> {
        val operation = "read_records"
        val querySpanDays = Duration.between(startTime, endTime).toDays()
        val context = mapOf(
            "data_type" to dataType.name,
            "query_span_days" to querySpanDays,
            "page_size" to pageSize,
            "has_page_token" to (pageToken != null),
        )

        return process(
            operation = operation,
            context = context,
        ) {
            HealthConnectorLogger.debug(
                tag = tag,
                operation = operation,
                message = "Preparing to read records",
                context = context,
            )

            val request = ReadRecordsRequest(
                recordType = dataType.toHealthConnectRecordClass(),
                timeRangeFilter = TimeRangeFilter.between(startTime, endTime),
                ascendingOrder = sortOrder.isAscending(),
                pageSize = pageSize,
                pageToken = pageToken,
                dataOriginFilter = dataOrigins,
            )

            val response = client.readRecords(request)
            val records = response.records.map { record -> record.toDto() }

            HealthConnectorLogger.info(
                tag = tag,
                operation = operation,
                message = "Records retrieved successfully",
                context = context + mapOf(
                    "record_count" to records.size,
                    "has_more" to (response.pageToken != null),
                ),
            )

            Pair(records, response.pageToken)
        }
    }
}
