import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        AggregateRequest,
        AggregateResponse,
        AggregationMetric,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
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
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType;
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
  const AggregateHealthDataPage({super.key});

  @override
  State<AggregateHealthDataPage> createState() =>
      _AggregateHealthDataPageState();
}

class _AggregateHealthDataPageState
    extends DateTimeRangePageState<AggregateHealthDataPage> {
  final _formKey = GlobalKey<FormState>();
  HealthDataType<HealthRecord, MeasurementUnit>? _selectedDataType;
  AggregationMetric? _selectedMetric;

  Future<void> _aggregate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final notifier = Provider.of<AggregateHealthDataChangeNotifier>(
      context,
      listen: false,
    );

    try {
      late final AggregateRequest request;

      switch (_selectedDataType!) {
        case StepsHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.sum:
              request = HealthDataType.steps.aggregateSum(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.count:
            case AggregationMetric.avg:
            case AggregationMetric.min:
            case AggregationMetric.max:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case WeightHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.avg:
              request = HealthDataType.weight.aggregateAverage(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.min:
              request = HealthDataType.weight.aggregateMin(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.max:
              request = HealthDataType.weight.aggregateMax(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.sum:
            case AggregationMetric.count:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case HeightHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.avg:
              request = HealthDataType.height.aggregateAverage(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.min:
              request = HealthDataType.height.aggregateMin(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.max:
              request = HealthDataType.height.aggregateMax(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.sum:
            case AggregationMetric.count:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case BodyFatPercentageHealthDataType():
          throw UnsupportedError(
            'Body fat percentage does not support aggregation',
          );
        case BodyTemperatureHealthDataType():
          throw UnsupportedError(
            'Body temperature does not support aggregation',
          );
        case LeanBodyMassHealthDataType():
          throw UnsupportedError(
            'Lean body mass does not support aggregation',
          );
        case DistanceHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.sum:
              request = HealthDataType.distance.aggregateSum(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.count:
            case AggregationMetric.avg:
            case AggregationMetric.min:
            case AggregationMetric.max:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case ActiveCaloriesBurnedHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.sum:
              request = HealthDataType.activeCaloriesBurned.aggregateSum(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.count:
            case AggregationMetric.avg:
            case AggregationMetric.min:
            case AggregationMetric.max:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case FloorsClimbedHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.sum:
              request = HealthDataType.floorsClimbed.aggregateSum(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.count:
            case AggregationMetric.avg:
            case AggregationMetric.min:
            case AggregationMetric.max:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case WheelchairPushesHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.sum:
              request = HealthDataType.wheelchairPushes.aggregateSum(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.count:
            case AggregationMetric.avg:
            case AggregationMetric.min:
            case AggregationMetric.max:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case HydrationHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.sum:
              request = HealthDataType.hydration.aggregateSum(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.count:
            case AggregationMetric.avg:
            case AggregationMetric.min:
            case AggregationMetric.max:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case HeartRateMeasurementRecordHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.avg:
              request = HealthDataType.heartRateMeasurementRecord
                  .aggregateAverage(
                    startTime: startDateTime!,
                    endTime: endDateTime!,
                  );
            case AggregationMetric.min:
              request = HealthDataType.heartRateMeasurementRecord.aggregateMin(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.max:
              request = HealthDataType.heartRateMeasurementRecord.aggregateMax(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.sum:
            case AggregationMetric.count:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
        case HeartRateSeriesRecordHealthDataType():
          switch (_selectedMetric!) {
            case AggregationMetric.avg:
              request = HealthDataType.heartRateSeriesRecord.aggregateAverage(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.min:
              request = HealthDataType.heartRateSeriesRecord.aggregateMin(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.max:
              request = HealthDataType.heartRateSeriesRecord.aggregateMax(
                startTime: startDateTime!,
                endTime: endDateTime!,
              );
            case AggregationMetric.sum:
            case AggregationMetric.count:
              throw UnsupportedError('Unsupported metric: $_selectedMetric');
          }
      }

      await notifier.aggregateHealthData(request);
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
                        if (value == null) {
                          return AppTexts.pleaseSelectDataType;
                        }
                        return null;
                      },
                      // Filter to only display data types with non-empty
                      // supported aggregation metrics
                      itemsFilter: (type) =>
                          type.supportedAggregationMetrics.isNotEmpty,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<AggregationMetric>(
                      initialValue: _selectedMetric,
                      decoration: const InputDecoration(
                        labelText: AppTexts.aggregationMetric,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(AppIcons.calculate),
                      ),
                      items: _selectedDataType?.supportedAggregationMetrics.map(
                        (metric) {
                          return DropdownMenuItem(
                            value: metric,
                            child: Text(metric.displayName),
                          );
                        },
                      ).toList(),
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
