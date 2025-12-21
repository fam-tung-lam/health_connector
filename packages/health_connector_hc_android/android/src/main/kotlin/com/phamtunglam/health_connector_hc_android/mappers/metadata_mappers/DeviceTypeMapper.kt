package com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers

import androidx.health.connect.client.records.metadata.Device
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto

/**
 * Converts a [DeviceTypeDto] to a Health Connect device type constant.
 */
internal fun DeviceTypeDto.toHealthConnect(): Int = when (this) {
    DeviceTypeDto.UNKNOWN -> Device.TYPE_UNKNOWN
    DeviceTypeDto.WATCH -> Device.TYPE_WATCH
    DeviceTypeDto.PHONE -> Device.TYPE_PHONE
    DeviceTypeDto.SCALE -> Device.TYPE_SCALE
    DeviceTypeDto.RING -> Device.TYPE_RING
    DeviceTypeDto.FITNESS_BAND -> Device.TYPE_FITNESS_BAND
    DeviceTypeDto.CHEST_STRAP -> Device.TYPE_CHEST_STRAP
    DeviceTypeDto.HEAD_MOUNTED -> Device.TYPE_HEAD_MOUNTED
    DeviceTypeDto.SMART_DISPLAY -> Device.TYPE_SMART_DISPLAY
}

/**
 * Converts a Health Connect device type constant to a [DeviceTypeDto].
 */
internal fun Int.toDeviceTypeDto(): DeviceTypeDto = when (this) {
    Device.TYPE_UNKNOWN -> DeviceTypeDto.UNKNOWN
    Device.TYPE_WATCH -> DeviceTypeDto.WATCH
    Device.TYPE_PHONE -> DeviceTypeDto.PHONE
    Device.TYPE_SCALE -> DeviceTypeDto.SCALE
    Device.TYPE_RING -> DeviceTypeDto.RING
    Device.TYPE_FITNESS_BAND -> DeviceTypeDto.FITNESS_BAND
    Device.TYPE_CHEST_STRAP -> DeviceTypeDto.CHEST_STRAP
    Device.TYPE_HEAD_MOUNTED -> DeviceTypeDto.HEAD_MOUNTED
    Device.TYPE_SMART_DISPLAY -> DeviceTypeDto.SMART_DISPLAY
    else -> DeviceTypeDto.UNKNOWN
}
