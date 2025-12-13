package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.RestingHeartRateRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.NumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.NumericUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.RestingHeartRateRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Resting Heart Rate health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX
 * - Health Connect Type: RestingHeartRateRecord
 */
internal object RestingHeartRateHandler :
    InstantRecordHandler,
    AggregationSupportingHandler<CommonAggregateRequestDto> {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.RESTING_HEART_RATE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is RestingHeartRateRecord) {
            "Expected RestingHeartRateRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is RestingHeartRateRecordDto) {
            "Expected RestingHeartRateRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = RestingHeartRateRecord::class

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> RestingHeartRateRecord.BPM_AVG
            AggregationMetricDto.MIN -> RestingHeartRateRecord.BPM_MIN
            AggregationMetricDto.MAX -> RestingHeartRateRecord.BPM_MAX
            AggregationMetricDto.SUM, AggregationMetricDto.COUNT ->
                throw UnsupportedOperationException(
                    "Aggregation metric ${request.aggregationMetric} for RestingHeartRate. " +
                        "Supported: AVG, MIN, MAX",
                )
        }

    override fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>,
    ): MeasurementUnitDto {
        val bpm = aggregationResult[aggregateMetric] as? Long
            ?: error("Aggregation result for $aggregateMetric is null")
        return NumericDto(value = bpm.toDouble(), unit = NumericUnitDto.NUMERIC)
    }
}
