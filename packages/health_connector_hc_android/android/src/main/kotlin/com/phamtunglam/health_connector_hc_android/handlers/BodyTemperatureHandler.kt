package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Body Temperature health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Not supported
 * - Health Connect Type: BodyTemperatureRecord
 */
object BodyTemperatureHandler : InstantRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.BODY_TEMPERATURE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is BodyTemperatureRecord) {
            "Expected BodyTemperatureRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is BodyTemperatureRecordDto) {
            "Expected BodyTemperatureRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = BodyTemperatureRecord::class
}
