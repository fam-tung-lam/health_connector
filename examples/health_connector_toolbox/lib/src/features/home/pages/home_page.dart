import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
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
import 'package:health_connector_toolbox/src/features/write_health_record/pages/write_health_record_page.dart';
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
            // Loading state
            if (notifier.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Error state
            if (notifier.error != null) {
              return Center(
                child: ErrorView(
                  message: notifier.error.toString(),
                  onRetry: () => notifier.init(),
                ),
              );
            }

            final healthConnector = notifier.healthConnector;
            if (healthConnector == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Main content
            return _HomeContent(
              healthConnector: healthConnector,
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
          _buildSectionHeader(context, AppTexts.exploreFeatures),
          const SizedBox(height: 16),

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

  /// Builds a section header with consistent styling.
  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
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
            child: WriteHealthRecordPage(
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
          create: (_) => AggregateHealthDataChangeNotifier(
            healthConnector,
          ),
          child: AggregateHealthDataPage(
            healthPlatform: healthConnector.healthPlatform,
          ),
        ),
      ),
    );
  }
}
