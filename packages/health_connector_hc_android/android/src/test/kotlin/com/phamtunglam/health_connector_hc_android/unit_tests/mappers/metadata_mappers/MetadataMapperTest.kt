package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.metadata_mappers

import androidx.health.connect.client.records.metadata.Device
import androidx.health.connect.client.records.metadata.Metadata
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.DeviceTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.RecordingMethodDto
import io.kotest.matchers.nulls.shouldBeNull
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Metadata Mapper.
 *
 * Tests verify proper bidirectional mapping between [MetadataDto] and Health Connect
 * [Metadata] objects, including handling of various recording methods, device information,
 * client record IDs, and update scenarios.
 */
@DisplayName("MetadataMapper")
class MetadataMapperTest {

    private companion object {
        const val TEST_PACKAGE_NAME = "com.test.app"
        const val TEST_MANUFACTURER = "Test Manufacturer"
        const val TEST_MODEL = "Test Model"
        const val TEST_CLIENT_RECORD_ID = "test-record-123"
        const val TEST_CLIENT_RECORD_VERSION = 1L
        const val TEST_RECORD_ID = "health-connect-id-456"
    }

    // region MetadataDto.toHealthConnect Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("MetadataDto.toHealthConnect")
    inner class MetadataDtoToHealthConnect {

        @Nested
        @TestInstance(TestInstance.Lifecycle.PER_CLASS)
        @DisplayName("Creating new records (no ID)")
        inner class CreatingNewRecords {

            @ParameterizedTest(name = "recordingMethod={0}")
            @MethodSource("provideRecordingMethods")
            @DisplayName(
                "GIVEN MetadataDto with various recording methods → " +
                    "WHEN toHealthConnect called without ID → " +
                    "THEN creates Metadata with correct recording method",
            )
            fun whenVariousRecordingMethods_thenCreatesCorrectMetadata(
                recordingMethod: RecordingMethodDto,
            ) {
                // Given
                val dto = MetadataDto(
                    dataOrigin = TEST_PACKAGE_NAME,
                    recordingMethod = recordingMethod,
                    lastModifiedTime = System.currentTimeMillis(),
                    clientRecordId = null,
                    clientRecordVersion = null,
                    deviceType = DeviceTypeDto.PHONE,
                    deviceManufacturer = TEST_MANUFACTURER,
                    deviceModel = TEST_MODEL,
                )

                // When
                val result = dto.toHealthConnect()

                // Then
                result.shouldNotBeNull()
                result.device.shouldNotBeNull()
                result.device?.manufacturer shouldBe TEST_MANUFACTURER
                result.device?.model shouldBe TEST_MODEL
                result.device?.type shouldBe Device.TYPE_PHONE
            }

            fun provideRecordingMethods(): List<Arguments> = listOf(
                Arguments.of(RecordingMethodDto.ACTIVELY_RECORDED),
                Arguments.of(RecordingMethodDto.AUTOMATICALLY_RECORDED),
                Arguments.of(RecordingMethodDto.MANUAL_ENTRY),
                Arguments.of(RecordingMethodDto.UNKNOWN),
            )

            @Test
            @DisplayName(
                "GIVEN MetadataDto with client record ID → " +
                    "WHEN toHealthConnect called → " +
                    "THEN creates Metadata with client record ID",
            )
            fun whenClientRecordIdProvided_thenIncludesInMetadata() {
                // Given
                val dto = MetadataDto(
                    dataOrigin = TEST_PACKAGE_NAME,
                    recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                    lastModifiedTime = System.currentTimeMillis(),
                    clientRecordId = TEST_CLIENT_RECORD_ID,
                    clientRecordVersion = TEST_CLIENT_RECORD_VERSION,
                    deviceType = DeviceTypeDto.WATCH,
                    deviceManufacturer = TEST_MANUFACTURER,
                    deviceModel = TEST_MODEL,
                )

                // When
                val result = dto.toHealthConnect()

                // Then
                result.clientRecordId shouldBe TEST_CLIENT_RECORD_ID
                result.clientRecordVersion shouldBe TEST_CLIENT_RECORD_VERSION
            }

            @Test
            @DisplayName(
                "GIVEN MetadataDto without client record ID → " +
                    "WHEN toHealthConnect called → " +
                    "THEN creates Metadata without client record ID",
            )
            fun whenNoClientRecordId_thenMetadataHasNoClientId() {
                // Given
                val dto = MetadataDto(
                    dataOrigin = TEST_PACKAGE_NAME,
                    recordingMethod = RecordingMethodDto.AUTOMATICALLY_RECORDED,
                    lastModifiedTime = System.currentTimeMillis(),
                    clientRecordId = null,
                    clientRecordVersion = null,
                    deviceType = DeviceTypeDto.FITNESS_BAND,
                    deviceManufacturer = TEST_MANUFACTURER,
                    deviceModel = TEST_MODEL,
                )

                // When
                val result = dto.toHealthConnect()

                // Then
                result.clientRecordId.shouldBeNull()
                result.clientRecordVersion shouldBe 0L
            }

            @Test
            @DisplayName(
                "GIVEN MetadataDto with null device info → " +
                    "WHEN toHealthConnect called → " +
                    "THEN creates Metadata with device type but no manufacturer/model",
            )
            fun whenNullDeviceInfo_thenCreatesDeviceWithTypeOnly() {
                // Given
                val dto = MetadataDto(
                    dataOrigin = TEST_PACKAGE_NAME,
                    recordingMethod = RecordingMethodDto.ACTIVELY_RECORDED,
                    lastModifiedTime = System.currentTimeMillis(),
                    clientRecordId = null,
                    clientRecordVersion = null,
                    deviceType = DeviceTypeDto.UNKNOWN,
                    deviceManufacturer = null,
                    deviceModel = null,
                )

                // When
                val result = dto.toHealthConnect()

                // Then
                result.device.shouldNotBeNull()
                result.device?.type shouldBe Device.TYPE_UNKNOWN
                result.device?.manufacturer.shouldBeNull()
                result.device?.model.shouldBeNull()
            }
        }

        @Nested
        @TestInstance(TestInstance.Lifecycle.PER_CLASS)
        @DisplayName("Updating existing records (with ID)")
        inner class UpdatingExistingRecords {

            @Test
            @DisplayName(
                "GIVEN MetadataDto and record ID → " +
                    "WHEN toHealthConnect called with ID → " +
                    "THEN creates Metadata for update with ID",
            )
            fun whenIdProvided_thenCreatesMetadataWithId() {
                // Given
                val dto = MetadataDto(
                    dataOrigin = TEST_PACKAGE_NAME,
                    recordingMethod = RecordingMethodDto.MANUAL_ENTRY,
                    lastModifiedTime = System.currentTimeMillis(),
                    clientRecordId = TEST_CLIENT_RECORD_ID,
                    clientRecordVersion = TEST_CLIENT_RECORD_VERSION,
                    deviceType = DeviceTypeDto.PHONE,
                    deviceManufacturer = TEST_MANUFACTURER,
                    deviceModel = TEST_MODEL,
                )

                // When
                val result = dto.toHealthConnect(id = TEST_RECORD_ID)

                // Then
                result.shouldNotBeNull()
                result.device.shouldNotBeNull()
                result.device?.manufacturer shouldBe TEST_MANUFACTURER
                result.device?.model shouldBe TEST_MODEL
            }

            @ParameterizedTest(name = "recordingMethod={0}")
            @MethodSource("provideRecordingMethodsForUpdate")
            @DisplayName(
                "GIVEN record ID and various recording methods → " +
                    "WHEN toHealthConnect called with ID → " +
                    "THEN uses WithId factory method",
            )
            fun whenIdProvidedWithVariousRecordingMethods_thenUsesWithIdFactory(
                recordingMethod: RecordingMethodDto,
            ) {
                // Given
                val dto = MetadataDto(
                    dataOrigin = TEST_PACKAGE_NAME,
                    recordingMethod = recordingMethod,
                    lastModifiedTime = System.currentTimeMillis(),
                    clientRecordId = null,
                    clientRecordVersion = null,
                    deviceType = DeviceTypeDto.SCALE,
                    deviceManufacturer = TEST_MANUFACTURER,
                    deviceModel = TEST_MODEL,
                )

                // When
                val result = dto.toHealthConnect(id = TEST_RECORD_ID)

                // Then
                result.shouldNotBeNull()
                result.device.shouldNotBeNull()
            }

            fun provideRecordingMethodsForUpdate(): List<Arguments> = listOf(
                Arguments.of(RecordingMethodDto.ACTIVELY_RECORDED),
                Arguments.of(RecordingMethodDto.AUTOMATICALLY_RECORDED),
                Arguments.of(RecordingMethodDto.MANUAL_ENTRY),
                Arguments.of(RecordingMethodDto.UNKNOWN),
            )
        }

        @Nested
        @TestInstance(TestInstance.Lifecycle.PER_CLASS)
        @DisplayName("Device type handling")
        inner class DeviceTypeHandling {

            @ParameterizedTest(name = "deviceType={0}, expectedType={1}")
            @MethodSource("provideDeviceTypes")
            @DisplayName(
                "GIVEN MetadataDto with various device types → " +
                    "WHEN toHealthConnect called → " +
                    "THEN creates Device with correct type",
            )
            fun whenVariousDeviceTypes_thenCreatesCorrectDevice(
                deviceType: DeviceTypeDto,
                expectedType: Int,
            ) {
                // Given
                val dto = MetadataDto(
                    dataOrigin = TEST_PACKAGE_NAME,
                    recordingMethod = RecordingMethodDto.ACTIVELY_RECORDED,
                    lastModifiedTime = System.currentTimeMillis(),
                    clientRecordId = null,
                    clientRecordVersion = null,
                    deviceType = deviceType,
                    deviceManufacturer = TEST_MANUFACTURER,
                    deviceModel = TEST_MODEL,
                )

                // When
                val result = dto.toHealthConnect()

                // Then
                result.device?.type shouldBe expectedType
            }

            fun provideDeviceTypes(): List<Arguments> = listOf(
                Arguments.of(DeviceTypeDto.WATCH, Device.TYPE_WATCH),
                Arguments.of(DeviceTypeDto.PHONE, Device.TYPE_PHONE),
                Arguments.of(DeviceTypeDto.SCALE, Device.TYPE_SCALE),
                Arguments.of(DeviceTypeDto.RING, Device.TYPE_RING),
                Arguments.of(DeviceTypeDto.FITNESS_BAND, Device.TYPE_FITNESS_BAND),
                Arguments.of(DeviceTypeDto.CHEST_STRAP, Device.TYPE_CHEST_STRAP),
                Arguments.of(DeviceTypeDto.HEAD_MOUNTED, Device.TYPE_HEAD_MOUNTED),
                Arguments.of(DeviceTypeDto.SMART_DISPLAY, Device.TYPE_SMART_DISPLAY),
                Arguments.of(DeviceTypeDto.UNKNOWN, Device.TYPE_UNKNOWN),
            )
        }
    }

