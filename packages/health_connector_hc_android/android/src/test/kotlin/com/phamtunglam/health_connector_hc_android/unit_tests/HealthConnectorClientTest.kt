package com.phamtunglam.health_connector_hc_android.unit_tests

import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import com.phamtunglam.health_connector_hc_android.HealthConnectorClient
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.handlers.HealthRecordHandlerRegistry
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSegmentTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionSegmentEventDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
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
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.unmockkAll
import java.time.Instant
import kotlinx.coroutines.test.StandardTestDispatcher
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@DisplayName("HealthConnectorClient — exercise segment extended field validation")
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
    @DisplayName("GIVEN isExerciseSegmentWeightSupported → ")
    inner class ExerciseSegmentWeightSupport {

        @Test
        @DisplayName("WHEN SDK Extension 21 is missing → THEN returns false")
        fun returnsFalseWithoutExtension21() {
            buildClient(supportsExt21 = false).isExerciseSegmentWeightSupported() shouldBe false
        }

        @Test
        @DisplayName("WHEN SDK Extension 21 is present → THEN returns true")
        fun returnsTrueWithExtension21() {
            buildClient(supportsExt21 = true).isExerciseSegmentWeightSupported() shouldBe true
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
