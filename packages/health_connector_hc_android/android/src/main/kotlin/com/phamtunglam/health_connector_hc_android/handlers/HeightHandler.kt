package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.LengthDto
import com.phamtunglam.health_connector_hc_android.pigeon.LengthUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.reflect.KClass

/**
 * Handler for Height health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX
 * - Health Connect Type: HeightRecord
 */
object HeightHandler : InstantRecordHandler, AggregationSupportingHandler<CommonAggregateRequestDto> {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.HEIGHT

    override fun toDto(record: Record): HealthRecordDto {
        require(record is HeightRecord) {
            "Expected HeightRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is HeightRecordDto) {
            "Expected HeightRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = HeightRecord::class

    override fun supportedAggregations(): List<AggregationMetricDto> {
        return listOf(
            AggregationMetricDto.AVG,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX
        )
    }

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> {
        return when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> HeightRecord.HEIGHT_AVG
            AggregationMetricDto.MIN -> HeightRecord.HEIGHT_MIN
            AggregationMetricDto.MAX -> HeightRecord.HEIGHT_MAX
            else -> error("Unsupported aggregation metric ${request.aggregationMetric} for Height. Supported: AVG, MIN, MAX")
        }
    }

    override fun extractAggregateValue(
        aggregatedValue: Any?,
        metric: AggregationMetricDto
    ): MeasurementUnitDto {
        val height = aggregatedValue as? Length
        return height?.toDto() ?: LengthDto(value = 0.0, unit = LengthUnitDto.METERS)
    }
}
