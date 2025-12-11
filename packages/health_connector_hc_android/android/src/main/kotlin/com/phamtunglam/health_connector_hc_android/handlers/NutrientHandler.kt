package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.units.Energy
import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toNutrientDto
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.CommonAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import kotlin.reflect.KClass

/**
 * Unified handler for all individual nutrient types.
 */
internal class NutrientHandler(private val nutrientType: HealthDataTypeDto) :
    InstantRecordHandler,
    AggregationSupportingHandler<CommonAggregateRequestDto> {

    override val supportedType: HealthDataTypeDto = nutrientType

    override fun toDto(record: Record): HealthRecordDto? {
        require(record is NutritionRecord) {
            "Expected NutritionRecord, got ${record::class.simpleName}"
        }

        return record.toNutrientDto(nutrientType)
    }

    override fun toHealthConnect(dto: HealthRecordDto): Record {
        require(dto is NutritionRecordDto) {
            "Expected NutritionRecordDto, got ${dto::class.simpleName}"
        }
        require(dto.healthDataType == nutrientType) {
            "Expected NutritionRecordDto with $nutrientType, got ${dto.healthDataType}"
        }

        return dto.toHealthConnect()
    }

    override fun getRecordClass(): KClass<out Record> = NutritionRecord::class

    override fun toAggregateMetric(request: CommonAggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> when (nutrientType) {
                HealthDataTypeDto.ENERGY_NUTRIENT -> NutritionRecord.ENERGY_TOTAL
                HealthDataTypeDto.CAFFEINE -> NutritionRecord.CAFFEINE_TOTAL
                HealthDataTypeDto.PROTEIN -> NutritionRecord.PROTEIN_TOTAL
                HealthDataTypeDto.TOTAL_CARBOHYDRATE -> NutritionRecord.TOTAL_CARBOHYDRATE_TOTAL
                HealthDataTypeDto.TOTAL_FAT -> NutritionRecord.TOTAL_FAT_TOTAL
                HealthDataTypeDto.SATURATED_FAT -> NutritionRecord.SATURATED_FAT_TOTAL
                HealthDataTypeDto.MONOUNSATURATED_FAT -> NutritionRecord.MONOUNSATURATED_FAT_TOTAL
                HealthDataTypeDto.POLYUNSATURATED_FAT -> NutritionRecord.POLYUNSATURATED_FAT_TOTAL
                HealthDataTypeDto.CHOLESTEROL -> NutritionRecord.CHOLESTEROL_TOTAL
                HealthDataTypeDto.DIETARY_FIBER -> NutritionRecord.DIETARY_FIBER_TOTAL
                HealthDataTypeDto.SUGAR -> NutritionRecord.SUGAR_TOTAL
                HealthDataTypeDto.VITAMIN_A -> NutritionRecord.VITAMIN_A_TOTAL
                HealthDataTypeDto.VITAMIN_B6 -> NutritionRecord.VITAMIN_B6_TOTAL
                HealthDataTypeDto.VITAMIN_B12 -> NutritionRecord.VITAMIN_B12_TOTAL
                HealthDataTypeDto.VITAMIN_C -> NutritionRecord.VITAMIN_C_TOTAL
                HealthDataTypeDto.VITAMIN_D -> NutritionRecord.VITAMIN_D_TOTAL
                HealthDataTypeDto.VITAMIN_E -> NutritionRecord.VITAMIN_E_TOTAL
                HealthDataTypeDto.VITAMIN_K -> NutritionRecord.VITAMIN_K_TOTAL
                HealthDataTypeDto.THIAMIN -> NutritionRecord.THIAMIN_TOTAL
                HealthDataTypeDto.RIBOFLAVIN -> NutritionRecord.RIBOFLAVIN_TOTAL
                HealthDataTypeDto.NIACIN -> NutritionRecord.NIACIN_TOTAL
                HealthDataTypeDto.FOLATE -> NutritionRecord.FOLATE_TOTAL
                HealthDataTypeDto.BIOTIN -> NutritionRecord.BIOTIN_TOTAL
                HealthDataTypeDto.PANTOTHENIC_ACID -> NutritionRecord.PANTOTHENIC_ACID_TOTAL
                HealthDataTypeDto.CALCIUM -> NutritionRecord.CALCIUM_TOTAL
                HealthDataTypeDto.IRON -> NutritionRecord.IRON_TOTAL
                HealthDataTypeDto.MAGNESIUM -> NutritionRecord.MAGNESIUM_TOTAL
                HealthDataTypeDto.MANGANESE -> NutritionRecord.MANGANESE_TOTAL
                HealthDataTypeDto.PHOSPHORUS -> NutritionRecord.PHOSPHORUS_TOTAL
                HealthDataTypeDto.POTASSIUM -> NutritionRecord.POTASSIUM_TOTAL
                HealthDataTypeDto.SELENIUM -> NutritionRecord.SELENIUM_TOTAL
                HealthDataTypeDto.SODIUM -> NutritionRecord.SODIUM_TOTAL
                HealthDataTypeDto.ZINC -> NutritionRecord.ZINC_TOTAL
                HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                HealthDataTypeDto.DISTANCE,
                HealthDataTypeDto.FLOORS_CLIMBED,
                HealthDataTypeDto.STEPS,
                HealthDataTypeDto.WEIGHT,
                HealthDataTypeDto.HEIGHT,
                HealthDataTypeDto.BODY_FAT_PERCENTAGE,
                HealthDataTypeDto.BODY_TEMPERATURE,
                HealthDataTypeDto.LEAN_BODY_MASS,
                HealthDataTypeDto.WHEELCHAIR_PUSHES,
                HealthDataTypeDto.HYDRATION,
                HealthDataTypeDto.HEART_RATE_SERIES_RECORD,
                HealthDataTypeDto.SLEEP_SESSION,
                HealthDataTypeDto.NUTRITION,
                HealthDataTypeDto.BLOOD_PRESSURE,
                -> throw IllegalArgumentException(
                    "$nutrientType not nutrient data type.",
                )
            }

            AggregationMetricDto.AVG,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX,
            AggregationMetricDto.COUNT,
            ->
                throw UnsupportedOperationException(
                    "Aggregation metric ${request.aggregationMetric} " +
                        "is not supported for nutrients (cumulative data). " +
                        "Only SUM is supported.",
                )
        }

    override fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>,
    ): MeasurementUnitDto = when (nutrientType) {
        HealthDataTypeDto.ENERGY_NUTRIENT -> {
            val energy = aggregationResult[aggregateMetric] as? Energy
                ?: error("Aggregation result for $aggregateMetric is null")
            energy.toDto()
        }

        HealthDataTypeDto.CAFFEINE,
        HealthDataTypeDto.PROTEIN,
        HealthDataTypeDto.TOTAL_CARBOHYDRATE,
        HealthDataTypeDto.TOTAL_FAT,
        HealthDataTypeDto.SATURATED_FAT,
        HealthDataTypeDto.MONOUNSATURATED_FAT,
        HealthDataTypeDto.POLYUNSATURATED_FAT,
        HealthDataTypeDto.CHOLESTEROL,
        HealthDataTypeDto.DIETARY_FIBER,
        HealthDataTypeDto.SUGAR,
        HealthDataTypeDto.VITAMIN_A,
        HealthDataTypeDto.VITAMIN_B6,
        HealthDataTypeDto.VITAMIN_B12,
        HealthDataTypeDto.VITAMIN_C,
        HealthDataTypeDto.VITAMIN_D,
        HealthDataTypeDto.VITAMIN_E,
        HealthDataTypeDto.VITAMIN_K,
        HealthDataTypeDto.THIAMIN,
        HealthDataTypeDto.RIBOFLAVIN,
        HealthDataTypeDto.NIACIN,
        HealthDataTypeDto.FOLATE,
        HealthDataTypeDto.BIOTIN,
        HealthDataTypeDto.PANTOTHENIC_ACID,
        HealthDataTypeDto.CALCIUM,
        HealthDataTypeDto.IRON,
        HealthDataTypeDto.MAGNESIUM,
        HealthDataTypeDto.MANGANESE,
        HealthDataTypeDto.PHOSPHORUS,
        HealthDataTypeDto.POTASSIUM,
        HealthDataTypeDto.SELENIUM,
        HealthDataTypeDto.SODIUM,
        HealthDataTypeDto.ZINC,
        -> {
            val mass = aggregationResult[aggregateMetric] as? Mass
                ?: error("Aggregation result for $aggregateMetric is null")
            mass.toDto()
        }

        HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
        HealthDataTypeDto.DISTANCE,
        HealthDataTypeDto.FLOORS_CLIMBED,
        HealthDataTypeDto.STEPS,
        HealthDataTypeDto.WEIGHT,
        HealthDataTypeDto.HEIGHT,
        HealthDataTypeDto.BODY_FAT_PERCENTAGE,
        HealthDataTypeDto.BODY_TEMPERATURE,
        HealthDataTypeDto.LEAN_BODY_MASS,
        HealthDataTypeDto.WHEELCHAIR_PUSHES,
        HealthDataTypeDto.HYDRATION,
        HealthDataTypeDto.HEART_RATE_SERIES_RECORD,
        HealthDataTypeDto.SLEEP_SESSION,
        HealthDataTypeDto.NUTRITION,
        HealthDataTypeDto.BLOOD_PRESSURE,
        -> error(
            "${NutrientHandler::class.simpleName} must only handle nutrient data types, " +
                "but received: $nutrientType",
        )
    }
}
