import Foundation
import HealthKit

/// Unified handler for all individual nutrient types
struct NutrientHandler {
    let nutrientType: HealthDataTypeDto
    let quantityTypeIdentifier: HKQuantityTypeIdentifier
    let healthStore: HKHealthStore

    init(
        nutrientType: HealthDataTypeDto,
        quantityTypeIdentifier: HKQuantityTypeIdentifier,
        healthStore: HKHealthStore
    ) {
        self.nutrientType = nutrientType
        self.quantityTypeIdentifier = quantityTypeIdentifier
        self.healthStore = healthStore
    }

    static func toDTO(
        _ sample: HKSample,
        nutrientType: HealthDataTypeDto,
        quantityTypeIdentifier: HKQuantityTypeIdentifier
    ) throws -> HealthRecordDto {
        guard let quantitySample = sample as? HKQuantitySample else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKQuantitySample, got \(type(of: sample))"
            )
        }

        guard quantitySample.quantityType.identifier == quantityTypeIdentifier.rawValue else {
            throw HealthConnectorError.invalidArgument(
                message:
                "Expected nutrient type \(quantityTypeIdentifier.rawValue), got \(quantitySample.quantityType.identifier)"
            )
        }

        let dto = try quantitySample.toNutrientDto(for: nutrientType)
        return dto
    }

    static func toHealthKit(
        _ dto: HealthRecordDto,
        nutrientType: HealthDataTypeDto,
        quantityTypeIdentifier: HKQuantityTypeIdentifier
    ) throws -> HKSample {
        try dto.toHealthKitNutrientSample(
            for: nutrientType, quantityTypeIdentifier: quantityTypeIdentifier
        )
    }

    func getSampleType() throws -> HKSampleType {
        try HKQuantityType.make(from: quantityTypeIdentifier)
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        switch metric {
        case .sum:
            return .cumulativeSum
        case .avg, .min, .max, .count:
            throw HealthConnectorError.invalidArgument(
                message:
                "Aggregation metric '\(metric)' not supported for nutrients (cumulative data)",
                context: ["details": "Only 'sum' is supported"]
            )
        }
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        let quantity: HKQuantity? =
            switch metric {
            case .sum:
                statistics.sumQuantity()
            case .avg, .min, .max, .count:
                throw HealthConnectorError.invalidArgument(
                    message: "Aggregation metric '\(metric)' not supported for nutrients",
                    context: ["details": "Only 'sum' is supported"]
                )
            }

        guard let quantity else {
            throw HealthConnectorError.invalidArgument(
                message: "No aggregation result for metric '\(metric)'",
                context: [
                    "details": "Statistics returned nil for \(quantityTypeIdentifier.rawValue)",
                ]
            )
        }

        if nutrientType == .energyNutrient {
            return quantity.toEnergyDto()
        } else {
            return quantity.toMassDto()
        }
    }
}

