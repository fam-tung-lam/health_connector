import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BiotinNutrientDataType,
        BloodPressureHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        CaffeineNutrientDataType,
        CalciumNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        DiastolicBloodPressureHealthDataType,
        DistanceHealthDataType,
        EnergyNutrientDataType,
        FloorsClimbedHealthDataType,
        FolateNutrientDataType,
        HealthConnectorErrorCode,
        HealthConnectorException,
        HealthDataType,
        HealthRecord,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        IronNutrientDataType,
        LeanBodyMassHealthDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        MeasurementUnit,
        MonounsaturatedFatNutrientDataType,
        NiacinNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        NutritionHealthDataType,
        PantothenicAcidNutrientDataType,
        OxygenSaturationHealthDataType,
        PhosphorusNutrientDataType,
        PotassiumNutrientDataType,
        ProteinNutrientDataType,
        RiboflavinNutrientDataType,
        RespiratoryRateHealthDataType,
        SaturatedFatNutrientDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        StepsHealthDataType,
        SugarNutrientDataType,
        SystolicBloodPressureHealthDataType,
        ThiaminNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        VitaminANutrientDataType,
        VitaminB12NutrientDataType,
        VitaminB6NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        ZincNutrientDataType,
        SleepSessionHealthDataType,
        RestingHeartRateHealthDataType,
        SleepStageHealthDataType,
        Vo2MaxHealthDataType;
import 'package:health_connector/health_connector.dart' show HealthPlatform;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/pages/date_time_range_page_state.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart'
    as theme;
import 'package:health_connector_toolbox/src/common/utils/show_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/date_time_range_picker_rows.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/read_health_records_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_data_type_dropdown_field.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tile.dart';
import 'package:provider/provider.dart' show Provider, Selector;

/// Page for reading and displaying health records.
///
/// Allows users to select a health data type, specify a time range, set page
/// size, and read health records. Supports pagination and deletion of records.
@immutable
final class ReadHealthRecordsPage extends StatefulWidget {
  const ReadHealthRecordsPage({required this.healthPlatform, super.key});

  final HealthPlatform healthPlatform;

  @override
  State<ReadHealthRecordsPage> createState() => _ReadHealthRecordsPageState();
}

