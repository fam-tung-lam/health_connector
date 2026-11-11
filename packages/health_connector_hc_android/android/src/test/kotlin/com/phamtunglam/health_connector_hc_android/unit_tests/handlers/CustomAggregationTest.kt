package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import androidx.health.connect.client.records.RespiratoryRateRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.testing.FakeHealthConnectClient
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.RespiratoryRateHandler
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.StandardAggregateRequestDto
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import java.time.Instant
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Test

class CustomAggregationTest {
    @Test
    fun `nonempty aggregation uses measured values for minimum maximum and average`() = runTest {
        val client = FakeHealthConnectClient()
        val handler = RespiratoryRateHandler(client = client)
        val records = listOf(12.0, 18.0).mapIndexed { index, rate ->
            RespiratoryRateRecord(
                time = Instant.ofEpochMilli(index + 1L),
                zoneOffset = null,
                rate = rate,
                metadata = Metadata.manualEntry(),
            )
        }
        client.insertRecords(records)

        for ((metric, expected) in mapOf(
            AggregationMetricDto.MIN to 12.0,
            AggregationMetricDto.MAX to 18.0,
            AggregationMetricDto.AVG to 15.0,
        )) {
            val request = StandardAggregateRequestDto(
                dataType = HealthDataTypeDto.RESPIRATORY_RATE,
                aggregationMetric = metric,
                startTime = 0,
                endTime = 1000,
            )
            handler.aggregate(request) shouldBe expected
        }
    }

    @Test
    fun `empty paginated aggregation throws NoData for every supported metric`() = runTest {
        val handler = RespiratoryRateHandler(client = FakeHealthConnectClient())

        for (metric in handler.supportedAggregationMetrics) {
            val request = StandardAggregateRequestDto(
                dataType = HealthDataTypeDto.RESPIRATORY_RATE,
                aggregationMetric = metric,
                startTime = 0,
                endTime = 1000,
            )

            shouldThrow<HealthConnectorException.NoData> { handler.aggregate(request) }
        }
    }
}
