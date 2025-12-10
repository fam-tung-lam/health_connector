package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import kotlin.reflect.KClass

/**
 * Handler for Body Fat Percentage health data type.
 *
 * Characteristics:
 * - Category: Instant record (single timestamp)
 * - Aggregation: Not supported
 * - Health Connect Type: BodyFatRecord
 */
object BodyFatPercentageHandler : InstantRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.BODY_FAT_PERCENTAGE

    override fun toDto(record: Record): HealthRecordDto {
        require(record is BodyFatRecord) {
            "Expected BodyFatRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is BodyFatPercentageRecordDto) {
            "Expected BodyFatPercentageRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = BodyFatRecord::class
}
