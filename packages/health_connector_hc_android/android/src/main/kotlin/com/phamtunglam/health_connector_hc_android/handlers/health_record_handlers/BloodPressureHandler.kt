package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.handlers.AggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureHealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import java.time.Instant

/**
 * Handler for composite Blood Pressure health data type.
 */
internal class BloodPressureHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.BLOOD_PRESSURE

    override suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto = process(
        operation = "aggregate",
        context = mapOf("request" to request),
    ) {
        if (request !is BloodPressureAggregateRequestDto) {
            throw IllegalArgumentException(
                "Expected BloodPressureAggregateRequestDto for BloodPressureHandler",
            )
        }

        require(request.startTime < request.endTime) {
            "Invalid time range: startTime must be before endTime"
        }

        val metric = getAggregateMetric(request.aggregationMetric, request.bloodPressureDataType)
        val aggregateRequest = AggregateRequest(
            metrics = setOf(metric),
            timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime),
                Instant.ofEpochMilli(request.endTime),
            ),
        )

        val result = client.aggregate(aggregateRequest)

        val valueDto = result[metric]?.toDto() ?: error("Aggregation result for $metric is null")

        AggregateResponseDto(value = valueDto)
    }

    private fun getAggregateMetric(
        metric: AggregationMetricDto,
        dataType: BloodPressureHealthDataTypeDto,
    ): AggregateMetric<Pressure> = when (metric) {
        AggregationMetricDto.AVG -> {
            when (dataType) {
                BloodPressureHealthDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_AVG
                BloodPressureHealthDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_AVG
            }
        }

        AggregationMetricDto.MAX -> {
            when (dataType) {
                BloodPressureHealthDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_MAX
                BloodPressureHealthDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_MAX
            }
        }

        AggregationMetricDto.MIN -> {
            when (dataType) {
                BloodPressureHealthDataTypeDto.DIASTOLIC -> BloodPressureRecord.DIASTOLIC_MIN
                BloodPressureHealthDataTypeDto.SYSTOLIC -> BloodPressureRecord.SYSTOLIC_MIN
            }
        }

        else -> throw IllegalArgumentException(
            "Aggregation metric $metric is not supported for blood pressure",
        )
    }
}
