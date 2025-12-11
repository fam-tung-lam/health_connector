package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
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
object WeightHandler : InstantRecordHandler, AggregationSupportingHandler<CommonAggregateRequestDto> {
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

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> WeightRecord.WEIGHT_AVG
            AggregationMetricDto.MIN -> WeightRecord.WEIGHT_MIN
            AggregationMetricDto.MAX -> WeightRecord.WEIGHT_MAX
            AggregationMetricDto.SUM, AggregationMetricDto.COUNT ->
                throw UnsupportedOperationException(
                    "Aggregation metric ${request.aggregationMetric} for Weight. Supported: AVG, MIN, MAX"
                )
        }

    override fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>
    ): MeasurementUnitDto {
        val mass = aggregationResult[aggregateMetric] as? Mass
            ?: throw IllegalStateException("Aggregation result for $aggregateMetric is null")
        return mass.toDto()
    }
}
