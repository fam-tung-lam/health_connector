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

    // MARK: - Mapper Methods

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

        guard let dto = quantitySample.toNutrientDto(for: nutrientType) else {
            throw
                HealthConnectorError
                .invalidArgument(
                    message:
                    "Failed to convert HKQuantitySample to nutrient DTO for type \(nutrientType)"
                )
        }
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

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try dto.extractNutrientTime()
    }

    // MARK: - Capability Methods

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
    MappableHealthRecordHandler,
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

    typealias RecordDto = EnergyNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .energyNutrient
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .energyNutrient,
            quantityTypeIdentifier: .dietaryEnergyConsumed
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .energyNutrient,
            quantityTypeIdentifier: .dietaryEnergyConsumed
        )
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = CaffeineNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .caffeine
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .caffeine,
            quantityTypeIdentifier: .dietaryCaffeine
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .caffeine,
            quantityTypeIdentifier: .dietaryCaffeine
        )
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = ProteinNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .protein
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .protein,
            quantityTypeIdentifier: .dietaryProtein
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .protein,
            quantityTypeIdentifier: .dietaryProtein
        )
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = TotalCarbohydrateNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .totalCarbohydrate
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .totalCarbohydrate,
            quantityTypeIdentifier: .dietaryCarbohydrates
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .totalCarbohydrate,
            quantityTypeIdentifier: .dietaryCarbohydrates
        )
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = TotalFatNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto { .totalFat }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample, nutrientType: .totalFat, quantityTypeIdentifier: .dietaryFatTotal
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto, nutrientType: .totalFat, quantityTypeIdentifier: .dietaryFatTotal
        )
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
    }

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
    MappableHealthRecordHandler,
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

    typealias RecordDto = SaturatedFatNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto { .saturatedFat }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample, nutrientType: .saturatedFat, quantityTypeIdentifier: .dietaryFatSaturated
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto, nutrientType: .saturatedFat, quantityTypeIdentifier: .dietaryFatSaturated
        )
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
    }

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
    MappableHealthRecordHandler,
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

    typealias RecordDto = MonounsaturatedFatNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto { .monounsaturatedFat }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample, nutrientType: .monounsaturatedFat,
            quantityTypeIdentifier: .dietaryFatMonounsaturated
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto, nutrientType: .monounsaturatedFat,
            quantityTypeIdentifier: .dietaryFatMonounsaturated
        )
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
    }

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
    MappableHealthRecordHandler,
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

    typealias RecordDto = PolyunsaturatedFatNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto { .polyunsaturatedFat }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample, nutrientType: .polyunsaturatedFat,
            quantityTypeIdentifier: .dietaryFatPolyunsaturated
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto, nutrientType: .polyunsaturatedFat,
            quantityTypeIdentifier: .dietaryFatPolyunsaturated
        )
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
    }

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
    MappableHealthRecordHandler,
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

    typealias RecordDto = CholesterolNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .cholesterol
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .cholesterol,
            quantityTypeIdentifier: .dietaryCholesterol
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .cholesterol,
            quantityTypeIdentifier: .dietaryCholesterol
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = DietaryFiberNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .dietaryFiber
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .dietaryFiber,
            quantityTypeIdentifier: .dietaryFiber
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .dietaryFiber,
            quantityTypeIdentifier: .dietaryFiber
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = SugarNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .sugar
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .sugar,
            quantityTypeIdentifier: .dietarySugar
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .sugar,
            quantityTypeIdentifier: .dietarySugar
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = VitaminANutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .vitaminA
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .vitaminA,
            quantityTypeIdentifier: .dietaryVitaminA
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .vitaminA,
            quantityTypeIdentifier: .dietaryVitaminA
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = VitaminB6NutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .vitaminB6
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .vitaminB6,
            quantityTypeIdentifier: .dietaryVitaminB6
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .vitaminB6,
            quantityTypeIdentifier: .dietaryVitaminB6
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = VitaminB12NutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .vitaminB12
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .vitaminB12,
            quantityTypeIdentifier: .dietaryVitaminB12
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .vitaminB12,
            quantityTypeIdentifier: .dietaryVitaminB12
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = VitaminCNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .vitaminC
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .vitaminC,
            quantityTypeIdentifier: .dietaryVitaminC
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .vitaminC,
            quantityTypeIdentifier: .dietaryVitaminC
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = VitaminDNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .vitaminD
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .vitaminD,
            quantityTypeIdentifier: .dietaryVitaminD
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .vitaminD,
            quantityTypeIdentifier: .dietaryVitaminD
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = VitaminENutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .vitaminE
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .vitaminE,
            quantityTypeIdentifier: .dietaryVitaminE
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .vitaminE,
            quantityTypeIdentifier: .dietaryVitaminE
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = VitaminKNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .vitaminK
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .vitaminK,
            quantityTypeIdentifier: .dietaryVitaminK
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .vitaminK,
            quantityTypeIdentifier: .dietaryVitaminK
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = ThiaminNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .thiamin
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .thiamin,
            quantityTypeIdentifier: .dietaryThiamin
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .thiamin,
            quantityTypeIdentifier: .dietaryThiamin
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = RiboflavinNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .riboflavin
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .riboflavin,
            quantityTypeIdentifier: .dietaryRiboflavin
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .riboflavin,
            quantityTypeIdentifier: .dietaryRiboflavin
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = NiacinNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .niacin
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .niacin,
            quantityTypeIdentifier: .dietaryNiacin
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .niacin,
            quantityTypeIdentifier: .dietaryNiacin
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = FolateNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .folate
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .folate,
            quantityTypeIdentifier: .dietaryFolate
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .folate,
            quantityTypeIdentifier: .dietaryFolate
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = BiotinNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .biotin
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .biotin,
            quantityTypeIdentifier: .dietaryBiotin
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .biotin,
            quantityTypeIdentifier: .dietaryBiotin
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = PantothenicAcidNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .pantothenicAcid
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .pantothenicAcid,
            quantityTypeIdentifier: .dietaryPantothenicAcid
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .pantothenicAcid,
            quantityTypeIdentifier: .dietaryPantothenicAcid
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = CalciumNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .calcium
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .calcium,
            quantityTypeIdentifier: .dietaryCalcium
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .calcium,
            quantityTypeIdentifier: .dietaryCalcium
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = IronNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .iron
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .iron,
            quantityTypeIdentifier: .dietaryIron
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .iron,
            quantityTypeIdentifier: .dietaryIron
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = MagnesiumNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .magnesium
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .magnesium,
            quantityTypeIdentifier: .dietaryMagnesium
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .magnesium,
            quantityTypeIdentifier: .dietaryMagnesium
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = ManganeseNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .manganese
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .manganese,
            quantityTypeIdentifier: .dietaryManganese
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .manganese,
            quantityTypeIdentifier: .dietaryManganese
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = PhosphorusNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .phosphorus
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .phosphorus,
            quantityTypeIdentifier: .dietaryPhosphorus
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .phosphorus,
            quantityTypeIdentifier: .dietaryPhosphorus
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = PotassiumNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .potassium
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .potassium,
            quantityTypeIdentifier: .dietaryPotassium
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .potassium,
            quantityTypeIdentifier: .dietaryPotassium
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = SeleniumNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .selenium
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .selenium,
            quantityTypeIdentifier: .dietarySelenium
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .selenium,
            quantityTypeIdentifier: .dietarySelenium
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = SodiumNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .sodium
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .sodium,
            quantityTypeIdentifier: .dietarySodium
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .sodium,
            quantityTypeIdentifier: .dietarySodium
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
    MappableHealthRecordHandler,
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

    typealias RecordDto = ZincNutrientRecordDto
    typealias SampleType = HKQuantitySample

    static var supportedType: HealthDataTypeDto {
        .zinc
    }

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        try NutrientHandler.toDTO(
            sample,
            nutrientType: .zinc,
            quantityTypeIdentifier: .dietaryZinc
        )
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        try NutrientHandler.toHealthKit(
            dto,
            nutrientType: .zinc,
            quantityTypeIdentifier: .dietaryZinc
        )
    }

    func getSampleType() throws -> HKSampleType {
        try handler.getSampleType()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        try NutrientHandler.extractTimestamp(dto)
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
