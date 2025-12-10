package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.LeanBodyMassRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.LeanBodyMassRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Lean Body Mass health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Not supported
 * - Health Connect Type: LeanBodyMassRecord
 */
object LeanBodyMassHandler : InstantRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.LEAN_BODY_MASS

    override fun toDto(record: Record): HealthRecordDto {
        require(record is LeanBodyMassRecord) {
            "Expected LeanBodyMassRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is LeanBodyMassRecordDto) {
            "Expected LeanBodyMassRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = LeanBodyMassRecord::class
}
