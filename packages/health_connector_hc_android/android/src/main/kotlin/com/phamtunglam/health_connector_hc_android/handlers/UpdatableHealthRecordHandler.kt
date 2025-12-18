package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.id
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import java.io.IOException

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
