package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("HeightRecordMapper")
class HeightRecordMapperTest {

    private companion object {
        const val TEST_ID = "height-id"
        const val TEST_TIME = 1609459200000L
        const val TEST_HEIGHT_METERS = 1.75
    }

    @Test
    @DisplayName("GIVEN HeightRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = HeightRecord(
            height = Length.meters(TEST_HEIGHT_METERS),
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = null,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.meters shouldBe TEST_HEIGHT_METERS
    }

    @Test
    @DisplayName("GIVEN HeightRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = HeightRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = null,
            meters = TEST_HEIGHT_METERS,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.height.inMeters shouldBe TEST_HEIGHT_METERS
        result.metadata.id shouldBe TEST_ID
    }
}
