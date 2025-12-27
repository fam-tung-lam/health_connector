package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.feature.ExperimentalMindfulnessSessionApi
import androidx.health.connect.client.records.MindfulnessSessionRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.time.Duration
import kotlin.time.toKotlinDuration

/**
 * Handler for Mindfulness Session records.
 *
 * Maps to Android Health Connect MindfulnessSessionRecord which includes
 * session type (meditation, breathing, music, movement, unguided).
 *
 * Note: iOS HealthKit has limited support - only generic HKCategoryTypeIdentifier.mindfulSession.
 * Session types are stored in custom metadata when writing to HealthKit.
 */
@OptIn(ExperimentalMindfulnessSessionApi::class)
internal class MindfulnessSessionHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.MINDFULNESS_SESSION

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to MindfulnessSessionRecord.MINDFULNESS_DURATION_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto {
        // Health Connect returns java.time.Duration, so we need to cast to that type
        // and convert it to kotlin.time.Duration before calling toDto()
        val javaDuration = aggregatedValue as? java.time.Duration
            ?: throw IllegalArgumentException(
                "Aggregated value is not java.time.Duration type: ${aggregatedValue::class.qualifiedName}",
            )
        val kotlinDuration = javaDuration.toKotlinDuration()
        return kotlinDuration.toDto()
    }
}
