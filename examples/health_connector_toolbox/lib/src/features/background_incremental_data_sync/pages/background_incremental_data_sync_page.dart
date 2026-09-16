import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthDataType, HealthPlatform;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/process_operation_with_error_handler_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/buttons/elevated_gradient_button.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/background_sync_console_card.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/background_sync_status_card.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/background_sync_token_card.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/health_data_type_multi_select_bottom_sheet.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/latest_sync_report_card.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/widgets/selected_data_types_card.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/pages/console_logs_page.dart';
import 'package:provider/provider.dart';

/// Reference screen for scheduling incremental sync in the background.
///
/// The screen configures the data types and frequency, enables or disables
/// the periodic task, and observes the token, the latest run report, and the
/// console logs the background isolate persisted.
@immutable
final class BackgroundIncrementalDataSyncPage extends StatefulWidget {
  const BackgroundIncrementalDataSyncPage({
    required this.healthPlatform,
    super.key,
  });

  final HealthPlatform healthPlatform;

  /// How often persisted background results are polled while visible.
  static const Duration refreshInterval = Duration(seconds: 10);

  @override
  State<BackgroundIncrementalDataSyncPage> createState() =>
      _BackgroundIncrementalDataSyncPageState();
}

class _BackgroundIncrementalDataSyncPageState
    extends State<BackgroundIncrementalDataSyncPage>
    with
        WidgetsBindingObserver,
        ProcessOperationWithErrorHandlerPageStateMixin<
          BackgroundIncrementalDataSyncPage
        > {
  late final _notifier = context
      .read<BackgroundIncrementalDataSyncChangeNotifier>();
  late final _consoleLogStore = context.read<ConsoleLogStore>();
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshTimer = Timer.periodic(
      BackgroundIncrementalDataSyncPage.refreshInterval,
      (_) => unawaited(_refresh()),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refresh());
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.wait([_notifier.refresh(), _consoleLogStore.reload()]);
  }

  Future<void> _editDataTypes() async {
    final selection = await HealthDataTypeMultiSelectBottomSheet.show(
      context,
      healthPlatform: widget.healthPlatform,
      initialSelection: _notifier.selectedDataTypes,
    );
    if (selection == null || !mounted) {
      return;
    }
    await process(() async {
      final tokenCleared = await _notifier.updateSelectedDataTypes(selection);
      if (!mounted) {
        return;
      }
      showAppSnackBar(
        context,
        tokenCleared ? SnackBarType.warning : SnackBarType.success,
        tokenCleared
            ? AppTexts.dataTypesChangedTokenCleared
            : AppTexts.selectionSaved,
      );
    });
  }

  Future<void> _toggleBackgroundSync() async {
    final enable = !_notifier.isBackgroundSyncEnabled;
    if (enable && _notifier.selectedDataTypes.isEmpty) {
      showAppSnackBar(
        context,
        SnackBarType.warning,
        AppTexts.selectAtLeastOneDataType,
      );
      return;
    }
    await process(() async {
      if (enable) {
        await _notifier.enableBackgroundSync();
      } else {
        await _notifier.disableBackgroundSync();
      }
      if (!mounted) {
        return;
      }
      showAppSnackBar(
        context,
        SnackBarType.success,
        enable
            ? AppTexts.backgroundSyncEnabled
            : AppTexts.backgroundSyncDisabled,
      );
    });
  }

  Future<void> _runNow() async {
    if (_notifier.selectedDataTypes.isEmpty) {
      showAppSnackBar(
        context,
        SnackBarType.warning,
        AppTexts.selectAtLeastOneDataType,
      );
      return;
    }
    await process(() async {
      final result = await _notifier.runSyncNow();
      await _consoleLogStore.reload();
      if (!mounted) {
        return;
      }
      final report = result.report;
      final type = switch (report.outcome) {
        BackgroundSyncOutcome.succeeded => SnackBarType.success,
        BackgroundSyncOutcome.skipped => SnackBarType.warning,
        BackgroundSyncOutcome.failed => SnackBarType.error,
      };
      showAppSnackBar(
        context,
        type,
        report.error?.message ?? AppTexts.backgroundSyncCompleted,
      );
    });
  }

  Future<void> _clearToken() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppTexts.clearSyncTokenQuestion),
        content: const Text(AppTexts.clearSyncTokenContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppTexts.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(AppTexts.clear),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false) || !mounted) {
      return;
    }
    await process(() async {
      await _notifier.clearToken();
      if (mounted) {
        showAppSnackBar(
          context,
          SnackBarType.success,
          AppTexts.syncTokenCleared,
        );
      }
    });
  }

  void _openConsole() {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(builder: (_) => const ConsoleLogsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<BackgroundIncrementalDataSyncChangeNotifier, (bool, bool)>(
      selector: (_, notifier) => (
        notifier.isLoading || notifier.isSyncing,
        notifier.isBackgroundSyncEnabled,
      ),
      builder: (context, state, _) {
        final (isBusy, isEnabled) = state;

        return LoadingOverlay(
          isLoading: isBusy,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(AppTexts.backgroundIncrementalDataSync),
              actions: [
                IconButton(
                  icon: const Icon(AppIcons.refresh),
                  tooltip: AppTexts.refresh,
                  onPressed: () => unawaited(_refresh()),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BackgroundSyncStatusCard(
                          healthPlatform: widget.healthPlatform,
                          onRunNow: () => unawaited(_runNow()),
                          onRequestPermission: () => unawaited(
                            process(_notifier.requestBackgroundReadPermission),
                          ),
                          onFrequencyChanged: (frequency) => unawaited(
                            process(() => _notifier.updateFrequency(frequency)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Selector<
                          BackgroundIncrementalDataSyncChangeNotifier,
                          List<HealthDataType>
                        >(
                          selector: (_, notifier) => notifier.selectedDataTypes,
                          builder: (context, dataTypes, _) =>
                              SelectedDataTypesCard(
                                dataTypes: dataTypes,
                                onEdit: () => unawaited(_editDataTypes()),
                              ),
                        ),
                        const SizedBox(height: 16),
                        BackgroundSyncTokenCard(
                          onClearToken: () => unawaited(_clearToken()),
                        ),
                        const SizedBox(height: 16),
                        const LatestSyncReportCard(),
                        const SizedBox(height: 16),
                        BackgroundSyncConsoleCard(onOpenConsole: _openConsole),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedGradientButton(
                    onPressed: isBusy
                        ? null
                        : () => unawaited(_toggleBackgroundSync()),
                    label: isEnabled
                        ? AppTexts.disableBackgroundSync
                        : AppTexts.enableBackgroundSync,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
