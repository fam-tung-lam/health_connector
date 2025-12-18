package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import java.io.IOException
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
