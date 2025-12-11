import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show
        ActiveCaloriesBurnedRecord,
        BiotinNutrientRecord,
        BodyFatPercentageRecord,
        BloodPressureRecord,
        BloodPressureBodyPosition,
        BloodPressureMeasurementLocation,
        BodyTemperatureRecord,
        CaffeineNutrientRecord,
        CalciumNutrientRecord,
        CholesterolNutrientRecord,
        DiastolicBloodPressureRecord,
        DietaryFiberNutrientRecord,
        DistanceRecord,
        EnergyNutrientRecord,
        FloorsClimbedRecord,
        FolateNutrientRecord,
        HealthRecord,
        HeartRateMeasurement,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        InstantHealthRecord,
        IntervalHealthRecord,
        IronNutrientRecord,
        LeanBodyMassRecord,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        MealType,
        MonounsaturatedFatNutrientRecord,
        NiacinNutrientRecord,
        NutritionRecord,
        PantothenicAcidNutrientRecord,
        PhosphorusNutrientRecord,
        PolyunsaturatedFatNutrientRecord,
        PotassiumNutrientRecord,
        ProteinNutrientRecord,
        RiboflavinNutrientRecord,
        SaturatedFatNutrientRecord,
        SeleniumNutrientRecord,
        SeriesHealthRecord,
        SodiumNutrientRecord,
        StepRecord,
        SugarNutrientRecord,
        SystolicBloodPressureRecord,
        ThiaminNutrientRecord,
        TotalCarbohydrateNutrientRecord,
        TotalFatNutrientRecord,
        VitaminANutrientRecord,
        VitaminB12NutrientRecord,
        VitaminB6NutrientRecord,
        VitaminCNutrientRecord,
        VitaminDNutrientRecord,
        VitaminENutrientRecord,
        VitaminKNutrientRecord,
        WeightRecord,
        WheelchairPushesRecord,
        ZincNutrientRecord,
        SleepSessionRecord,
        SleepStageRecord,
        SleepStage,
        SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart'
    as theme;
import 'package:health_connector_toolbox/src/common/utils/date_format_utils.dart';
import 'package:health_connector_toolbox/src/common/widgets/measurement_unit_display.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_detail_row.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/heart_rate_samples_list.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/instant_health_record_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/interval_health_record_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/series_health_record_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/sleep_stages_list.dart';

/// Metadata for nutrient record types.
///
/// Contains display information for different nutrient record types.
@immutable
final class NutrientTypeMetadata {
  const NutrientTypeMetadata({
    required this.displayName,
    this.icon = AppIcons.fastfood,
  });

  final String displayName;
  final IconData icon;
}

