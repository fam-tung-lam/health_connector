package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.ExerciseSessionRecord
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for Exercise Session records.
 */
internal class ExerciseSessionHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.EXERCISE_SESSION

    override val tag = "ExerciseSessionHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to ExerciseSessionRecord.EXERCISE_DURATION_TOTAL,
    )

    /**
     * Aggregates active energy in the saved exercise session's time range and data origin.
     *
     * Health Connect does not link calorie records to exercise sessions. Other active energy
     * from the same source during this interval may therefore be included.
     *
     * @return The total active energy in kilocalories.
     * @throws HealthConnectorException.NoData when no active energy is found.
     * @throws HealthConnectorException.InvalidArgument when the exercise session does not exist.
     * @throws HealthConnectorException.Authorization when either required read permission is denied.
     */
    suspend fun aggregateActiveEnergy(exerciseSessionId: String): Double = process(
        operation = "aggregate_active_energy",
    ) {
        require(exerciseSessionId.isNotBlank()) {
            "Exercise session ID must not be blank"
        }

        val exerciseSession = try {
            client.readRecord(ExerciseSessionRecord::class, exerciseSessionId).record
        } catch (exception: SecurityException) {
            throw HealthConnectorException.Authorization(
                code = HealthConnectorErrorCodeDto.PERMISSION_NOT_GRANTED,
                message = "Permission not granted to read exercise sessions " +
                    "(${HealthPermission.getReadPermission(ExerciseSessionRecord::class)})",
                cause = exception,
            )
        } catch (exception: RemoteException) {
            when (exception.message) {
                "No records" -> throw HealthConnectorException.InvalidArgument(
                    message = "Exercise session does not exist",
                    cause = exception,
                )
                else -> throw exception
            }
        }

        val result = try {
            client.aggregate(
                AggregateRequest(
                    metrics = setOf(ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL),
                    timeRangeFilter = TimeRangeFilter.between(
                        exerciseSession.startTime,
                        exerciseSession.endTime,
                    ),
                    dataOriginFilter = setOf(exerciseSession.metadata.dataOrigin),
                ),
            )
        } catch (exception: SecurityException) {
            throw HealthConnectorException.Authorization(
                code = HealthConnectorErrorCodeDto.PERMISSION_NOT_GRANTED,
                message = "Permission not granted to read active calories burned " +
                    "(${HealthPermission.getReadPermission(ActiveCaloriesBurnedRecord::class)})",
                cause = exception,
            )
        }

        result[ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL]?.inKilocalories
            ?: throw HealthConnectorException.NoData()
    }

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val javaDuration = aggregatedValue as? java.time.Duration
            ?: throw IllegalArgumentException(
                "Aggregated value is not java.time.Duration type: " +
                    "${aggregatedValue::class.qualifiedName}",
            )
        return javaDuration.toSeconds().toDouble()
    }
}
