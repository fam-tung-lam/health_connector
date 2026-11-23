package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import android.os.ext.SdkExtensions
import androidx.health.connect.client.aggregate.AggregationResultGroupedByPeriod
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.ActivityIntensityRecord
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.testing.AggregationResult
import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import androidx.health.connect.client.testing.stubs.stub
import androidx.health.connect.client.units.Energy
import androidx.health.connect.client.units.Mass
import androidx.health.connect.client.units.Pressure
import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ActiveEnergyBurnedHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ActivityIntensityHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BloodPressureHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HydrationHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.StepsHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.WeightHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.StandardAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.utils.MainDispatcherExtension
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import io.mockk.every
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import java.time.Duration
import java.time.LocalDate
import java.time.ZoneId
import java.util.TimeZone
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

@DisplayName("Daily aggregation")
@ExtendWith(MainDispatcherExtension::class)
class DailyAggregatableHealthRecordHandlerTest {
    private lateinit var client: FakeHealthConnectClient
    private lateinit var systemUnderTest: HealthConnectAggregatableHealthRecordHandler
    private lateinit var previousTimeZone: TimeZone
    private val zone = ZoneId.of("Europe/Berlin")

    @BeforeEach
    fun setUp() {
        HealthConnectorLogger.isEnabled = false
        previousTimeZone = TimeZone.getDefault()
        TimeZone.setDefault(TimeZone.getTimeZone(zone))
        client = FakeHealthConnectClient(
            permissionController = FakePermissionController(grantAll = true),
        )
        systemUnderTest = HydrationHandler(dispatcher = Dispatchers.Main.immediate, client = client)
    }

    @AfterEach
    fun tearDown() {
        TimeZone.setDefault(previousTimeZone)
    }

    @Test
    @DisplayName(
        "GIVEN spring DST and sparse buckets → WHEN queried → THEN preserves zero, empty days and 23-hour days",
    )
    fun `fills missing days and preserves measured zero`() = runTest {
        // Given
        val start = LocalDate.of(2026, 3, 28)
        client.overrides.aggregateGroupByPeriod = stub<List<AggregationResultGroupedByPeriod>>(
            listOf(
                AggregationResultGroupedByPeriod(
                    result = AggregationResult(
                        metrics = mapOf(HydrationRecord.VOLUME_TOTAL to Volume.liters(0.0)),
                    ),
                    startTime = start.atStartOfDay(),
                    endTime = start.plusDays(1).atStartOfDay(),
                ),
                AggregationResultGroupedByPeriod(
                    result = AggregationResult(
                        metrics = mapOf(HydrationRecord.VOLUME_TOTAL to Volume.liters(2.5)),
                    ),
                    startTime = start.plusDays(2).atStartOfDay(),
                    endTime = start.plusDays(3).atStartOfDay(),
                ),
            ),
        )
        // When
        val days = systemUnderTest.aggregateByDay(request(start, start.plusDays(3)))
        // Then
        days.map { it.value } shouldBe listOf(0.0, null, 2.5)
        days.map {
            Duration.ofMillis(it.endTime - it.startTime).toHours()
        } shouldBe listOf(24L, 23L, 24L)
        days.last().endTime shouldBe start.plusDays(3).atStartOfDay(zone).toInstant().toEpochMilli()
    }

    @Test
    @DisplayName("GIVEN autumn DST → WHEN queried → THEN returns one 25-hour day")
    fun `uses calendar days over autumn transition`() = runTest {
        // Given
        client.overrides.aggregateGroupByPeriod = stub<List<AggregationResultGroupedByPeriod>>(
            default = emptyList(),
        )
        val start = LocalDate.of(2026, 10, 25)
        // When
        val days = systemUnderTest.aggregateByDay(request(start, start.plusDays(1)))
        // Then
        days.size shouldBe 1
        days.single().value shouldBe null
        Duration.ofMillis(days.single().endTime - days.single().startTime).toHours() shouldBe 25L
    }

    @Test
    @DisplayName("GIVEN partial day → WHEN queried → THEN returns InvalidArgument")
    fun `rejects partial calendar days`() = runTest {
        // Given
        val start = LocalDate.of(2026, 3, 28)
        val invalid = request(
            start,
            start.plusDays(1),
        ).copy(startTime = start.atTime(12, 0).atZone(zone).toInstant().toEpochMilli())
        // When / Then
        shouldThrow<HealthConnectorException.InvalidArgument> {
            systemUnderTest.aggregateByDay(invalid)
        }
    }

