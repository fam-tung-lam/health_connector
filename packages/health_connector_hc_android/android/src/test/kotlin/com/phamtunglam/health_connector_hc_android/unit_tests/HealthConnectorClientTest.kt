package com.phamtunglam.health_connector_hc_android.unit_tests

import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import com.phamtunglam.health_connector_hc_android.HealthConnectorClient
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.handlers.AggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthRecordHandlerRegistry
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ExerciseSessionHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSegmentTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionActiveEnergyAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionSegmentEventDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.StandardAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorDataOriginService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorDataSyncService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorFeatureService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorManifestService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorPermissionService
import com.phamtunglam.health_connector_hc_android.utils.MainDispatcherExtension
import com.phamtunglam.health_connector_hc_android.utils.TestDispatcherProvider
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldNotBeEmpty
import io.kotest.matchers.types.shouldBeInstanceOf
import io.mockk.MockKAnnotations
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.confirmVerified
import io.mockk.every
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.mockk
import io.mockk.unmockkAll
import io.mockk.verify
import java.time.Instant
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@DisplayName("HealthConnectorClient")
@ExtendWith(MainDispatcherExtension::class)
class HealthConnectorClientTest {

    @RelaxedMockK
    private lateinit var manifestService: HealthConnectorManifestService

    @RelaxedMockK
    private lateinit var featureService: HealthConnectorFeatureService

    @RelaxedMockK
    private lateinit var permissionService: HealthConnectorPermissionService

    @RelaxedMockK
    private lateinit var syncService: HealthConnectorDataSyncService

    @RelaxedMockK
    private lateinit var dataOriginService: HealthConnectorDataOriginService

