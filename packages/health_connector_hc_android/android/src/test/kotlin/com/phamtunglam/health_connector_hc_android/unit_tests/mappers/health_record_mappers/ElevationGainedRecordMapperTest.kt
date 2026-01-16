package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.ElevationGainedRecord
import androidx.health.connect.client.records.metadata.DataOrigin
import androidx.health.connect.client.records.metadata.Device
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ElevationGainedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import io.mockk.every
import io.mockk.mockk
import java.time.Instant
import java.time.ZoneOffset
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
            startZoneOffset = ZoneOffset.UTC,
            endZoneOffset = ZoneOffset.UTC,
            metadata = mockk {
                every {
                    dataOrigin
                } returns DataOrigin(
                    "com.example.app",
                )
                every {
                    recordingMethod
                } returns Metadata.RECORDING_METHOD_MANUAL_ENTRY
                every { id } returns TEST_ID
                every { device } returns null
                every { lastModifiedTime } returns Instant.ofEpochMilli(TEST_END_TIME)
                every { clientRecordId } returns null
                every { clientRecordVersion } returns 0
            },
        )

        // When
        val result = record.toDto()

        // Then
        (result as ElevationGainedRecordDto).meters shouldBe TEST_ELEVATION_METERS
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.metadata.dataOrigin shouldBe "com.example.app"
        result.metadata.recordingMethod shouldBe RecordingMethodDto.MANUAL_ENTRY
    }

    @Test
    @DisplayName("GIVEN ElevationGainedRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = ElevationGainedRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = 0,
            endZoneOffsetSeconds = 0,
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
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe ZoneOffset.UTC
        result.endZoneOffset shouldBe ZoneOffset.UTC
        result.metadata.id shouldBe TEST_ID
        result.metadata.recordingMethod shouldBe Metadata.RECORDING_METHOD_AUTOMATICALLY_RECORDED
        result.metadata.device?.type shouldBe Device.TYPE_PHONE
    }
}
