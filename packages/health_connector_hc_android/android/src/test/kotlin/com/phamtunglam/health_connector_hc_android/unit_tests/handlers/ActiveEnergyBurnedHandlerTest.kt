package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.metadata.Device
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.testing.AggregationResult
import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import androidx.health.connect.client.testing.stubs.stub
import androidx.health.connect.client.time.TimeRangeFilter
import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ActiveEnergyBurnedHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.ActiveEnergyBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
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
import org.junit.jupiter.api.Disabled
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@DisplayName("ActiveCaloriesBurnedHandler")
@ExtendWith(MainDispatcherExtension::class)
class ActiveEnergyBurnedHandlerTest {

    private lateinit var fakePermissionController: FakePermissionController
    private lateinit var fakeHealthConnectClient: FakeHealthConnectClient
    private lateinit var systemUnderTest: ActiveEnergyBurnedHandler

    @BeforeEach
    fun setUp() {
        HealthConnectorLogger.isEnabled = false
        fakePermissionController = FakePermissionController(grantAll = true)
        fakeHealthConnectClient = FakeHealthConnectClient(
            packageName = FAKE_PACKAGE_NAME,
            permissionController = fakePermissionController,
        )
        systemUnderTest = ActiveEnergyBurnedHandler(
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
            "THEN returns ACTIVE_CALORIES_BURNED",
    )
    fun `handler has correct data type`() {
        systemUnderTest.dataType shouldBe HealthDataTypeDto.ACTIVE_CALORIES_BURNED
    }

    @Test
    @DisplayName(
        "GIVEN handler → " +
            "WHEN checking aggregateMetricMappings → " +
            "THEN returns supported SUM metric",
    )
    fun `handler has correct aggregateMetricMappings`() {
        systemUnderTest.aggregateMetricMappings shouldBe mapOf(
            AggregationMetricDto.SUM to ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL,
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
            val energyValue = 123.456
            val dto = ActiveEnergyBurnedRecordDto(
                startTime = startTime,
                endTime = endTime,
                energy = EnergyDto(
                    kilocalories = energyValue,
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
                    recordType = ActiveCaloriesBurnedRecord::class,
                    timeRangeFilter = TimeRangeFilter.between(
                        Instant.ofEpochMilli(startTime),
                        Instant.ofEpochMilli(endTime).plusSeconds(1),
                    ),
                ),
            ).records.firstOrNull { it.metadata.id == id }

            storedRecord shouldNotBe null
            storedRecord?.energy?.inKilocalories shouldBe energyValue
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
                ActiveCaloriesBurnedRecord(
                    startTime = startTime.plusSeconds(i * 3600L),
                    startZoneOffset = ZoneOffset.UTC,
                    endTime = startTime.plusSeconds(i * 3600L + 1800),
                    endZoneOffset = ZoneOffset.UTC,
                    energy = Energy.kilocalories(i * 10.0),
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
                dto.shouldBeInstanceOf<ActiveEnergyBurnedRecordDto>()
                dto.energy.kilocalories shouldBe (index + 1) * 10.0
            }
        }

        @Test
        @DisplayName(
            "WHEN reading with pagination → " +
                "THEN returns paged results",
        )
        fun `read records with pagination`() = runTest {
            val endTime = FIXED_NOW
            val startTime = endTime.minusSeconds(86400 + 3600)

            // Page 1
            val result1 = systemUnderTest.readRecords(
                startTime = startTime,
                endTime = endTime,
                pageSize = 2,
            )
            result1.first.size shouldBe 2
            result1.second.shouldNotBeEmpty() // next page token

            // Page 2
            val result2 = systemUnderTest.readRecords(
                startTime = startTime,
                endTime = endTime,
                pageSize = 2,
                pageToken = result1.second,
            )
            result2.first.size shouldBe 2
            result2.second.shouldNotBeEmpty()

            // Page 3
            val result3 = systemUnderTest.readRecords(
                startTime = startTime,
                endTime = endTime,
                pageSize = 2,
                pageToken = result2.second,
            )
            result3.first.size shouldBe 1
            // Last page token might be null or empty depending on implementation,
            // usually null if no more records, but handler returns String?
        }
    }

    @Disabled(
        "Test fails with the error: " +
            "```Permission not granted for ACTIVE_CALORIES_BURNED: " +
            "Trying to update records owned by another package```. " +
            "Even when `FakeHealthConnectClient` is initialized with the same package name.",
    )
    @Nested
    @DisplayName("GIVEN updating records → ")
    inner class UpdateRecords {

        @Test
        @DisplayName(
            "WHEN updating a record → " +
                "THEN fields are updated correctly",
        )
        fun `update record`() = runTest {
            // Arrange
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW
            val initialEnergy = 100.0
            val record = ActiveCaloriesBurnedRecord(
                startTime = startTime,
                startZoneOffset = ZoneOffset.UTC,
                endTime = endTime,
                endZoneOffset = ZoneOffset.UTC,
                energy = Energy.kilocalories(initialEnergy),
                metadata = Metadata.manualEntry(
                    device = Device(
                        manufacturer = "TestBrand",
                        model = "TestModel",
                        type = 2,
                    ),
                ),
            )
            fakeHealthConnectClient.insertRecords(listOf(record))
            val recordId = fakeHealthConnectClient.readRecords(
                ReadRecordsRequest(
                    recordType = ActiveCaloriesBurnedRecord::class,
                    timeRangeFilter = TimeRangeFilter.between(
                        startTime.minusSeconds(1),
                        endTime.plusSeconds(1),
                    ),
                ),
            ).records.first().metadata.id

            // Act
            val updatedEnergy = 200.0
            val updateDto = ActiveEnergyBurnedRecordDto(
                id = recordId,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                energy = EnergyDto(
                    kilocalories = updatedEnergy,
                ),
                metadata = MetadataDto(
                    dataOrigin = FAKE_PACKAGE_NAME,
                    deviceType = DeviceTypeDto.PHONE,
                    recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                ),
            )
            systemUnderTest.updateRecord(updateDto)

            // Assert
            val storedRecord = fakeHealthConnectClient.readRecords(
                ReadRecordsRequest(
                    recordType = ActiveCaloriesBurnedRecord::class,
                    timeRangeFilter = TimeRangeFilter.between(
                        startTime.minusSeconds(1),
                        endTime.plusSeconds(1),
                    ),
                ),
            ).records.first { it.metadata.id == recordId }

            storedRecord.energy.inKilocalories shouldBe updatedEnergy
        }
    }

    @Nested
    @DisplayName(
        "GIVEN deleting records → ",
    )
    inner class DeleteRecords {

        @Test
        @DisplayName(
            "WHEN deleting by ID → " +
                "THEN record is removed",
        )
        fun `delete record by id`() = runTest {
            // Arrange
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW
            val record = ActiveCaloriesBurnedRecord(
                startTime = startTime,
                startZoneOffset = ZoneOffset.UTC,
                endTime = endTime,
                endZoneOffset = ZoneOffset.UTC,
                energy = Energy.kilocalories(100.0),
                metadata = Metadata.manualEntry(
                    device = Device(manufacturer = "TestBrand", model = "TestModel", type = 1),
                ),
            )
            fakeHealthConnectClient.insertRecords(listOf(record))
            val recordId = fakeHealthConnectClient.readRecords(
                ReadRecordsRequest(
                    recordType = ActiveCaloriesBurnedRecord::class,
                    timeRangeFilter = TimeRangeFilter.between(
                        startTime.minusSeconds(1),
                        endTime.plusSeconds(1),
                    ),
                ),
            ).records.first().metadata.id

            // Act
            systemUnderTest.deleteRecords(listOf(recordId))

            // Assert
            val remainingRecords = fakeHealthConnectClient.readRecords(
                ReadRecordsRequest(
                    recordType = ActiveCaloriesBurnedRecord::class,
                    timeRangeFilter = TimeRangeFilter.between(
                        startTime.minusSeconds(1),
                        endTime.plusSeconds(1),
                    ),
                ),
            ).records
            remainingRecords.isEmpty() shouldBe true
        }

        @Test
        @DisplayName(
            "WHEN deleting by time range → " +
                "THEN records in range are removed",
        )
        fun `delete records by time range`() = runTest {
            // Arrange
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW
            val record = ActiveCaloriesBurnedRecord(
                startTime = startTime,
                startZoneOffset = ZoneOffset.UTC,
                endTime = endTime,
                endZoneOffset = ZoneOffset.UTC,
                energy = Energy.kilocalories(100.0),
                metadata = Metadata.manualEntry(
                    device = Device(manufacturer = "TestBrand", model = "TestModel", type = 1),
                ),
            )
            fakeHealthConnectClient.insertRecords(listOf(record))

            // Act
            systemUnderTest.deleteRecordsByTimeRange(
                startTime = startTime.minusSeconds(1),
                endTime = endTime.plusSeconds(1),
            )

            // Assert
            val remainingRecords = fakeHealthConnectClient.readRecords(
                ReadRecordsRequest(
                    recordType = ActiveCaloriesBurnedRecord::class,
                    timeRangeFilter = TimeRangeFilter.between(
                        startTime.minusSeconds(1),
                        endTime.plusSeconds(1),
                    ),
                ),
            ).records
            remainingRecords.isEmpty() shouldBe true
        }
    }

    @Nested
    @DisplayName(
        "GIVEN aggregation → ",
    )
    inner class Aggregation {

        @Test
        @DisplayName(
            "WHEN aggregating sum → " +
                "THEN returns correct value",
        )
        fun `aggregate sum with common request`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW
            val expectedEnergy = 150.0

            val result = AggregationResult(
                metrics = buildMap {
                    put(
                        ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL,
                        Energy.kilocalories(expectedEnergy),
                    )
                },
            )
            fakeHealthConnectClient.overrides.aggregate = stub(result)

            val request = CommonAggregateRequestDto(
                dataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                aggregationMetric = AggregationMetricDto.SUM,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            val response = systemUnderTest.aggregate(request)

            response.shouldBeInstanceOf<EnergyDto>()
            response.kilocalories shouldBe expectedEnergy
        }

        @Test
        @DisplayName(
            "WHEN aggregating with invalid time range → " +
                "THEN throws HealthConnectorErrorDto",
        )
        fun `aggregate with invalid time range`() = runTest {
            val startTime = FIXED_NOW
            val endTime = startTime.minusSeconds(3600) // end before start

            val request = CommonAggregateRequestDto(
                dataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                aggregationMetric = AggregationMetricDto.SUM,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            val result = runCatching {
                systemUnderTest.aggregate(request)
            }

            result.isFailure shouldBe true
            result.exceptionOrNull().shouldBeInstanceOf<HealthConnectorException.InvalidArgument>()
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

            // ActiveCaloriesBurnedHandler only supports SUM
            val request = CommonAggregateRequestDto(
                dataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                aggregationMetric = AggregationMetricDto.AVG, // AVG is not supported
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            // When && Then
            shouldThrow<HealthConnectorException.InvalidArgument> {
                systemUnderTest.aggregate(request)
            }
        }

        @Test
        @DisplayName(
            "WHEN aggregating with unsupported data type → " +
                "THEN throws HealthConnectorErrorDto",
        )
        fun `aggregate with unsupported data type`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW

            val result = AggregationResult(
                metrics = buildMap {
                    // Empty map or wrong metric
                },
            )
            fakeHealthConnectClient.overrides.aggregate = stub(result)

            val request = CommonAggregateRequestDto(
                dataType = HealthDataTypeDto.HYDRATION,
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
