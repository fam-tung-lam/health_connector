package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.BloodGlucoseRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Blood Glucose health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Supports AVG, MIN, MAX (via manual aggregation - reading records and computing)
 * - Health Connect Type: BloodGlucoseRecord
 */
internal object BloodGlucoseHandler : InstantRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.BLOOD_GLUCOSE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is BloodGlucoseRecord) {
            "Expected BloodGlucoseRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is BloodGlucoseRecordDto) {
            "Expected BloodGlucoseRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = BloodGlucoseRecord::class
}
