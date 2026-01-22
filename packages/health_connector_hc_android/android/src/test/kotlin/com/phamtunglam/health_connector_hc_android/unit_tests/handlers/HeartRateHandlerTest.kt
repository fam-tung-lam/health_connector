package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.testing.AggregationResult
import androidx.health.connect.client.testing.FakeHealthConnectClient
import androidx.health.connect.client.testing.FakePermissionController
import androidx.health.connect.client.testing.stubs.stub
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HeartRateHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.StandardAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.utils.MainDispatcherExtension
import io.kotest.matchers.shouldBe
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

@DisplayName("HeartRateHandler")
@ExtendWith(MainDispatcherExtension::class)
class HeartRateHandlerTest {

    private lateinit var fakePermissionController: FakePermissionController
    private lateinit var fakeHealthConnectClient: FakeHealthConnectClient
    private lateinit var systemUnderTest: HeartRateHandler

    @BeforeEach
    fun setUp() {
        HealthConnectorLogger.isEnabled = false
        fakePermissionController = FakePermissionController(grantAll = true)
        fakeHealthConnectClient = FakeHealthConnectClient(
            packageName = FAKE_PACKAGE_NAME,
            permissionController = fakePermissionController,
        )
        systemUnderTest = HeartRateHandler(
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
            "THEN returns HEART_RATE_SERIES",
    )
    fun `handler has correct data type`() {
        systemUnderTest.dataType shouldBe HealthDataTypeDto.HEART_RATE_SERIES
    }

    @Test
    @DisplayName(
        "GIVEN handler → " +
            "WHEN checking aggregateMetricMappings → " +
            "THEN returns supported AVG, MIN, MAX metrics",
    )
    fun `handler has correct aggregateMetricMappings`() {
        systemUnderTest.aggregateMetricMappings shouldBe mapOf(
            AggregationMetricDto.AVG to HeartRateRecord.BPM_AVG,
            AggregationMetricDto.MIN to HeartRateRecord.BPM_MIN,
            AggregationMetricDto.MAX to HeartRateRecord.BPM_MAX,
        )
    }

    @Nested
    @DisplayName(
        "GIVEN aggregation → ",
    )
    inner class Aggregation {

        @Test
        @DisplayName(
            "WHEN aggregating AVG → " +
                "THEN returns correct value in BPM",
        )
        fun `aggregate avg for heart rate`() = runTest {
            val startTime = FIXED_NOW.minusSeconds(3600)
            val endTime = FIXED_NOW
            val expectedAvg = 75L

            val result = AggregationResult(
                metrics = buildMap {
                    put(
                        HeartRateRecord.BPM_AVG,
                        expectedAvg,
                    )
                },
            )
            fakeHealthConnectClient.overrides.aggregate = stub(result)

            val request = StandardAggregateRequestDto(
                dataType = HealthDataTypeDto.HEART_RATE_SERIES,
                aggregationMetric = AggregationMetricDto.AVG,
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
            )

            val response = systemUnderTest.aggregate(request)

            response shouldBe expectedAvg.toDouble()
        }
    }

    private companion object Companion {
        const val FAKE_PACKAGE_NAME = "com.test"
        val FIXED_NOW: Instant = Instant.parse("2026-01-01T12:00:00Z")
    }
}
