package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.Vo2MaxRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.Vo2MaxRecordDto
import kotlin.reflect.KClass

/**
 * Handler for VO2 Max health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX (implemented via manual computation using ReadRecordsRequest)
 * - Health Connect Type: Vo2MaxRecord
 */
internal object Vo2MaxHandler : InstantRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.VO2MAX

    override fun toDto(record: Record): HealthRecordDto {
        require(record is Vo2MaxRecord) {
            "Expected Vo2MaxRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is Vo2MaxRecordDto) {
            "Expected Vo2MaxRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = Vo2MaxRecord::class
}
