package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.MealType
import com.phamtunglam.health_connector_hc_android.pigeon.MealTypeDto

/**
 * Converts Health Connect meal type to DTO.
 */
internal fun Int.toMealTypeDto(): MealTypeDto = when (this) {
    MealType.MEAL_TYPE_UNKNOWN -> MealTypeDto.UNKNOWN
    MealType.MEAL_TYPE_BREAKFAST -> MealTypeDto.BREAKFAST
    MealType.MEAL_TYPE_LUNCH -> MealTypeDto.LUNCH
    MealType.MEAL_TYPE_DINNER -> MealTypeDto.DINNER
    MealType.MEAL_TYPE_SNACK -> MealTypeDto.SNACK
    else -> MealTypeDto.UNKNOWN
}

/**
 * Converts DTO meal type to Health Connect.
 */
internal fun MealTypeDto.toHealthConnect(): Int = when (this) {
    MealTypeDto.BREAKFAST -> MealType.MEAL_TYPE_BREAKFAST
    MealTypeDto.LUNCH -> MealType.MEAL_TYPE_LUNCH
    MealTypeDto.DINNER -> MealType.MEAL_TYPE_DINNER
    MealTypeDto.SNACK -> MealType.MEAL_TYPE_SNACK
    MealTypeDto.UNKNOWN -> MealType.MEAL_TYPE_UNKNOWN
}
