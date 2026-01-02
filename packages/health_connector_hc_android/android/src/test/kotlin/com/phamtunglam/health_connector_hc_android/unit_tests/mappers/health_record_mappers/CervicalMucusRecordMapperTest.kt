package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.CervicalMucusRecord
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusAppearanceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusSensationTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("CervicalMucusRecordMapper")
class CervicalMucusRecordMapperTest {

    private companion object {
        const val TEST_ID = "cervical-mucus-id"
        const val TEST_TIME = 1609459200000L
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN CervicalMucusRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = CervicalMucusRecord(
            appearance = CervicalMucusRecord.APPEARANCE_EGG_WHITE,
            sensation = CervicalMucusRecord.SENSATION_HEAVY,
            time = Instant.ofEpochMilli(TEST_TIME),
            zoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
        )

        // When
        val result = record.toDto()

        // Then
        result.appearance shouldBe CervicalMucusAppearanceTypeDto.EGG_WHITE
        result.sensation shouldBe CervicalMucusSensationTypeDto.HEAVY
        result.time shouldBe TEST_TIME
        result.zoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName("GIVEN CervicalMucusRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = CervicalMucusRecordDto(
            id = TEST_ID,
            time = TEST_TIME,
            zoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            appearance = CervicalMucusAppearanceTypeDto.EGG_WHITE,
            sensation = CervicalMucusSensationTypeDto.HEAVY,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.appearance shouldBe CervicalMucusRecord.APPEARANCE_EGG_WHITE
        result.sensation shouldBe CervicalMucusRecord.SENSATION_HEAVY
        result.time shouldBe Instant.ofEpochMilli(TEST_TIME)
        result.zoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