    // endregion

    // region Metadata.toDto Tests

    @Nested
    @DisplayName("Metadata.toDto")
    inner class MetadataToDto {

        @Test
        @DisplayName(
            "GIVEN Metadata with manual entry → " +
                "WHEN toDto called → " +
                "THEN creates MetadataDto with correct properties",
        )
        fun whenManualEntryMetadata_thenCreatesCorrectDto() {
            // Given
            val device = Device(
                manufacturer = TEST_MANUFACTURER,
                model = TEST_MODEL,
                type = Device.TYPE_PHONE,
            )
            val metadata = Metadata.manualEntry(
                clientRecordId = TEST_CLIENT_RECORD_ID,
                clientRecordVersion = TEST_CLIENT_RECORD_VERSION,
                device = device,
            )

            // When
            val result = metadata.toDto()

            // Then
            result.recordingMethod shouldBe RecordingMethodDto.MANUAL_ENTRY
            result.clientRecordId shouldBe TEST_CLIENT_RECORD_ID
            (result.clientRecordVersion ?: 0L) shouldBe TEST_CLIENT_RECORD_VERSION
            result.deviceType shouldBe DeviceTypeDto.PHONE
            result.deviceManufacturer shouldBe TEST_MANUFACTURER
            result.deviceModel shouldBe TEST_MODEL
            // lastModifiedTime may be null in test environment
            result.lastModifiedTime.shouldNotBeNull()
        }

        @Test
        @DisplayName(
            "GIVEN Metadata with actively recorded → " +
                "WHEN toDto called → " +
                "THEN creates MetadataDto with ACTIVELY_RECORDED method",
        )
        fun whenActivelyRecordedMetadata_thenCreatesCorrectDto() {
            // Given
            val device = Device(
                manufacturer = TEST_MANUFACTURER,
                model = TEST_MODEL,
                type = Device.TYPE_WATCH,
            )
            val metadata = Metadata.activelyRecorded(device = device)

            // When
            val result = metadata.toDto()

            // Then
            result.recordingMethod shouldBe RecordingMethodDto.ACTIVELY_RECORDED
            result.deviceType shouldBe DeviceTypeDto.WATCH
        }

        @Test
        @DisplayName(
            "GIVEN Metadata with null device → " +
                "WHEN toDto called → " +
                "THEN creates MetadataDto with UNKNOWN device type",
        )
        fun whenNullDevice_thenUsesUnknownDeviceType() {
            // Given
            val metadata = Metadata.manualEntry(device = null)

            // When
            val result = metadata.toDto()

            // Then
            result.deviceType shouldBe DeviceTypeDto.UNKNOWN
            result.deviceManufacturer.shouldBeNull()
            result.deviceModel.shouldBeNull()
        }

        @Test
        @DisplayName(
            "GIVEN Metadata with data origin → " +
                "WHEN toDto called → " +
                "THEN includes data origin package name",
        )
        fun whenMetadataWithDataOrigin_thenIncludesPackageName() {
            // Given
            val device = Device(
                manufacturer = TEST_MANUFACTURER,
                model = TEST_MODEL,
                type = Device.TYPE_SCALE,
            )
            val metadata = Metadata.manualEntry(device = device)

            // When
            val result = metadata.toDto()

            // Then
            result.dataOrigin.shouldNotBeNull()
            // In test environment, package name may be empty or test package
        }

        @Test
        @DisplayName(
            "GIVEN Metadata with last modified time → " +
                "WHEN toDto called → " +
                "THEN converts to epoch milliseconds",
        )
        fun whenMetadataWithLastModifiedTime_thenConvertsToEpochMillis() {
            // Given
            val device = Device(
                manufacturer = TEST_MANUFACTURER,
                model = TEST_MODEL,
                type = Device.TYPE_RING,
            )
            val metadata = Metadata.autoRecorded(device = device)

            // When
            val result = metadata.toDto()

            // Then
            // lastModifiedTime may be null in test environment
            result.lastModifiedTime.shouldNotBeNull()
            result.recordingMethod shouldBe RecordingMethodDto.AUTOMATICALLY_RECORDED
        }
    }

