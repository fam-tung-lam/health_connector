package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.StepsRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Steps health data type.
 *
 * Characteristics:
 * - Category: Interval record (startTime + endTime)
 * - Aggregation: Supports SUM only
 * - Health Connect Type: StepsRecord
 */
object StepsHandler : IntervalRecordHandler, AggregationSupportingHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.STEPS

    override fun toDto(record: Record): HealthRecordDto? {
        return (record as? StepsRecord)?.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is StepRecordDto) {
            "Expected StepRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = StepsRecord::class

    override fun supportedAggregations(): List<AggregationMetricDto> {
        return listOf(AggregationMetricDto.SUM)
    }

    override fun toAggregateMetric(metric: AggregationMetricDto): AggregateMetric<*> {
        return when (metric) {
            AggregationMetricDto.SUM -> StepsRecord.COUNT_TOTAL
            else -> error("Unsupported aggregation metric $metric for Steps. Supported: SUM")
        }
    }

    override fun extractAggregateValue(
        aggregatedValue: Any?,
        metric: AggregationMetricDto
    ): MeasurementUnitDto {
        val count = (aggregatedValue as? Long) ?: 0L
        return count.toNumericDto()
    }
}
