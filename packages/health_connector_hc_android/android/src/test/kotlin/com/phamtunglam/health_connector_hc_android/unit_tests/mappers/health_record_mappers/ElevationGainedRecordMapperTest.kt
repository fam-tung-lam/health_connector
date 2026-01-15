package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.ElevationGainedRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ElevationGainedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("ElevationGainedRecordMapper")
class ElevationGainedRecordMapperTest {

    private companion object {
        const val TEST_ID = "test-elevation-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_ELEVATION_METERS = 100.0
    }

    @Test
    @DisplayName("GIVEN ElevationGainedRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = ElevationGainedRecord(
            elevation = Length.meters(TEST_ELEVATION_METERS),
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = null,
            endZoneOffset = null,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        (result as ElevationGainedRecordDto).meters shouldBe TEST_ELEVATION_METERS
    }

    @Test
    @DisplayName("GIVEN ElevationGainedRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = ElevationGainedRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = null,
            endZoneOffsetSeconds = null,
            meters = TEST_ELEVATION_METERS,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.AUTOMATICALLY_RECORDED,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        (result as ElevationGainedRecord).elevation.inMeters shouldBe TEST_ELEVATION_METERS
        result.metadata.id shouldBe TEST_ID
    }
}
