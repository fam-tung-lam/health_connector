package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.IntermenstrualBleedingRecord
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.IntermenstrualBleedingRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("IntermenstrualBleedingRecordMapper")
class IntermenstrualBleedingRecordMapperTest {

    private companion object {
        const val TEST_ID = "bleeding-id"
        const val TEST_TIME = 1609459200000L
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN IntermenstrualBleedingRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = IntermenstrualBleedingRecord(
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.time shouldBe TEST_TIME
        result.zoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName(
        "GIVEN IntermenstrualBleedingRecordDto → WHEN toHealthConnect → THEN creates correctly",
    )
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = IntermenstrualBleedingRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME)
        result.zoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
