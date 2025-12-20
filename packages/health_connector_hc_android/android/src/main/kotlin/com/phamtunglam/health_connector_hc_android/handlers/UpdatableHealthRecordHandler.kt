package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import com.phamtunglam.health_connector_hc_android.HealthConnectorClient
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.id
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import java.io.IOException

/**
 * Capability for handlers that support updating records in Health Connect.
 *
 * Batch update operations are handled atomically at the [HealthConnectorClient]
 * level to ensure all-or-nothing semantics across different record types.
 *
 * ## Update Semantics
 *
 * Health Connect's `updateRecords()` API modifies existing records by their Health Connect-assigned UUID.
 * This differs from an "upsert" pattern - updates require the exact record ID and will fail if the record
 * doesn't exist.
 *
 * ## Alternative: Upsert Pattern
 * If you don't have a record ID but want to avoid duplicates, consider using Health Connect's upsert
 * pattern with `clientRecordId` and `clientRecordVersion` via `insertRecords()`. See Health Connect
 * documentation for details.
 */
internal interface UpdatableHealthRecordHandler : HealthRecordHandler {
    /**
     * Updates a single health record in Health Connect.
     *
     * @param dto The health record DTO to update. Must contain a valid `id` field with the
     *            Health Connect-assigned UUID of an existing record.
     * @throws IllegalArgumentException if [HealthRecordDto.id] is null or empty
     * @throws SecurityException if the app lacks WRITE permission for this data type
     * @throws RemoteException if Health Connect service is unavailable
     * @throws IOException for network/system-level errors
     * @throws Exception for other Health Connect-specific errors (e.g., record not found)
     */
    @Throws(
        IllegalArgumentException::class,
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun updateRecord(dto: HealthRecordDto) = process(
        operation = "update_record",
        context = mapOf("record_id" to dto.id),
    ) {
        require(!dto.id.isNullOrEmpty()) {
            "Record ID must be provided for update operations. Use `writeRecord()` for new records."
        }

        val record = dto.toHealthConnect()

        client.updateRecords(listOf(record))
    }
}
