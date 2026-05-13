package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ExerciseSessionHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSegmentTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionLapEventDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionSegmentEventDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.utils.MainDispatcherExtension
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldNotBeEmpty
import io.mockk.unmockkAll
import java.time.Instant
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@DisplayName("ExerciseSessionHandler")
@ExtendWith(MainDispatcherExtension::class)
class ExerciseSessionHandlerTest {

    private lateinit var fakePermissionController: FakePermissionController
    private lateinit var fakeHealthConnectClient: FakeHealthConnectClient

    @BeforeEach
    fun setUp() {
        HealthConnectorLogger.isEnabled = false
        fakePermissionController = FakePermissionController(grantAll = true)
        fakeHealthConnectClient = FakeHealthConnectClient(
            packageName = FAKE_PACKAGE_NAME,
            permissionController = fakePermissionController,
        )
    }

    @AfterEach
    fun tearDown() {
        unmockkAll()
    }

    @Test
    @DisplayName("GIVEN handler → WHEN checking dataType → THEN returns EXERCISE_SESSION")
    fun `handler has correct data type`() {
        val handler = ExerciseSessionHandler(
            dispatcher = Dispatchers.Main.immediate,
            client = fakeHealthConnectClient,
        )
        handler.dataType shouldBe HealthDataTypeDto.EXERCISE_SESSION
    }

    @Nested
    @DisplayName("GIVEN writing ExerciseSession → ")
    inner class WriteRecord {

        @Test
        @DisplayName(
            "WHEN session has segment with null weight → THEN write succeeds",
        )
        fun `write session with null segment weight succeeds`() = runTest {
            val handler = ExerciseSessionHandler(
                dispatcher = Dispatchers.Main.immediate,
                client = fakeHealthConnectClient,
            )
            val dto = buildExerciseSessionDto(weightKg = null)

            val id = handler.writeRecord(dto)

            id.shouldNotBeEmpty()
        }

        @Test
        @DisplayName(
            "WHEN session has no segments → THEN write succeeds",
        )
        fun `write session without segments succeeds`() = runTest {
            val handler = ExerciseSessionHandler(
                dispatcher = Dispatchers.Main.immediate,
                client = fakeHealthConnectClient,
            )
            val dto = buildExerciseSessionDto(weightKg = null, includeSegment = false)

            val id = handler.writeRecord(dto)

            id.shouldNotBeEmpty()
        }

        @Test
        @DisplayName(
            "WHEN session has only lap events → THEN write succeeds",
        )
        fun `write session with lap events only succeeds`() = runTest {
            val handler = ExerciseSessionHandler(
                dispatcher = Dispatchers.Main.immediate,
                client = fakeHealthConnectClient,
            )
            val dto = buildExerciseSessionDtoWithLapOnly()

            val id = handler.writeRecord(dto)

            id.shouldNotBeEmpty()
        }
    }

    private fun buildExerciseSessionDto(
        weightKg: Double?,
        includeSegment: Boolean = true,
        id: String? = null,
    ): ExerciseSessionRecordDto {
        val startTime = FIXED_NOW.minusSeconds(3600).toEpochMilli()
        val endTime = FIXED_NOW.toEpochMilli()
        val segStartTime = FIXED_NOW.minusSeconds(3600).toEpochMilli()
        val segEndTime = FIXED_NOW.minusSeconds(1800).toEpochMilli()

        val events = if (includeSegment) {
            listOf(
                ExerciseSessionSegmentEventDto(
                    startTime = segStartTime,
                    endTime = segEndTime,
                    segmentType = ExerciseSegmentTypeDto.RUNNING,
                    repetitions = null,
                    weightKg = weightKg,
                ),
            )
        } else {
            emptyList()
        }

        return ExerciseSessionRecordDto(
            id = id,
            startTime = startTime,
            endTime = endTime,
            exerciseType = ExerciseTypeDto.RUNNING,
            events = events,
            metadata = MetadataDto(
                dataOrigin = FAKE_PACKAGE_NAME,
                deviceType = DeviceTypeDto.PHONE,
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
            ),
        )
    }

    private fun buildExerciseSessionDtoWithLapOnly(): ExerciseSessionRecordDto {
        val startTime = FIXED_NOW.minusSeconds(3600).toEpochMilli()
        val endTime = FIXED_NOW.toEpochMilli()

        return ExerciseSessionRecordDto(
            id = null,
            startTime = startTime,
            endTime = endTime,
            exerciseType = ExerciseTypeDto.RUNNING,
            events = listOf(
                ExerciseSessionLapEventDto(
                    startTime = startTime,
                    endTime = endTime,
                    distanceMeters = 1000.0,
                ),
            ),
            metadata = MetadataDto(
                dataOrigin = FAKE_PACKAGE_NAME,
                deviceType = DeviceTypeDto.PHONE,
                recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
            ),
        )
    }

    private companion object {
        const val FAKE_PACKAGE_NAME = "com.test"
        val FIXED_NOW: Instant = Instant.parse("2026-01-01T12:00:00Z")
    }
}
