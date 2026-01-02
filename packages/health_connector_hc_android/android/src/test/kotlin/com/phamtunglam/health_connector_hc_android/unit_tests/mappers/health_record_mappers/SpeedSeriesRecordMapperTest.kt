package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.SpeedRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.Velocity
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.SpeedMeasurementDto
import com.phamtunglam.health_connector_hc_android.pigeon.SpeedSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.VelocityDto
import com.phamtunglam.health_connector_hc_android.pigeon.VelocityUnitDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("SpeedSeriesRecordMapper")
class SpeedSeriesRecordMapperTest {

    private companion object {
        const val TEST_ID = "speed-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_SPEED_MPS = 5.0
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN SpeedRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = SpeedRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
            samples = listOf(
                SpeedRecord.Sample(
                    time = Instant.ofEpochMilli(TEST_START_TIME),
                    speed = Velocity.metersPerSecond(TEST_SPEED_MPS),
                ),
            ),
        )

        // When
        val result = record.toDto()

        // Then
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.startZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.endZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.samples.size shouldBe 1
        result.samples[0].speed.value shouldBe TEST_SPEED_MPS
        result.samples[0].speed.unit shouldBe VelocityUnitDto.METERS_PER_SECOND
    }

    @Test
    @DisplayName("GIVEN SpeedSeriesRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = SpeedSeriesRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
            samples = listOf(
                SpeedMeasurementDto(
                    time = TEST_START_TIME,
                    speed = VelocityDto(
                        value = TEST_SPEED_MPS,
                        unit = VelocityUnitDto.METERS_PER_SECOND,
                    ),
                ),
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.samples.size shouldBe 1
        result.samples[0].speed.inMetersPerSecond shouldBe TEST_SPEED_MPS
        result.metadata.id shouldBe TEST_ID
    }
}
