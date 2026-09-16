import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/widgets/error_view.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/aggregate_health_data_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/pages/aggregate_health_data_page.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/pages/background_incremental_data_sync_page.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_scheduler.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_storage.dart';
import 'package:health_connector_toolbox/src/features/console_logs/pages/console_logs_page.dart';
import 'package:health_connector_toolbox/src/features/home/home_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/platform_status_card.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/toolbox_operations_section.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/welcome_header.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/pages/incremental_data_sync_page.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/services/sync_token_storage_service.dart';
import 'package:health_connector_toolbox/src/features/permissions/pages/permissions_page.dart';
import 'package:health_connector_toolbox/src/features/privacy/pages/privacy_policy_page.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/pages/read_health_records_page.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/read_health_records_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/pages/health_data_type_selection_page.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart'
    show Consumer, Provider, ChangeNotifierProvider;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart' show Workmanager;

/// The main home page of the application.
///
/// Displays a modern, card-based interface with:
/// - Welcome header with app branding
/// - Platform connection status
/// - Privacy and data information
/// - SDK operation navigation cards
/// - Diagnostics navigation cards
///
/// The design follows Material Design 3 principles with a calming color
/// palette suitable for health applications.
@immutable
final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeChangeNotifier>(
          builder: (context, notifier, _) {
            if (notifier.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final error = notifier.error;
            if (error != null) {
              switch (error.code) {
                case HealthConnectorErrorCode
                    .healthServiceNotInstalledOrUpdateRequired:
                  return Center(
                    child: ErrorView(
                      message: error.toString(),
                      onRetry: () => notifier.launchHealthAppPageInAppStore(),
                    ),
                  );
                case HealthConnectorErrorCode.unsupportedOperation:
                case HealthConnectorErrorCode.permissionNotDeclared:
                case HealthConnectorErrorCode.invalidArgument:
                case HealthConnectorErrorCode.permissionNotGranted:
                case HealthConnectorErrorCode.remoteError:
                case HealthConnectorErrorCode.unknownError:
                case HealthConnectorErrorCode.healthServiceRestricted:
                case HealthConnectorErrorCode.healthServiceDatabaseInaccessible:
                case HealthConnectorErrorCode.ioError:
                case HealthConnectorErrorCode.rateLimitExceeded:
                case HealthConnectorErrorCode.dataSyncInProgress:
                case HealthConnectorErrorCode.healthServiceUnavailable:
                  return Center(
                    child: ErrorView(
                      message: error.toString(),
                      onRetry: () => notifier.init(),
                    ),
                  );
              }
            }

            return _HomeContent(
              healthConnector: notifier.healthConnector!,
            );
          },
        ),
      ),
    );
  }
}

/// The main content widget for the home page.
///
/// Separated into its own widget for better organization and to avoid
/// rebuilding the entire scaffold when only content changes.
final class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.healthConnector,
  });

  final HealthConnector healthConnector;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome header
          const WelcomeHeader(),
          const SizedBox(height: 24),

          // Platform status card
          PlatformStatusCard(
            healthPlatform: healthConnector.healthPlatform,
          ),
          const SizedBox(height: 12),
          ToolboxOperationsSection(
            onOpenPrivacy: () => _navigateToPrivacyPolicy(context),
            onOpenPermissions: () => _navigateToPermissions(context),
            onOpenRecords: () => _navigateToReadRecords(context),
            onOpenWrite: () => _navigateToWriteRecords(context),
            onOpenAggregation: () => _navigateToAggregate(context),
            onOpenSync: () => unawaited(
              _navigateToIncrementalDataSync(context),
            ),
            onOpenBackgroundSync: () =>
                _navigateToBackgroundIncrementalDataSync(context),
            onOpenConsoleLogs: () => _navigateToConsoleLogs(context),
          ),

          // Bottom padding for better scroll experience
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Navigates to the permissions page.
  void _navigateToPermissions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => Provider<HealthConnector>.value(
          value: healthConnector,
          child: PermissionsPage(
            healthPlatform: healthConnector.healthPlatform,
          ),
        ),
      ),
    );
  }

  /// Navigates to the read health records page.
  void _navigateToReadRecords(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => ReadHealthRecordsChangeNotifier(
            healthConnector,
          ),
          child: ReadHealthRecordsPage(
            healthPlatform: healthConnector.healthPlatform,
          ),
        ),
      ),
    );
  }

  /// Navigates to the write health record page.
  void _navigateToWriteRecords(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => Provider<HealthConnector>.value(
          value: healthConnector,
          child: ChangeNotifierProvider(
            create: (_) => WriteHealthRecordChangeNotifier(
              healthConnector,
            ),
            child: HealthDataTypeSelectionPage(
              healthPlatform: healthConnector.healthPlatform,
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the aggregate health data page.
  void _navigateToAggregate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => AggregateDataChangeNotifier(
            healthConnector,
          ),
          child: AggregateDataPage(
            healthPlatform: healthConnector.healthPlatform,
          ),
        ),
      ),
    );
  }

  /// Navigates to the incremental data sync page.
  Future<void> _navigateToIncrementalDataSync(BuildContext context) async {
    // Initialize SharedPreferences for sync token storage
    final prefs = await SharedPreferences.getInstance();
    final storageService = SyncTokenStorageService(prefs);

    if (!context.mounted) {
      return;
    }

    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => IncrementalDataSyncChangeNotifier(
              healthConnector,
              storageService,
            )..initialize(),
            child: IncrementalDataSyncPage(
              healthPlatform: healthConnector.healthPlatform,
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the background incremental data sync page.
  ///
  /// Storage uses the async preferences API so the page observes values the
  /// headless background isolate wrote.
  void _navigateToBackgroundIncrementalDataSync(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => BackgroundIncrementalDataSyncChangeNotifier(
            healthConnector: healthConnector,
            storage: SharedPreferencesBackgroundSyncStorage(
              SharedPreferencesAsync(),
            ),
            scheduler: WorkmanagerBackgroundSyncScheduler(Workmanager()),
          )..initialize(),
          child: BackgroundIncrementalDataSyncPage(
            healthPlatform: healthConnector.healthPlatform,
          ),
        ),
      ),
    );
  }

  /// Navigates to the SDK console logs page.
  ///
  /// The console log store is provided above the [MaterialApp], so the page
  /// reads it from the inherited provider tree.
  void _navigateToConsoleLogs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => const ConsoleLogsPage(),
      ),
    );
  }

  /// Navigates to the privacy policy page.
  void _navigateToPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => PrivacyPolicyPage(
          healthPlatform: healthConnector.healthPlatform,
        ),
      ),
    );
  }
}
