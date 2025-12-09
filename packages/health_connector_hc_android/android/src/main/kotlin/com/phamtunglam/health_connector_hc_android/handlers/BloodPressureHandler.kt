package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import kotlin.reflect.KClass

/**
 * Handler for composite Blood Pressure health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Not supported (use Systolic/Diastolic handlers for aggregation)
 * - Health Connect Type: BloodPressureRecord
 */
object BloodPressureHandler : InstantRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.BLOOD_PRESSURE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is BloodPressureRecord) {
            "Expected BloodPressureRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is BloodPressureRecordDto) {
            "Expected BloodPressureRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = BloodPressureRecord::class
}
