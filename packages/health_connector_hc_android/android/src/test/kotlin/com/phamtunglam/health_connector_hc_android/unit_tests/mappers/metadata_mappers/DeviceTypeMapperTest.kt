package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.metadata_mappers

import androidx.health.connect.client.records.metadata.Device
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDeviceTypeDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Device Type Mapper.
 *
 * Tests verify proper bidirectional mapping between [DeviceTypeDto] and Health Connect
 * device type constants, including edge case handling for unknown device types.
 */
@DisplayName("DeviceTypeMapper")
class DeviceTypeMapperTest {

    // region toHealthConnect Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toHealthConnect")
    inner class ToHealthConnect {

        @ParameterizedTest(name = "deviceType={0} maps to constant={1}")
        @MethodSource("provideDeviceTypeMappings")
        @DisplayName(
            "GIVEN any DeviceTypeDto → " +
                "WHEN toHealthConnect called → " +
                "THEN maps to correct Health Connect device type constant",
        )
        fun whenAnyDeviceType_thenMapsToCorrectConstant(
            deviceType: DeviceTypeDto,
            expectedConstant: Int,
        ) {
            // When
            val result = deviceType.toHealthConnect()

            // Then
            result shouldBe expectedConstant
        }

        fun provideDeviceTypeMappings(): List<Arguments> = listOf(
            Arguments.of(DeviceTypeDto.UNKNOWN, Device.TYPE_UNKNOWN),
            Arguments.of(DeviceTypeDto.WATCH, Device.TYPE_WATCH),
            Arguments.of(DeviceTypeDto.PHONE, Device.TYPE_PHONE),
            Arguments.of(DeviceTypeDto.SCALE, Device.TYPE_SCALE),
            Arguments.of(DeviceTypeDto.RING, Device.TYPE_RING),
            Arguments.of(DeviceTypeDto.FITNESS_BAND, Device.TYPE_FITNESS_BAND),
            Arguments.of(DeviceTypeDto.CHEST_STRAP, Device.TYPE_CHEST_STRAP),
            Arguments.of(DeviceTypeDto.HEAD_MOUNTED, Device.TYPE_HEAD_MOUNTED),
            Arguments.of(DeviceTypeDto.SMART_DISPLAY, Device.TYPE_SMART_DISPLAY),
        )
    }

    // endregion

    // region toDeviceTypeDto Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toDeviceTypeDto")
    inner class ToDeviceTypeDto {

        @ParameterizedTest(name = "constant={0} maps to deviceType={1}")
        @MethodSource("provideDeviceTypeReverseMappings")
        @DisplayName(
            "GIVEN any device type constant → " +
                "WHEN toDeviceTypeDto called → " +
                "THEN maps to correct DeviceTypeDto",
        )
        fun whenAnyConstant_thenMapsToCorrectDeviceType(
            constant: Int,
            expectedDeviceType: DeviceTypeDto,
        ) {
            // When
            val result = constant.toDeviceTypeDto()

            // Then
            result shouldBe expectedDeviceType
        }

        fun provideDeviceTypeReverseMappings(): List<Arguments> = listOf(
            Arguments.of(Device.TYPE_UNKNOWN, DeviceTypeDto.UNKNOWN),
            Arguments.of(Device.TYPE_WATCH, DeviceTypeDto.WATCH),
            Arguments.of(Device.TYPE_PHONE, DeviceTypeDto.PHONE),
            Arguments.of(Device.TYPE_SCALE, DeviceTypeDto.SCALE),
            Arguments.of(Device.TYPE_RING, DeviceTypeDto.RING),
            Arguments.of(Device.TYPE_FITNESS_BAND, DeviceTypeDto.FITNESS_BAND),
            Arguments.of(Device.TYPE_CHEST_STRAP, DeviceTypeDto.CHEST_STRAP),
            Arguments.of(Device.TYPE_HEAD_MOUNTED, DeviceTypeDto.HEAD_MOUNTED),
            Arguments.of(Device.TYPE_SMART_DISPLAY, DeviceTypeDto.SMART_DISPLAY),
            Arguments.of(9999, DeviceTypeDto.UNKNOWN),
            Arguments.of(-1, DeviceTypeDto.UNKNOWN),
        )
    }

    // endregion
}
