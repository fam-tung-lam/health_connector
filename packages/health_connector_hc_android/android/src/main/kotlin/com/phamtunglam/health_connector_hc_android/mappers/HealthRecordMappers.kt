package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.HeartRateRecord.Sample
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.LeanBodyMassRecord
import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import androidx.health.connect.client.units.Temperature
import com.phamtunglam.health_connector_hc_android.pigeon.ActiveCaloriesBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyPositionDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.FloorsClimbedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateMeasurementDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.LeanBodyMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementLocationDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepStageTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WheelchairPushesRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Extension property to get the ID from a [HealthRecordDto].
 *
 * This extension is needed due to a Pigeon limitation where sealed classes cannot have
 * any fields. Since [HealthRecordDto] is a sealed class, we cannot define a common `id`
 * field at the sealed class level. Instead, each subclass has its own `id` field, and
 * this extension provides a unified way to access the ID across all record types.
 *
 * @return The platform-assigned unique identifier for the record, or `null` if the
 * record doesn't have an ID (e.g., for new records being written).
 */
internal val HealthRecordDto.id: String?
    get() = when (this) {
        is ActiveCaloriesBurnedRecordDto -> id
        is DistanceRecordDto -> id
        is FloorsClimbedRecordDto -> id
        is StepRecordDto -> id
        is HeightRecordDto -> id
        is HydrationRecordDto -> id
        is BodyFatPercentageRecordDto -> id
        is BodyTemperatureRecordDto -> id
        is WeightRecordDto -> id
        is LeanBodyMassRecordDto -> id
        is WheelchairPushesRecordDto -> id
        is HeartRateSeriesRecordDto -> id
        is SleepSessionRecordDto -> id

        // Blood pressure records
        is BloodPressureRecordDto -> id

        // Unified nutrition record
        is NutritionRecordDto -> id
    }

/**
 * Converts a Health Connect [ActiveCaloriesBurnedRecord] object to an [ActiveCaloriesBurnedRecordDto].
 */
internal fun ActiveCaloriesBurnedRecord.toDto(): ActiveCaloriesBurnedRecordDto {
    return ActiveCaloriesBurnedRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        energy = energy.toDto()
    )
}

/**
 * Converts a Health Connect [DistanceRecord] object to a [DistanceRecordDto].
 */
internal fun DistanceRecord.toDto(): DistanceRecordDto {
    return DistanceRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        distance = distance.toDto()
    )
}

/**
 * Converts a Health Connect [FloorsClimbedRecord] object to a [FloorsClimbedRecordDto].
 */
internal fun FloorsClimbedRecord.toDto(): FloorsClimbedRecordDto {
    return FloorsClimbedRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        floors = floors.toNumericDto()
    )
}

/**
 * Converts a Health Connect [StepsRecord] object to a [StepRecordDto].
 */
internal fun StepsRecord.toDto(): StepRecordDto {
    return StepRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        count = count.toNumericDto()
    )
}

/**
 * Converts a Health Connect [WeightRecord] object to a [WeightRecordDto].
 */
internal fun WeightRecord.toDto(): WeightRecordDto {
    return WeightRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        weight = weight.toDto()
    )
}

/**
 * Converts a Health Connect [LeanBodyMassRecord] object to a [LeanBodyMassRecordDto].
 */
internal fun LeanBodyMassRecord.toDto(): LeanBodyMassRecordDto {
    return LeanBodyMassRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        mass = mass.toDto()
    )
}

/**
 * Converts a Health Connect [HeightRecord] object to a [HeightRecordDto].
 */
internal fun HeightRecord.toDto(): HeightRecordDto {
    return HeightRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        height = height.toDto()
    )
}

/**
 * Converts a Health Connect [BodyFatRecord] object to a [BodyFatPercentageRecordDto].
 */
internal fun BodyFatRecord.toDto(): BodyFatPercentageRecordDto {
    return BodyFatPercentageRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        percentage = percentage.toDto()
    )
}

/**
 * Converts a Health Connect [BodyTemperatureRecord] object to a [BodyTemperatureRecordDto].
 */
internal fun BodyTemperatureRecord.toDto(): BodyTemperatureRecordDto {
    return BodyTemperatureRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        temperature = temperature.inCelsius.toTemperatureDto()
    )
}

