package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("HydrationRecordMapper")
class HydrationRecordMapperTest {

    private companion object {
        const val TEST_ID = "hydration-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_VOLUME_LITERS = 0.5
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN HydrationRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = HydrationRecord(
            volume = Volume.liters(TEST_VOLUME_LITERS),
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.volume.liters shouldBe TEST_VOLUME_LITERS
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.startZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.endZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName("GIVEN HydrationRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = HydrationRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            volume = VolumeDto(liters = TEST_VOLUME_LITERS),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.volume.inLiters shouldBe TEST_VOLUME_LITERS
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
