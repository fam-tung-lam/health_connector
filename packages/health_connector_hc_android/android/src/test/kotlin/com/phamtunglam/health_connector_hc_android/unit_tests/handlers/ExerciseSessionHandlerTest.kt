package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import android.os.RemoteException
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.ExerciseSessionRecord
import androidx.health.connect.client.records.metadata.DataOrigin
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.response.ReadRecordResponse
import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import androidx.health.connect.client.testing.populatedWithTestValues
import androidx.health.connect.client.testing.stubs.Stub
import androidx.health.connect.client.testing.stubs.stub
import androidx.health.connect.client.time.TimeRangeFilter
import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
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
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldNotBeEmpty
import io.mockk.every
import io.mockk.mockk
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

import androidx.health.connect.client.testing.AggregationResult as createAggregationResult

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

    @Nested
    @DisplayName("GIVEN exercise session active energy aggregation → ")
    inner class AggregateActiveEnergy {
        private lateinit var systemUnderTest: ExerciseSessionHandler

        @BeforeEach
        fun setUpHandler() {
            systemUnderTest = ExerciseSessionHandler(
                dispatcher = Dispatchers.Main.immediate,
                client = fakeHealthConnectClient,
            )
        }

        @Test
        @DisplayName(
            "GIVEN saved exercise session → WHEN aggregating energy → " +
                "THEN queries saved times and source and returns kilocalories",
        )
        fun `energy uses the saved exercise session time range and data origin`() = runTest {
            // Given
            val exerciseSession = ExerciseSessionRecord(
                startTime = EXERCISE_SESSION_START,
                startZoneOffset = null,
                endTime = EXERCISE_SESSION_END,
                endZoneOffset = null,
                exerciseType = ExerciseSessionRecord.EXERCISE_TYPE_RUNNING,
                metadata = Metadata.manualEntry().populatedWithTestValues(
                    id = EXERCISE_SESSION_ID,
                    dataOrigin = DataOrigin(FAKE_PACKAGE_NAME),
                ),
            )
            fakeHealthConnectClient.overrides.readRecord = object :
                Stub<String, ReadRecordResponse<*>> {
                override fun next(request: String): ReadRecordResponse<*> {
                    request shouldBe EXERCISE_SESSION_ID
                    return ReadRecordResponse(exerciseSession)
                }
            }
            val exerciseSessionId = EXERCISE_SESSION_ID
            lateinit var nativeRequest: AggregateRequest
            fakeHealthConnectClient.overrides.aggregate = object :
                Stub<AggregateRequest, AggregationResult> {
                override fun next(request: AggregateRequest): AggregationResult {
                    nativeRequest = request
                    return energyResult(279.0)
                }
            }

            // When
            val result = systemUnderTest.aggregateActiveEnergy(exerciseSessionId)

            // Then
            result shouldBe 279.0
            nativeRequest shouldBe AggregateRequest(
                metrics = setOf(ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL),
                timeRangeFilter = TimeRangeFilter.between(
                    EXERCISE_SESSION_START,
                    EXERCISE_SESSION_END,
                ),
                dataOriginFilter = setOf(DataOrigin(FAKE_PACKAGE_NAME)),
            )
        }

        @Test
        @DisplayName(
            "GIVEN zero active energy → WHEN aggregating exercise session energy → THEN returns zero",
        )
        fun `zero energy remains a valid result`() = runTest {
            // Given
            val exerciseSession = ExerciseSessionRecord(
                startTime = EXERCISE_SESSION_START,
                startZoneOffset = null,
                endTime = EXERCISE_SESSION_END,
                endZoneOffset = null,
                exerciseType = ExerciseSessionRecord.EXERCISE_TYPE_RUNNING,
                metadata = Metadata.manualEntry().populatedWithTestValues(
                    id = EXERCISE_SESSION_ID,
                    dataOrigin = DataOrigin(FAKE_PACKAGE_NAME),
                ),
            )
            fakeHealthConnectClient.overrides.readRecord = object :
                Stub<String, ReadRecordResponse<*>> {
                override fun next(request: String): ReadRecordResponse<*> {
                    request shouldBe EXERCISE_SESSION_ID
                    return ReadRecordResponse(exerciseSession)
                }
            }
            val exerciseSessionId = EXERCISE_SESSION_ID
            fakeHealthConnectClient.overrides.aggregate = stub(energyResult(0.0))

            // When / Then
            systemUnderTest.aggregateActiveEnergy(exerciseSessionId) shouldBe 0.0
        }

        @Test
        @DisplayName(
            "GIVEN no active energy → WHEN aggregating exercise session energy → THEN throws NoData",
        )
        fun `missing energy throws NoData`() = runTest {
            // Given
            val exerciseSession = ExerciseSessionRecord(
                startTime = EXERCISE_SESSION_START,
                startZoneOffset = null,
                endTime = EXERCISE_SESSION_END,
                endZoneOffset = null,
                exerciseType = ExerciseSessionRecord.EXERCISE_TYPE_RUNNING,
                metadata = Metadata.manualEntry().populatedWithTestValues(
                    id = EXERCISE_SESSION_ID,
                    dataOrigin = DataOrigin(FAKE_PACKAGE_NAME),
                ),
            )
            fakeHealthConnectClient.overrides.readRecord = object :
                Stub<String, ReadRecordResponse<*>> {
                override fun next(request: String): ReadRecordResponse<*> {
                    request shouldBe EXERCISE_SESSION_ID
                    return ReadRecordResponse(exerciseSession)
                }
            }
            val exerciseSessionId = EXERCISE_SESSION_ID
            fakeHealthConnectClient.overrides.aggregate = stub(createAggregationResult())

            // When / Then
            shouldThrow<HealthConnectorException.NoData> {
                systemUnderTest.aggregateActiveEnergy(exerciseSessionId)
            }
        }

        @Test
        @DisplayName(
            "GIVEN missing exercise session → WHEN aggregating energy → THEN throws InvalidArgument",
        )
        fun `missing exercise session fails before aggregating energy`() = runTest {
            // Given
            val exerciseSessionId = "missing-exercise-session"

            val missingRecordException = mockk<RemoteException>()
            every { missingRecordException.message } returns "No records"
            fakeHealthConnectClient.overrides.readRecord = object :
                Stub<String, ReadRecordResponse<*>> {
                override fun next(request: String): ReadRecordResponse<*> =
                    throw missingRecordException
            }

            // When / Then
            val exception = shouldThrow<HealthConnectorException.InvalidArgument> {
                systemUnderTest.aggregateActiveEnergy(exerciseSessionId)
            }
            exception.message shouldBe "Exercise session does not exist"
        }

        @Test
        @DisplayName(
            "GIVEN blank exercise session ID → WHEN aggregating energy → THEN throws InvalidArgument",
        )
        fun `blank exercise session ID fails validation`() = runTest {
            // Given
            val exerciseSessionId = "   "

            // When / Then
            shouldThrow<HealthConnectorException.InvalidArgument> {
                systemUnderTest.aggregateActiveEnergy(exerciseSessionId)
            }
        }

        @Test
        @DisplayName(
            "GIVEN exercise session read denied → WHEN aggregating energy → THEN throws Authorization",
        )
        fun `exercise session read permission errors are preserved`() = runTest {
            // Given
            val exerciseSessionId = EXERCISE_SESSION_ID
            fakeHealthConnectClient.overrides.readRecord = object :
                Stub<String, ReadRecordResponse<*>> {
                override fun next(request: String): ReadRecordResponse<*> =
                    throw SecurityException("Exercise session read denied")
            }

            // When / Then
            val exception = shouldThrow<HealthConnectorException.Authorization> {
                systemUnderTest.aggregateActiveEnergy(exerciseSessionId)
            }
            exception.message shouldBe
                "Permission not granted to read exercise sessions " +
                "(android.permission.health.READ_EXERCISE)"
        }

        @Test
        @DisplayName(
            "GIVEN energy read denied → WHEN aggregating energy → THEN throws Authorization",
        )
        fun `active energy permission errors are preserved`() = runTest {
            // Given
            val exerciseSession = ExerciseSessionRecord(
                startTime = EXERCISE_SESSION_START,
                startZoneOffset = null,
                endTime = EXERCISE_SESSION_END,
                endZoneOffset = null,
                exerciseType = ExerciseSessionRecord.EXERCISE_TYPE_RUNNING,
                metadata = Metadata.manualEntry().populatedWithTestValues(
                    id = EXERCISE_SESSION_ID,
                    dataOrigin = DataOrigin(FAKE_PACKAGE_NAME),
                ),
            )
            fakeHealthConnectClient.overrides.readRecord = object :
                Stub<String, ReadRecordResponse<*>> {
                override fun next(request: String): ReadRecordResponse<*> {
                    request shouldBe EXERCISE_SESSION_ID
                    return ReadRecordResponse(exerciseSession)
                }
            }
            val exerciseSessionId = EXERCISE_SESSION_ID
            fakeHealthConnectClient.overrides.aggregate = object :
                Stub<AggregateRequest, AggregationResult> {
                override fun next(request: AggregateRequest): AggregationResult =
                    throw SecurityException("Active calories burned read denied")
            }

            // When / Then
            val exception = shouldThrow<HealthConnectorException.Authorization> {
                systemUnderTest.aggregateActiveEnergy(exerciseSessionId)
            }
            exception.message shouldBe
                "Permission not granted to read active calories burned " +
                "(android.permission.health.READ_ACTIVE_CALORIES_BURNED)"
        }

        private fun energyResult(kilocalories: Double): AggregationResult = createAggregationResult(
            metrics = buildMap {
                put(
                    ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL,
                    Energy.kilocalories(kilocalories),
                )
            },
        )
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
        const val EXERCISE_SESSION_ID = "exercise-session-id"
        val EXERCISE_SESSION_START: Instant = Instant.parse("2026-01-01T10:00:00Z")
        val EXERCISE_SESSION_END: Instant = Instant.parse("2026-01-01T11:00:00Z")
        const val FAKE_PACKAGE_NAME = "com.test"
        val FIXED_NOW: Instant = Instant.parse("2026-01-01T12:00:00Z")
    }
}
