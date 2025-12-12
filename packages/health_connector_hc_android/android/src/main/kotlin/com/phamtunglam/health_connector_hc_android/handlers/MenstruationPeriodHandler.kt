package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.MenstruationFlowRecord
import androidx.health.connect.client.records.MenstruationPeriodRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MenstruationPeriodRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsResponseDto
import java.time.Instant
import kotlin.reflect.KClass

internal object MenstruationPeriodHandler : IntervalRecordHandler {
    override val supportedType: HealthDataTypeDto = HealthDataTypeDto.MENSTRUATION_PERIOD

    override fun toDto(record: Record): HealthRecordDto {
        require(record is MenstruationPeriodRecord) {
            "Expected MenstruationPeriodRecord, got ${record::class.simpleName}"
        }
        return record.toDto()
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is MenstruationPeriodRecordDto) {
            "Expected MenstruationPeriodRecordDto, got ${dto::class.simpleName}"
        }
        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = MenstruationPeriodRecord::class

    /**
     * Specialized read method that fetches Period records AND their associated Flow records.
     */
    suspend fun readRecordsWithFlows(
        client: HealthConnectClient,
        request: ReadRecordsRequestDto,
    ): ReadRecordsResponseDto {
        // 1. Read MenstruationPeriodRecords
        val timeRangeFilter = TimeRangeFilter.between(
            Instant.ofEpochMilli(request.startTime),
            Instant.ofEpochMilli(request.endTime),
        )

        val readRequest = ReadRecordsRequest(
            recordType = MenstruationPeriodRecord::class,
            timeRangeFilter = timeRangeFilter,
            pageSize = request.pageSize.toInt(),
            pageToken = request.pageToken,
        )

        val response = client.readRecords(readRequest)

        val periodRecords = response.records.filterIsInstance<MenstruationPeriodRecord>()

        if (periodRecords.isEmpty()) {
            return ReadRecordsResponseDto(
                records = emptyList(),
                nextPageToken = response.pageToken,
            )
        }

        // 2. Read MenstruationFlowRecords for the entire range (optimization: minimal range covering all periods)
        // Since we page periods, strict min/max or request range?
        // Using request range is safer but might fetch flows for periods not in this page.
        // Better: Use min(period.start) and max(period.end) from the fetched periods.
        val minStart = periodRecords.minOf { it.startTime }
        val maxEnd = periodRecords.maxOf { it.endTime }

        val flowTimeRangeFilter = TimeRangeFilter.between(minStart, maxEnd)

        // We need ALL flows in this range, so we might need to page through flows if there are many.
        // Typically flows are 1 per day. Range is usually months.
        val flowRecords = mutableListOf<MenstruationFlowRecord>()
        var flowPageToken: String? = null

        do {
            val flowReadRequest = ReadRecordsRequest(
                recordType = MenstruationFlowRecord::class,
                timeRangeFilter = flowTimeRangeFilter,
                pageSize = 1000,
                pageToken = flowPageToken,
            )
            val flowResponse = client.readRecords(flowReadRequest)
            flowRecords.addAll(flowResponse.records.filterIsInstance<MenstruationFlowRecord>())
            flowPageToken = flowResponse.pageToken
        } while (flowPageToken != null)

        // 3. Associate flows with periods and map to DTO
        val dtos = periodRecords.map { period ->
            val periodDto = period.toDto()
            // Find flows that fall within this period's time range
            val flowsForPeriod = flowRecords.filter { flow ->
                !flow.time.isBefore(period.startTime) && !flow.time.isAfter(period.endTime)
            }.map { it.toDto() }

            // Return copy with samples populated
            periodDto.copy(samples = flowsForPeriod)
        }

        return ReadRecordsResponseDto(
            records = dtos,
            nextPageToken = response.pageToken.takeIf { it?.isNotEmpty() == true },
        )
    }

    suspend fun readRecordWithFlows(
        client: HealthConnectClient,
        request: ReadRecordRequestDto,
    ): ReadRecordResponseDto {
        val response = client.readRecord(MenstruationPeriodRecord::class, request.recordId)
        val period = response.record

        // Read flows for this period
        val flowTimeRangeFilter = TimeRangeFilter.between(period.startTime, period.endTime)
        val flowRecords = mutableListOf<MenstruationFlowRecord>()
        var flowPageToken: String? = null

        do {
            val flowReadRequest = ReadRecordsRequest(
                recordType = MenstruationFlowRecord::class,
                timeRangeFilter = flowTimeRangeFilter,
                pageSize = 100, // Should be few
                pageToken = flowPageToken,
            )
            val flowResponse = client.readRecords(flowReadRequest)
            flowRecords.addAll(flowResponse.records.filterIsInstance<MenstruationFlowRecord>())
            flowPageToken = flowResponse.pageToken
        } while (flowPageToken != null)

        val periodDto = period.toDto()
        val flowsDto = flowRecords.map { it.toDto() }

        return ReadRecordResponseDto(record = periodDto.copy(samples = flowsDto))
    }
}
