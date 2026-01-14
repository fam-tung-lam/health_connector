package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.PowerRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.units.watts
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerSampleDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("PowerSeriesRecordMapper")
class PowerSeriesRecordMapperTest {

    private companion object {
        const val TEST_ID = "power-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_POWER_WATTS_1 = 150.0
        const val TEST_POWER_WATTS_2 = 160.0
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN PowerRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = PowerRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
            samples = listOf(
                PowerRecord.Sample(
                    time = Instant.ofEpochMilli(TEST_START_TIME),
                    power = TEST_POWER_WATTS_1.watts,
                ),
                PowerRecord.Sample(
                    time = Instant.ofEpochMilli(TEST_END_TIME),
                    power = TEST_POWER_WATTS_2.watts,
                ),
            ),
        )

        // When
        val result = record.toDto()

        // Then
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.samples.size shouldBe 2
        result.samples[0].watts shouldBe TEST_POWER_WATTS_1
        result.samples[1].watts shouldBe TEST_POWER_WATTS_2

        result.startZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.endZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName("GIVEN PowerSeriesRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = PowerSeriesRecordDto(
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
                PowerSampleDto(
                    time = TEST_START_TIME,
                    watts = TEST_POWER_WATTS_1,
                ),
                PowerSampleDto(
                    time = TEST_END_TIME,
                    watts = TEST_POWER_WATTS_2,
                ),
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.samples.size shouldBe 2
        result.samples[0].power.inWatts shouldBe TEST_POWER_WATTS_1
        result.samples[1].power.inWatts shouldBe TEST_POWER_WATTS_2
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
