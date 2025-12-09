package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeDto
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeUnitDto
import kotlin.reflect.KClass

/**
 * Handler for Hydration health data type.
 *
 * Characteristics:
 * - Category: Interval record (startTime + endTime)
 * - Aggregation: Supports SUM only
 * - Health Connect Type: HydrationRecord
 */
object HydrationHandler : IntervalRecordHandler, AggregationSupportingHandler<CommonAggregateRequestDto> {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.HYDRATION

    override fun toDto(record: Record): HealthRecordDto {
        require(record is HydrationRecord) {
            "Expected HydrationRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is HydrationRecordDto) {
            "Expected HydrationRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = HydrationRecord::class

    override fun supportedAggregations(): List<AggregationMetricDto> {
        return listOf(AggregationMetricDto.SUM)
    }

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> {
        return when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> HydrationRecord.VOLUME_TOTAL
            else -> error("Unsupported aggregation metric ${request.aggregationMetric} for Hydration. Supported: SUM")
        }
    }

    override fun extractAggregateValue(
        aggregatedValue: Any?,
        metric: AggregationMetricDto
    ): MeasurementUnitDto {
        val volume = aggregatedValue as? Volume
        return volume?.toDto() ?: VolumeDto(value = 0.0, unit = VolumeUnitDto.LITERS)
    }
}