    private lateinit var fakeHealthConnectClient: FakeHealthConnectClient
    private val testDispatcher = StandardTestDispatcher()

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        HealthConnectorLogger.isEnabled = false
        fakeHealthConnectClient = FakeHealthConnectClient(
            packageName = FAKE_PACKAGE_NAME,
            permissionController = FakePermissionController(grantAll = true),
        )
    }

    @AfterEach
    fun tearDown() {
        unmockkAll()
    }

    private fun buildClient(supportsExt21: Boolean): HealthConnectorClient {
        val dispatchers = TestDispatcherProvider(testDispatcher)
        val registry = HealthRecordHandlerRegistry(
            dispatchers = dispatchers,
            client = fakeHealthConnectClient,
        )
        return HealthConnectorClient(
            dispatchers = dispatchers,
            client = fakeHealthConnectClient,
            manifestService = manifestService,
            featureService = featureService,
            permissionService = permissionService,
            syncService = syncService,
            recordHandlerRegistry = registry,
            dataOriginService = dataOriginService,
            supportsHealthConnectSdkExtension21 = supportsExt21,
        )
    }

    @Nested
    @DisplayName("GIVEN writeRecord → ")
    inner class WriteRecord {

        @Test
        @DisplayName(
            "WHEN exercise session has segment with non-null weight on unsupported SDK → " +
                "THEN throws UnsupportedOperation",
        )
        fun `writeRecord throws on segment weight with unsupported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = false)
                val dto = buildExerciseSessionDto(weightKg = 80.0)

                val exception = shouldThrow<HealthConnectorException> {
                    client.writeRecord(dto)
                }
                exception.shouldBeInstanceOf<HealthConnectorException.UnsupportedOperation>()
                exception.message shouldBe EXPECTED_ERROR_MESSAGE
            }

        @Test
        @DisplayName(
            "WHEN exercise session has segment with non-null weight on supported SDK → " +
                "THEN write succeeds",
        )
        fun `writeRecord succeeds on segment weight with supported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = true)
                val dto = buildExerciseSessionDto(weightKg = 80.0)

                val id = client.writeRecord(dto)

                id.shouldNotBeEmpty()
            }

        @Test
        @DisplayName(
            "WHEN exercise session has segment with null weight on unsupported SDK → " +
                "THEN write succeeds",
        )
        fun `writeRecord succeeds on null segment weight with unsupported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = false)
                val dto = buildExerciseSessionDto(weightKg = null)

                val id = client.writeRecord(dto)

                id.shouldNotBeEmpty()
            }

        @Test
        @DisplayName(
            "WHEN exercise session has segment with non-null setIndex on unsupported SDK → " +
                "THEN throws UnsupportedOperation",
        )
        fun `writeRecord throws on segment setIndex with unsupported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = false)
                val dto = buildExerciseSessionDto(weightKg = null, setIndex = 2L)

                val exception = shouldThrow<HealthConnectorException> {
                    client.writeRecord(dto)
                }
                exception.shouldBeInstanceOf<HealthConnectorException.UnsupportedOperation>()
                exception.message shouldBe EXPECTED_ERROR_MESSAGE
            }

        @Test
        @DisplayName(
            "WHEN exercise session has segment with non-null rateOfPerceivedExertion on " +
                "unsupported SDK → THEN throws UnsupportedOperation",
        )
        fun `writeRecord throws on segment rateOfPerceivedExertion with unsupported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = false)
                val dto = buildExerciseSessionDto(
                    weightKg = null,
                    rateOfPerceivedExertion = 7.5,
                )

                val exception = shouldThrow<HealthConnectorException> {
                    client.writeRecord(dto)
                }
                exception.shouldBeInstanceOf<HealthConnectorException.UnsupportedOperation>()
                exception.message shouldBe EXPECTED_ERROR_MESSAGE
            }

        @Test
        @DisplayName(
            "WHEN exercise session has segment with non-null setIndex and " +
                "rateOfPerceivedExertion on supported SDK → THEN write succeeds",
        )
        fun `writeRecord succeeds on segment setIndex and RPE with supported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = true)
                val dto = buildExerciseSessionDto(
                    weightKg = null,
                    setIndex = 2L,
                    rateOfPerceivedExertion = 7.5,
                )

                val id = client.writeRecord(dto)

                id.shouldNotBeEmpty()
            }
    }

    @Nested
    @DisplayName("GIVEN writeRecords (batch) → ")
    inner class WriteRecords {

        @Test
        @DisplayName(
            "WHEN batch contains exercise session with segment weight on unsupported SDK → " +
                "THEN throws UnsupportedOperation",
        )
        fun `writeRecords throws on segment weight with unsupported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = false)
                val records = listOf(buildExerciseSessionDto(weightKg = 70.0))

                val exception = shouldThrow<HealthConnectorException> {
                    client.writeRecords(records)
                }
                exception.shouldBeInstanceOf<HealthConnectorException.UnsupportedOperation>()
                exception.message shouldBe EXPECTED_ERROR_MESSAGE
            }

        @Test
        @DisplayName(
            "WHEN batch contains exercise session with segment weight on supported SDK → " +
                "THEN write succeeds",
        )
        fun `writeRecords succeeds on segment weight with supported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = true)
                val records = listOf(buildExerciseSessionDto(weightKg = 70.0))

                val ids = client.writeRecords(records)

                ids.size shouldBe 1
                ids.first().shouldNotBeEmpty()
            }

        @Test
        @DisplayName(
            "WHEN batch contains exercise session with null weight on unsupported SDK → " +
                "THEN write succeeds",
        )
        fun `writeRecords succeeds on null segment weight with unsupported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = false)
                val records = listOf(buildExerciseSessionDto(weightKg = null))

                val ids = client.writeRecords(records)

                ids.size shouldBe 1
            }
    }

    @Nested
    @DisplayName("GIVEN updateRecord → ")
    inner class UpdateRecord {

        @Test
        @DisplayName(
            "WHEN exercise session has segment with non-null weight on unsupported SDK → " +
                "THEN throws UnsupportedOperation",
        )
        fun `updateRecord throws on segment weight with unsupported SDK`() =
            runTest(testDispatcher) {
                val supportedClient = buildClient(supportsExt21 = true)
                val writtenId = supportedClient.writeRecord(
                    buildExerciseSessionDto(weightKg = null),
                )

                val unsupportedClient = buildClient(supportsExt21 = false)
                val updateDto = buildExerciseSessionDto(weightKg = 75.0, id = writtenId)

                val exception = shouldThrow<HealthConnectorException> {
                    unsupportedClient.updateRecord(updateDto)
                }
                exception.shouldBeInstanceOf<HealthConnectorException.UnsupportedOperation>()
                exception.message shouldBe EXPECTED_ERROR_MESSAGE
            }

        @Test
        @DisplayName(
            "WHEN exercise session has segment with null weight on unsupported SDK → " +
                "THEN update succeeds",
        )
        fun `updateRecord succeeds on null segment weight with unsupported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = false)
                val writtenId = client.writeRecord(buildExerciseSessionDto(weightKg = null))
                val updateDto = buildExerciseSessionDto(weightKg = null, id = writtenId)

                // Should not throw
                client.updateRecord(updateDto)
            }
    }

    @Nested
    @DisplayName("GIVEN updateRecords (batch) → ")
    inner class UpdateRecords {

        @Test
        @DisplayName(
            "WHEN batch contains exercise session with segment weight on unsupported SDK → " +
                "THEN throws UnsupportedOperation",
        )
        fun `updateRecords throws on segment weight with unsupported SDK`() =
            runTest(testDispatcher) {
                val supportedClient = buildClient(supportsExt21 = true)
                val writtenId = supportedClient.writeRecord(
                    buildExerciseSessionDto(weightKg = null),
                )

                val unsupportedClient = buildClient(supportsExt21 = false)
                val records = listOf(buildExerciseSessionDto(weightKg = 80.0, id = writtenId))

                val exception = shouldThrow<HealthConnectorException> {
                    unsupportedClient.updateRecords(records)
                }
                exception.shouldBeInstanceOf<HealthConnectorException.UnsupportedOperation>()
                exception.message shouldBe EXPECTED_ERROR_MESSAGE
            }

        @Test
        @DisplayName(
            "WHEN batch contains exercise session with null weight on unsupported SDK → " +
                "THEN update succeeds",
        )
        fun `updateRecords succeeds on null segment weight with unsupported SDK`() =
            runTest(testDispatcher) {
                val client = buildClient(supportsExt21 = false)
                val writtenId = client.writeRecord(buildExerciseSessionDto(weightKg = null))
                val records = listOf(buildExerciseSessionDto(weightKg = null, id = writtenId))

                // Should not throw
                client.updateRecords(records)
            }
    }

    @Nested
    @DisplayName("GIVEN aggregation request routing → ")
    inner class Aggregate {
        private lateinit var systemUnderTest: HealthConnectorClient
        private lateinit var recordHandlerRegistry: HealthRecordHandlerRegistry

        @BeforeEach
        fun setUpClient() {
            recordHandlerRegistry = mockk()
            systemUnderTest = HealthConnectorClient(
                dispatchers = TestDispatcherProvider(testDispatcher),
                client = fakeHealthConnectClient,
                manifestService = manifestService,
                featureService = featureService,
                permissionService = permissionService,
                syncService = syncService,
                recordHandlerRegistry = recordHandlerRegistry,
                dataOriginService = dataOriginService,
                supportsHealthConnectSdkExtension21 = false,
            )
        }

        @Test
        @DisplayName(
            "WHEN aggregating a standard request → THEN calls its aggregation handler",
        )
        fun `standard requests route to their data type handler`() = runTest(testDispatcher) {
            // Given
            val request = StandardAggregateRequestDto(
                aggregationMetric = AggregationMetricDto.SUM,
                dataType = HealthDataTypeDto.STEPS,
                startTime = FIXED_NOW.minusSeconds(3600).toEpochMilli(),
                endTime = FIXED_NOW.toEpochMilli(),
            )
            val handler = mockk<AggregatableHealthRecordHandler>()
            every {
                recordHandlerRegistry.getRecordHandler(HealthDataTypeDto.STEPS)
            } returns handler
            coEvery { handler.aggregate(request) } returns 5000.0

            // When
            val result = systemUnderTest.aggregate(request)

            // Then
            result shouldBe 5000.0
            verify(exactly = 1) {
                recordHandlerRegistry.getRecordHandler(HealthDataTypeDto.STEPS)
            }
            coVerify(exactly = 1) { handler.aggregate(request) }
            confirmVerified(recordHandlerRegistry, handler)
        }

        @Test
        @DisplayName(
            "WHEN aggregating a blood pressure request → THEN calls its aggregation handler",
        )
        fun `blood pressure requests route to the blood pressure handler`() =
            runTest(testDispatcher) {
                // Given
                val request = BloodPressureAggregateRequestDto(
                    aggregationMetric = AggregationMetricDto.AVG,
                    bloodPressureDataType = BloodPressureDataTypeDto.SYSTOLIC,
                    startTime = FIXED_NOW.minusSeconds(3600).toEpochMilli(),
                    endTime = FIXED_NOW.toEpochMilli(),
                )
                val handler = mockk<AggregatableHealthRecordHandler>()
                every {
                    recordHandlerRegistry.getRecordHandler(HealthDataTypeDto.BLOOD_PRESSURE)
                } returns handler
                coEvery { handler.aggregate(request) } returns 120.0

                // When
                val result = systemUnderTest.aggregate(request)

                // Then
                result shouldBe 120.0
                verify(exactly = 1) {
                    recordHandlerRegistry.getRecordHandler(HealthDataTypeDto.BLOOD_PRESSURE)
                }
                coVerify(exactly = 1) { handler.aggregate(request) }
                confirmVerified(recordHandlerRegistry, handler)
            }

        @Test
        @DisplayName(
            "WHEN aggregating an activity intensity request → THEN calls its aggregation handler",
        )
        fun `activity intensity requests route to the activity intensity handler`() =
            runTest(testDispatcher) {
                // Given
                val request = ActivityIntensityAggregateRequestDto(
                    dataType = HealthDataTypeDto.ACTIVITY_INTENSITY,
                    intensityType = null,
                    startTime = FIXED_NOW.minusSeconds(3600).toEpochMilli(),
                    endTime = FIXED_NOW.toEpochMilli(),
                )
                val handler = mockk<AggregatableHealthRecordHandler>()
                every {
                    recordHandlerRegistry.getRecordHandler(HealthDataTypeDto.ACTIVITY_INTENSITY)
                } returns handler
                coEvery { handler.aggregate(request) } returns 30.0

                // When
                val result = systemUnderTest.aggregate(request)

                // Then
                result shouldBe 30.0
                verify(exactly = 1) {
                    recordHandlerRegistry.getRecordHandler(HealthDataTypeDto.ACTIVITY_INTENSITY)
                }
                coVerify(exactly = 1) { handler.aggregate(request) }
                confirmVerified(recordHandlerRegistry, handler)
            }

        @Test
        @DisplayName(
            "WHEN aggregating exercise session active energy → " +
                "THEN calls the exercise session handler's active energy operation",
        )
        fun `active energy requests route to the exercise session handler`() =
            runTest(testDispatcher) {
                // Given
                val request = ExerciseSessionActiveEnergyAggregateRequestDto(
                    exerciseSessionId = "saved-exercise-session",
                    startTime = FIXED_NOW.minusSeconds(3600).toEpochMilli(),
                    endTime = FIXED_NOW.toEpochMilli(),
                )
                val handler = mockk<ExerciseSessionHandler>()
                every {
                    recordHandlerRegistry.getRecordHandler(HealthDataTypeDto.EXERCISE_SESSION)
                } returns handler
                coEvery {
                    handler.aggregateActiveEnergy(request.exerciseSessionId)
                } returns 279.0

                // When
                val result = systemUnderTest.aggregate(request)

                // Then
                result shouldBe 279.0
                verify(exactly = 1) {
                    recordHandlerRegistry.getRecordHandler(HealthDataTypeDto.EXERCISE_SESSION)
                }
                coVerify(exactly = 1) {
                    handler.aggregateActiveEnergy(request.exerciseSessionId)
                }
                confirmVerified(recordHandlerRegistry, handler)
            }
    }

    private fun buildExerciseSessionDto(
        weightKg: Double?,
        id: String? = null,
        setIndex: Long? = null,
        rateOfPerceivedExertion: Double? = null,
    ): ExerciseSessionRecordDto {
        val startTime = FIXED_NOW.minusSeconds(3600).toEpochMilli()
        val endTime = FIXED_NOW.toEpochMilli()
        return ExerciseSessionRecordDto(
            id = id,
            startTime = startTime,
            endTime = endTime,
            exerciseType = ExerciseTypeDto.RUNNING,
            events = listOf(
                ExerciseSessionSegmentEventDto(
                    startTime = startTime,
                    endTime = FIXED_NOW.minusSeconds(1800).toEpochMilli(),
                    segmentType = ExerciseSegmentTypeDto.RUNNING,
                    repetitions = null,
                    weightKg = weightKg,
                    setIndex = setIndex,
                    rateOfPerceivedExertion = rateOfPerceivedExertion,
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
        // The fake client and the test records deliberately share the SAME package name.
        // These tests verify SDK Extension 21 weight handling, not record ownership, and
        // `MetadataMapper.toHealthConnect` cannot set `dataOrigin` (Health Connect assigns the
        // owner package at write time), so DTO-mapped records carry an empty package name.
        // `FakeHealthConnectClient.updateRecords` rejects a record whose
        // `dataOrigin.packageName` differs from its own `packageName`, so the fake uses this
        // same empty package name and the ownership check stays a no-op.
        const val FAKE_PACKAGE_NAME = ""
        val FIXED_NOW: Instant = Instant.parse("2026-01-01T12:00:00Z")
        const val EXPECTED_ERROR_MESSAGE =
            "Writing ExerciseSessionSegmentEvent.weight, setIndex or " +
                "rateOfPerceivedExertion requires Health Connect SDK Extension 21 " +
                "(Android 14+ with the latest Health Connect Mainline update). " +
                "This device does not meet the requirement."
    }
}
