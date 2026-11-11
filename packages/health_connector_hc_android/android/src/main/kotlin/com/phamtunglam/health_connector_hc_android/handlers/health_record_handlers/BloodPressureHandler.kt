package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for composite Blood Pressure health data type.
 */
internal class BloodPressureHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.BLOOD_PRESSURE

    override val tag = "BloodPressureHandler"

    override fun getAggregateMetric(request: AggregateRequestDto): AggregateMetric<*> {
        require(request is BloodPressureAggregateRequestDto) {
            "Expected BloodPressureAggregateRequestDto for BloodPressureHandler"
        }
        return getAggregateMetric(request.aggregationMetric, request.bloodPressureDataType)
    }

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val pressure = aggregatedValue as? Pressure ?: throw IllegalArgumentException(
            "Expected Pressure",
        )
        return pressure.inMillimetersOfMercury
    }

    private fun getAggregateMetric(
        metric: AggregationMetricDto,
        dataType: BloodPressureDataTypeDto,
    ): AggregateMetric<Pressure> = when (metric) {
        AggregationMetricDto.AVG -> {
            when (dataType) {
                BloodPressureDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_AVG
                BloodPressureDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_AVG
            }
        }

        AggregationMetricDto.MAX -> {
            when (dataType) {
                BloodPressureDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_MAX
                BloodPressureDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_MAX
            }
        }

        AggregationMetricDto.MIN -> {
            when (dataType) {
                BloodPressureDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_MIN
                BloodPressureDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_MIN
            }
        }

        else -> throw IllegalArgumentException(
            "Aggregation metric $metric is not supported for blood pressure",
        )
    }
}
