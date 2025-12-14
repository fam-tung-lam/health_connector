package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto

/**
 * Handler for Body Temperature records.
 */
internal class BodyTemperatureHandler(override val client: HealthConnectClient) :
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.BODY_TEMPERATURE
}
