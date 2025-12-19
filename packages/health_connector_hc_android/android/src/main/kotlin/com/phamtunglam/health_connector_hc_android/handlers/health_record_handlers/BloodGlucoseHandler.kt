package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.handlers.CustomAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto

/**
 * Handler for Blood Glucose records.
 *
 * This handler leverages the default paginated aggregation implementation from
 * [CustomAggregatableHealthRecordHandler], requiring only value extraction and result wrapping logic.
 */
internal class BloodGlucoseHandler(override val client: HealthConnectClient) :
    CustomAggregatableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.BLOOD_GLUCOSE

    override val supportedAggregationMetrics: Set<AggregationMetricDto>
        get() = setOf(
            AggregationMetricDto.AVG,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX,
        )

    override fun extractValueForAggregation(recordDto: HealthRecordDto): Double {
        if (recordDto !is BloodGlucoseRecordDto) {
            throw IllegalArgumentException(
                "Expected ${BloodGlucoseRecordDto::class.simpleName} but received: " +
                    "${recordDto::class.simpleName}",
            )
        }

        return recordDto.bloodGlucose.value
    }

    override fun wrapAggregationResult(value: Double): MeasurementUnitDto = BloodGlucoseDto(
        BloodGlucoseUnitDto.MILLIGRAMS_PER_DECILITER,
        value,
    )
}
