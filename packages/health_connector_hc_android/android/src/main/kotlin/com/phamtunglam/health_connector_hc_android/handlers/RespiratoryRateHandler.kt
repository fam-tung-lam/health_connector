package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.RespiratoryRateRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RespiratoryRateRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Respiratory Rate health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX (implemented via manual computation using ReadRecordsRequest)
 * - Health Connect Type: RespiratoryRateRecord
 */
internal object RespiratoryRateHandler : InstantRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.RESPIRATORY_RATE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is RespiratoryRateRecord) {
            "Expected RespiratoryRateRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is RespiratoryRateRecordDto) {
            "Expected RespiratoryRateRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = RespiratoryRateRecord::class
}
