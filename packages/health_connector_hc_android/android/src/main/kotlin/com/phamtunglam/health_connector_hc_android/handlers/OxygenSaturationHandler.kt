package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.OxygenSaturationRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.OxygenSaturationRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Oxygen Saturation health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX
 * - Health Connect Type: OxygenSaturationRecord
 */
internal object OxygenSaturationHandler : InstantRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.OXYGEN_SATURATION

    override fun toDto(record: Record): HealthRecordDto {
        require(record is OxygenSaturationRecord) {
            "Expected OxygenSaturationRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is OxygenSaturationRecordDto) {
            "Expected OxygenSaturationRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = OxygenSaturationRecord::class
}
