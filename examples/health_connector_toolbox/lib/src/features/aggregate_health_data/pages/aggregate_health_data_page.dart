import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show
        AggregationMetric,
        BloodPressureHealthDataType,
        HealthDataType,
        HealthRecord,
        MeasurementUnit,
        Pressure,
        HealthPlatform;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/date_time_range_picker_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/process_operation_with_error_handler_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/buttons/elevated_gradient_button.dart';
import 'package:health_connector_toolbox/src/common/widgets/date_range_presets.dart';
import 'package:health_connector_toolbox/src/common/widgets/health_data_type_dropdown_field.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_time_range_picker_column.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/aggregate_health_data_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/widgets/aggregate_result_card.dart';
import 'package:provider/provider.dart' show Provider, Selector;

/// Page for aggregating health data over a time range.
///
/// Allows users to select a health data type, aggregation metric (sum, average,
/// min, max), and time range. Displays the aggregation result in a card.
@immutable
final class AggregateHealthDataPage extends StatefulWidget {
  const AggregateHealthDataPage({required this.healthPlatform, super.key});

  final HealthPlatform healthPlatform;

  @override
  State<AggregateHealthDataPage> createState() =>
      _AggregateHealthDataPageState();
}

class _AggregateHealthDataPageState extends State<AggregateHealthDataPage>
    with
        DateTimeRangePickerPageStateMixin<AggregateHealthDataPage>,
        ProcessOperationWithErrorHandlerPageStateMixin<
          AggregateHealthDataPage
        > {
  final _formKey = GlobalKey<FormState>();
  HealthDataType<HealthRecord, MeasurementUnit>? _selectedDataType;
  AggregationMetric? _selectedMetric;
  HealthDataType<HealthRecord, Pressure>? _selectedBloodPressureSubtype;

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
        AppTexts.pleaseSelectBloodPressureType,
      );
      return;
    }

    final notifier = Provider.of<AggregateHealthDataChangeNotifier>(
      context,
      listen: false,
    );

    await process(() async {
      await notifier.aggregateHealthData(
        dataType: _selectedDataType!,
        aggregationMetric: _selectedMetric!,
        startTime: startDateTime!,
        endTime: endDateTime!,
        bloodPressureSubtype: _selectedBloodPressureSubtype,
      );
    });
  }

  /// Handles changes to the selected health data type.
  void _onDataTypeChanged(
    HealthDataType<HealthRecord, MeasurementUnit>? value,
  ) {
    setState(() {
      _selectedDataType = value;
      _selectedBloodPressureSubtype = null;

      if (value is BloodPressureHealthDataType) {
        _selectedMetric = null;
      } else {
        _selectedMetric = value?.supportedAggregationMetrics.first;
      }

      final notifier = Provider.of<AggregateHealthDataChangeNotifier>(
        context,
        listen: false,
      );
      notifier.clearResults();
    });
  }

  /// Handles changes to the selected blood pressure subtype.
  void _onBloodPressureSubtypeChanged(
    HealthDataType<HealthRecord, Pressure>? value,
  ) {
    setState(() {
      _selectedBloodPressureSubtype = value;
      _selectedMetric = value?.supportedAggregationMetrics.first;

      final notifier = Provider.of<AggregateHealthDataChangeNotifier>(
        context,
        listen: false,
      );
      notifier.clearResults();
    });
  }

  /// Handles changes to the selected aggregation metric.
  void _onAggregationMetricChanged(AggregationMetric? value) {
    setState(() {
      _selectedMetric = value ?? AggregationMetric.sum;

      final notifier = Provider.of<AggregateHealthDataChangeNotifier>(
        context,
        listen: false,
      );
      notifier.clearResults();
    });
  }

  String? _validateDataType(
    HealthDataType<HealthRecord, MeasurementUnit>? value,
  ) {
    if (value == null) {
      return AppTexts.pleaseSelectDataType;
    }
    return null;
  }

  bool _filterSupportedDataTypes(
    HealthDataType<HealthRecord, MeasurementUnit> type,
  ) {
    return type.supportedHealthPlatforms.contains(widget.healthPlatform) &&
        type.supportedAggregationMetrics.isNotEmpty;
  }

  String? _validateBloodPressureType(
    HealthDataType<HealthRecord, Pressure>? value,
  ) {
    if (_selectedDataType is BloodPressureHealthDataType && value == null) {
      return AppTexts.pleaseSelectBloodPressureType;
    }
    return null;
  }

  String? _validateAggregationMetric(AggregationMetric? value) {
    if (value == null) {
      return AppTexts.pleaseSelectMetric;
    }
    return null;
  }

  void _onPresetSelected(
    DateTime startDate,
    TimeOfDay startTime,
    DateTime endDate,
    TimeOfDay endTime,
  ) {
    setStartDate(startDate);
    setStartTime(startTime);
    setEndDate(endDate);
    setEndTime(endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AggregateHealthDataChangeNotifier, bool>(
      selector: (_, notifier) => notifier.isLoading,
      builder: (context, isLoading, _) {
        return LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            appBar: AppBar(title: const Text(AppTexts.readAggregateData)),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HealthDataTypeDropdownField(
                            initialValue: _selectedDataType,
                            onChanged: _onDataTypeChanged,
                            validator: _validateDataType,
                            itemsFilter: _filterSupportedDataTypes,
                          ),
                          const SizedBox(height: 12),
                          if (_selectedDataType
                              is BloodPressureHealthDataType) ...[
                            DropdownButtonFormField<
                              HealthDataType<HealthRecord, Pressure>
                            >(
                              initialValue: _selectedBloodPressureSubtype,
                              decoration: const InputDecoration(
                                labelText: AppTexts.bloodPressureType,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  AppIcons.bloodPressure,
                                ),
                              ),
                              items: [
                                DropdownMenuItem<
                                  HealthDataType<HealthRecord, Pressure>
                                >(
                                  value: HealthDataType.systolicBloodPressure,
                                  child: Text(
                                    HealthDataType
                                        .systolicBloodPressure
                                        .displayName,
                                  ),
                                ),
                                DropdownMenuItem<
                                  HealthDataType<HealthRecord, Pressure>
                                >(
                                  value: HealthDataType.diastolicBloodPressure,
                                  child: Text(
                                    HealthDataType
                                        .diastolicBloodPressure
                                        .displayName,
                                  ),
                                ),
                              ],
                              onChanged: _onBloodPressureSubtypeChanged,
                              validator: _validateBloodPressureType,
                            ),
                            const SizedBox(height: 12),
                          ],
                          DropdownButtonFormField<AggregationMetric>(
                            initialValue: _selectedMetric,
                            decoration: const InputDecoration(
                              labelText: AppTexts.aggregationMetric,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(AppIcons.calculate),
                            ),
                            items:
                                (_selectedDataType
                                            is BloodPressureHealthDataType
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
                            onChanged: _onAggregationMetricChanged,
                            validator: _validateAggregationMetric,
                          ),
                          const SizedBox(height: 16),
                          DateRangePresets(
                            onPresetSelected: _onPresetSelected,
                          ),
                          const SizedBox(height: 12),
                          DateTimeRangePickerColumn(
                            startDate: startDate,
                            startTime: startTime,
                            endDate: endDate,
                            endTime: endTime,
                            onStartDateChanged: setStartDate,
                            onStartTimeChanged: setStartTime,
                            onEndDateChanged: setEndDate,
                            onEndTimeChanged: setEndTime,
                          ),
                          Selector<
                            AggregateHealthDataChangeNotifier,
                            MeasurementUnit?
                          >(
                            selector: (_, notifier) =>
                                notifier.aggregationResult,
                            builder: (context, aggregationResult, _) {
                              if (aggregationResult != null &&
                                  _selectedMetric != null) {
                                return AggregateResultCard(
                                  metric: _selectedMetric!.displayName,
                                  aggregationMetric: _selectedMetric!,
                                  value: aggregationResult,
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
                ElevatedGradientButton(
                  onPressed: isLoading ? null : _aggregate,
                  label: AppTexts.aggregate.toUpperCase(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
