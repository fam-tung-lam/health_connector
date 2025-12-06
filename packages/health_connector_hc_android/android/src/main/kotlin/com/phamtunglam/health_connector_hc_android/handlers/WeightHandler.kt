package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.WeightRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Weight health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX
 * - Health Connect Type: WeightRecord
 */
object WeightHandler : InstantRecordHandler, AggregationSupportingHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.WEIGHT

    override fun toDto(record: Record): HealthRecordDto {
        require(record is WeightRecord) {
            "Expected WeightRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is WeightRecordDto) {
            "Expected WeightRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = WeightRecord::class

    override fun supportedAggregations(): List<AggregationMetricDto> {
        return listOf(
            AggregationMetricDto.AVG,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX
        )
    }

    override fun toAggregateMetric(metric: AggregationMetricDto): AggregateMetric<*> {
        return when (metric) {
            AggregationMetricDto.AVG -> WeightRecord.WEIGHT_AVG
            AggregationMetricDto.MIN -> WeightRecord.WEIGHT_MIN
            AggregationMetricDto.MAX -> WeightRecord.WEIGHT_MAX
            else -> error("Unsupported aggregation metric $metric for Weight. Supported: AVG, MIN, MAX")
        }
    }

    override fun extractAggregateValue(
        aggregatedValue: Any?,
        metric: AggregationMetricDto
    ): MeasurementUnitDto {
        val mass = aggregatedValue as? Mass
        return mass?.toDto() ?: MassDto(value = 0.0, unit = MassUnitDto.KILOGRAMS)
    }
}
