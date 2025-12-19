import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        AggregateRequest,
        AggregateResponse,
        AggregationMetric,
        BodyFatPercentageHealthDataType,
        BloodGlucoseHealthDataType,
        BloodPressureHealthDataType,
        RespiratoryRateHealthDataType,
        BodyTemperatureHealthDataType,
        DiastolicBloodPressureHealthDataType,
        DistanceHealthDataType,
        FloorsClimbedHealthDataType,
        HealthConnectorErrorCode,
        HealthConnectorException,
        HealthDataType,
        HealthRecord,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        LeanBodyMassHealthDataType,
        MeasurementUnit,
        Pressure,
        RestingHeartRateHealthDataType,
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        NutritionHealthDataType,
        EnergyNutrientDataType,
        CaffeineNutrientDataType,
        ProteinNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        SaturatedFatNutrientDataType,
        MonounsaturatedFatNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        SugarNutrientDataType,
        CalciumNutrientDataType,
        IronNutrientDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        PhosphorusNutrientDataType,
        SystolicBloodPressureHealthDataType,
        OxygenSaturationHealthDataType,
        PotassiumNutrientDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        ZincNutrientDataType,
        VitaminANutrientDataType,
        VitaminB6NutrientDataType,
        VitaminB12NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        ThiaminNutrientDataType,
        RiboflavinNutrientDataType,
        NiacinNutrientDataType,
        FolateNutrientDataType,
        BiotinNutrientDataType,
        PantothenicAcidNutrientDataType,
        Vo2MaxHealthDataType,
        HealthPlatform;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/pages/date_time_range_page_state.dart';
import 'package:health_connector_toolbox/src/common/utils/health_connector_model_ui_extensions.dart';
import 'package:health_connector_toolbox/src/common/utils/show_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/date_time_range_picker_rows.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/aggregate_health_data_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/widgets/aggregate_result_card.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_data_type_dropdown_field.dart';
import 'package:provider/provider.dart' show Provider, Selector;

/// Page for aggregating health data over a time range.
///
/// Allows users to select a health data type, aggregation metric (sum, average,
/// min, max, count), and time range. Displays the aggregation result in a card.
@immutable
final class AggregateHealthDataPage extends StatefulWidget {
  const AggregateHealthDataPage({required this.healthPlatform, super.key});

  final HealthPlatform healthPlatform;

  @override
  State<AggregateHealthDataPage> createState() =>
      _AggregateHealthDataPageState();
}

