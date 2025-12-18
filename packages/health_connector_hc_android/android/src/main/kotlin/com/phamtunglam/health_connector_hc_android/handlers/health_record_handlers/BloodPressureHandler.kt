package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureHealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto

/**
 * Handler for composite Blood Pressure health data type.
 */
internal class BloodPressureHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.BLOOD_PRESSURE

    override fun toAggregateMetric(request: AggregateRequestDto): AggregateMetric<*> {
        // Safe cast because the Pigeon API ensures this type for Blood Pressure
        if (request !is BloodPressureAggregateRequestDto) {
            throw IllegalArgumentException(
                "Expected BloodPressureAggregateRequestDto for BloodPressureHandler",
            )
        }

        return when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> {
                when (request.bloodPressureDataType) {
                    BloodPressureHealthDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_AVG
                    BloodPressureHealthDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_AVG
                }
            }

            AggregationMetricDto.MAX -> {
                when (request.bloodPressureDataType) {
                    BloodPressureHealthDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_MAX
                    BloodPressureHealthDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_MAX
                }
            }

            AggregationMetricDto.MIN -> {
                when (request.bloodPressureDataType) {
                    BloodPressureHealthDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_MIN
                    BloodPressureHealthDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_MIN
                }
            }

            else -> throw IllegalArgumentException(
                "Aggregation metric ${request.aggregationMetric} is not supported for blood pressure",
            )
        }
    }

    override fun extractAggregateValue(
        result: AggregationResult,
        metric: AggregateMetric<*>,
    ): MeasurementUnitDto {
        val pressure = result[metric] as? Pressure
            ?: error("Aggregation result for $metric is null")
        return pressure.toDto()
    }
}