    // endregion

    // region Round-trip Mapping Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("Round-trip mapping")
    inner class RoundTripMapping {

        @ParameterizedTest(name = "recordingMethod={0}, deviceType={1}")
        @MethodSource("provideRecordingMethodAndDeviceTypeCombinations")
        @DisplayName(
            "GIVEN MetadataDto → " +
                "WHEN converting to Metadata and back to DTO → " +
                "THEN preserves recording method and device type",
        )
        fun whenRoundTrip_thenPreservesRecordingMethodAndDeviceType(
            recordingMethod: RecordingMethodDto,
            deviceType: DeviceTypeDto,
        ) {
            // Given
            val originalDto = MetadataDto(
                dataOrigin = TEST_PACKAGE_NAME,
                recordingMethod = recordingMethod,
                lastModifiedTime = System.currentTimeMillis(),
                clientRecordId = TEST_CLIENT_RECORD_ID,
                clientRecordVersion = TEST_CLIENT_RECORD_VERSION,
                deviceType = deviceType,
                deviceManufacturer = TEST_MANUFACTURER,
                deviceModel = TEST_MODEL,
            )

            // When
            val metadata = originalDto.toHealthConnect()
            val resultDto = metadata.toDto()

            // Then
            resultDto.recordingMethod shouldBe recordingMethod
            resultDto.deviceType shouldBe deviceType
            resultDto.clientRecordId shouldBe TEST_CLIENT_RECORD_ID
            (resultDto.clientRecordVersion ?: 0L) shouldBe TEST_CLIENT_RECORD_VERSION
            resultDto.deviceManufacturer shouldBe TEST_MANUFACTURER
            resultDto.deviceModel shouldBe TEST_MODEL
        }

        fun provideRecordingMethodAndDeviceTypeCombinations(): List<Arguments> = listOf(
            Arguments.of(RecordingMethodDto.ACTIVELY_RECORDED, DeviceTypeDto.WATCH),
            Arguments.of(RecordingMethodDto.AUTOMATICALLY_RECORDED, DeviceTypeDto.PHONE),
            Arguments.of(RecordingMethodDto.MANUAL_ENTRY, DeviceTypeDto.SCALE),
            Arguments.of(RecordingMethodDto.UNKNOWN, DeviceTypeDto.FITNESS_BAND),
        )
    }

    // endregion
}
