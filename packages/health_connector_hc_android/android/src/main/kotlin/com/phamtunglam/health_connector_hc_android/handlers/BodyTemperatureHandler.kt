package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
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

    override fun toDto(record: Record): HealthRecordDto? {
        return (record as? BodyTemperatureRecord)?.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is BodyTemperatureRecordDto) {
            "Expected BodyTemperatureRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = BodyTemperatureRecord::class
}
