package com.phamtunglam.health_connector_hc_android.services

import android.content.pm.PackageManager
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.mapMetadata
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import java.util.concurrent.ConcurrentHashMap
import kotlinx.coroutines.currentCoroutineContext
import kotlinx.coroutines.ensureActive

/**
 * Adds available app labels to read results without changing source identifiers.
 *
 * Resolved labels are reused for the lifetime of this service. Unsuccessful
 * lookups stay local to the current response, so a later read can still resolve
 * a package that becomes visible.
 */
internal class HealthConnectorDataOriginService(private val packageManager: PackageManager) {

    private val displayNames = ConcurrentHashMap<String, String>()

    suspend fun withDisplayName(record: HealthRecordDto): HealthRecordDto =
        withDisplayNames(listOf(record)).single()

    suspend fun withDisplayNames(records: List<HealthRecordDto>): List<HealthRecordDto> {
        val names = mutableMapOf<String, String?>()
        val coroutineContext = currentCoroutineContext()
        return records.map { record ->
            coroutineContext.ensureActive()
            record.mapMetadata { metadata ->
                val packageName = metadata.dataOrigin
                if (!names.containsKey(packageName)) {
                    names[packageName] = displayNames[packageName]
                        ?: resolveDisplayName(packageName)?.also { displayNames[packageName] = it }
                }
                metadata.copy(dataOriginDisplayName = names[packageName])
            }
        }
    }

    private fun resolveDisplayName(packageName: String): String? {
        if (packageName.isBlank()) {
            return null
        }
        return try {
            val appInfo = packageManager.getApplicationInfo(packageName, 0)
            packageManager.getApplicationLabel(appInfo).toString().takeIf { it.isNotBlank() }
        } catch (_: PackageManager.NameNotFoundException) {
            // Uninstalled or invisible sources still have readable health records.
            null
        } catch (_: SecurityException) {
            // Label access is optional and must not fail the underlying health read.
            null
        }
    }
}