final class EnergyNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .energyNutrient,
            quantityTypeIdentifier: .dietaryEnergyConsumed,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .energyNutrient
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class CaffeineNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .caffeine,
            quantityTypeIdentifier: .dietaryCaffeine,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .caffeine
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class ProteinNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .protein,
            quantityTypeIdentifier: .dietaryProtein,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .protein
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class TotalCarbohydrateNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .totalCarbohydrate,
            quantityTypeIdentifier: .dietaryCarbohydrates,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .totalCarbohydrate
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class TotalFatNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .totalFat,
            quantityTypeIdentifier: .dietaryFatTotal,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto { .totalFat }

    func getSampleType() throws -> HKSampleType { try handler.getSampleType() }
    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(from statistics: HKStatistics, metric: AggregationMetricDto) throws
        -> MeasurementUnitDto
    {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class SaturatedFatNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .saturatedFat,
            quantityTypeIdentifier: .dietaryFatSaturated,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto { .saturatedFat }

    func getSampleType() throws -> HKSampleType { try handler.getSampleType() }
    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(from statistics: HKStatistics, metric: AggregationMetricDto) throws
        -> MeasurementUnitDto
    {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class MonounsaturatedFatNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .monounsaturatedFat,
            quantityTypeIdentifier: .dietaryFatMonounsaturated,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto { .monounsaturatedFat }

    func getSampleType() throws -> HKSampleType { try handler.getSampleType() }
    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(from statistics: HKStatistics, metric: AggregationMetricDto) throws
        -> MeasurementUnitDto
    {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class PolyunsaturatedFatNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .polyunsaturatedFat,
            quantityTypeIdentifier: .dietaryFatPolyunsaturated,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto { .polyunsaturatedFat }

    func getSampleType() throws -> HKSampleType { try handler.getSampleType() }
    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(from statistics: HKStatistics, metric: AggregationMetricDto) throws
        -> MeasurementUnitDto
    {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class CholesterolNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .cholesterol,
            quantityTypeIdentifier: .dietaryCholesterol,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .cholesterol
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class DietaryFiberNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .dietaryFiber,
            quantityTypeIdentifier: .dietaryFiber,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .dietaryFiber
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class SugarNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .sugar,
            quantityTypeIdentifier: .dietarySugar,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .sugar
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class VitaminANutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .vitaminA,
            quantityTypeIdentifier: .dietaryVitaminA,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .vitaminA
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class VitaminB6NutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .vitaminB6,
            quantityTypeIdentifier: .dietaryVitaminB6,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .vitaminB6
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class VitaminB12NutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .vitaminB12,
            quantityTypeIdentifier: .dietaryVitaminB12,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .vitaminB12
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class VitaminCNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .vitaminC,
            quantityTypeIdentifier: .dietaryVitaminC,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .vitaminC
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class VitaminDNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .vitaminD,
            quantityTypeIdentifier: .dietaryVitaminD,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .vitaminD
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class VitaminENutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .vitaminE,
            quantityTypeIdentifier: .dietaryVitaminE,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .vitaminE
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class VitaminKNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .vitaminK,
            quantityTypeIdentifier: .dietaryVitaminK,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .vitaminK
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class ThiaminNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .thiamin,
            quantityTypeIdentifier: .dietaryThiamin,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .thiamin
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class RiboflavinNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .riboflavin,
            quantityTypeIdentifier: .dietaryRiboflavin,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .riboflavin
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class NiacinNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .niacin,
            quantityTypeIdentifier: .dietaryNiacin,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .niacin
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class FolateNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .folate,
            quantityTypeIdentifier: .dietaryFolate,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .folate
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class BiotinNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .biotin,
            quantityTypeIdentifier: .dietaryBiotin,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .biotin
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class PantothenicAcidNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .pantothenicAcid,
            quantityTypeIdentifier: .dietaryPantothenicAcid,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .pantothenicAcid
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class CalciumNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .calcium,
            quantityTypeIdentifier: .dietaryCalcium,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .calcium
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class IronNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .iron,
            quantityTypeIdentifier: .dietaryIron,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .iron
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class MagnesiumNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .magnesium,
            quantityTypeIdentifier: .dietaryMagnesium,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .magnesium
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class ManganeseNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .manganese,
            quantityTypeIdentifier: .dietaryManganese,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .manganese
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class PhosphorusNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .phosphorus,
            quantityTypeIdentifier: .dietaryPhosphorus,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .phosphorus
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class PotassiumNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .potassium,
            quantityTypeIdentifier: .dietaryPotassium,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .potassium
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class SeleniumNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .selenium,
            quantityTypeIdentifier: .dietarySelenium,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .selenium
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class SodiumNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .sodium,
            quantityTypeIdentifier: .dietarySodium,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .sodium
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class ZincNutrientHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler
{
    let healthStore: HKHealthStore
    private let handler: NutrientHandler

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
        handler = NutrientHandler(
            nutrientType: .zinc,
            quantityTypeIdentifier: .dietaryZinc,
            healthStore: healthStore
        )
    }

    static var supportedType: HealthDataTypeDto {
        .zinc
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(
        from statistics: HKStatistics,
        metric: AggregationMetricDto
    ) throws -> MeasurementUnitDto {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}
