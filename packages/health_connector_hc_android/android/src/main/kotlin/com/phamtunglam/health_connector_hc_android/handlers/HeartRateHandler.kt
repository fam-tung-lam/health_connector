package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateSeriesRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Heart Rate health data type.
 *
 * Characteristics:
 * - Category: Series record (time series samples)
 * - Aggregation: Not supported
 * - Health Connect Type: HeartRateRecord
 */
object HeartRateHandler : SeriesRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.HEART_RATE_SERIES_RECORD

    override fun toDto(record: Record): HealthRecordDto {
        require(record is HeartRateRecord) {
            "Expected HeartRateRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is HeartRateSeriesRecordDto) {
            "Expected HeartRateSeriesRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = HeartRateRecord::class
}
