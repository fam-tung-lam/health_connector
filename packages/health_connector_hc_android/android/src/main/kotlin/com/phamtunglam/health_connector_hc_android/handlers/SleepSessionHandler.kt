package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.SleepSessionRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import java.time.Duration
import kotlin.reflect.KClass

/**
 * Handler for Sleep Session health data type.
 *
 * Characteristics:
 * - Category: Session record (extended interval with stages)
 * - Aggregation: Supports SUM only (duration)
 * - Health Connect Type: SleepSessionRecord
 */
object SleepSessionHandler : SessionRecordHandler, AggregationSupportingHandler<CommonAggregateRequestDto> {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.SLEEP_SESSION

    override fun toDto(record: Record): HealthRecordDto {
        require(record is SleepSessionRecord) {
            "Expected SleepSessionRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is SleepSessionRecordDto) {
            "Expected SleepSessionRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = SleepSessionRecord::class

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> SleepSessionRecord.SLEEP_DURATION_TOTAL
            AggregationMetricDto.AVG, AggregationMetricDto.MIN, AggregationMetricDto.MAX, AggregationMetricDto.COUNT ->
                throw UnsupportedOperationException(
                    "Aggregation metric ${request.aggregationMetric} is not supported for sleep session (cumulative sum). Only SUM is supported."
                )
        }

    override fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>
    ): MeasurementUnitDto {
        // Sleep duration is returned as java.time.Duration, convert to seconds
        val duration = aggregationResult[aggregateMetric] as? Duration
            ?: throw IllegalStateException("Aggregation result for $aggregateMetric is null")
        val seconds = duration.seconds.toDouble()
        return seconds.toNumericDto()
    }
}
