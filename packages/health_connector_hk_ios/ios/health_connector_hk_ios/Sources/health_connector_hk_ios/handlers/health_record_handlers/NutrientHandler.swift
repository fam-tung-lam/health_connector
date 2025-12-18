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

final class EnergyNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = EnergyNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .energyNutrient
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

final class CaffeineNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = CaffeineNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .caffeine
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

final class ProteinNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = ProteinNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .protein
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

final class TotalCarbohydrateNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = TotalCarbohydrateNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .totalCarbohydrate
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

final class TotalFatNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = TotalFatNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto { .totalFat }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(from statistics: HKStatistics, metric: AggregationMetricDto) throws
        -> MeasurementUnitDto
    {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class SaturatedFatNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = SaturatedFatNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto { .saturatedFat }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(from statistics: HKStatistics, metric: AggregationMetricDto) throws
        -> MeasurementUnitDto
    {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class MonounsaturatedFatNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = MonounsaturatedFatNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto { .monounsaturatedFat }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(from statistics: HKStatistics, metric: AggregationMetricDto) throws
        -> MeasurementUnitDto
    {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class PolyunsaturatedFatNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = PolyunsaturatedFatNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto { .polyunsaturatedFat }

    func toStatisticsOptions(_ metric: AggregationMetricDto) throws -> HKStatisticsOptions {
        try handler.toStatisticsOptions(metric)
    }

    func extractAggregateValue(from statistics: HKStatistics, metric: AggregationMetricDto) throws
        -> MeasurementUnitDto
    {
        try handler.extractAggregateValue(from: statistics, metric: metric)
    }
}

final class CholesterolNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = CholesterolNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .cholesterol
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

final class DietaryFiberNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = DietaryFiberNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .dietaryFiber
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

final class SugarNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = SugarNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .sugar
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

final class VitaminANutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = VitaminANutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .vitaminA
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

final class VitaminB6NutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = VitaminB6NutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .vitaminB6
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

final class VitaminB12NutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = VitaminB12NutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .vitaminB12
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

final class VitaminCNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = VitaminCNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .vitaminC
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

final class VitaminDNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = VitaminDNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .vitaminD
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

final class VitaminENutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = VitaminENutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .vitaminE
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

final class VitaminKNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = VitaminKNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .vitaminK
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

final class ThiaminNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = ThiaminNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .thiamin
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

final class RiboflavinNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = RiboflavinNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .riboflavin
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

final class NiacinNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = NiacinNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .niacin
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

final class FolateNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = FolateNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .folate
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

final class BiotinNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = BiotinNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .biotin
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

final class PantothenicAcidNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = PantothenicAcidNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .pantothenicAcid
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

final class CalciumNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = CalciumNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .calcium
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

final class IronNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = IronNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .iron
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

final class MagnesiumNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = MagnesiumNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .magnesium
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

final class ManganeseNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = ManganeseNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .manganese
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

final class PhosphorusNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = PhosphorusNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .phosphorus
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

final class PotassiumNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = PotassiumNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .potassium
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

final class SeleniumNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = SeleniumNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .selenium
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

final class SodiumNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = SodiumNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .sodium
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

final class ZincNutrientHandler: @unchecked Sendable,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthKitAggregatableHealthRecordHandler
{
    typealias RecordDto = ZincNutrientRecordDto
    typealias SampleType = HKQuantitySample

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

    static var dataType: HealthDataTypeDto {
        .zinc
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