class _ReadHealthRecordsPageState
    extends DateTimeRangePageState<ReadHealthRecordsPage> {
  final _formKey = GlobalKey<FormState>();
  final _pageSizeController = TextEditingController();
  HealthDataType<HealthRecord, MeasurementUnit>? _selectedDataType;
  int _pageSize = 100;

  @override
  void initState() {
    super.initState();
    _pageSizeController.text = _pageSize.toString();
    _pageSizeController.addListener(_onPageSizeChanged);
  }

  void _onPageSizeChanged() {
    final pageSize = int.tryParse(_pageSizeController.text) ?? _pageSize;
    setState(() {
      _pageSize = pageSize;
    });
  }

  @override
  void dispose() {
    _pageSizeController.dispose();
    super.dispose();
  }

  Future<void> _readRecords() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final notifier = Provider.of<ReadHealthRecordsChangeNotifier>(
      context,
      listen: false,
    );

    try {
      final request = switch (_selectedDataType!) {
        StepsHealthDataType() => HealthDataType.steps.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        WeightHealthDataType() => HealthDataType.weight.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        HeightHealthDataType() => HealthDataType.height.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        BodyFatPercentageHealthDataType() =>
          HealthDataType.bodyFatPercentage.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        BodyTemperatureHealthDataType() =>
          HealthDataType.bodyTemperature.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        LeanBodyMassHealthDataType() => HealthDataType.leanBodyMass.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        DistanceHealthDataType() => HealthDataType.distance.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        ActiveCaloriesBurnedHealthDataType() =>
          HealthDataType.activeCaloriesBurned.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        FloorsClimbedHealthDataType() =>
          HealthDataType.floorsClimbed.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        WheelchairPushesHealthDataType() =>
          HealthDataType.wheelchairPushes.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        HydrationHealthDataType() => HealthDataType.hydration.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        HeartRateMeasurementRecordHealthDataType() =>
          HealthDataType.heartRateMeasurementRecord.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        HeartRateSeriesRecordHealthDataType() =>
          HealthDataType.heartRateSeriesRecord.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        RestingHeartRateHealthDataType() =>
          HealthDataType.restingHeartRate.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        SleepSessionHealthDataType() => HealthDataType.sleepSession.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        SleepStageHealthDataType() =>
          HealthDataType.sleepStageRecord.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        EnergyNutrientDataType() => HealthDataType.energyNutrient.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        CaffeineNutrientDataType() => HealthDataType.caffeine.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        ProteinNutrientDataType() => HealthDataType.protein.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        TotalCarbohydrateNutrientDataType() =>
          HealthDataType.totalCarbohydrate.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        TotalFatNutrientDataType() => HealthDataType.totalFat.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        SaturatedFatNutrientDataType() =>
          HealthDataType.saturatedFat.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        MonounsaturatedFatNutrientDataType() =>
          HealthDataType.monounsaturatedFat.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        PolyunsaturatedFatNutrientDataType() =>
          HealthDataType.polyunsaturatedFat.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        BloodPressureHealthDataType() =>
          HealthDataType.bloodPressure.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        SystolicBloodPressureHealthDataType() =>
          HealthDataType.systolicBloodPressure.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        DiastolicBloodPressureHealthDataType() =>
          HealthDataType.diastolicBloodPressure.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        CholesterolNutrientDataType() => HealthDataType.cholesterol.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        DietaryFiberNutrientDataType() =>
          HealthDataType.dietaryFiber.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        SugarNutrientDataType() => HealthDataType.sugar.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        CalciumNutrientDataType() => HealthDataType.calcium.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        IronNutrientDataType() => HealthDataType.iron.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        MagnesiumNutrientDataType() => HealthDataType.magnesium.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        ManganeseNutrientDataType() => HealthDataType.manganese.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        PhosphorusNutrientDataType() => HealthDataType.phosphorus.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        PotassiumNutrientDataType() => HealthDataType.potassium.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        SeleniumNutrientDataType() => HealthDataType.selenium.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        SodiumNutrientDataType() => HealthDataType.sodium.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        ZincNutrientDataType() => HealthDataType.zinc.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        VitaminANutrientDataType() => HealthDataType.vitaminA.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        VitaminB6NutrientDataType() => HealthDataType.vitaminB6.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        VitaminB12NutrientDataType() => HealthDataType.vitaminB12.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        VitaminCNutrientDataType() => HealthDataType.vitaminC.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        VitaminDNutrientDataType() => HealthDataType.vitaminD.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        VitaminENutrientDataType() => HealthDataType.vitaminE.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        VitaminKNutrientDataType() => HealthDataType.vitaminK.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        ThiaminNutrientDataType() => HealthDataType.thiamin.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        RiboflavinNutrientDataType() => HealthDataType.riboflavin.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        NiacinNutrientDataType() => HealthDataType.niacin.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        FolateNutrientDataType() => HealthDataType.folate.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        BiotinNutrientDataType() => HealthDataType.biotin.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        PantothenicAcidNutrientDataType() =>
          HealthDataType.pantothenicAcid.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        NutritionHealthDataType() => HealthDataType.nutrition.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
        OxygenSaturationHealthDataType() =>
          HealthDataType.oxygenSaturation.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        RespiratoryRateHealthDataType() =>
          HealthDataType.respiratoryRate.readRecords(
            startTime: startDateTime!,
            endTime: endDateTime!,
            pageSize: _pageSize,
          ),
        Vo2MaxHealthDataType() => HealthDataType.vo2Max.readRecords(
          startTime: startDateTime!,
          endTime: endDateTime!,
          pageSize: _pageSize,
        ),
      };

      await notifier.readHealthRecords(request);
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }

      final message =
          e.code == HealthConnectorErrorCode.unsupportedHealthPlatformApi
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

  Future<void> _loadNextPage() async {
    final notifier = Provider.of<ReadHealthRecordsChangeNotifier>(
      context,
      listen: false,
    );
    final nextPageRequest = notifier.nextPageRequest;
    if (nextPageRequest == null) {
      return;
    }

    try {
      await notifier.loadNextPage();
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.error,
        '${AppTexts.failedToLoadNextPage} ${e.message}',
      );
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

  Future<void> _deleteRecord(HealthRecord record) async {
    final notifier = Provider.of<ReadHealthRecordsChangeNotifier>(
      context,
      listen: false,
    );

    try {
      await notifier.deleteRecord(record, _selectedDataType!);

      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.success,
        AppTexts.recordDeletedSuccessfully,
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }

      final message =
          e.code == HealthConnectorErrorCode.unsupportedHealthPlatformApi
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
    return Selector<ReadHealthRecordsChangeNotifier, bool>(
      selector: (_, notifier) => notifier.isLoading,
      builder: (context, isLoading, _) {
        return LoadingOverlay(
          isLoading: isLoading,
          message: AppTexts.readRecords,
          child: Scaffold(
            appBar: AppBar(title: const Text(AppTexts.readHealthRecords)),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HealthDataTypeDropdownField(
                      initialValue: _selectedDataType,
                      onChanged: (value) {
                        setState(() {
                          _selectedDataType = value;
                          final notifier =
                              Provider.of<ReadHealthRecordsChangeNotifier>(
                                context,
                                listen: false,
                              );
                          notifier.reset();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return AppTexts.pleaseSelectDataType;
                        }
                        return null;
                      },
                      items: HealthDataType.values
                          .where(
                            (type) => type.supportedHealthPlatforms.contains(
                              widget.healthPlatform,
                            ),
                          )
                          .toList(),
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pageSizeController,
                      decoration: const InputDecoration(
                        labelText: AppTexts.pageSize,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(AppIcons.list),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null; // Optional field
                        }
                        final pageSize = int.tryParse(value);
                        if (pageSize == null) {
                          return AppTexts.pleaseEnterValidNumber;
                        }
                        if (pageSize < 1 || pageSize > 10000) {
                          return AppTexts.pageSizeMustBeBetween1And10000;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: isLoading ? null : _readRecords,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text(AppTexts.readRecords),
                    ),
                    Selector<ReadHealthRecordsChangeNotifier, bool>(
                      selector: (_, notifier) => notifier.hasQueriedRecords,
                      builder: (context, hasQueriedRecords, _) {
                        if (!hasQueriedRecords) {
                          return const SizedBox.shrink();
                        }

                        final notifier =
                            Provider.of<ReadHealthRecordsChangeNotifier>(
                              context,
                            );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${AppTexts.foundRecords} '
                                    '${notifier.healthRecords.length} '
                                    '${AppTexts.records}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  if (notifier.nextPageRequest != null)
                                    Text(
                                      AppTexts.moreAvailable,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (notifier.healthRecords.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      AppIcons.inbox,
                                      size: 64,
                                      color: theme.AppColors.grey400,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      AppTexts.noRecordsFound,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: theme.AppColors.grey600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              ...notifier.healthRecords.map(
                                (record) => HealthRecordListTile(
                                  record: record,
                                  onDelete: () => _deleteRecord(record),
                                ),
                              ),
                            if (notifier.nextPageRequest != null) ...[
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: isLoading ? null : _loadNextPage,
                                child: const Text(AppTexts.loadMore),
                              ),
                            ],
                          ],
                        );
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