    @Test
    @DisplayName("GIVEN active energy → WHEN queried → THEN converts native energy to kilocalories")
    fun `converts energy units`() = runTest {
        // Given
        val start = LocalDate.of(2026, 3, 28)
        systemUnderTest = ActiveEnergyBurnedHandler(
            dispatcher = Dispatchers.Main.immediate,
            client = client,
        )
        client.overrides.aggregateGroupByPeriod = stub<List<AggregationResultGroupedByPeriod>>(
            listOf(
                AggregationResultGroupedByPeriod(
                    result = AggregationResult(
                        metrics = mapOf(
                            ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL to Energy.kilocalories(
                                123.5,
                            ),
                        ),
                    ),
                    startTime = start.atStartOfDay(),
                    endTime = start.plusDays(1).atStartOfDay(),
                ),
            ),
        )
        // When
        val days = systemUnderTest.aggregateByDay(
            request(
                start,
                start.plusDays(1),
            ).copy(dataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED),
        )
        // Then
        days.single().value shouldBe 123.5
    }

    @Test
    @DisplayName("GIVEN steps → WHEN grouped daily → THEN returns native counts")
    fun `groups steps without a data type allowlist`() = runTest {
        // Given
        val start = LocalDate.of(2026, 3, 28)
        systemUnderTest = StepsHandler(dispatcher = Dispatchers.Main.immediate, client = client)
        val result = AggregationResult(metrics = mapOf(StepsRecord.COUNT_TOTAL to 1234L))
        client.overrides.aggregateGroupByPeriod = stub(
            default = listOf(
                AggregationResultGroupedByPeriod(
                    result,
                    start.atStartOfDay(),
                    start.plusDays(1).atStartOfDay(),
                ),
            ),
        )
        // When
        val days = systemUnderTest.aggregateByDay(
            request(start, start.plusDays(1)).copy(dataType = HealthDataTypeDto.STEPS),
        )
        // Then
        days.single().value shouldBe 1234.0
    }

    @Test
    @DisplayName(
        "GIVEN weight min, average and max → WHEN grouped daily → THEN selects each metric",
    )
    fun `groups all supported discrete metrics`() = runTest {
        // Given: the Health Connect test helper probes Android's SDK-extension service.
        mockkStatic(SdkExtensions::class)
        every { SdkExtensions.getExtensionVersion(any()) } returns 0
        try {
            // Given
            val start = LocalDate.of(2026, 3, 28)
            systemUnderTest = WeightHandler(
                dispatcher = Dispatchers.Main.immediate,
                client = client,
            )
            val result =
                AggregationResult(
                    metrics = mapOf(
                        WeightRecord.WEIGHT_MIN to Mass.kilograms(70.0),
                        WeightRecord.WEIGHT_AVG to Mass.kilograms(71.0),
                        WeightRecord.WEIGHT_MAX to Mass.kilograms(72.0),
                    ),
                )
            client.overrides.aggregateGroupByPeriod = stub(
                default = listOf(
                    AggregationResultGroupedByPeriod(
                        result,
                        start.atStartOfDay(),
                        start.plusDays(1).atStartOfDay(),
                    ),
                ),
            )
            // When / Then
            for ((metric, expected) in listOf(
                AggregationMetricDto.MIN to 70.0,
                AggregationMetricDto.AVG to 71.0,
                AggregationMetricDto.MAX to 72.0,
            )) {
                val days = systemUnderTest.aggregateByDay(
                    request(
                        start,
                        start.plusDays(1),
                    ).copy(dataType = HealthDataTypeDto.WEIGHT, aggregationMetric = metric),
                )
                days.single().value shouldBe expected
            }
        } finally {
            unmockkStatic(SdkExtensions::class)
        }
    }

    @Test
    @DisplayName(
        "GIVEN specialized blood pressure → WHEN grouped or ungrouped → THEN preserves metric and unit",
    )
    fun `groups native blood pressure requests`() = runTest {
        // Given
        val start = LocalDate.of(2026, 3, 28)
        systemUnderTest = BloodPressureHandler(
            dispatcher = Dispatchers.Main.immediate,
            client = client,
        )
        val result =
            AggregationResult(
                metrics = mapOf(
                    BloodPressureRecord.SYSTOLIC_AVG to Pressure.millimetersOfMercury(120.0),
                ),
            )
        client.overrides.aggregateGroupByPeriod = stub(
            default = listOf(
                AggregationResultGroupedByPeriod(
                    result,
                    start.atStartOfDay(),
                    start.plusDays(1).atStartOfDay(),
                ),
            ),
        )
        client.overrides.aggregate = stub(result)
        val request =
            BloodPressureAggregateRequestDto(
                bloodPressureDataType = BloodPressureDataTypeDto.SYSTOLIC,
                aggregationMetric = AggregationMetricDto.AVG,
                startTime = start.atStartOfDay(zone).toInstant().toEpochMilli(),
                endTime = start.plusDays(1).atStartOfDay(zone).toInstant().toEpochMilli(),
            )
        // When / Then
        systemUnderTest.aggregateByDay(request).single().value shouldBe 120.0
        systemUnderTest.aggregate(request) shouldBe 120.0
    }

