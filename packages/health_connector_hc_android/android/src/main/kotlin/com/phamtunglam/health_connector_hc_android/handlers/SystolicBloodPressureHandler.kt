package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toSystolicDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.PressureDto
import com.phamtunglam.health_connector_hc_android.pigeon.PressureUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.SystolicBloodPressureRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Systolic Blood Pressure health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX (using BloodPressureRecord.SYSTOLIC_* metrics)
 * - Health Connect Type: BloodPressureRecord (with diastolic set to 0)
 * - Note: Writes create a BloodPressureRecord with diastolic=0
 */
object SystolicBloodPressureHandler : InstantRecordHandler, AggregationSupportingHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.SYSTOLIC_BLOOD_PRESSURE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is BloodPressureRecord) {
            "Expected BloodPressureRecord, got ${record::class.simpleName}"
        }
        return record.toSystolicDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is SystolicBloodPressureRecordDto) {
            "Expected SystolicBloodPressureRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = BloodPressureRecord::class

    override fun supportedAggregations(): List<AggregationMetricDto> {
        return listOf(
            AggregationMetricDto.AVG,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX
        )
    }

    override fun toAggregateMetric(metric: AggregationMetricDto): AggregateMetric<*> {
        return when (metric) {
            AggregationMetricDto.AVG -> BloodPressureRecord.SYSTOLIC_AVG
            AggregationMetricDto.MIN -> BloodPressureRecord.SYSTOLIC_MIN
            AggregationMetricDto.MAX -> BloodPressureRecord.SYSTOLIC_MAX
            else -> error("Unsupported aggregation metric $metric for SystolicBloodPressure. Supported: AVG, MIN, MAX")
        }
    }

    override fun extractAggregateValue(
        aggregatedValue: Any?,
        metric: AggregationMetricDto
    ): MeasurementUnitDto {
        val pressure = aggregatedValue as? Pressure
        return pressure?.toDto() ?: PressureDto(value = 0.0, unit = PressureUnitDto.MILLIMETERS_OF_MERCURY)
    }
}
