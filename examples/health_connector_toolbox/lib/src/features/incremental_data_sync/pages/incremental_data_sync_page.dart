import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/process_operation_with_error_handler_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/buttons/elevated_gradient_button.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/widgets/sync_console_log_card.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/widgets/sync_results_viewer_card.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/widgets/sync_token_card.dart';
import 'package:provider/provider.dart';

/// Test page for manually verifying the incremental synchronization API.
///
/// Provides UI controls for testing sync tokens, pagination, token expiration,
/// and viewing sync results with detailed logging.
@immutable
final class IncrementalDataSyncPage extends StatefulWidget {
  const IncrementalDataSyncPage({
    required this.healthPlatform,
    super.key,
  });

  final HealthPlatform healthPlatform;

  @override
  State<IncrementalDataSyncPage> createState() =>
      _IncrementalDataSyncPageState();
}

class _IncrementalDataSyncPageState extends State<IncrementalDataSyncPage>
    with
        ProcessOperationWithErrorHandlerPageStateMixin<
          IncrementalDataSyncPage
        > {
  late final _notifier = Provider.of<IncrementalDataSyncChangeNotifier>(
    context,
    listen: false,
  );

  Future<void> _handleSynchronize() async {
    try {
      await _notifier.synchronize();
      if (!mounted) {
        return;
      }
      showAppSnackBar(
        context,
        SnackBarType.success,
        AppTexts.synchronizationCompleted,
      );
    } on InvalidArgumentException catch (_) {
      if (!mounted) {
        return;
      }

      // Token expired - offer backfill
      final shouldBackfill = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppTexts.tokenExpired),
          content: const Text(AppTexts.tokenExpiredContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(AppTexts.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(AppTexts.clearAndSync),
            ),
          ],
        ),
      );

      if (shouldBackfill ?? false) {
        await _handleClearToken(showSnackBar: false);
        if (mounted) {
          await _handleSynchronize();
        }
      }
    } on ArgumentError catch (e) {
      if (!mounted) {
        return;
      }
      showAppSnackBar(
        context,
        SnackBarType.error,
        e.toString(),
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      showAppSnackBar(context, SnackBarType.error, e.message);
    }
  }

  Future<void> _handleClearToken({bool showSnackBar = true}) async {
    // Show confirmation dialog
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

    if (confirmed ?? false) {
      await process(() async {
        await _notifier.clearToken();
        if (showSnackBar && mounted) {
          showAppSnackBar(
            context,
            SnackBarType.success,
            AppTexts.tokenClearedSuccessfully,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<IncrementalDataSyncChangeNotifier, bool>(
      selector: (_, notifier) => _notifier.isLoading,
      builder: (context, isLoading, _) {
        return LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(AppTexts.incrementalDataSync),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Token Dashboard
                        SyncTokenCard(
                          healthPlatform: widget.healthPlatform,
                          onDataTypesChanged: _notifier.updateSelectedDataTypes,
                          onClearToken: _handleClearToken,
                        ),
                        const SizedBox(height: 16),

                        // Results Viewer
                        SyncResultsViewerCard(
                          onLoadMore: _notifier.loadMore,
                        ),
                        const SizedBox(height: 16),

                        // Console Log
                        const SyncConsoleLogCard(),
                      ],
                    ),
                  ),
                ),

                // Bottom button
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedGradientButton(
                    onPressed: isLoading ? null : _handleSynchronize,
                    label: AppTexts.synchronize,
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
