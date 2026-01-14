package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.units.Energy
import androidx.health.connect.client.units.Mass
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
            energy = energyInKilocalories?.let { Energy.kilocalories(it) },
            protein = proteinInGrams?.let { Mass.grams(it) },
            totalCarbohydrate = totalCarbohydrateInGrams?.let { Mass.grams(it) },
            totalFat = totalFatInGrams?.let { Mass.grams(it) },
            saturatedFat = saturatedFatInGrams?.let { Mass.grams(it) },
            monounsaturatedFat = monounsaturatedFatInGrams?.let { Mass.grams(it) },
            polyunsaturatedFat = polyunsaturatedFatInGrams?.let { Mass.grams(it) },
            cholesterol = cholesterolInGrams?.let { Mass.grams(it) },
            dietaryFiber = dietaryFiberInGrams?.let { Mass.grams(it) },
            sugar = sugarInGrams?.let { Mass.grams(it) },
            vitaminA = vitaminAInGrams?.let { Mass.grams(it) },
            vitaminB6 = vitaminB6InGrams?.let { Mass.grams(it) },
            vitaminB12 = vitaminB12InGrams?.let { Mass.grams(it) },
            vitaminC = vitaminCInGrams?.let { Mass.grams(it) },
            vitaminD = vitaminDInGrams?.let { Mass.grams(it) },
            vitaminE = vitaminEInGrams?.let { Mass.grams(it) },
            vitaminK = vitaminKInGrams?.let { Mass.grams(it) },
            thiamin = thiaminInGrams?.let { Mass.grams(it) },
            riboflavin = riboflavinInGrams?.let { Mass.grams(it) },
            niacin = niacinInGrams?.let { Mass.grams(it) },
            folate = folateInGrams?.let { Mass.grams(it) },
            biotin = biotinInGrams?.let { Mass.grams(it) },
            pantothenicAcid = pantothenicAcidInGrams?.let { Mass.grams(it) },
            calcium = calciumInGrams?.let { Mass.grams(it) },
            iron = ironInGrams?.let { Mass.grams(it) },
            magnesium = magnesiumInGrams?.let { Mass.grams(it) },
            manganese = manganeseInGrams?.let { Mass.grams(it) },
            phosphorus = phosphorusInGrams?.let { Mass.grams(it) },
            potassium = potassiumInGrams?.let { Mass.grams(it) },
            selenium = seleniumInGrams?.let { Mass.grams(it) },
            sodium = sodiumInGrams?.let { Mass.grams(it) },
            zinc = zincInGrams?.let { Mass.grams(it) },
            caffeine = caffeineInGrams?.let { Mass.grams(it) },
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
    energyInKilocalories = energy?.inKilocalories,
    proteinInGrams = protein?.inGrams,
    totalCarbohydrateInGrams = totalCarbohydrate?.inGrams,
    totalFatInGrams = totalFat?.inGrams,
    saturatedFatInGrams = saturatedFat?.inGrams,
    monounsaturatedFatInGrams = monounsaturatedFat?.inGrams,
    polyunsaturatedFatInGrams = polyunsaturatedFat?.inGrams,
    cholesterolInGrams = cholesterol?.inGrams,
    dietaryFiberInGrams = dietaryFiber?.inGrams,
    sugarInGrams = sugar?.inGrams,
    vitaminAInGrams = vitaminA?.inGrams,
    vitaminB6InGrams = vitaminB6?.inGrams,
    vitaminB12InGrams = vitaminB12?.inGrams,
    vitaminCInGrams = vitaminC?.inGrams,
    vitaminDInGrams = vitaminD?.inGrams,
    vitaminEInGrams = vitaminE?.inGrams,
    vitaminKInGrams = vitaminK?.inGrams,
    thiaminInGrams = thiamin?.inGrams,
    riboflavinInGrams = riboflavin?.inGrams,
    niacinInGrams = niacin?.inGrams,
    folateInGrams = folate?.inGrams,
    biotinInGrams = biotin?.inGrams,
    pantothenicAcidInGrams = pantothenicAcid?.inGrams,
    calciumInGrams = calcium?.inGrams,
    ironInGrams = iron?.inGrams,
    magnesiumInGrams = magnesium?.inGrams,
    manganeseInGrams = manganese?.inGrams,
    phosphorusInGrams = phosphorus?.inGrams,
    potassiumInGrams = potassium?.inGrams,
    seleniumInGrams = selenium?.inGrams,
    sodiumInGrams = sodium?.inGrams,
    zincInGrams = zinc?.inGrams,
    caffeineInGrams = caffeine?.inGrams,
)
