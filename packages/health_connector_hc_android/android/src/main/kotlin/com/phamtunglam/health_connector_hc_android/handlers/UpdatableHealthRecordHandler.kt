package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.id
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import java.io.IOException

/**
 * Capability for handlers that support updating records in Health Connect.
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

    /**
     * Updates multiple health records atomically in Health Connect.
     *
     * This batch operation leverages Health Connect's native atomic batch update capability,
     * meaning either **all** records update successfully, or **none** do. This ensures data
     * consistency even if there's an interruption mid-operation.
     *
     * ### Requirements
     * - All records in the batch must be of the same data type (handled by client validation)
     * - Every record must have a valid, non-null `id` field
     * - All IDs must correspond to existing records in Health Connect
     *
     * ### Atomicity Guarantee
     * If the batch contains 10 records and record #7 has an invalid ID, the entire operation
     * fails and **no records are updated** - not even the first 6. This all-or-nothing behavior
     * prevents partial updates that could leave data in an inconsistent state.
     *
     * @param dtos List of health record DTOs to update. All must be the same data type and
     *             contain valid `id` fields.
     * @throws IllegalArgumentException if any record has a null or empty `id`
     * @throws SecurityException if the app lacks WRITE permission
     * @throws RemoteException if Health Connect service is unavailable
     * @throws IOException for network/system-level errors
     * @throws Exception for other Health Connect errors (e.g., record not found, validation errors)
     */
    @Throws(
        IllegalArgumentException::class,
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    suspend fun updateRecords(dtos: List<HealthRecordDto>) = process(
        operation = "update_records",
        context = mapOf("record_count" to dtos.size),
    ) {
        val invalidRecords = dtos.filter { it.id.isNullOrEmpty() }
        require(invalidRecords.isEmpty()) {
            "All records must have IDs for update operations. " +
                "Found ${invalidRecords.size} record(s) without IDs."
        }

        val records = dtos.map { it.toHealthConnect() }
        client.updateRecords(records)
    }
}
