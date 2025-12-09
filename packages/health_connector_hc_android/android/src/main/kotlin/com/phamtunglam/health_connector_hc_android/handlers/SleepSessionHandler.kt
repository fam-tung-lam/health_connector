package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.SleepSessionRecord
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
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

    override fun supportedAggregations(): List<AggregationMetricDto> {
        return listOf(AggregationMetricDto.SUM)
    }

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> {
        return when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> SleepSessionRecord.SLEEP_DURATION_TOTAL
            else -> error("Unsupported aggregation metric ${request.aggregationMetric} for SleepSession. Supported: SUM")
        }
    }

    override fun extractAggregateValue(
        aggregatedValue: Any?,
        metric: AggregationMetricDto
    ): MeasurementUnitDto {
        // Sleep duration is returned as java.time.Duration, convert to seconds
        val duration = aggregatedValue as? Duration
        val seconds = duration?.seconds?.toDouble() ?: 0.0
        return seconds.toNumericDto()
    }
}
