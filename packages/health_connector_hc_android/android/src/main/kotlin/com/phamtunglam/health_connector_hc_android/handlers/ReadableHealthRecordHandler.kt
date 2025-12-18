package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.metadata.DataOrigin
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import java.io.IOException
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
