package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ActiveCaloriesBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.reflect.KClass

/**
 * Handler for Active Calories Burned health data type.
 *
 * Characteristics:
 * - Category: Interval record (startTime + endTime)
 * - Aggregation: Supports SUM only
 * - Health Connect Type: ActiveCaloriesBurnedRecord
 */
object ActiveCaloriesBurnedHandler : IntervalRecordHandler, AggregationSupportingHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.ACTIVE_CALORIES_BURNED

    override fun toDto(record: Record): HealthRecordDto {
        require(record is ActiveCaloriesBurnedRecord) {
            "Expected ActiveCaloriesBurnedRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is ActiveCaloriesBurnedRecordDto) {
            "Expected ActiveCaloriesBurnedRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = ActiveCaloriesBurnedRecord::class

    override fun supportedAggregations(): List<AggregationMetricDto> {
        return listOf(AggregationMetricDto.SUM)
    }

    override fun toAggregateMetric(metric: AggregationMetricDto): AggregateMetric<*> {
        return when (metric) {
            AggregationMetricDto.SUM -> ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL
            else -> error("Unsupported aggregation metric $metric for ActiveCaloriesBurned. Supported: SUM")
        }
    }

    override fun extractAggregateValue(
        aggregatedValue: Any?,
        metric: AggregationMetricDto
    ): MeasurementUnitDto {
        val energy = aggregatedValue as? Energy
        return energy?.toDto() ?: EnergyDto(value = 0.0, unit = EnergyUnitDto.KILOCALORIES)
    }
}
