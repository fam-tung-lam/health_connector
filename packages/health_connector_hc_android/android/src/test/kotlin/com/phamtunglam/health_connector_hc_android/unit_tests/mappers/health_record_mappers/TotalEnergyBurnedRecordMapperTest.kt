package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.TotalCaloriesBurnedRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.TotalEnergyBurnedRecordDto
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for TotalCaloriesBurnedRecord Mapper.
 */
@DisplayName("TotalEnergyBurnedRecordMapper")
class TotalEnergyBurnedRecordMapperTest {

    private companion object Companion {
        const val TEST_ID = "test-total-cal-id-123"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609545600000L
        const val TEST_ENERGY_KCAL = 1850.25
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName(
        "GIVEN TotalCaloriesBurnedRecord → " +
            "WHEN toDto called → " +
            "THEN converts to DTO correctly",
    )
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = TotalCaloriesBurnedRecord(
            energy = Energy.kilocalories(TEST_ENERGY_KCAL),
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.kilocalories shouldBe TEST_ENERGY_KCAL
        result.metadata shouldNotBe null
    }

    @Test
    @DisplayName(
        "GIVEN TotalEnergyBurnedRecordDto → " +
            "WHEN toHealthConnect called → " +
            "THEN creates record correctly",
    )
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = TotalEnergyBurnedRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            kilocalories = TEST_ENERGY_KCAL,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.AUTOMATICALLY_RECORDED,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.energy.inKilocalories shouldBe TEST_ENERGY_KCAL
        result.metadata.id shouldBe TEST_ID
    }
}
