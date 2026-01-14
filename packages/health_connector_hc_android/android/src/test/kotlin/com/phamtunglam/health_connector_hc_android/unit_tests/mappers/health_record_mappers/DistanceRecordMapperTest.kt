package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("DistanceRecordMapper")
class DistanceRecordMapperTest {

    private companion object {
        const val TEST_ID = "test-distance-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_DISTANCE_METERS = 5000.0
    }

    @Test
    @DisplayName("GIVEN DistanceRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = DistanceRecord(
            distance = Length.meters(TEST_DISTANCE_METERS),
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = null,
            endZoneOffset = null,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.meters shouldBe TEST_DISTANCE_METERS
    }

    @Test
    @DisplayName("GIVEN DistanceRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = DistanceRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = null,
            endZoneOffsetSeconds = null,
            meters = TEST_DISTANCE_METERS,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.AUTOMATICALLY_RECORDED,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.distance.inMeters shouldBe TEST_DISTANCE_METERS
        result.metadata.id shouldBe TEST_ID
    }
}
