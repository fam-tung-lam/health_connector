package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import com.phamtunglam.health_connector_hc_android.HealthConnectorClient
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import java.io.IOException

/**
 * Capability protocol for handlers that support writing health records to Health Connect.
 *
 * This interface provides a default implementation for writing individual health records.
 * Batch write operations are handled atomically at the [HealthConnectorClient]
 * level to ensure all-or-nothing semantics across different record types.
 */
internal interface WritableHealthRecordHandler : HealthRecordHandler {
    /**
     * Writes a single health record to Health Connect.
     *
     * This method converts the DTO to a Health Connect record and inserts it atomically.
     *
     * @param dto The health record DTO to write
     * @return The platform-assigned record ID string
     *
     * @throws RemoteException if the Health Connect service is unreachable
     * @throws SecurityException if write permission is not granted
     * @throws IOException if a network or storage error occurs
     */
    @Throws(
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun writeRecord(dto: HealthRecordDto): String {
        val operation = "write_record"
        val context = mapOf("data_type" to dataType.name)

        return process(
            operation = operation,
            context = context,
        ) {
            HealthConnectorLogger.debug(
                tag = tag,
                operation = operation,
                message = "Preparing to write record",
                context = context,
            )

            val record = dto.toHealthConnect()

            val response = client.insertRecords(listOf(record))

            val recordId = response.recordIdsList.first()

            HealthConnectorLogger.info(
                tag = tag,
                operation = operation,
                message = "Record written successfully",
                context = context,
            )

            recordId
        }
    }
}
