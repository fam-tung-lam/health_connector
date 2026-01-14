package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.ActiveEnergyBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for ActiveCaloriesBurnedRecord Mapper.
 */
@DisplayName("ActiveEnergyBurnedRecordMapper")
class ActiveEnergyBurnedRecordMapperTest {

    private companion object Companion {
        const val TEST_ID = "test-active-cal-id-123"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_ENERGY_KCAL = 250.5
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(-8)
    }

    @Test
    @DisplayName(
        "GIVEN ActiveCaloriesBurnedRecord → " +
            "WHEN toDto called → " +
            "THEN converts to DTO with correct fields",
    )
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = ActiveCaloriesBurnedRecord(
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
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.startZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.endZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.kilocalories shouldBe TEST_ENERGY_KCAL
        result.metadata shouldNotBe null
    }

    @Test
    @DisplayName(
        "GIVEN ActiveEnergyBurnedRecordDto → " +
            "WHEN toHealthConnect called → " +
            "THEN creates record with correct fields",
    )
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = ActiveEnergyBurnedRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            kilocalories = TEST_ENERGY_KCAL,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.energy.inKilocalories shouldBe TEST_ENERGY_KCAL
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
