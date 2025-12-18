package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import java.io.IOException

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
