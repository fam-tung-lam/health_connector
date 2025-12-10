package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
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
import com.phamtunglam.health_connector_hc_android.pigeon.PressureDto
import com.phamtunglam.health_connector_hc_android.pigeon.PressureUnitDto
import kotlin.reflect.KClass

/**
 * Handler for composite Blood Pressure health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Not supported (use Systolic/Diastolic handlers for aggregation)
 * - Health Connect Type: BloodPressureRecord
 */
object BloodPressureHandler : InstantRecordHandler, AggregationSupportingHandler<BloodPressureAggregateRequestDto> {
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

    override fun supportedAggregations(): List<AggregationMetricDto> {
        return listOf(
            AggregationMetricDto.AVG,
            AggregationMetricDto.MAX,
            AggregationMetricDto.MIN,
        )
    }

    override fun toAggregateMetric(request: BloodPressureAggregateRequestDto): AggregateMetric<*> {
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

            AggregationMetricDto.COUNT, AggregationMetricDto.SUM -> throw IllegalArgumentException()
        }
    }

    override fun extractAggregateValue(
        aggregatedValue: Any?, metric: AggregationMetricDto
    ): MeasurementUnitDto {
        val pressure = aggregatedValue as? Pressure
        return pressure?.toDto() ?: PressureDto(value = 0.0, unit = PressureUnitDto.MILLIMETERS_OF_MERCURY)
    }
}
