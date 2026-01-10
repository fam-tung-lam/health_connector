package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.CyclingPedalingCadenceRecord
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.CyclingPedalingCadenceSampleDto
import com.phamtunglam.health_connector_hc_android.pigeon.CyclingPedalingCadenceSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.NumberDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("CyclingPedalingCadenceRecordMapper")
class CyclingPedalingCadenceRecordMapperTest {

    private companion object {
        const val TEST_ID = "cycling-cadence-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609462800000L
        const val TEST_RPM_1 = 80.0
        const val TEST_RPM_2 = 85.0
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN CyclingPedalingCadenceRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = CyclingPedalingCadenceRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
            samples = listOf(
                CyclingPedalingCadenceRecord.Sample(
                    time = Instant.ofEpochMilli(TEST_START_TIME),
                    revolutionsPerMinute = TEST_RPM_1,
                ),
                CyclingPedalingCadenceRecord.Sample(
                    time = Instant.ofEpochMilli(TEST_END_TIME),
                    revolutionsPerMinute = TEST_RPM_2,
                ),
            ),
        )

        // When
        val result = record.toDto()

        // Then
        result.startTime shouldBe TEST_START_TIME
        result.endTime shouldBe TEST_END_TIME
        result.samples.size shouldBe 2
        result.samples[0].revolutionsPerMinute.value shouldBe TEST_RPM_1
        result.samples[1].revolutionsPerMinute.value shouldBe TEST_RPM_2
        result.startZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
        result.endZoneOffsetSeconds shouldBe TEST_ZONE_OFFSET.totalSeconds.toLong()
    }

    @Test
    @DisplayName(
        "GIVEN CyclingPedalingCadenceSeriesRecordDto → WHEN toHealthConnect → THEN creates correctly",
    )
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = CyclingPedalingCadenceSeriesRecordDto(
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
                CyclingPedalingCadenceSampleDto(
                    time = TEST_START_TIME,
                    revolutionsPerMinute = NumberDto(value = TEST_RPM_1),
                ),
                CyclingPedalingCadenceSampleDto(
                    time = TEST_END_TIME,
                    revolutionsPerMinute = NumberDto(value = TEST_RPM_2),
                ),
            ),
        )

        // When
        val result = dto.toHealthConnect()

        // Then
        result.samples.size shouldBe 2
        result.samples[0].revolutionsPerMinute shouldBe TEST_RPM_1
        result.samples[1].revolutionsPerMinute shouldBe TEST_RPM_2
        result.startTime shouldBe Instant.ofEpochMilli(TEST_START_TIME)
        result.endTime shouldBe Instant.ofEpochMilli(TEST_END_TIME)
        result.startZoneOffset shouldBe TEST_ZONE_OFFSET
        result.endZoneOffset shouldBe TEST_ZONE_OFFSET
        result.metadata.id shouldBe TEST_ID
    }
}
