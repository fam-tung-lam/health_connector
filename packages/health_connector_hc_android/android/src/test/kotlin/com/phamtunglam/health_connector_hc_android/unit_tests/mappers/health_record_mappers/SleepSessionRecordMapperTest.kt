package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_record_mappers

import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageSampleDto
import io.kotest.matchers.shouldBe
import java.time.Instant
import java.time.ZoneOffset
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

@DisplayName("SleepSessionRecordMapper")
class SleepSessionRecordMapperTest {

    private companion object {
        const val TEST_ID = "sleep-id"
        const val TEST_START_TIME = 1609459200000L
        const val TEST_END_TIME = 1609489200000L // +8 hours approx
        const val TEST_STAGE_START = 1609460000000L
        const val TEST_STAGE_END = 1609461000000L
        const val TEST_TITLE = "Night Sleep"
        const val TEST_NOTES = "Good sleep"
        val TEST_ZONE_OFFSET: ZoneOffset = ZoneOffset.ofHours(1)
    }

    @Test
    @DisplayName("GIVEN SleepSessionRecord → WHEN toDto → THEN converts correctly")
    fun whenRecordToDto_thenConvertsCorrectly() {
        // Given
        val record = SleepSessionRecord(
            startTime = Instant.ofEpochMilli(TEST_START_TIME),
            endTime = Instant.ofEpochMilli(TEST_END_TIME),
            startZoneOffset = TEST_ZONE_OFFSET,
            endZoneOffset = TEST_ZONE_OFFSET,
            metadata = Metadata.manualEntry(),
            title = TEST_TITLE,
            notes = TEST_NOTES,
            stages = listOf(
                SleepSessionRecord.Stage(
                    startTime = Instant.ofEpochMilli(TEST_STAGE_START),
                    endTime = Instant.ofEpochMilli(TEST_STAGE_END),
                    stage = SleepSessionRecord.STAGE_TYPE_DEEP,
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
        result.title shouldBe TEST_TITLE
        result.notes shouldBe TEST_NOTES
        result.stages.size shouldBe 1
        result.stages[0].stage shouldBe SleepStageDto.DEEP
        result.stages[0].startTime shouldBe TEST_STAGE_START
        result.stages[0].endTime shouldBe TEST_STAGE_END
    }

    @Test
    @DisplayName("GIVEN SleepSessionRecordDto → WHEN toHealthConnect → THEN creates correctly")
    fun whenDtoToHealthConnect_thenCreatesCorrectly() {
        // Given
        val dto = SleepSessionRecordDto(
            id = TEST_ID,
            startTime = TEST_START_TIME,
            endTime = TEST_END_TIME,
            startZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            endZoneOffsetSeconds = TEST_ZONE_OFFSET.totalSeconds.toLong(),
            title = TEST_TITLE,
            notes = TEST_NOTES,
            metadata = MetadataDto(
                dataOrigin = "com.example.app",
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                deviceType = DeviceTypeDto.PHONE,
            ),
            stages = listOf(
                SleepStageSampleDto(
                    startTime = TEST_STAGE_START,
                    endTime = TEST_STAGE_END,
                    stage = SleepStageDto.LIGHT,
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
        result.title shouldBe TEST_TITLE
        result.notes shouldBe TEST_NOTES
        result.stages.size shouldBe 1
        result.stages[0].stage shouldBe SleepSessionRecord.STAGE_TYPE_LIGHT
        result.stages[0].startTime shouldBe Instant.ofEpochMilli(TEST_STAGE_START)
        result.stages[0].endTime shouldBe Instant.ofEpochMilli(TEST_STAGE_END)
        result.metadata.id shouldBe TEST_ID
    }
}
