package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.mappers.toDiastolicDto
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.DiastolicBloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.PressureDto
import com.phamtunglam.health_connector_hc_android.pigeon.PressureUnitDto
import kotlin.reflect.KClass

/**
 * Handler for Diastolic Blood Pressure health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX (using BloodPressureRecord.DIASTOLIC_* metrics)
 * - Health Connect Type: BloodPressureRecord (with systolic set to 0)
 * - Note: Writes create a BloodPressureRecord with systolic=0
 */
object DiastolicBloodPressureHandler : InstantRecordHandler, AggregationSupportingHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.DIASTOLIC_BLOOD_PRESSURE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is BloodPressureRecord) {
            "Expected BloodPressureRecord, got ${record::class.simpleName}"
        }
        return record.toDiastolicDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is DiastolicBloodPressureRecordDto) {
            "Expected DiastolicBloodPressureRecordDto, got ${dto::class.simpleName}"
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
            AggregationMetricDto.AVG -> BloodPressureRecord.DIASTOLIC_AVG
            AggregationMetricDto.MIN -> BloodPressureRecord.DIASTOLIC_MIN
            AggregationMetricDto.MAX -> BloodPressureRecord.DIASTOLIC_MAX
            else -> error("Unsupported aggregation metric $metric for DiastolicBloodPressure. Supported: AVG, MIN, MAX")
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
