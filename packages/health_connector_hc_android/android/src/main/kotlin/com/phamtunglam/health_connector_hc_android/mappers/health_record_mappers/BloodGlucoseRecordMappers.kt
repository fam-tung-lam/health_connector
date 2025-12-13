package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.BloodGlucoseRecord
import androidx.health.connect.client.records.MealType
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRelationToMealDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseSpecimenSourceDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts [BloodGlucoseRelationToMealDto] to Health Connect int constant.
 */
internal fun BloodGlucoseRelationToMealDto.toHealthConnect(): Int = when (this) {
    BloodGlucoseRelationToMealDto.UNKNOWN -> BloodGlucoseRecord.RELATION_TO_MEAL_UNKNOWN
    BloodGlucoseRelationToMealDto.GENERAL -> BloodGlucoseRecord.RELATION_TO_MEAL_GENERAL
    BloodGlucoseRelationToMealDto.FASTING -> BloodGlucoseRecord.RELATION_TO_MEAL_FASTING
    BloodGlucoseRelationToMealDto.BEFORE_MEAL -> BloodGlucoseRecord.RELATION_TO_MEAL_BEFORE_MEAL
    BloodGlucoseRelationToMealDto.AFTER_MEAL -> BloodGlucoseRecord.RELATION_TO_MEAL_AFTER_MEAL
}

/**
 * Converts Health Connect int constant to [BloodGlucoseRelationToMealDto].
 */
internal fun Int.toBloodGlucoseRelationToMealDto(): BloodGlucoseRelationToMealDto = when (this) {
    BloodGlucoseRecord.RELATION_TO_MEAL_GENERAL -> BloodGlucoseRelationToMealDto.GENERAL
    BloodGlucoseRecord.RELATION_TO_MEAL_FASTING -> BloodGlucoseRelationToMealDto.FASTING
    BloodGlucoseRecord.RELATION_TO_MEAL_BEFORE_MEAL -> BloodGlucoseRelationToMealDto.BEFORE_MEAL
    BloodGlucoseRecord.RELATION_TO_MEAL_AFTER_MEAL -> BloodGlucoseRelationToMealDto.AFTER_MEAL
    else -> BloodGlucoseRelationToMealDto.UNKNOWN
}

/**
 * Converts [BloodGlucoseSpecimenSourceDto] to Health Connect int constant.
 */
internal fun BloodGlucoseSpecimenSourceDto.toHealthConnect(): Int = when (this) {
    BloodGlucoseSpecimenSourceDto.UNKNOWN -> BloodGlucoseRecord.SPECIMEN_SOURCE_UNKNOWN
    BloodGlucoseSpecimenSourceDto.INTERSTITIAL_FLUID ->
        BloodGlucoseRecord.SPECIMEN_SOURCE_INTERSTITIAL_FLUID

    BloodGlucoseSpecimenSourceDto.CAPILLARY_BLOOD ->
        BloodGlucoseRecord.SPECIMEN_SOURCE_CAPILLARY_BLOOD

    BloodGlucoseSpecimenSourceDto.PLASMA -> BloodGlucoseRecord.SPECIMEN_SOURCE_PLASMA
    BloodGlucoseSpecimenSourceDto.SERUM -> BloodGlucoseRecord.SPECIMEN_SOURCE_SERUM
    BloodGlucoseSpecimenSourceDto.TEARS -> BloodGlucoseRecord.SPECIMEN_SOURCE_TEARS
    BloodGlucoseSpecimenSourceDto.WHOLE_BLOOD -> BloodGlucoseRecord.SPECIMEN_SOURCE_WHOLE_BLOOD
}

/**
 * Converts Health Connect int constant to [BloodGlucoseSpecimenSourceDto].
 */
internal fun Int.toBloodGlucoseSpecimenSourceDto(): BloodGlucoseSpecimenSourceDto = when (this) {
    BloodGlucoseRecord.SPECIMEN_SOURCE_INTERSTITIAL_FLUID ->
        BloodGlucoseSpecimenSourceDto.INTERSTITIAL_FLUID

    BloodGlucoseRecord.SPECIMEN_SOURCE_CAPILLARY_BLOOD ->
        BloodGlucoseSpecimenSourceDto.CAPILLARY_BLOOD

    BloodGlucoseRecord.SPECIMEN_SOURCE_PLASMA -> BloodGlucoseSpecimenSourceDto.PLASMA
    BloodGlucoseRecord.SPECIMEN_SOURCE_SERUM -> BloodGlucoseSpecimenSourceDto.SERUM
    BloodGlucoseRecord.SPECIMEN_SOURCE_TEARS -> BloodGlucoseSpecimenSourceDto.TEARS
    BloodGlucoseRecord.SPECIMEN_SOURCE_WHOLE_BLOOD -> BloodGlucoseSpecimenSourceDto.WHOLE_BLOOD
    else -> BloodGlucoseSpecimenSourceDto.UNKNOWN
}

/**
 * Converts a Health Connect [BloodGlucoseRecord] to a [BloodGlucoseRecordDto].
 */
internal fun BloodGlucoseRecord.toDto(): BloodGlucoseRecordDto = BloodGlucoseRecordDto(
    id = metadata.id,
    time = time.toEpochMilli(),
    zoneOffsetSeconds = zoneOffset?.totalSeconds?.toLong(),
    metadata = metadata.toDto(),
    bloodGlucose = level.toDto(),
    relationToMeal = relationToMeal.toBloodGlucoseRelationToMealDto(),
    specimenSource = specimenSource.toBloodGlucoseSpecimenSourceDto(),
    mealType = mealType.toMealTypeDto(),
)

/**
 * Converts a [BloodGlucoseRecordDto] to a Health Connect [BloodGlucoseRecord].
 */
internal fun BloodGlucoseRecordDto.toHealthConnect(): BloodGlucoseRecord = BloodGlucoseRecord(
    time = Instant.ofEpochMilli(time),
    zoneOffset = zoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) },
    metadata = metadata.toHealthConnect(),
    level = bloodGlucose.toHealthConnect(),
    relationToMeal = relationToMeal?.toHealthConnect()
        ?: BloodGlucoseRecord.RELATION_TO_MEAL_UNKNOWN,
    specimenSource = specimenSource?.toHealthConnect()
        ?: BloodGlucoseRecord.SPECIMEN_SOURCE_UNKNOWN,
    mealType = mealType?.toHealthConnect() ?: MealType.MEAL_TYPE_UNKNOWN,
)
