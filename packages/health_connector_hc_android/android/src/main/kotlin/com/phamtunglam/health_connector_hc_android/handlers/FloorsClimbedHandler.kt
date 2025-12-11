package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.FloorsClimbedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.reflect.KClass

/**
 * Handler for Floors Climbed health data type.
 *
 * Characteristics:
 * - Category: Interval record (startTime + endTime)
 * - Aggregation: Supports SUM only
 * - Health Connect Type: FloorsClimbedRecord
 */
object FloorsClimbedHandler : IntervalRecordHandler, AggregationSupportingHandler<CommonAggregateRequestDto> {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.FLOORS_CLIMBED

    override fun toDto(record: Record): HealthRecordDto {
        require(record is FloorsClimbedRecord) {
            "Expected FloorsClimbedRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is FloorsClimbedRecordDto) {
            "Expected FloorsClimbedRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = FloorsClimbedRecord::class

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> FloorsClimbedRecord.FLOORS_CLIMBED_TOTAL
            AggregationMetricDto.AVG, AggregationMetricDto.MIN, AggregationMetricDto.MAX, AggregationMetricDto.COUNT ->
                throw UnsupportedOperationException(
                    "Aggregation metric ${request.aggregationMetric} for FloorsClimbed. Supported: SUM"
                )
        }

    override fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>
    ): MeasurementUnitDto {
        val floors = aggregationResult[aggregateMetric] as? Double
            ?: throw IllegalStateException("Aggregation result for $aggregateMetric is null")
        return floors.toNumericDto()
    }
}