/**
 * Converts a Health Connect [WheelchairPushesRecord] object to a [WheelchairPushesRecordDto].
 */
internal fun WheelchairPushesRecord.toDto(): WheelchairPushesRecordDto {
    return WheelchairPushesRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        pushes = count.toNumericDto()
    )
}

/**
 * Converts a Health Connect [HydrationRecord] object to a [HydrationRecordDto].
 */
internal fun HydrationRecord.toDto(): HydrationRecordDto {
    return HydrationRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        volume = volume.toDto()
    )
}

/**
 * Converts a Health Connect [HeartRateRecord] object to a [HeartRateSeriesRecordDto].
 */
internal fun HeartRateRecord.toDto(): HeartRateSeriesRecordDto {
    return HeartRateSeriesRecordDto(
        id = metadata.id,
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        samples = samples.map { sample ->
            HeartRateMeasurementDto(
                time = sample.time.toEpochMilli(),
                beatsPerMinute = sample.beatsPerMinute.toNumericDto()
            )
        }
    )
}

internal fun SleepStageTypeDto.toHealthConnect(): Int {
    return when (this) {
        SleepStageTypeDto.UNKNOWN -> SleepSessionRecord.STAGE_TYPE_UNKNOWN
        SleepStageTypeDto.AWAKE -> SleepSessionRecord.STAGE_TYPE_AWAKE
        SleepStageTypeDto.SLEEPING -> SleepSessionRecord.STAGE_TYPE_SLEEPING
        SleepStageTypeDto.OUT_OF_BED -> SleepSessionRecord.STAGE_TYPE_OUT_OF_BED
        SleepStageTypeDto.LIGHT -> SleepSessionRecord.STAGE_TYPE_LIGHT
        SleepStageTypeDto.DEEP -> SleepSessionRecord.STAGE_TYPE_DEEP
        SleepStageTypeDto.REM -> SleepSessionRecord.STAGE_TYPE_REM
        SleepStageTypeDto.IN_BED -> SleepSessionRecord.STAGE_TYPE_AWAKE_IN_BED
    }
}

internal fun Int.toSleepStageTypeDto(): SleepStageTypeDto {
    return when (this) {
        SleepSessionRecord.STAGE_TYPE_UNKNOWN -> SleepStageTypeDto.UNKNOWN
        SleepSessionRecord.STAGE_TYPE_AWAKE -> SleepStageTypeDto.AWAKE
        SleepSessionRecord.STAGE_TYPE_SLEEPING -> SleepStageTypeDto.SLEEPING
        SleepSessionRecord.STAGE_TYPE_OUT_OF_BED -> SleepStageTypeDto.OUT_OF_BED
        SleepSessionRecord.STAGE_TYPE_LIGHT -> SleepStageTypeDto.LIGHT
        SleepSessionRecord.STAGE_TYPE_DEEP -> SleepStageTypeDto.DEEP
        SleepSessionRecord.STAGE_TYPE_REM -> SleepStageTypeDto.REM
        SleepSessionRecord.STAGE_TYPE_AWAKE_IN_BED -> SleepStageTypeDto.IN_BED
        else -> SleepStageTypeDto.UNKNOWN
    }
}

internal fun SleepStageDto.toHealthConnect(): SleepSessionRecord.Stage {
    return SleepSessionRecord.Stage(
        startTime = Instant.ofEpochMilli(startTime),
        endTime = Instant.ofEpochMilli(endTime),
        stage = stage.toHealthConnect()
    )
}

internal fun SleepSessionRecord.Stage.toDto(): SleepStageDto {
    return SleepStageDto(
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        stage = stage.toSleepStageTypeDto()
    )
}

internal fun SleepSessionRecord.toDto(): SleepSessionRecordDto {
    return SleepSessionRecordDto(
        id = metadata.id,
        metadata = metadata.toDto(),
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        title = title,
        notes = notes,
        stages = stages.map { it.toDto() }
    )
}

/**
 * Converts a [HealthRecordDto] to a Health Connect [Record] object.
 *
 * This extension uses pattern matching on the sealed class to convert
 * each record type to its corresponding Health Connect record.
 */
