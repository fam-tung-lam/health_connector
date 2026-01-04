package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Percentage
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.PercentageDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("BodyFatRecordMapper")
class BodyFatRecordMapperTest {

    private companion object {
        const val TEST_ID = "bodyfat-id"
        const val TEST_TIME = 1609459200000L
        const val TEST_PERCENTAGE = 0.18
    }

    @Test
    @DisplayName("GIVEN BodyFatRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = BodyFatRecord(
            percentage = Percentage(TEST_PERCENTAGE),
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = null,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.percentage.decimal shouldBe TEST_PERCENTAGE
    }

    @Test
    @DisplayName("GIVEN BodyFatPercentageRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = BodyFatPercentageRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = null,
            percentage = PercentageDto(decimal = TEST_PERCENTAGE),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.percentage.value shouldBe TEST_PERCENTAGE
        result.metadata.id shouldBe TEST_ID
    }
}
