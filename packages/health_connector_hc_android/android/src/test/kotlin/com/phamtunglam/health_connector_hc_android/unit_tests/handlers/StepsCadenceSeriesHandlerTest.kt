package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import androidx.health.connect.client.records.StepsCadenceRecord
import androidx.health.connect.client.records.metadata.Device
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.testing.AggregationResult
import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import androidx.health.connect.client.testing.stubs.stub
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.StepsCadenceSeriesHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import com.phamtunglam.health_connector_hc_android.pigeon.StandardAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepsCadenceSampleDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepsCadenceSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.utils.MainDispatcherExtension
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.kotest.matchers.string.shouldNotBeEmpty
import io.kotest.matchers.types.shouldBeInstanceOf
import io.mockk.unmockkAll
import java.time.Instant
import java.time.ZoneOffset
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@DisplayName("StepsCadenceSeriesHandler")
@ExtendWith(MainDispatcherExtension::class)
class StepsCadenceSeriesHandlerTest {

    private lateinit var fakePermissionController: FakePermissionController
    private lateinit var fakeHealthConnectClient: FakeHealthConnectClient
    private lateinit var systemUnderTest: StepsCadenceSeriesHandler

    @BeforeEach
    fun setUp() {
        HealthConnectorLogger.isEnabled = false
        fakePermissionController = FakePermissionController(grantAll = true)
        fakeHealthConnectClient = FakeHealthConnectClient(
            packageName = FAKE_PACKAGE_NAME,
            permissionController = fakePermissionController,
        )
        systemUnderTest = StepsCadenceSeriesHandler(
            // `MainDispatcherExtension` sets `Dispatchers.Main` to `StandardTestDispatcher`, so
            // we can use `Dispatchers.Main.immediate` to get the test dispatcher.
            dispatcher = Dispatchers.Main.immediate,
            client = fakeHealthConnectClient,
        )
    }

    @AfterEach
    fun tearDown() {
        unmockkAll()
    }

    @Test
    @DisplayName(
        "GIVEN handler → " +
            "WHEN checking dataType → " +
            "THEN returns STEPS_CADENCE_SERIES_RECORD",
    )
    fun `handler has correct data type`() {
        systemUnderTest.dataType shouldBe HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD
    }

    @Test
    @DisplayName(
        "GIVEN handler → " +
            "WHEN checking aggregateMetricMappings → " +
            "THEN returns supported AVG, MIN, MAX metrics",
    )
    fun `handler has correct aggregateMetricMappings`() {
        systemUnderTest.aggregateMetricMappings shouldBe mapOf(
            AggregationMetricDto.AVG to StepsCadenceRecord.RATE_AVG,
            AggregationMetricDto.MIN to StepsCadenceRecord.RATE_MIN,
            AggregationMetricDto.MAX to StepsCadenceRecord.RATE_MAX,
        )
    }