internal fun HealthRecordDto.toHealthConnect(): Record {
    return when (this) {
        is ActiveCaloriesBurnedRecordDto -> ActiveCaloriesBurnedRecord(
            energy = energy.toHealthConnect(),
            startTime = Instant.ofEpochMilli(startTime),
            endTime = Instant.ofEpochMilli(endTime),
            startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is DistanceRecordDto -> DistanceRecord(
            distance = distance.toHealthConnect(),
            startTime = Instant.ofEpochMilli(startTime),
            endTime = Instant.ofEpochMilli(endTime),
            startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is FloorsClimbedRecordDto -> FloorsClimbedRecord(
            floors = floors.value,
            startTime = Instant.ofEpochMilli(startTime),
            endTime = Instant.ofEpochMilli(endTime),
            startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is StepRecordDto -> StepsRecord(
            count = count.toLong(),
            startTime = Instant.ofEpochMilli(startTime),
            endTime = Instant.ofEpochMilli(endTime),
            startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is HeightRecordDto -> HeightRecord(
            height = height.toHealthConnect(),
            time = Instant.ofEpochMilli(time),
            zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is HydrationRecordDto -> HydrationRecord(
            volume = volume.toHealthConnect(),
            startTime = Instant.ofEpochMilli(startTime),
            endTime = Instant.ofEpochMilli(endTime),
            startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is BodyFatPercentageRecordDto -> BodyFatRecord(
            percentage = percentage.toHealthConnect(),
            time = Instant.ofEpochMilli(time),
            zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is BodyTemperatureRecordDto -> BodyTemperatureRecord(
            temperature = Temperature.celsius(temperature.value),
            time = Instant.ofEpochMilli(time),
            zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is WeightRecordDto -> WeightRecord(
            weight = weight.toHealthConnect(),
            time = Instant.ofEpochMilli(time),
            zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is LeanBodyMassRecordDto -> LeanBodyMassRecord(
            mass = mass.toHealthConnect(),
            time = Instant.ofEpochMilli(time),
            zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is WheelchairPushesRecordDto -> WheelchairPushesRecord(
            count = pushes.value.toLong(),
            startTime = Instant.ofEpochMilli(startTime),
            endTime = Instant.ofEpochMilli(endTime),
            startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is HeartRateSeriesRecordDto -> HeartRateRecord(
            samples = samples.map { sample ->
                Sample(
                    time = Instant.ofEpochMilli(sample.time),
                    beatsPerMinute = sample.beatsPerMinute.value.toLong()
                )
            },
            startTime = Instant.ofEpochMilli(startTime),
            endTime = Instant.ofEpochMilli(endTime),
            startZoneOffset = startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
            metadata = metadata.toHealthConnect(),
        )

        is SleepSessionRecordDto -> SleepSessionRecord(
            startTime = Instant.ofEpochMilli(startTime),
            endTime = Instant.ofEpochMilli(endTime),
            startZoneOffset = startZoneOffsetSeconds?.let {
                ZoneOffset.ofTotalSeconds(it.toInt())
            } ?: ZoneOffset.UTC,
            endZoneOffset = endZoneOffsetSeconds?.let {
                ZoneOffset.ofTotalSeconds(it.toInt())
            } ?: ZoneOffset.UTC,
            title = title,
            notes = notes,
            stages = stages.map { it.toHealthConnect() },
            metadata = metadata.toHealthConnect()
        )

        is NutritionRecordDto -> {
            val startTimeInstant = Instant.ofEpochMilli(startTime)
            val endTimeInstant = Instant.ofEpochMilli(endTime)
            val startZoneOffset =
                startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) } ?: ZoneOffset.UTC
            val endZoneOffset = endZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) } ?: ZoneOffset.UTC

            // For individual nutrients, create a small interval (endTime = startTime + 100ms)
            // For combined nutrition, use the provided startTime/endTime
            val (actualStartTime, actualEndTime) = if (healthDataType != HealthDataTypeDto.NUTRITION) {
                val instant = Instant.ofEpochMilli(startTime)
                Pair(instant, instant.plusMillis(100))
            } else {
                Pair(startTimeInstant, endTimeInstant)
            }

            // Build NutritionRecord based on healthDataType
            when (healthDataType) {
                HealthDataTypeDto.ENERGY_NUTRIENT -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    energy = energy?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.CAFFEINE -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    caffeine = caffeine?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.PROTEIN -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    protein = protein?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.TOTAL_CARBOHYDRATE -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    totalCarbohydrate = totalCarbohydrate?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.TOTAL_FAT -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    totalFat = totalFat?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.SATURATED_FAT -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    saturatedFat = saturatedFat?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.MONOUNSATURATED_FAT -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    monounsaturatedFat = monounsaturatedFat?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.POLYUNSATURATED_FAT -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    polyunsaturatedFat = polyunsaturatedFat?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.CHOLESTEROL -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    cholesterol = cholesterol?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.DIETARY_FIBER -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    dietaryFiber = dietaryFiber?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.SUGAR -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    sugar = sugar?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.VITAMIN_A -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    vitaminA = vitaminA?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.VITAMIN_B6 -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    vitaminB6 = vitaminB6?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.VITAMIN_B12 -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    vitaminB12 = vitaminB12?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.VITAMIN_C -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    vitaminC = vitaminC?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.VITAMIN_D -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    vitaminD = vitaminD?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.VITAMIN_E -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    vitaminE = vitaminE?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.VITAMIN_K -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    vitaminK = vitaminK?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.THIAMIN -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    thiamin = thiamin?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.RIBOFLAVIN -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    riboflavin = riboflavin?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.NIACIN -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    niacin = niacin?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.FOLATE -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    folate = folate?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.BIOTIN -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    biotin = biotin?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.PANTOTHENIC_ACID -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    pantothenicAcid = pantothenicAcid?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.CALCIUM -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    calcium = calcium?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.IRON -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    iron = iron?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.MAGNESIUM -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    magnesium = magnesium?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.MANGANESE -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    manganese = manganese?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.PHOSPHORUS -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    phosphorus = phosphorus?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.POTASSIUM -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    potassium = potassium?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.SELENIUM -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    selenium = selenium?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.SODIUM -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    sodium = sodium?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.ZINC -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    zinc = zinc?.toHealthConnect(),
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                HealthDataTypeDto.NUTRITION -> NutritionRecord(
                    startTime = actualStartTime,
                    endTime = actualEndTime,
                    startZoneOffset = startZoneOffset,
                    endZoneOffset = endZoneOffset,
                    name = foodName,
                    mealType = mealType.toHealthConnect(),
                    energy = energy?.toHealthConnect(),
                    protein = protein?.toHealthConnect(),
                    totalCarbohydrate = totalCarbohydrate?.toHealthConnect(),
                    totalFat = totalFat?.toHealthConnect(),
                    saturatedFat = saturatedFat?.toHealthConnect(),
                    monounsaturatedFat = monounsaturatedFat?.toHealthConnect(),
                    polyunsaturatedFat = polyunsaturatedFat?.toHealthConnect(),
                    cholesterol = cholesterol?.toHealthConnect(),
                    dietaryFiber = dietaryFiber?.toHealthConnect(),
                    sugar = sugar?.toHealthConnect(),
                    vitaminA = vitaminA?.toHealthConnect(),
                    vitaminB6 = vitaminB6?.toHealthConnect(),
                    vitaminB12 = vitaminB12?.toHealthConnect(),
                    vitaminC = vitaminC?.toHealthConnect(),
                    vitaminD = vitaminD?.toHealthConnect(),
                    vitaminE = vitaminE?.toHealthConnect(),
                    vitaminK = vitaminK?.toHealthConnect(),
                    thiamin = thiamin?.toHealthConnect(),
                    riboflavin = riboflavin?.toHealthConnect(),
                    niacin = niacin?.toHealthConnect(),
                    folate = folate?.toHealthConnect(),
                    biotin = biotin?.toHealthConnect(),
                    pantothenicAcid = pantothenicAcid?.toHealthConnect(),
                    calcium = calcium?.toHealthConnect(),
                    iron = iron?.toHealthConnect(),
                    magnesium = magnesium?.toHealthConnect(),
                    manganese = manganese?.toHealthConnect(),
                    phosphorus = phosphorus?.toHealthConnect(),
                    potassium = potassium?.toHealthConnect(),
                    selenium = selenium?.toHealthConnect(),
                    sodium = sodium?.toHealthConnect(),
                    zinc = zinc?.toHealthConnect(),
                    caffeine = caffeine?.toHealthConnect(),
                    metadata = metadata.toHealthConnect(),
                )

                else -> throw IllegalArgumentException("Unsupported healthDataType for NutritionRecordDto: $healthDataType")
            }
        }

        is BloodPressureRecordDto -> toHealthConnect()
    }
}

/**
 * Converts [NutritionRecord] to a unified [NutritionRecordDto] based on [nutrientType] with the corresponding
 * nutrient field populated.
 *
 * ## When Return `null`
 *
 * Health Connect uses a single [NutritionRecord] class to represent all nutrients and nutrition data.
 *
 * When converting to a specific nutrient type via this function, if the expected nutrient value
 * is null in the [NutritionRecord], it indicates that this record does not contain data for the
 * requested [nutrientType]. In such cases, this function returns `null` to signal that the record
 * is not relevant to the expected nutrient type.
 *
 * ### Example
 *
 * If a nutrition record only contains `energy` and `protein` values, and `nutrientType = VITAMIN_C`,
 * it will return `null` because the record does not contain vitamin C data.
 *
 * @param nutrientType The specific nutrient type to extract from the [NutritionRecord]
 * @return A [NutritionRecordDto] with the requested nutrient type, or `null` if the record does
 *         not contain data for the requested nutrient type
 */
internal fun NutritionRecord.toNutrientDto(nutrientType: HealthDataTypeDto): HealthRecordDto? {
    return when (nutrientType) {
        HealthDataTypeDto.ENERGY_NUTRIENT -> {
            val energyDto = energy?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.ENERGY_NUTRIENT,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                energy = energyDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.CAFFEINE -> {
            val caffeineDto = caffeine?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.CAFFEINE,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                caffeine = caffeineDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.PROTEIN -> {
            val proteinDto = protein?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.PROTEIN,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                protein = proteinDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.TOTAL_CARBOHYDRATE -> {
            val totalCarbohydrateDto = totalCarbohydrate?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.TOTAL_CARBOHYDRATE,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                totalCarbohydrate = totalCarbohydrateDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.TOTAL_FAT -> {
            val totalFatDto = totalFat?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.TOTAL_FAT,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                totalFat = totalFatDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.SATURATED_FAT -> {
            val saturatedFatDto = saturatedFat?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.SATURATED_FAT,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                saturatedFat = saturatedFatDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.MONOUNSATURATED_FAT -> {
            val monounsaturatedFatDto = monounsaturatedFat?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.MONOUNSATURATED_FAT,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                monounsaturatedFat = monounsaturatedFatDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.POLYUNSATURATED_FAT -> {
            val polyunsaturatedFatDto = polyunsaturatedFat?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.POLYUNSATURATED_FAT,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                polyunsaturatedFat = polyunsaturatedFatDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.CHOLESTEROL -> {
            val cholesterolDto = cholesterol?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.CHOLESTEROL,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                cholesterol = cholesterolDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.DIETARY_FIBER -> {
            val dietaryFiberDto = dietaryFiber?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.DIETARY_FIBER,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                dietaryFiber = dietaryFiberDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.SUGAR -> {
            val sugarDto = sugar?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.SUGAR,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                sugar = sugarDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.VITAMIN_A -> {
            val vitaminADto = vitaminA?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.VITAMIN_A,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                vitaminA = vitaminADto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.VITAMIN_B6 -> {
            val vitaminB6Dto = vitaminB6?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.VITAMIN_B6,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                vitaminB6 = vitaminB6Dto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.VITAMIN_B12 -> {
            val vitaminB12Dto = vitaminB12?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.VITAMIN_B12,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                vitaminB12 = vitaminB12Dto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.VITAMIN_C -> {
            val vitaminCDto = vitaminC?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.VITAMIN_C,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                vitaminC = vitaminCDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.VITAMIN_D -> {
            val vitaminDDto = vitaminD?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.VITAMIN_D,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                vitaminD = vitaminDDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.VITAMIN_E -> {
            val vitaminEDto = vitaminE?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.VITAMIN_E,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                vitaminE = vitaminEDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.VITAMIN_K -> {
            val vitaminKDto = vitaminK?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.VITAMIN_K,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                vitaminK = vitaminKDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.THIAMIN -> {
            val thiaminDto = thiamin?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.THIAMIN,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                thiamin = thiaminDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.RIBOFLAVIN -> {
            val riboflavinDto = riboflavin?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.RIBOFLAVIN,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                riboflavin = riboflavinDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.NIACIN -> {
            val niacinDto = niacin?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.NIACIN,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                niacin = niacinDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.FOLATE -> {
            val folateDto = folate?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.FOLATE,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                folate = folateDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.BIOTIN -> {
            val biotinDto = biotin?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.BIOTIN,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                biotin = biotinDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.PANTOTHENIC_ACID -> {
            val pantothenicAcidDto = pantothenicAcid?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.PANTOTHENIC_ACID,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                pantothenicAcid = pantothenicAcidDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.CALCIUM -> {
            val calciumDto = calcium?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.CALCIUM,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                calcium = calciumDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.IRON -> {
            val ironDto = iron?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.IRON,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                iron = ironDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.MAGNESIUM -> {
            val magnesiumDto = magnesium?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.MAGNESIUM,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                magnesium = magnesiumDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.MANGANESE -> {
            val manganeseDto = manganese?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.MANGANESE,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                manganese = manganeseDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.PHOSPHORUS -> {
            val phosphorusDto = phosphorus?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.PHOSPHORUS,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                phosphorus = phosphorusDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.POTASSIUM -> {
            val potassiumDto = potassium?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.POTASSIUM,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                potassium = potassiumDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.SELENIUM -> {
            val seleniumDto = selenium?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.SELENIUM,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                selenium = seleniumDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.SODIUM -> {
            val sodiumDto = sodium?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.SODIUM,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                sodium = sodiumDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        HealthDataTypeDto.ZINC -> {
            val zincDto = zinc?.toDto() ?: return null

            NutritionRecordDto(
                id = metadata.id,
                metadata = metadata.toDto(),
                startTime = startTime.toEpochMilli(),
                endTime = endTime.toEpochMilli(),
                healthDataType = HealthDataTypeDto.ZINC,
                startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
                endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
                zinc = zincDto,
                foodName = name,
                mealType = mealType.toMealTypeDto(),
            )
        }

        else -> throw IllegalArgumentException("Unsupported nutrientType: $nutrientType")
    }
}

/**
 * Converts NutritionRecord to a unified NutritionRecordDto for combined nutrition.
 *
 * Creates a NutritionRecordDto with healthDataType = NUTRITION and all non-null fields populated.
 */
internal fun NutritionRecord.toDto(): NutritionRecordDto {
    return NutritionRecordDto(
        id = metadata.id,
        metadata = metadata.toDto(),
        startTime = startTime.toEpochMilli(),
        endTime = endTime.toEpochMilli(),
        healthDataType = HealthDataTypeDto.NUTRITION,
        startZoneOffsetSeconds = startZoneOffset?.totalSeconds?.toLong(),
        endZoneOffsetSeconds = endZoneOffset?.totalSeconds?.toLong(),
        foodName = name,
        mealType = mealType.toMealTypeDto(),
        energy = energy?.toDto(),
        protein = protein?.toDto(),
        totalCarbohydrate = totalCarbohydrate?.toDto(),
        totalFat = totalFat?.toDto(),
        saturatedFat = saturatedFat?.toDto(),
        monounsaturatedFat = monounsaturatedFat?.toDto(),
        polyunsaturatedFat = polyunsaturatedFat?.toDto(),
        cholesterol = cholesterol?.toDto(),
        dietaryFiber = dietaryFiber?.toDto(),
        sugar = sugar?.toDto(),
        vitaminA = vitaminA?.toDto(),
        vitaminB6 = vitaminB6?.toDto(),
        vitaminB12 = vitaminB12?.toDto(),
        vitaminC = vitaminC?.toDto(),
        vitaminD = vitaminD?.toDto(),
        vitaminE = vitaminE?.toDto(),
        vitaminK = vitaminK?.toDto(),
        thiamin = thiamin?.toDto(),
        riboflavin = riboflavin?.toDto(),
        niacin = niacin?.toDto(),
        folate = folate?.toDto(),
        biotin = biotin?.toDto(),
        pantothenicAcid = pantothenicAcid?.toDto(),
        calcium = calcium?.toDto(),
        iron = iron?.toDto(),
        magnesium = magnesium?.toDto(),
        manganese = manganese?.toDto(),
        phosphorus = phosphorus?.toDto(),
        potassium = potassium?.toDto(),
        selenium = selenium?.toDto(),
        sodium = sodium?.toDto(),
        zinc = zinc?.toDto(),
        caffeine = caffeine?.toDto(),
    )
}

// region Blood Pressure Mappers

/**
 * Converts a BodyPositionDto to the Health Connect BloodPressureRecord.BodyPosition.
 */
internal fun BodyPositionDto.toHealthConnect(): Int {
    return when (this) {
        BodyPositionDto.UNKNOWN -> BloodPressureRecord.BODY_POSITION_UNKNOWN
        BodyPositionDto.STANDING_UP -> BloodPressureRecord.BODY_POSITION_STANDING_UP
        BodyPositionDto.SITTING_DOWN -> BloodPressureRecord.BODY_POSITION_SITTING_DOWN
        BodyPositionDto.LYING_DOWN -> BloodPressureRecord.BODY_POSITION_LYING_DOWN
        BodyPositionDto.RECLINING -> BloodPressureRecord.BODY_POSITION_RECLINING
    }
}

/**
 * Converts Health Connect body position int to BodyPositionDto.
 */
internal fun Int.toBodyPositionDto(): BodyPositionDto {
    return when (this) {
        BloodPressureRecord.BODY_POSITION_STANDING_UP -> BodyPositionDto.STANDING_UP
        BloodPressureRecord.BODY_POSITION_SITTING_DOWN -> BodyPositionDto.SITTING_DOWN
        BloodPressureRecord.BODY_POSITION_LYING_DOWN -> BodyPositionDto.LYING_DOWN
        BloodPressureRecord.BODY_POSITION_RECLINING -> BodyPositionDto.RECLINING
        else -> BodyPositionDto.UNKNOWN
    }
}

/**
 * Converts a MeasurementLocationDto to the Health Connect BloodPressureRecord.MeasurementLocation.
 */
internal fun MeasurementLocationDto.toHealthConnect(): Int {
    return when (this) {
        MeasurementLocationDto.UNKNOWN -> BloodPressureRecord.MEASUREMENT_LOCATION_UNKNOWN
        MeasurementLocationDto.LEFT_WRIST -> BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_WRIST
        MeasurementLocationDto.RIGHT_WRIST -> BloodPressureRecord.MEASUREMENT_LOCATION_RIGHT_WRIST
        MeasurementLocationDto.LEFT_UPPER_ARM -> BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_UPPER_ARM
        MeasurementLocationDto.RIGHT_UPPER_ARM -> BloodPressureRecord.MEASUREMENT_LOCATION_RIGHT_UPPER_ARM
    }
}

/**
 * Converts Health Connect measurement location int to MeasurementLocationDto.
 */
internal fun Int.toMeasurementLocationDto(): MeasurementLocationDto {
    return when (this) {
        BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_WRIST -> MeasurementLocationDto.LEFT_WRIST
        BloodPressureRecord.MEASUREMENT_LOCATION_RIGHT_WRIST -> MeasurementLocationDto.RIGHT_WRIST
        BloodPressureRecord.MEASUREMENT_LOCATION_LEFT_UPPER_ARM -> MeasurementLocationDto.LEFT_UPPER_ARM
        BloodPressureRecord.MEASUREMENT_LOCATION_RIGHT_UPPER_ARM -> MeasurementLocationDto.RIGHT_UPPER_ARM
        else -> MeasurementLocationDto.UNKNOWN
    }
}

/**
 * Converts a Health Connect [BloodPressureRecord] to a [BloodPressureRecordDto].
 */
internal fun BloodPressureRecord.toDto(): BloodPressureRecordDto {
    return BloodPressureRecordDto(
        id = metadata.id,
        time = time.toEpochMilli(),
        zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
        metadata = metadata.toDto(),
        systolic = systolic.toDto(),
        diastolic = diastolic.toDto(),
        bodyPosition = bodyPosition.toBodyPositionDto(),
        measurementLocation = measurementLocation.toMeasurementLocationDto()
    )
}

/**
 * Converts a [BloodPressureRecordDto] to a Health Connect [BloodPressureRecord].
 */
internal fun BloodPressureRecordDto.toHealthConnect(): BloodPressureRecord {
    return BloodPressureRecord(
        time = Instant.ofEpochMilli(time),
        zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
        systolic = systolic.toHealthConnect(),
        diastolic = diastolic.toHealthConnect(),
        bodyPosition = bodyPosition.toHealthConnect(),
        measurementLocation = measurementLocation.toHealthConnect(),
        metadata = metadata.toHealthConnect()
    )
}

// endregion