class _AggregateHealthDataPageState
    extends DateTimeRangePageState<AggregateHealthDataPage> {
  final _formKey = GlobalKey<FormState>();
  HealthDataType<HealthRecord, MeasurementUnit>? _selectedDataType;
  AggregationMetric? _selectedMetric;
  HealthDataType<HealthRecord, Pressure>? _selectedBloodPressureSubtype;

  /// Builds an aggregation request for nutrient data types.
  ///
  /// All nutrient data types only support sum aggregation.
  AggregateRequest _buildNutrientAggregationRequest(
    HealthDataType<HealthRecord, MeasurementUnit> nutrientType,
    AggregationMetric metric,
    DateTime startTime,
    DateTime endTime,
  ) {
    if (metric != AggregationMetric.sum) {
      throw UnsupportedError('Unsupported metric: $metric');
    }

    // Use pattern matching to call the appropriate aggregateSum method
    return switch (nutrientType) {
      EnergyNutrientDataType() => HealthDataType.energyNutrient.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      CaffeineNutrientDataType() => HealthDataType.caffeine.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      ProteinNutrientDataType() => HealthDataType.protein.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      TotalCarbohydrateNutrientDataType() =>
        HealthDataType.totalCarbohydrate.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      TotalFatNutrientDataType() => HealthDataType.totalFat.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      SaturatedFatNutrientDataType() =>
        HealthDataType.saturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      MonounsaturatedFatNutrientDataType() =>
        HealthDataType.monounsaturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      PolyunsaturatedFatNutrientDataType() =>
        HealthDataType.polyunsaturatedFat.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      CholesterolNutrientDataType() => HealthDataType.cholesterol.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      DietaryFiberNutrientDataType() =>
        HealthDataType.dietaryFiber.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      SugarNutrientDataType() => HealthDataType.sugar.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      CalciumNutrientDataType() => HealthDataType.calcium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      IronNutrientDataType() => HealthDataType.iron.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      MagnesiumNutrientDataType() => HealthDataType.magnesium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      ManganeseNutrientDataType() => HealthDataType.manganese.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      PhosphorusNutrientDataType() => HealthDataType.phosphorus.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      PotassiumNutrientDataType() => HealthDataType.potassium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      SeleniumNutrientDataType() => HealthDataType.selenium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      SodiumNutrientDataType() => HealthDataType.sodium.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      ZincNutrientDataType() => HealthDataType.zinc.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminANutrientDataType() => HealthDataType.vitaminA.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminB6NutrientDataType() => HealthDataType.vitaminB6.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminB12NutrientDataType() => HealthDataType.vitaminB12.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminCNutrientDataType() => HealthDataType.vitaminC.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminDNutrientDataType() => HealthDataType.vitaminD.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminENutrientDataType() => HealthDataType.vitaminE.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      VitaminKNutrientDataType() => HealthDataType.vitaminK.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      ThiaminNutrientDataType() => HealthDataType.thiamin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      RiboflavinNutrientDataType() => HealthDataType.riboflavin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      NiacinNutrientDataType() => HealthDataType.niacin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      FolateNutrientDataType() => HealthDataType.folate.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      BiotinNutrientDataType() => HealthDataType.biotin.aggregateSum(
        startTime: startTime,
        endTime: endTime,
      ),
      PantothenicAcidNutrientDataType() =>
        HealthDataType.pantothenicAcid.aggregateSum(
          startTime: startTime,
          endTime: endTime,
        ),
      _ => throw ArgumentError(
        'Unsupported nutrient data type: ${nutrientType.runtimeType}',
      ),
    };
  }

  Future<void> _aggregate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate blood pressure subtype is selected when
    // BloodPressureHealthDataType is selected
    if (_selectedDataType is BloodPressureHealthDataType &&
        _selectedBloodPressureSubtype == null) {
      if (!mounted) {
        return;
      }
      showAppSnackBar(
        context,
        SnackBarType.error,
        'Please select a blood pressure type',
      );
      return;
    }

    final notifier = Provider.of<AggregateHealthDataChangeNotifier>(
      context,
      listen: false,
    );

    try {
      final request = switch (_selectedDataType!) {
        StepsHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.sum => HealthDataType.steps.aggregateSum(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.avg ||
          AggregationMetric.min ||
          AggregationMetric.max => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        WeightHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg => HealthDataType.weight.aggregateAvg(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.min => HealthDataType.weight.aggregateMin(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.max => HealthDataType.weight.aggregateMax(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        HeightHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg => HealthDataType.height.aggregateAvg(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.min => HealthDataType.height.aggregateMin(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.max => HealthDataType.height.aggregateMax(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        BodyFatPercentageHealthDataType() => throw UnsupportedError(
          'Body fat percentage does not support aggregation',
        ),
        BloodPressureHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg =>
            HealthDataType.bloodPressure.aggregateAverage(
              bloodPressureType: _selectedBloodPressureSubtype!,
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.min => HealthDataType.bloodPressure.aggregateMin(
            bloodPressureType: _selectedBloodPressureSubtype!,
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.max => HealthDataType.bloodPressure.aggregateMax(
            bloodPressureType: _selectedBloodPressureSubtype!,
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        SystolicBloodPressureHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg =>
            HealthDataType.systolicBloodPressure.aggregateAvg(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.min =>
            HealthDataType.systolicBloodPressure.aggregateMin(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.max =>
            HealthDataType.systolicBloodPressure.aggregateMax(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        DiastolicBloodPressureHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg =>
            HealthDataType.diastolicBloodPressure.aggregateAvg(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.min =>
            HealthDataType.diastolicBloodPressure.aggregateMin(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.max =>
            HealthDataType.diastolicBloodPressure.aggregateMax(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        BodyTemperatureHealthDataType() => throw UnsupportedError(
          'Body temperature does not support aggregation',
        ),
        LeanBodyMassHealthDataType() => throw UnsupportedError(
          'Lean body mass does not support aggregation',
        ),
        DistanceHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.sum => HealthDataType.distance.aggregateSum(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.avg ||
          AggregationMetric.min ||
          AggregationMetric.max => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        ActiveCaloriesBurnedHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.sum =>
            HealthDataType.activeCaloriesBurned.aggregateSum(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.avg ||
          AggregationMetric.min ||
          AggregationMetric.max => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        FloorsClimbedHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.sum => HealthDataType.floorsClimbed.aggregateSum(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.avg ||
          AggregationMetric.min ||
          AggregationMetric.max => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        WheelchairPushesHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.sum => HealthDataType.wheelchairPushes.aggregateSum(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.avg ||
          AggregationMetric.min ||
          AggregationMetric.max => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        HydrationHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.sum => HealthDataType.hydration.aggregateSum(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.avg ||
          AggregationMetric.min ||
          AggregationMetric.max => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        HeartRateMeasurementRecordHealthDataType() =>
          switch (_selectedMetric!) {
            AggregationMetric.avg =>
              HealthDataType.heartRateMeasurementRecord.aggregateAvg(
                startTime: startDateTime!,
                endTime: endDateTime!,
              ),
            AggregationMetric.min =>
              HealthDataType.heartRateMeasurementRecord.aggregateMin(
                startTime: startDateTime!,
                endTime: endDateTime!,
              ),
            AggregationMetric.max =>
              HealthDataType.heartRateMeasurementRecord.aggregateMax(
                startTime: startDateTime!,
                endTime: endDateTime!,
              ),
            AggregationMetric.sum => throw UnsupportedError(
              'Unsupported metric: $_selectedMetric',
            ),
          },
        HeartRateSeriesRecordHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg =>
            HealthDataType.heartRateSeriesRecord.aggregateAvg(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.min =>
            HealthDataType.heartRateSeriesRecord.aggregateMin(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.max =>
            HealthDataType.heartRateSeriesRecord.aggregateMax(
              startTime: startDateTime!,
              endTime: endDateTime!,
            ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        RestingHeartRateHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg => HealthDataType.restingHeartRate.aggregateAvg(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.min => HealthDataType.restingHeartRate.aggregateMin(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.max => HealthDataType.restingHeartRate.aggregateMax(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        SleepSessionHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.sum => HealthDataType.sleepSession.aggregateSum(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.avg ||
          AggregationMetric.min ||
          AggregationMetric.max => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        SleepStageHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.sum => HealthDataType.sleepStageRecord.aggregateSum(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.avg ||
          AggregationMetric.min ||
          AggregationMetric.max => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        NutritionHealthDataType() => throw UnsupportedError(
          'Nutrition does not support aggregation',
        ),
        OxygenSaturationHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg => HealthDataType.oxygenSaturation.aggregateAvg(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.min => HealthDataType.oxygenSaturation.aggregateMin(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.max => HealthDataType.oxygenSaturation.aggregateMax(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        RespiratoryRateHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg => HealthDataType.respiratoryRate.aggregateAvg(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.min => HealthDataType.respiratoryRate.aggregateMin(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.max => HealthDataType.respiratoryRate.aggregateMax(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        Vo2MaxHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg => HealthDataType.vo2Max.aggregateAvg(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.min => HealthDataType.vo2Max.aggregateMin(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.max => HealthDataType.vo2Max.aggregateMax(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },
        BloodGlucoseHealthDataType() => switch (_selectedMetric!) {
          AggregationMetric.avg => HealthDataType.bloodGlucose.aggregateAvg(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.min => HealthDataType.bloodGlucose.aggregateMin(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.max => HealthDataType.bloodGlucose.aggregateMax(
            startTime: startDateTime!,
            endTime: endDateTime!,
          ),
          AggregationMetric.sum => throw UnsupportedError(
            'Unsupported metric: $_selectedMetric',
          ),
        },

        // All nutrient data types follow the same pattern: only sum aggregation
        EnergyNutrientDataType() ||
        CaffeineNutrientDataType() ||
        ProteinNutrientDataType() ||
        TotalCarbohydrateNutrientDataType() ||
        TotalFatNutrientDataType() ||
        SaturatedFatNutrientDataType() ||
        MonounsaturatedFatNutrientDataType() ||
        PolyunsaturatedFatNutrientDataType() ||
        CholesterolNutrientDataType() ||
        DietaryFiberNutrientDataType() ||
        SugarNutrientDataType() ||
        CalciumNutrientDataType() ||
        IronNutrientDataType() ||
        MagnesiumNutrientDataType() ||
        ManganeseNutrientDataType() ||
        PhosphorusNutrientDataType() ||
        PotassiumNutrientDataType() ||
        SeleniumNutrientDataType() ||
        SodiumNutrientDataType() ||
        ZincNutrientDataType() ||
        VitaminANutrientDataType() ||
        VitaminB6NutrientDataType() ||
        VitaminB12NutrientDataType() ||
        VitaminCNutrientDataType() ||
        VitaminDNutrientDataType() ||
        VitaminENutrientDataType() ||
        VitaminKNutrientDataType() ||
        ThiaminNutrientDataType() ||
        RiboflavinNutrientDataType() ||
        NiacinNutrientDataType() ||
        FolateNutrientDataType() ||
        BiotinNutrientDataType() ||
        PantothenicAcidNutrientDataType() => _buildNutrientAggregationRequest(
          _selectedDataType!,
          _selectedMetric!,
          startDateTime!,
          endDateTime!,
        ),
      };

      await notifier.aggregateHealthData(request);
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }

      final message = e.code == HealthConnectorErrorCode.unsupportedOperation
          ? AppTexts.readPermissionDenied
          : e.message;
      showAppSnackBar(context, SnackBarType.error, message);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.error,
        '${AppTexts.errorPrefixColon} $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AggregateHealthDataChangeNotifier, bool>(
      selector: (_, notifier) => notifier.isLoading,
      builder: (context, isLoading, _) {
        return LoadingOverlay(
          isLoading: isLoading,
          message: AppTexts.aggregate,
          child: Scaffold(
            appBar: AppBar(title: const Text(AppTexts.readAggregateData)),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Only show data types that support aggregation metrics
                    HealthDataTypeDropdownField(
                      initialValue: _selectedDataType,
                      onChanged: (value) {
                        setState(() {
                          _selectedDataType = value;
                          // Reset blood pressure subtype when data type changes
                          _selectedBloodPressureSubtype = null;

                          // Use subtype's supported metrics if
                          // BloodPressureHealthDataType is selected,
                          // otherwise use the selected data type's metrics
                          if (value is BloodPressureHealthDataType) {
                            // For BloodPressureHealthDataType, we'll use
                            // the subtype's metrics but we need to wait for
                            // subtype selection, so set to null for now
                            _selectedMetric = null;
                          } else {
                            _selectedMetric =
                                value?.supportedAggregationMetrics.first;
                          }
                          final notifier =
                              Provider.of<AggregateHealthDataChangeNotifier>(
                                context,
                                listen: false,
                              );
                          notifier.clearResults();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return AppTexts.pleaseSelectDataType;
                        }
                        return null;
                      },
                      // Filter to only display data types with non-empty
                      // supported aggregation metrics and
                      // supported on the current platform
                      itemsFilter: (type) =>
                          type.supportedHealthPlatforms.contains(
                            widget.healthPlatform,
                          ) &&
                          type.supportedAggregationMetrics.isNotEmpty,
                    ),
                    if (_selectedDataType is BloodPressureHealthDataType) ...[
                      const SizedBox(height: 16),
                      DropdownButtonFormField<
                        HealthDataType<HealthRecord, Pressure>
                      >(
                        initialValue: _selectedBloodPressureSubtype,
                        decoration: const InputDecoration(
                          labelText: 'Blood Pressure Type',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(AppIcons.bloodPressure),
                        ),
                        items: [
                          DropdownMenuItem<
                            HealthDataType<HealthRecord, Pressure>
                          >(
                            value: HealthDataType.systolicBloodPressure,
                            child: Text(
                              HealthDataType.systolicBloodPressure.displayName,
                            ),
                          ),
                          DropdownMenuItem<
                            HealthDataType<HealthRecord, Pressure>
                          >(
                            value: HealthDataType.diastolicBloodPressure,
                            child: Text(
                              HealthDataType.diastolicBloodPressure.displayName,
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedBloodPressureSubtype = value;
                            _selectedMetric =
                                value?.supportedAggregationMetrics.first;
                            final notifier =
                                Provider.of<AggregateHealthDataChangeNotifier>(
                                  context,
                                  listen: false,
                                );
                            notifier.clearResults();
                          });
                        },
                        validator: (value) {
                          if (_selectedDataType
                                  is BloodPressureHealthDataType &&
                              value == null) {
                            return 'Please select a blood pressure type';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 16),
                    DropdownButtonFormField<AggregationMetric>(
                      initialValue: _selectedMetric,
                      decoration: const InputDecoration(
                        labelText: AppTexts.aggregationMetric,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(AppIcons.calculate),
                      ),
                      items:
                          (_selectedDataType is BloodPressureHealthDataType
                                  ? _selectedBloodPressureSubtype
                                        ?.supportedAggregationMetrics
                                  : _selectedDataType
                                        ?.supportedAggregationMetrics)
                              ?.map(
                                (metric) {
                                  return DropdownMenuItem(
                                    value: metric,
                                    child: Text(metric.displayName),
                                  );
                                },
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMetric = value ?? AggregationMetric.sum;
                          final notifier =
                              Provider.of<AggregateHealthDataChangeNotifier>(
                                context,
                                listen: false,
                              );
                          notifier.clearResults();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return AppTexts.pleaseSelectMetric;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DateTimeRangePickerRows(
                      startDate: startDate,
                      startTime: startTime,
                      endDate: endDate,
                      endTime: endTime,
                      onStartDateChanged: setStartDate,
                      onStartTimeChanged: setStartTime,
                      onEndDateChanged: setEndDate,
                      onEndTimeChanged: setEndTime,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: isLoading ? null : _aggregate,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text(AppTexts.aggregate),
                    ),
                    Selector<
                      AggregateHealthDataChangeNotifier,
                      AggregateResponse?
                    >(
                      selector: (_, notifier) => notifier.aggregateResponse,
                      builder: (context, aggregateResponse, _) {
                        if (aggregateResponse != null &&
                            _selectedMetric != null) {
                          return AggregateResultCard(
                            metric: _selectedMetric!.displayName,
                            value: aggregateResponse.value,
                            startDateTime: startDateTime,
                            endDateTime: endDateTime,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
