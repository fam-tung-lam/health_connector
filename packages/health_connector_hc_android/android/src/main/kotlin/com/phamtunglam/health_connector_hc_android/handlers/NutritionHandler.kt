package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import kotlin.reflect.KClass

/**
 * Handler for combined nutrition record (interval-based).
 */
internal object NutritionHandler : IntervalRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.NUTRITION

    override fun toDto(record: Record): HealthRecordDto {
        require(record is NutritionRecord) {
            "Expected NutritionRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is NutritionRecordDto) {
            "Expected NutritionRecordDto, got ${dto::class.simpleName}"
        }
        require(dto.healthDataType == HealthDataTypeDto.NUTRITION) {
            "Expected NutritionRecordDto with healthDataType = NUTRITION, got ${dto.healthDataType}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = NutritionRecord::class
}