/// A widget that displays a health record in a list tile format.
///
/// Automatically selects the appropriate unified tile widget based on the
/// record type hierarchy (InstantHealthRecord, IntervalHealthRecord,
/// SeriesHealthRecord) and provides record-specific builders for customization.
@immutable
final class HealthRecordListTile extends StatelessWidget {
  /// Metadata registry for mass nutrient record types.
  ///
  /// Maps record types to their display metadata.
  static const _massNutrientMetadata = <Type, NutrientTypeMetadata>{
    ProteinNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.protein),
    TotalCarbohydrateNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.totalCarbohydrate,
    ),
    TotalFatNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.totalFat,
    ),
    SaturatedFatNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.saturatedFat,
    ),
    MonounsaturatedFatNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.monounsaturatedFat,
    ),
    PolyunsaturatedFatNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.polyunsaturatedFat,
    ),
    CholesterolNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.cholesterol,
    ),
    DietaryFiberNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.dietaryFiber,
    ),
    SugarNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.sugar),
    CalciumNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.calcium),
    IronNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.iron),
    MagnesiumNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.magnesium,
    ),
    ManganeseNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.manganese,
    ),
    PhosphorusNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.phosphorus,
    ),
    PotassiumNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.potassium,
    ),
    SeleniumNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.selenium,
    ),
    SodiumNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.sodium),
    ZincNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.zinc),
    VitaminANutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.vitaminA,
    ),
    VitaminB6NutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.vitaminB6,
    ),
    VitaminB12NutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.vitaminB12,
    ),
    VitaminCNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.vitaminC,
    ),
    VitaminDNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.vitaminD,
    ),
    VitaminENutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.vitaminE,
    ),
    VitaminKNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.vitaminK,
    ),
    ThiaminNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.thiamin),
    RiboflavinNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.riboflavin,
    ),
    NiacinNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.niacin),
    FolateNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.folate),
    BiotinNutrientRecord: NutrientTypeMetadata(displayName: AppTexts.biotin),
    PantothenicAcidNutrientRecord: NutrientTypeMetadata(
      displayName: AppTexts.pantothenicAcid,
    ),
  };

  const HealthRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final HealthRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return switch (record) {
      InstantHealthRecord() => _buildInstantRecord(
        context,
        record as InstantHealthRecord,
      ),
      SeriesHealthRecord() => _buildSeriesRecord(
        context,
        record as SeriesHealthRecord,
      ),
      IntervalHealthRecord() => _buildIntervalRecord(
        context,
        record as IntervalHealthRecord,
      ),
    };
  }

  Widget _buildInstantRecord(
    BuildContext context,
    InstantHealthRecord record,
  ) {
    return switch (record) {
      BloodPressureRecord() => _buildBloodPressureRecord(record, onDelete),
      SystolicBloodPressureRecord() => _buildSystolicBloodPressureRecord(
        record,
        onDelete,
      ),
      DiastolicBloodPressureRecord() => _buildDiastolicBloodPressureRecord(
        record,
        onDelete,
      ),
      WeightRecord() => InstantHealthRecordTile<WeightRecord>(
        record: record,
        icon: AppIcons.monitorWeight,
        title:
            '${record.weight.inKilograms.toStringAsFixed(2)} kg '
            '(${record.weight.inPounds.toStringAsFixed(2)} lbs)',
        subtitleBuilder: (r, ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
            ),
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        ),
        detailRowsBuilder: (r, ctx) => [
          const HealthRecordDetailRow(
            label: AppTexts.value,
            value: '',
          ),
          MeasurementUnitDisplay(unit: r.weight),
        ],
        onDelete: onDelete,
      ),
      HeightRecord() => InstantHealthRecordTile<HeightRecord>(
        record: record,
        icon: AppIcons.height,
        title:
            '${record.height.inMeters.toStringAsFixed(2)} m '
            '(${record.height.inCentimeters.toStringAsFixed(0)} cm)',
        subtitleBuilder: (r, ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
            ),
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        ),
        detailRowsBuilder: (r, ctx) => [
          const HealthRecordDetailRow(
            label: AppTexts.value,
            value: '',
          ),
          MeasurementUnitDisplay(unit: r.height),
        ],
        onDelete: onDelete,
      ),
      BodyFatPercentageRecord() =>
        InstantHealthRecordTile<BodyFatPercentageRecord>(
          record: record,
          icon: AppIcons.percent,
          title: '${record.percentage.asWhole.toStringAsFixed(2)}%',
          subtitleBuilder: (r, ctx) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
              ),
              Text(
                '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          ),
          detailRowsBuilder: (r, ctx) => [
            const HealthRecordDetailRow(
              label: AppTexts.value,
              value: '',
            ),
            MeasurementUnitDisplay(unit: r.percentage),
          ],
          onDelete: onDelete,
        ),
      LeanBodyMassRecord() => InstantHealthRecordTile<LeanBodyMassRecord>(
        record: record,
        icon: AppIcons.monitorWeight,
        title:
            '${record.mass.inKilograms.toStringAsFixed(2)} kg '
            '(${record.mass.inPounds.toStringAsFixed(2)} lbs)',
        subtitleBuilder: (r, ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
            ),
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        ),
        detailRowsBuilder: (r, ctx) => [
          const HealthRecordDetailRow(
            label: AppTexts.value,
            value: '',
          ),
          MeasurementUnitDisplay(unit: r.mass),
        ],
        onDelete: onDelete,
      ),
      BodyTemperatureRecord() => InstantHealthRecordTile<BodyTemperatureRecord>(
        record: record,
        icon: AppIcons.temperature,
        title:
            '${record.temperature.inCelsius.toStringAsFixed(2)} °C '
            '(${record.temperature.inFahrenheit.toStringAsFixed(2)} °F)',
        subtitleBuilder: (r, ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
            ),
            Text(
              '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        ),
        detailRowsBuilder: (r, ctx) => [
          const HealthRecordDetailRow(
            label: AppTexts.value,
            value: '',
          ),
          MeasurementUnitDisplay(unit: r.temperature),
        ],
        onDelete: onDelete,
      ),
      HeartRateMeasurementRecord() =>
        InstantHealthRecordTile<HeartRateMeasurementRecord>(
          record: record,
          icon: AppIcons.favorite,
          title:
              '${record.beatsPerMinute.value.toInt()} '
              '${AppTexts.heartRateLabel}',
          subtitleBuilder: (r, ctx) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
              ),
              Text(
                '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          ),
          detailRowsBuilder: (r, ctx) => [
            HealthRecordDetailRow(
              label: AppTexts.heartRateBpm,
              value: r.beatsPerMinute.value.toInt().toString(),
            ),
          ],
          onDelete: onDelete,
        ),
      EnergyNutrientRecord() => _buildEnergyNutrientRecord(record, onDelete),
      CaffeineNutrientRecord() => _buildCaffeineNutrientRecord(
        record,
        onDelete,
      ),
      // Use metadata registry for all mass nutrient records
      ProteinNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[ProteinNutrientRecord]!,
        onDelete,
      ),
      TotalCarbohydrateNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[TotalCarbohydrateNutrientRecord]!,
        onDelete,
      ),
      TotalFatNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[TotalFatNutrientRecord]!,
        onDelete,
      ),
      SaturatedFatNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[SaturatedFatNutrientRecord]!,
        onDelete,
      ),
      MonounsaturatedFatNutrientRecord() =>
        _buildMassNutrientRecordWithMetadata(
          record,
          _massNutrientMetadata[MonounsaturatedFatNutrientRecord]!,
          onDelete,
        ),
      PolyunsaturatedFatNutrientRecord() =>
        _buildMassNutrientRecordWithMetadata(
          record,
          _massNutrientMetadata[PolyunsaturatedFatNutrientRecord]!,
          onDelete,
        ),
      CholesterolNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[CholesterolNutrientRecord]!,
        onDelete,
      ),
      DietaryFiberNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[DietaryFiberNutrientRecord]!,
        onDelete,
      ),
      SugarNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[SugarNutrientRecord]!,
        onDelete,
      ),
      CalciumNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[CalciumNutrientRecord]!,
        onDelete,
      ),
      IronNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[IronNutrientRecord]!,
        onDelete,
      ),
      MagnesiumNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[MagnesiumNutrientRecord]!,
        onDelete,
      ),
      ManganeseNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[ManganeseNutrientRecord]!,
        onDelete,
      ),
      PhosphorusNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[PhosphorusNutrientRecord]!,
        onDelete,
      ),
      PotassiumNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[PotassiumNutrientRecord]!,
        onDelete,
      ),
      SeleniumNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[SeleniumNutrientRecord]!,
        onDelete,
      ),
      SodiumNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[SodiumNutrientRecord]!,
        onDelete,
      ),
      ZincNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[ZincNutrientRecord]!,
        onDelete,
      ),
      VitaminANutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[VitaminANutrientRecord]!,
        onDelete,
      ),
      VitaminB6NutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[VitaminB6NutrientRecord]!,
        onDelete,
      ),
      VitaminB12NutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[VitaminB12NutrientRecord]!,
        onDelete,
      ),
      VitaminCNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[VitaminCNutrientRecord]!,
        onDelete,
      ),
      VitaminDNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[VitaminDNutrientRecord]!,
        onDelete,
      ),
      VitaminENutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[VitaminENutrientRecord]!,
        onDelete,
      ),
      VitaminKNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[VitaminKNutrientRecord]!,
        onDelete,
      ),
      ThiaminNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[ThiaminNutrientRecord]!,
        onDelete,
      ),
      RiboflavinNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[RiboflavinNutrientRecord]!,
        onDelete,
      ),
      NiacinNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[NiacinNutrientRecord]!,
        onDelete,
      ),
      FolateNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[FolateNutrientRecord]!,
        onDelete,
      ),
      BiotinNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[BiotinNutrientRecord]!,
        onDelete,
      ),
      PantothenicAcidNutrientRecord() => _buildMassNutrientRecordWithMetadata(
        record,
        _massNutrientMetadata[PantothenicAcidNutrientRecord]!,
        onDelete,
      ),
    };
  }

  Widget _buildEnergyNutrientRecord(
    EnergyNutrientRecord record,
    VoidCallback onDelete,
  ) {
    return InstantHealthRecordTile<EnergyNutrientRecord>(
      record: record,
      icon: AppIcons.localFireDepartment,
      title:
          '${record.value.inKilocalories.toStringAsFixed(2)} kcal '
          '(${record.value.inCalories.toStringAsFixed(0)} cal)',
      subtitleBuilder: (r, ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
          ),
          if (r.foodName != null && r.foodName!.isNotEmpty)
            Text(
              'Food: ${r.foodName}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          if (r.mealType != MealType.unknown)
            Text(
              'Meal: ${_getMealTypeDisplayName(r.mealType)}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          Text(
            '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
            style: const TextStyle(
              fontSize: 12,
              color: theme.AppColors.grey600,
            ),
          ),
        ],
      ),
      detailRowsBuilder: (r, ctx) => [
        const HealthRecordDetailRow(
          label: AppTexts.value,
          value: '',
        ),
        MeasurementUnitDisplay(unit: r.value),
        if (r.foodName != null && r.foodName!.isNotEmpty)
          HealthRecordDetailRow(
            label: AppTexts.foodName,
            value: r.foodName,
          ),
        if (r.mealType != MealType.unknown)
          HealthRecordDetailRow(
            label: AppTexts.mealType,
            value: _getMealTypeDisplayName(r.mealType),
          ),
      ],
      onDelete: onDelete,
    );
  }

  Widget _buildCaffeineNutrientRecord(
    CaffeineNutrientRecord record,
    VoidCallback onDelete,
  ) {
    return InstantHealthRecordTile<CaffeineNutrientRecord>(
      record: record,
      icon: AppIcons.fastfood,
      title:
          '${record.value.inGrams.toStringAsFixed(3)} g '
          '(${(record.value.inGrams * 1000).toStringAsFixed(1)} mg)',
      subtitleBuilder: (r, ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
          ),
          if (r.foodName != null && r.foodName!.isNotEmpty)
            Text(
              'Food: ${r.foodName}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          if (r.mealType != MealType.unknown)
            Text(
              'Meal: ${_getMealTypeDisplayName(r.mealType)}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          Text(
            '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
            style: const TextStyle(
              fontSize: 12,
              color: theme.AppColors.grey600,
            ),
          ),
        ],
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.caffeineG,
          value: r.value.inGrams.toStringAsFixed(3),
        ),
        HealthRecordDetailRow(
          label: AppTexts.caffeineMg,
          value: (r.value.inGrams * 1000).toStringAsFixed(1),
        ),
        if (r.foodName != null && r.foodName!.isNotEmpty)
          HealthRecordDetailRow(
            label: AppTexts.foodName,
            value: r.foodName,
          ),
        if (r.mealType != MealType.unknown)
          HealthRecordDetailRow(
            label: AppTexts.mealType,
            value: _getMealTypeDisplayName(r.mealType),
          ),
      ],
      onDelete: onDelete,
    );
  }

  /// Builds a mass nutrient record tile using metadata registry.
  ///
  /// All mass nutrient records share the same structure, so we can extract
  /// properties using a single switch expression.
  Widget _buildMassNutrientRecordWithMetadata<T extends InstantHealthRecord>(
    T record,
    NutrientTypeMetadata metadata,
    VoidCallback onDelete,
  ) {
    // Extract properties from the record using pattern matching
    // Mass nutrient records have the same structure: value, foodName, mealType
    final (mass, foodName, mealType) = switch (record) {
      ProteinNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      TotalCarbohydrateNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      TotalFatNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      SaturatedFatNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      MonounsaturatedFatNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      PolyunsaturatedFatNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      CholesterolNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      DietaryFiberNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      SugarNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      CalciumNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      IronNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      MagnesiumNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      ManganeseNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      PhosphorusNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      PotassiumNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      SeleniumNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      SodiumNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      ZincNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      VitaminANutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      VitaminB6NutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      VitaminB12NutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      VitaminCNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      VitaminDNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      VitaminENutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      VitaminKNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      ThiaminNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      RiboflavinNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      NiacinNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      FolateNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      BiotinNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      PantothenicAcidNutrientRecord() => (
        record.value,
        record.foodName,
        record.mealType,
      ),
      _ => throw ArgumentError(
        'Unsupported mass nutrient record type: ${record.runtimeType}',
      ),
    };

    return InstantHealthRecordTile<T>(
      record: record,
      icon: metadata.icon,
      title:
          '${metadata.displayName}: ${mass.inGrams.toStringAsFixed(3)} g '
          '(${(mass.inGrams * 1000).toStringAsFixed(1)} mg)',
      subtitleBuilder: (r, ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
          ),
          if (foodName != null && foodName.isNotEmpty)
            Text(
              '${AppTexts.food}: $foodName',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          if (mealType != MealType.unknown)
            Text(
              '${AppTexts.meal}: ${_getMealTypeDisplayName(mealType)}',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          Text(
            '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
            style: const TextStyle(
              fontSize: 12,
              color: theme.AppColors.grey600,
            ),
          ),
        ],
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: '${metadata.displayName} (g)',
          value: mass.inGrams.toStringAsFixed(3),
        ),
        HealthRecordDetailRow(
          label: '${metadata.displayName} (mg)',
          value: (mass.inGrams * 1000).toStringAsFixed(1),
        ),
        if (foodName != null && foodName.isNotEmpty)
          HealthRecordDetailRow(
            label: AppTexts.foodName,
            value: foodName,
          ),
        if (mealType != MealType.unknown)
          HealthRecordDetailRow(
            label: AppTexts.mealType,
            value: _getMealTypeDisplayName(mealType),
          ),
      ],
      onDelete: onDelete,
    );
  }

  Widget _buildIntervalRecord(
    BuildContext context,
    IntervalHealthRecord record,
  ) {
    return switch (record) {
      HeartRateSeriesRecord() => _buildSeriesRecord(context, record),
      SleepSessionRecord() => _buildSeriesRecord(context, record),
      StepRecord() => IntervalHealthRecordTile<StepRecord>(
        record: record,
        icon: AppIcons.directionsWalk,
        title: '${record.count.value.toInt()} ${AppTexts.stepsLabel}',
        subtitleBuilder: (r, ctx) {
          final duration = r.duration;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.startLabel} '
                '${DateFormatUtils.formatDateTime(r.startTime)}',
              ),
              Text(
                '${AppTexts.endLabel} '
                '${DateFormatUtils.formatDateTime(r.endTime)}',
              ),
              Text(
                '${AppTexts.duration} ${duration.inHours}h '
                '${duration.inMinutes.remainder(60)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          );
        },
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.count,
            value: r.count.value,
          ),
        ],
        onDelete: onDelete,
      ),
      DistanceRecord() => IntervalHealthRecordTile<DistanceRecord>(
        record: record,
        icon: AppIcons.straighten,
        title:
            '${record.distance.inMeters.toStringAsFixed(2)} m '
            '(${record.distance.inKilometers.toStringAsFixed(2)} km)',
        subtitleBuilder: (r, ctx) {
          final duration = r.duration;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.startLabel} '
                '${DateFormatUtils.formatDateTime(r.startTime)}',
              ),
              Text(
                '${AppTexts.endLabel} '
                '${DateFormatUtils.formatDateTime(r.endTime)}',
              ),
              Text(
                '${AppTexts.duration} ${duration.inHours}h '
                '${duration.inMinutes.remainder(60)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          );
        },
        detailRowsBuilder: (r, ctx) => [
          const HealthRecordDetailRow(
            label: AppTexts.value,
            value: '',
          ),
          MeasurementUnitDisplay(unit: r.distance),
        ],
        onDelete: onDelete,
      ),
      ActiveCaloriesBurnedRecord() =>
        IntervalHealthRecordTile<ActiveCaloriesBurnedRecord>(
          record: record,
          icon: AppIcons.localFireDepartment,
          title:
              '${record.energy.inKilocalories.toStringAsFixed(2)} kcal '
              '(${record.energy.inCalories.toStringAsFixed(0)} cal)',
          subtitleBuilder: (r, ctx) {
            final duration = r.duration;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${AppTexts.startLabel} '
                  '${DateFormatUtils.formatDateTime(r.startTime)}',
                ),
                Text(
                  '${AppTexts.endLabel} '
                  '${DateFormatUtils.formatDateTime(r.endTime)}',
                ),
                Text(
                  '${AppTexts.duration} ${duration.inHours}h '
                  '${duration.inMinutes.remainder(60)}m',
                  style: const TextStyle(
                    fontSize: 12,
                    color: theme.AppColors.grey600,
                  ),
                ),
              ],
            );
          },
          detailRowsBuilder: (r, ctx) => [
            const HealthRecordDetailRow(
              label: AppTexts.value,
              value: '',
            ),
            MeasurementUnitDisplay(unit: r.energy),
          ],
          onDelete: onDelete,
        ),
      FloorsClimbedRecord() => IntervalHealthRecordTile<FloorsClimbedRecord>(
        record: record,
        icon: AppIcons.stairs,
        title: '${record.floors.value.toInt()} ${AppTexts.floorsClimbedLabel}',
        subtitleBuilder: (r, ctx) {
          final duration = r.duration;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.startLabel} '
                '${DateFormatUtils.formatDateTime(r.startTime)}',
              ),
              Text(
                '${AppTexts.endLabel} '
                '${DateFormatUtils.formatDateTime(r.endTime)}',
              ),
              Text(
                '${AppTexts.duration} ${duration.inHours}h '
                '${duration.inMinutes.remainder(60)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          );
        },
        detailRowsBuilder: (r, ctx) => [
          HealthRecordDetailRow(
            label: AppTexts.count,
            value: r.floors.value.toString(),
          ),
        ],
        onDelete: onDelete,
      ),
      WheelchairPushesRecord() =>
        IntervalHealthRecordTile<WheelchairPushesRecord>(
          record: record,
          icon: AppIcons.accessible,
          title:
              '${record.pushes.value.toInt()} '
              '${AppTexts.wheelchairPushesLabel}',
          subtitleBuilder: (r, ctx) {
            final duration = r.duration;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${AppTexts.startLabel} '
                  '${DateFormatUtils.formatDateTime(r.startTime)}',
                ),
                Text(
                  '${AppTexts.endLabel} '
                  '${DateFormatUtils.formatDateTime(r.endTime)}',
                ),
                Text(
                  '${AppTexts.duration} ${duration.inHours}h '
                  '${duration.inMinutes.remainder(60)}m',
                  style: const TextStyle(
                    fontSize: 12,
                    color: theme.AppColors.grey600,
                  ),
                ),
              ],
            );
          },
          detailRowsBuilder: (r, ctx) => [
            HealthRecordDetailRow(
              label: AppTexts.count,
              value: r.pushes.value.toString(),
            ),
          ],
          onDelete: onDelete,
        ),
      HydrationRecord() => IntervalHealthRecordTile<HydrationRecord>(
        record: record,
        icon: AppIcons.volume,
        title:
            '${record.volume.inLiters.toStringAsFixed(2)} L '
            '(${record.volume.inMilliliters.toStringAsFixed(0)} mL)',
        subtitleBuilder: (r, ctx) {
          final duration = r.duration;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${AppTexts.startLabel} '
                '${DateFormatUtils.formatDateTime(r.startTime)}',
              ),
              Text(
                '${AppTexts.endLabel} '
                '${DateFormatUtils.formatDateTime(r.endTime)}',
              ),
              Text(
                '${AppTexts.duration} ${duration.inHours}h '
                '${duration.inMinutes.remainder(60)}m',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          );
        },
        detailRowsBuilder: (r, ctx) => [
          const HealthRecordDetailRow(
            label: AppTexts.value,
            value: '',
          ),
          MeasurementUnitDisplay(unit: r.volume),
        ],
        onDelete: onDelete,
      ),
      SleepStageRecord() => _buildSleepStageRecord(context, record),
      NutritionRecord() => _buildNutritionRecord(context, record, onDelete),
    };
  }

  Widget _buildNutritionRecord(
    BuildContext context,
    NutritionRecord record,
    VoidCallback onDelete,
  ) {
    final duration = record.duration;
    final nutrientFields = <String, String>{};

    if (record.energy != null) {
      nutrientFields[AppTexts.energy] =
          '${record.energy!.inKilocalories.toStringAsFixed(2)} kcal';
    }
    if (record.protein != null) {
      nutrientFields[AppTexts.protein] =
          '${record.protein!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.totalCarbohydrate != null) {
      nutrientFields[AppTexts.totalCarbohydrate] =
          '${record.totalCarbohydrate!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.totalFat != null) {
      nutrientFields[AppTexts.totalFat] =
          '${record.totalFat!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.saturatedFat != null) {
      nutrientFields[AppTexts.saturatedFat] =
          '${record.saturatedFat!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.monounsaturatedFat != null) {
      nutrientFields[AppTexts.monounsaturatedFat] =
          '${record.monounsaturatedFat!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.polyunsaturatedFat != null) {
      nutrientFields[AppTexts.polyunsaturatedFat] =
          '${record.polyunsaturatedFat!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.cholesterol != null) {
      nutrientFields[AppTexts.cholesterol] =
          '${record.cholesterol!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.dietaryFiber != null) {
      nutrientFields[AppTexts.dietaryFiber] =
          '${record.dietaryFiber!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.sugar != null) {
      nutrientFields[AppTexts.sugar] =
          '${record.sugar!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.vitaminA != null) {
      nutrientFields[AppTexts.vitaminA] =
          '${record.vitaminA!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.vitaminB6 != null) {
      nutrientFields[AppTexts.vitaminB6] =
          '${record.vitaminB6!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.vitaminB12 != null) {
      nutrientFields[AppTexts.vitaminB12] =
          '${record.vitaminB12!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.vitaminC != null) {
      nutrientFields[AppTexts.vitaminC] =
          '${record.vitaminC!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.vitaminD != null) {
      nutrientFields[AppTexts.vitaminD] =
          '${record.vitaminD!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.vitaminE != null) {
      nutrientFields[AppTexts.vitaminE] =
          '${record.vitaminE!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.vitaminK != null) {
      nutrientFields[AppTexts.vitaminK] =
          '${record.vitaminK!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.thiamin != null) {
      nutrientFields[AppTexts.thiamin] =
          '${record.thiamin!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.riboflavin != null) {
      nutrientFields[AppTexts.riboflavin] =
          '${record.riboflavin!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.niacin != null) {
      nutrientFields[AppTexts.niacin] =
          '${record.niacin!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.folate != null) {
      nutrientFields[AppTexts.folate] =
          '${record.folate!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.biotin != null) {
      nutrientFields[AppTexts.biotin] =
          '${record.biotin!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.pantothenicAcid != null) {
      nutrientFields[AppTexts.pantothenicAcid] =
          '${record.pantothenicAcid!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.calcium != null) {
      nutrientFields[AppTexts.calcium] =
          '${record.calcium!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.iron != null) {
      nutrientFields[AppTexts.iron] =
          '${record.iron!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.magnesium != null) {
      nutrientFields[AppTexts.magnesium] =
          '${record.magnesium!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.manganese != null) {
      nutrientFields[AppTexts.manganese] =
          '${record.manganese!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.phosphorus != null) {
      nutrientFields[AppTexts.phosphorus] =
          '${record.phosphorus!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.potassium != null) {
      nutrientFields[AppTexts.potassium] =
          '${record.potassium!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.selenium != null) {
      nutrientFields[AppTexts.selenium] =
          '${record.selenium!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.sodium != null) {
      nutrientFields[AppTexts.sodium] =
          '${record.sodium!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.zinc != null) {
      nutrientFields[AppTexts.zinc] =
          '${record.zinc!.inGrams.toStringAsFixed(3)} g';
    }
    if (record.caffeine != null) {
      nutrientFields[AppTexts.caffeine] =
          '${record.caffeine!.inGrams.toStringAsFixed(3)} g';
    }

    final title = nutrientFields.isEmpty
        ? AppTexts.nutritionRecord
        : '${nutrientFields.length} ${AppTexts.nutrients}';

    return IntervalHealthRecordTile<NutritionRecord>(
      record: record,
      icon: AppIcons.fastfood,
      title: title,
      subtitleBuilder: (r, ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.startLabel} '
              '${DateFormatUtils.formatDateTime(r.startTime)}',
            ),
            Text(
              '${AppTexts.endLabel} '
              '${DateFormatUtils.formatDateTime(r.endTime)}',
            ),
            Text(
              '${AppTexts.duration} ${duration.inHours}h '
              '${duration.inMinutes.remainder(60)}m',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
            if (r.foodName != null && r.foodName!.isNotEmpty)
              Text(
                '${AppTexts.food}: ${r.foodName}',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            if (r.mealType != MealType.unknown)
              Text(
                '${AppTexts.meal}: ${_getMealTypeDisplayName(r.mealType)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
          ],
        );
      },
      detailRowsBuilder: (r, ctx) {
        final rows = <Widget>[
          HealthRecordDetailRow(
            label: AppTexts.duration,
            value: '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
          ),
        ];
        if (r.foodName != null && r.foodName!.isNotEmpty) {
          rows.add(
            HealthRecordDetailRow(
              label: AppTexts.foodName,
              value: r.foodName,
            ),
          );
        }
        if (r.mealType != MealType.unknown) {
          rows.add(
            HealthRecordDetailRow(
              label: AppTexts.mealType,
              value: _getMealTypeDisplayName(r.mealType),
            ),
          );
        }
        for (final entry in nutrientFields.entries) {
          rows.add(
            HealthRecordDetailRow(
              label: entry.key,
              value: entry.value,
            ),
          );
        }
        return rows;
      },
      onDelete: onDelete,
    );
  }

  Widget _buildSeriesRecord(
    BuildContext context,
    SeriesHealthRecord<dynamic> record,
  ) {
    return switch (record) {
      HeartRateSeriesRecord() => _buildHeartRateSeriesRecord(
        context,
        record,
      ),
      SleepSessionRecord() => _buildSleepSessionRecord(
        context,
        record,
      ),
    };
  }

  /// Maps a [SleepStageType] to its display string.
  static String _getStageTypeDisplayName(SleepStageType type) {
    return switch (type) {
      SleepStageType.unknown => AppTexts.sleepStageUnknown,
      SleepStageType.awake => AppTexts.sleepStageAwake,
      SleepStageType.sleeping => AppTexts.sleepStageSleeping,
      SleepStageType.outOfBed => AppTexts.sleepStageOutOfBed,
      SleepStageType.light => AppTexts.sleepStageLight,
      SleepStageType.deep => AppTexts.sleepStageDeep,
      SleepStageType.rem => AppTexts.sleepStageRem,
      SleepStageType.inBed => AppTexts.sleepStageInBed,
    };
  }

  /// Maps a [MealType] to its display string.
  static String _getMealTypeDisplayName(MealType type) {
    return switch (type) {
      MealType.unknown => AppTexts.mealTypeUnknown,
      MealType.breakfast => AppTexts.mealTypeBreakfast,
      MealType.lunch => AppTexts.mealTypeLunch,
      MealType.dinner => AppTexts.mealTypeDinner,
      MealType.snack => AppTexts.mealTypeSnack,
    };
  }

  Widget _buildSleepStageRecord(
    BuildContext context,
    SleepStageRecord record,
  ) {
    final duration = record.duration;
    final stageTypeName = _getStageTypeDisplayName(record.stageType);
    return IntervalHealthRecordTile<SleepStageRecord>(
      record: record,
      icon: AppIcons.bedtime,
      title: '$stageTypeName (${duration.inMinutes}m)',
      subtitleBuilder: (r, ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.startLabel} '
              '${DateFormatUtils.formatDateTime(r.startTime)}',
            ),
            Text(
              '${AppTexts.endLabel} '
              '${DateFormatUtils.formatDateTime(r.endTime)}',
            ),
            Text(
              '${AppTexts.duration} ${duration.inHours}h '
              '${duration.inMinutes.remainder(60)}m',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        );
      },
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.stageType,
          value: _getStageTypeDisplayName(r.stageType),
        ),
        HealthRecordDetailRow(
          label: AppTexts.duration,
          value: '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
        ),
      ],
      onDelete: onDelete,
    );
  }

  Widget _buildSleepSessionRecord(
    BuildContext context,
    SleepSessionRecord record,
  ) {
    final totalSleepDuration = record.totalSleepDuration;
    final duration = record.duration;
    return SeriesHealthRecordTile<SleepSessionRecord, SleepStage>(
      record: record,
      icon: AppIcons.bedtime,
      title:
          '${totalSleepDuration.inHours}h '
          '${totalSleepDuration.inMinutes.remainder(60)}m '
          '${AppTexts.sleepStage.toLowerCase()}',
      subtitleBuilder: (r, ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.startLabel} '
              '${DateFormatUtils.formatDateTime(r.startTime)}',
            ),
            Text(
              '${AppTexts.endLabel} '
              '${DateFormatUtils.formatDateTime(r.endTime)}',
            ),
            Text(
              '${AppTexts.duration} ${duration.inHours}h '
              '${duration.inMinutes.remainder(60)}m',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
          ],
        );
      },
      samplesBuilder: (stages, ctx) => SleepStagesList(stages: stages),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.duration,
          value: '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
        ),
        HealthRecordDetailRow(
          label: 'Total Sleep Duration',
          value:
              '${totalSleepDuration.inHours}h '
              '${totalSleepDuration.inMinutes.remainder(60)}m',
        ),
        HealthRecordDetailRow(
          label: 'Number of Stages',
          value: r.samples.length.toString(),
        ),
      ],
      onDelete: onDelete,
    );
  }

  Widget _buildHeartRateSeriesRecord(
    BuildContext context,
    HeartRateSeriesRecord record,
  ) {
    return SeriesHealthRecordTile<HeartRateSeriesRecord, HeartRateMeasurement>(
      record: record,
      icon: AppIcons.favorite,
      title:
          '${record.averageBpm.value.toInt()} ${AppTexts.heartRateLabel} '
          '(${record.samplesCount} ${AppTexts.heartRateSamples.toLowerCase()})',
      subtitleBuilder: (r, ctx) {
        final duration = r.duration;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppTexts.startLabel} '
              '${DateFormatUtils.formatDateTime(r.startTime)}',
            ),
            Text(
              '${AppTexts.endLabel} '
              '${DateFormatUtils.formatDateTime(r.endTime)}',
            ),
            Text(
              '${AppTexts.duration} ${duration.inHours}h '
              '${duration.inMinutes.remainder(60)}m',
              style: const TextStyle(
                fontSize: 12,
                color: theme.AppColors.grey600,
              ),
            ),
            if (r.samples.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                '${AppTexts.averageBpm}: ${r.averageBpm.value.toInt()}, '
                '${AppTexts.minBpm}: ${r.minBpm.value.toInt()}, '
                '${AppTexts.maxBpm}: ${r.maxBpm.value.toInt()}',
                style: const TextStyle(
                  fontSize: 12,
                  color: theme.AppColors.grey600,
                ),
              ),
            ],
          ],
        );
      },
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.averageBpm,
          value: r.averageBpm.value.toInt().toString(),
        ),
        HealthRecordDetailRow(
          label: AppTexts.minBpm,
          value: r.minBpm.value.toInt().toString(),
        ),
        HealthRecordDetailRow(
          label: AppTexts.maxBpm,
          value: r.maxBpm.value.toInt().toString(),
        ),
      ],
      samplesBuilder: (samples, ctx) => HeartRateSamplesList(
        samples: samples,
      ),
      onDelete: onDelete,
    );
  }

  Widget _buildBloodPressureRecord(
    BloodPressureRecord record,
    VoidCallback onDelete,
  ) {
    return InstantHealthRecordTile<BloodPressureRecord>(
      record: record,
      icon: AppIcons.bloodPressure,
      title:
          '${record.systolic.inMillimetersOfMercury.toStringAsFixed(0)}/'
          '${record.diastolic.inMillimetersOfMercury.toStringAsFixed(0)} mmHg',
      subtitleBuilder: (r, ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
          ),
          Text(
            '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
            style: const TextStyle(
              fontSize: 12,
              color: theme.AppColors.grey600,
            ),
          ),
        ],
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.systolic,
          value: '${r.systolic.inMillimetersOfMercury.toStringAsFixed(0)} mmHg',
        ),
        HealthRecordDetailRow(
          label: AppTexts.diastolic,
          value:
              '${r.diastolic.inMillimetersOfMercury.toStringAsFixed(0)} mmHg',
        ),
        if (r.bodyPosition != BloodPressureBodyPosition.unknown)
          HealthRecordDetailRow(
            label: AppTexts.bodyPosition,
            value: _getBodyPositionDisplayName(r.bodyPosition),
          ),
        if (r.measurementLocation != BloodPressureMeasurementLocation.unknown)
          HealthRecordDetailRow(
            label: AppTexts.measurementLocation,
            value: _getMeasurementLocationDisplayName(r.measurementLocation),
          ),
      ],
      onDelete: onDelete,
    );
  }

  Widget _buildSystolicBloodPressureRecord(
    SystolicBloodPressureRecord record,
    VoidCallback onDelete,
  ) {
    return InstantHealthRecordTile<SystolicBloodPressureRecord>(
      record: record,
      icon: AppIcons.bloodPressure,
      title:
          '${record.pressure.inMillimetersOfMercury.toStringAsFixed(0)} mmHg '
          '(${AppTexts.systolic})',
      subtitleBuilder: (r, ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
          ),
          Text(
            '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
            style: const TextStyle(
              fontSize: 12,
              color: theme.AppColors.grey600,
            ),
          ),
        ],
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.value,
          value: '${r.pressure.inMillimetersOfMercury.toStringAsFixed(0)} mmHg',
        ),
      ],
      onDelete: onDelete,
    );
  }

  Widget _buildDiastolicBloodPressureRecord(
    DiastolicBloodPressureRecord record,
    VoidCallback onDelete,
  ) {
    return InstantHealthRecordTile<DiastolicBloodPressureRecord>(
      record: record,
      icon: AppIcons.bloodPressure,
      title:
          '${record.pressure.inMillimetersOfMercury.toStringAsFixed(0)} mmHg '
          '(${AppTexts.diastolic})',
      subtitleBuilder: (r, ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '${AppTexts.time}: ${DateFormatUtils.formatDateTime(r.time)}',
          ),
          Text(
            '${AppTexts.recording}: ${r.metadata.recordingMethod.name}',
            style: const TextStyle(
              fontSize: 12,
              color: theme.AppColors.grey600,
            ),
          ),
        ],
      ),
      detailRowsBuilder: (r, ctx) => [
        HealthRecordDetailRow(
          label: AppTexts.value,
          value: '${r.pressure.inMillimetersOfMercury.toStringAsFixed(0)} mmHg',
        ),
      ],
      onDelete: onDelete,
    );
  }

  static String _getBodyPositionDisplayName(
    BloodPressureBodyPosition position,
  ) {
    return switch (position) {
      BloodPressureBodyPosition.unknown => 'Unknown',
      BloodPressureBodyPosition.sittingDown => AppTexts.bodyPositionSittingDown,
      BloodPressureBodyPosition.standingUp => AppTexts.bodyPositionStandingUp,
      BloodPressureBodyPosition.lyingDown => AppTexts.bodyPositionLyingDown,
      BloodPressureBodyPosition.reclining => AppTexts.bodyPositionReclining,
    };
  }

  static String _getMeasurementLocationDisplayName(
    BloodPressureMeasurementLocation location,
  ) {
    return switch (location) {
      BloodPressureMeasurementLocation.unknown => 'Unknown',
      BloodPressureMeasurementLocation.leftWrist =>
        AppTexts.measurementLocationLeftWrist,
      BloodPressureMeasurementLocation.rightWrist =>
        AppTexts.measurementLocationRightWrist,
      BloodPressureMeasurementLocation.leftUpperArm =>
        AppTexts.measurementLocationLeftUpperArm,
      BloodPressureMeasurementLocation.rightUpperArm =>
        AppTexts.measurementLocationRightUpperArm,
    };
  }
}
