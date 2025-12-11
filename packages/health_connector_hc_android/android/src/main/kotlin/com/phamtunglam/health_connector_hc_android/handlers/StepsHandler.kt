package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.StepsRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
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
internal object StepsHandler :
    IntervalRecordHandler,
    AggregationSupportingHandler<CommonAggregateRequestDto> {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.STEPS

    override fun toDto(record: Record): HealthRecordDto {
        require(record is StepsRecord) {
            "Expected StepsRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is StepRecordDto) {
            "Expected StepRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = StepsRecord::class

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> StepsRecord.COUNT_TOTAL
            AggregationMetricDto.AVG,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX,
            AggregationMetricDto.COUNT,
            ->
                throw UnsupportedOperationException(
                    "Aggregation metric ${request.aggregationMetric} " +
                        "is not supported for steps (cumulative data). " +
                        "Only SUM is supported.",
                )
        }

    override fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>,
    ): MeasurementUnitDto {
        val count = aggregationResult[aggregateMetric] as? Long
            ?: error("Aggregation result for $aggregateMetric is null")
        return count.toNumericDto()
    }
}
