package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import java.io.IOException
import java.time.Duration
import java.time.Instant

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

        val operation = "delete_records"
        val context = mapOf(
            "data_type" to dataType.name,
            "record_count" to recordIds.size,
        )

        process(
            operation = operation,
            context = context,
        ) {
            HealthConnectorLogger.debug(
                tag = tag,
                operation = operation,
                message = "Preparing to delete records by IDs",
                context = context,
            )

            client.deleteRecords(
                recordType = dataType.toHealthConnectRecordClass(),
                recordIdsList = recordIds,
                clientRecordIdsList = emptyList(),
            )

            HealthConnectorLogger.info(
                tag = tag,
                operation = operation,
                message = "Records deleted successfully",
                context = context,
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
        val operation = "delete_records_by_time_range"
        val querySpanDays = Duration.between(startTime, endTime).toDays()
        val context = mapOf(
            "data_type" to dataType.name,
            "query_span_days" to querySpanDays,
        )

        process(
            operation = operation,
            context = context,
        ) {
            HealthConnectorLogger.debug(
                tag = tag,
                operation = operation,
                message = "Preparing to delete records by time range",
                context = context,
            )

            require(startTime < endTime) {
                "Invalid time range: startTime must be before endTime"
            }

            client.deleteRecords(
                recordType = dataType.toHealthConnectRecordClass(),
                timeRangeFilter = TimeRangeFilter.between(startTime, endTime),
            )

            HealthConnectorLogger.info(
                tag = tag,
                operation = operation,
                message = "Records deleted successfully in time range",
                context = context,
            )
        }
    }
}
