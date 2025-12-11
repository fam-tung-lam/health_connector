package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.reflect.KClass

/**
 * Handler for Distance health data type.
 *
 * Characteristics:
 * - Category: Interval record (startTime + endTime)
 * - Aggregation: Supports SUM only
 * - Health Connect Type: DistanceRecord
 */
internal object DistanceHandler :
    IntervalRecordHandler,
    AggregationSupportingHandler<CommonAggregateRequestDto> {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.DISTANCE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is DistanceRecord) {
            "Expected DistanceRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is DistanceRecordDto) {
            "Expected DistanceRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = DistanceRecord::class

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> DistanceRecord.DISTANCE_TOTAL
            AggregationMetricDto.AVG,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX,
            AggregationMetricDto.COUNT,
            ->
                throw UnsupportedOperationException(
                    "Aggregation metric ${request.aggregationMetric} for Distance. Supported: SUM",
                )
        }

    override fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>,
    ): MeasurementUnitDto {
        val distance = aggregationResult[aggregateMetric] as? Length
            ?: throw IllegalStateException("Aggregation result for $aggregateMetric is null")
        return distance.toDto()
    }
}