    @Nested
    @DisplayName(
        "GIVEN writing records → ",
    )
    inner class WriteRecords {

        @Test
        @DisplayName(
            "WHEN writing a record → " +
                "THEN it returns a valid ID and data is persisted",
        )
        fun `write record and verify persistence`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(3600).toEpochMilli()
            val endTime = FIXED_NOW.toEpochMilli()
            val cadenceValue = 120.0
            val dto = StepsCadenceSeriesRecordDto(
                startTime = startTime,
                endTime = endTime,
                samples = listOf(
                    StepsCadenceSampleDto(
                        time = startTime,
                        stepsPerMinute = cadenceValue,
                    ),
                ),
                metadata = MetadataDto(
                    dataOrigin = "com.test",
                    deviceType = DeviceTypeDto.PHONE,
                    recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                ),
            )

            val id = systemUnderTest.writeRecord(dto)

            id.shouldNotBeEmpty()

            // Verify persistence by reading back
            val storedRecord = fakeHealthConnectClient.readRecords(
                ReadRecordsRequest(
                    recordType = StepsCadenceRecord::class,
                    timeRangeFilter = TimeRangeFilter.between(
                        Instant.ofEpochMilli(startTime),
                        Instant.ofEpochMilli(endTime).plusSeconds(1),
                    ),
                ),
            ).records.firstOrNull { it.metadata.id == id }

            storedRecord shouldNotBe null
            storedRecord?.samples?.first()?.rate shouldBe cadenceValue
        }
    }

    @Nested
    @DisplayName(
        "GIVEN reading records → ",
    )
    inner class ReadRecords {

        @BeforeEach
        fun setUpRecords() = runTest {
            val startTime = FIXED_NOW.minusSeconds(86400) // 24h ago
            val records = (1..5).map { i ->
                StepsCadenceRecord(
                    startTime = startTime.plusSeconds(i * 3600L),
                    startZoneOffset = ZoneOffset.UTC,
                    endTime = startTime.plusSeconds(i * 3600L + 1800),
                    endZoneOffset = ZoneOffset.UTC,
                    samples = listOf(
                        StepsCadenceRecord.Sample(
                            time = startTime.plusSeconds(i * 3600L),
                            rate = i * 10.0,
                        ),
                    ),
                    metadata = Metadata.manualEntry(
                        device = Device(manufacturer = "TestBrand", model = "TestModel", type = 1),
                    ),
                )
            }
            fakeHealthConnectClient.insertRecords(records)
        }

        @Test
        @DisplayName(
            "WHEN reading records by time range → " +
                "THEN returns correct records",
        )
        fun `read records by time range`() = runTest {
            // Read all 24h
            val endTime = FIXED_NOW
            val startTime = endTime.minusSeconds(86400 + 3600) // cover all

            val result = systemUnderTest.readRecords(
                startTime = startTime,
                endTime = endTime,
            )

            result.first.size shouldBe 5
            result.first.forEachIndexed { index, dto ->
                dto.shouldBeInstanceOf<StepsCadenceSeriesRecordDto>()
                dto.samples?.first()?.stepsPerMinute shouldBe (index + 1) * 10.0
            }
        }
    }

    @Nested
    @DisplayName(
        "GIVEN aggregation → ",
    )
    inner class Aggregation {

        @Test
        @DisplayName(
            "WHEN aggregating AVG → " +
                "THEN returns correct value",
        )
        fun `aggregate avg with common request`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW
            val expectedAvg = 120.0

            val result = AggregationResult(
                metrics = buildMap {
                    put(
                        StepsCadenceRecord.RATE_AVG,
                        expectedAvg,
                    )
                },
            )
            fakeHealthConnectClient.overrides.aggregate = stub(result)

            val request = StandardAggregateRequestDto(
                dataType = HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD,
                aggregationMetric = AggregationMetricDto.AVG,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            val response = systemUnderTest.aggregate(request)

            response shouldBe expectedAvg
        }

        @Test
        @DisplayName(
            "WHEN aggregating MIN → " +
                "THEN returns correct value",
        )
        fun `aggregate min with common request`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW
            val expectedMin = 100.0

            val result = AggregationResult(
                metrics = buildMap {
                    put(
                        StepsCadenceRecord.RATE_MIN,
                        expectedMin,
                    )
                },
            )
            fakeHealthConnectClient.overrides.aggregate = stub(result)

            val request = StandardAggregateRequestDto(
                dataType = HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD,
                aggregationMetric = AggregationMetricDto.MIN,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            val response = systemUnderTest.aggregate(request)

            response shouldBe expectedMin
        }

        @Test
        @DisplayName(
            "WHEN aggregating MAX → " +
                "THEN returns correct value",
        )
        fun `aggregate max with common request`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW
            val expectedMax = 150.0

            val result = AggregationResult(
                metrics = buildMap {
                    put(
                        StepsCadenceRecord.RATE_MAX,
                        expectedMax,
                    )
                },
            )
            fakeHealthConnectClient.overrides.aggregate = stub(result)

            val request = StandardAggregateRequestDto(
                dataType = HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD,
                aggregationMetric = AggregationMetricDto.MAX,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            val response = systemUnderTest.aggregate(request)

            response shouldBe expectedMax
        }

        @Test
        @DisplayName(
            "WHEN aggregating with unsupported metric → " +
                "THEN throws HealthConnectorErrorDto",
        )
        fun `aggregate with unsupported metric`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW

            val result = AggregationResult(
                metrics = buildMap {
                    // Empty map or wrong metric
                },
            )
            fakeHealthConnectClient.overrides.aggregate = stub(result)

            // SUM is not supported for Steps Cadence
            val request = StandardAggregateRequestDto(
                dataType = HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD,
                aggregationMetric = AggregationMetricDto.SUM,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            // When && Then
            shouldThrow<HealthConnectorException.InvalidArgument> {
                systemUnderTest.aggregate(request)
            }
        }
    }

    private companion object Companion {
        const val FAKE_PACKAGE_NAME = "com.test"
        val FIXED_NOW: Instant = Instant.parse("2026-01-01T12:00:00Z")
    }
}
