package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.NutritionRecord
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.metadata_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import java.time.Instant
import java.time.ZoneOffset

/**
 * Converts a [NutritionRecordDto] to a Health Connect [NutritionRecord] object.
 */
internal fun NutritionRecordDto.toHealthConnect(): NutritionRecord {
    val startTimeInstant = Instant.ofEpochMilli(startTime)
    val endTimeInstant = Instant.ofEpochMilli(endTime)
    val startZoneOffset =
        startZoneOffsetSeconds?.let { ZoneOffset.ofTotalSeconds(it.toInt()) } ?: ZoneOffset.UTC
    val endZoneOffset = endZoneOffsetSeconds?.let {
        ZoneOffset.ofTotalSeconds(it.toInt())
    } ?: ZoneOffset.UTC

    // Build NutritionRecord based on healthDataType
    return when (healthDataType) {
        HealthDataTypeDto.NUTRITION -> NutritionRecord(
            startTime = startTimeInstant,
            endTime = endTimeInstant,
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
            metadata = metadata.toHealthConnect(id),
        )

        else -> throw IllegalArgumentException(
            "Unsupported healthDataType for NutritionRecordDto: $healthDataType",
        )
    }
}

/**
 * Converts NutritionRecord to a unified NutritionRecordDto for combined nutrition.
 *
 * Creates a NutritionRecordDto with healthDataType = NUTRITION and all non-null fields populated.
 */
internal fun NutritionRecord.toDto(): NutritionRecordDto = NutritionRecordDto(
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