    @Test
    @DisplayName(
        "GIVEN specialized activity intensity → WHEN grouped or ungrouped → THEN preserves duration seconds",
    )
    fun `groups native activity intensity requests`() = runTest {
        // Given
        val start = LocalDate.of(2026, 3, 28)
        systemUnderTest = ActivityIntensityHandler(
            dispatcher = Dispatchers.Main.immediate,
            client = client,
        )
        val result =
            AggregationResult(
                metrics = mapOf(
                    ActivityIntensityRecord.VIGOROUS_DURATION_TOTAL to Duration.ofSeconds(90),
                ),
            )
        client.overrides.aggregateGroupByPeriod = stub(
            default = listOf(
                AggregationResultGroupedByPeriod(
                    result,
                    start.atStartOfDay(),
                    start.plusDays(1).atStartOfDay(),
                ),
            ),
        )
        client.overrides.aggregate = stub(result)
        val request =
            ActivityIntensityAggregateRequestDto(
                dataType = HealthDataTypeDto.ACTIVITY_INTENSITY,
                intensityType = ActivityIntensityTypeDto.VIGOROUS,
                startTime = start.atStartOfDay(zone).toInstant().toEpochMilli(),
                endTime = start.plusDays(1).atStartOfDay(zone).toInstant().toEpochMilli(),
            )
        // When / Then
        systemUnderTest.aggregateByDay(request).single().value shouldBe 90.0
        systemUnderTest.aggregate(request) shouldBe 90.0
    }

    @Test
    @DisplayName(
        "GIVEN unsupported metric → WHEN aggregating → THEN retains supported-metric diagnostics",
    )
    fun `preserves unsupported metric messages`() = runTest {
        // Given
        val start = LocalDate.of(2026, 3, 28)
        systemUnderTest = StepsHandler(dispatcher = Dispatchers.Main.immediate, client = client)
        val invalid = request(start, start.plusDays(1)).copy(
            dataType = HealthDataTypeDto.STEPS,
            aggregationMetric = AggregationMetricDto.AVG,
        )
        val expected = "Unsupported metric: AVG. Supported: [SUM]"
        // When / Then
        shouldThrow<HealthConnectorException.InvalidArgument> {
            systemUnderTest.aggregate(invalid)
        }.message shouldContain expected
        shouldThrow<HealthConnectorException.InvalidArgument> {
            systemUnderTest.aggregateByDay(invalid)
        }.message shouldContain expected
    }

    @Test
    @DisplayName(
        "GIVEN wrong specialized request → WHEN aggregating → THEN retains handler-specific diagnostics",
    )
    fun `preserves specialized request messages`() = runTest {
        // Given
        val start = LocalDate.of(2026, 3, 28)
        val cases: List<Pair<HealthConnectAggregatableHealthRecordHandler, String>> = listOf(
            BloodPressureHandler(dispatcher = Dispatchers.Main.immediate, client = client) to
                "Expected BloodPressureAggregateRequestDto for BloodPressureHandler",
            ActivityIntensityHandler(dispatcher = Dispatchers.Main.immediate, client = client) to
                "Expected ActivityIntensityAggregateRequestDto for ActivityIntensityHandler",
        )
        // When / Then
        for ((handler, expected) in cases) {
            val invalid = request(start, start.plusDays(1)).copy(dataType = handler.dataType)
            shouldThrow<HealthConnectorException.InvalidArgument> {
                handler.aggregate(invalid)
            }.message shouldContain expected
            shouldThrow<HealthConnectorException.InvalidArgument> {
                handler.aggregateByDay(invalid)
            }.message shouldContain expected
        }
    }

    private fun request(start: LocalDate, end: LocalDate): StandardAggregateRequestDto =
        StandardAggregateRequestDto(
            dataType = HealthDataTypeDto.HYDRATION,
            aggregationMetric = AggregationMetricDto.SUM,
            startTime = start.atStartOfDay(zone).toInstant().toEpochMilli(),
            endTime = end.atStartOfDay(zone).toInstant().toEpochMilli(),
        )
}
