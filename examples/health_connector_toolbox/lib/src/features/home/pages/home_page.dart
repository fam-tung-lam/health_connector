import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/error_view.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/aggregate_health_data_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/aggregate_health_data/pages/aggregate_health_data_page.dart';
import 'package:health_connector_toolbox/src/features/home/home_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/feature_navigation_card.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/platform_status_card.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/welcome_header.dart';
import 'package:health_connector_toolbox/src/features/permissions/pages/permissions_page.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/pages/read_health_records_page.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/read_health_records_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/pages/health_data_type_selection_page.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart'
    show Consumer, Provider, ChangeNotifierProvider;

/// The main home page of the application.
///
/// Displays a modern, card-based interface with:
/// - Welcome header with app branding
/// - Platform connection status
/// - Health metrics summary with demo data
/// - Feature navigation cards for permissions, read, write, and aggregation
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
                    .healthPlatformNotInstalledOrUpdateRequired:
                  return Center(
                    child: ErrorView(
                      message: error.toString(),
                      onRetry: () => notifier.launchHealthAppPageInAppStore(),
                    ),
                  );
                case HealthConnectorErrorCode.healthPlatformUnavailable:
                case HealthConnectorErrorCode.unsupportedOperation:
                case HealthConnectorErrorCode.invalidConfiguration:
                case HealthConnectorErrorCode.invalidArgument:
                case HealthConnectorErrorCode.notAuthorized:
                case HealthConnectorErrorCode.remoteError:
                case HealthConnectorErrorCode.syncTokenExpired:
                case HealthConnectorErrorCode.unknown:
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
          const SizedBox(height: 32),

          // Feature navigation section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              AppTexts.exploreFeatures,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Launch Health App in App Store card
          if (healthConnector.healthPlatform != HealthPlatform.appleHealth) ...[
            FeatureNavigationCard(
              icon: AppIcons.store,
              title: AppTexts.openHealthAppStore,
              description: AppTexts.openHealthAppStoreDescription,
              color: Colors.green,
              onTap: () => _launchHealthAppPageInAppStore(context),
            ),
            const SizedBox(height: 12),
          ],

          // Permissions card
          FeatureNavigationCard(
            icon: AppIcons.lockOutline,
            title: AppTexts.permissions,
            description: AppTexts.permissionsDescription,
            color: Colors.deepOrange,
            onTap: () => _navigateToPermissions(context),
          ),
          const SizedBox(height: 12),

          // Read records card
          FeatureNavigationCard(
            icon: AppIcons.readMore,
            title: AppTexts.readHealthRecords,
            description: AppTexts.readRecordsDescription,
            color: Colors.teal,
            onTap: () => _navigateToReadRecords(context),
          ),
          const SizedBox(height: 12),

          // Write records card
          FeatureNavigationCard(
            icon: AppIcons.add,
            title: AppTexts.write,
            description: AppTexts.writeRecordsDescription,
            color: Colors.blue,
            onTap: () => _navigateToWriteRecords(context),
          ),
          const SizedBox(height: 12),

          // Aggregate data card
          FeatureNavigationCard(
            icon: AppIcons.calculate,
            title: AppTexts.aggregate,
            description: AppTexts.aggregateDescription,
            color: Colors.purple,
            onTap: () => _navigateToAggregate(context),
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

  Future<void> _launchHealthAppPageInAppStore(BuildContext context) async {
    try {
      final notifier = Provider.of<HomeChangeNotifier>(context, listen: false);

      return notifier.launchHealthAppPageInAppStore();
    } on HealthConnectorException catch (e) {
      if (context.mounted) {
        showAppSnackBar(
          context,
          SnackBarType.error,
          '${AppTexts.failedToLaunchHealthAppStore}: ${e.message}',
        );
      }
    }
  }
}
