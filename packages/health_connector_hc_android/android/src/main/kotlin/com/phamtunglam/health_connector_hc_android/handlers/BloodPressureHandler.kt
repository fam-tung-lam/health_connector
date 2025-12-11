package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureHealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.reflect.KClass

/**
 * Handler for composite Blood Pressure health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Not supported (use Systolic/Diastolic handlers for aggregation)
 * - Health Connect Type: BloodPressureRecord
 */
internal object BloodPressureHandler :
    InstantRecordHandler,
    AggregationSupportingHandler<BloodPressureAggregateRequestDto> {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.BLOOD_PRESSURE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is BloodPressureRecord) {
            "Expected BloodPressureRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is BloodPressureRecordDto) {
            "Expected BloodPressureRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = BloodPressureRecord::class

    override fun toAggregateMetric(request: BloodPressureAggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
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

            AggregationMetricDto.COUNT, AggregationMetricDto.SUM ->
                throw UnsupportedOperationException(
                    "Aggregation metric ${request.aggregationMetric} is not supported for blood pressure (discrete data). Supported metrics: AVG, MIN, MAX.",
                )
        }

    override fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>,
    ): MeasurementUnitDto {
        val pressure = aggregationResult[aggregateMetric] as? Pressure
            ?: throw IllegalStateException("Aggregation result for $aggregateMetric is null")
        return pressure.toDto()
    }
}
