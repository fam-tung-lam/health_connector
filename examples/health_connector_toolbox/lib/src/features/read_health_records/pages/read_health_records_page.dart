import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/date_time_range_picker_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/process_operation_with_error_handler_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/buttons/elevated_gradient_button.dart';
import 'package:health_connector_toolbox/src/common/widgets/date_range_presets.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_time_range_picker_column.dart';
import 'package:health_connector_toolbox/src/features/permissions/pages/permissions_page.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/read_health_records_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_data_type_dropdown_field.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/read_health_record_results_section.dart';
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

class _ReadHealthRecordsPageState extends State<ReadHealthRecordsPage>
    with
        DateTimeRangePickerPageStateMixin<ReadHealthRecordsPage>,
        ProcessOperationWithErrorHandlerPageStateMixin<ReadHealthRecordsPage> {
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

  /// Reads health records based on the selected data type and time range.
  Future<void> _readRecords() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final notifier = Provider.of<ReadHealthRecordsChangeNotifier>(
      context,
      listen: false,
    );

    await process(() async {
      await notifier.readHealthRecords(
        dataType: _selectedDataType!,
        startTime: startDateTime!,
        endTime: endDateTime!,
        pageSize: _pageSize,
      );
    });
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

    await process(notifier.loadNextPage);
  }

  Future<void> _deleteRecord(HealthRecord record) async {
    if (!mounted) {
      return;
    }

    final notifier = Provider.of<ReadHealthRecordsChangeNotifier>(
      context,
      listen: false,
    );

    await process(() async {
      await notifier.deleteRecord(record, _selectedDataType!);

      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.success,
        AppTexts.recordDeletedSuccessfully,
      );
    });
  }

  /// Handles refresh action.
  Future<void> _onRefresh() async {
    if (_formKey.currentState!.validate()) {
      await _readRecords();
    }
  }

  /// Handles data type selection changes.
  void _onDataTypeChanged(
    HealthDataType<HealthRecord, MeasurementUnit>? value,
  ) {
    setState(() {
      _selectedDataType = value;
      final notifier = Provider.of<ReadHealthRecordsChangeNotifier>(
        context,
        listen: false,
      );
      notifier.reset();
    });
  }

  /// Validates the selected data type.
  String? _validateDataType(
    HealthDataType<HealthRecord, MeasurementUnit>? value,
  ) {
    if (value == null) {
      return AppTexts.pleaseSelectDataType;
    }
    return null;
  }

  /// Handles date range preset selection.
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

  /// Validates the page size field.
  String? _validatePageSize(String? value) {
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
  }

  /// Navigates to the permissions page.
  void _navigateToPermissions() {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => Provider<HealthConnector>.value(
          value: Provider.of<HealthConnector>(
            context,
            listen: false,
          ),
          child: PermissionsPage(
            healthPlatform: widget.healthPlatform,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ReadHealthRecordsChangeNotifier, bool>(
      selector: (_, notifier) => notifier.isLoading,
      builder: (context, isLoading, _) {
        return LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            appBar: AppBar(title: const Text(AppTexts.readHealthRecords)),
            body: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                              items: HealthDataType.values
                                  .where(
                                    (type) =>
                                        type.supportedHealthPlatforms.contains(
                                          widget.healthPlatform,
                                        ),
                                  )
                                  .toList(),
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
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _pageSizeController,
                              decoration: const InputDecoration(
                                labelText: AppTexts.pageSize,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(AppIcons.list),
                              ),
                              keyboardType: TextInputType.number,
                              validator: _validatePageSize,
                            ),
                            const SizedBox(height: 16),
                            ReadHealthRecordResultsSection(
                              healthPlatform: widget.healthPlatform,
                              onCheckPermissions: _navigateToPermissions,
                              onDeleteRecord: _deleteRecord,
                              onLoadNextPage: _loadNextPage,
                              isLoading: isLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedGradientButton(
                  onPressed: isLoading ? null : _readRecords,
                  label: AppTexts.read.toUpperCase(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
