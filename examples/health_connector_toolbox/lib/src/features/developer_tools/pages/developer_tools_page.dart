import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthPlatform;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/feature_navigation_card.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/platform_status_card.dart';

/// Optional technical views for Health Connector SDK operations.
///
/// The tools open the same on-device health data flows as the personal
/// inspector and never expand the permissions selected by the user.
@immutable
final class DeveloperToolsPage extends StatelessWidget {
  const DeveloperToolsPage({
    required this.healthPlatform,
    required this.onOpenPermissions,
    required this.onOpenRecords,
    required this.onOpenWrite,
    required this.onOpenAggregation,
    required this.onOpenSync,
    super.key,
  });

  final HealthPlatform healthPlatform;
  final VoidCallback onOpenPermissions;
  final VoidCallback onOpenRecords;
  final VoidCallback onOpenWrite;
  final VoidCallback onOpenAggregation;
  final VoidCallback onOpenSync;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.developerTools)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              AppTexts.developerToolsSubtitle,
              style: textTheme.bodyLarge?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 20),
            PlatformStatusCard(healthPlatform: healthPlatform),
            const SizedBox(height: 28),
            Text(
              AppTexts.sdkOperations,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            FeatureNavigationCard(
              icon: AppIcons.lockOutline,
              title: AppTexts.permissionsApi,
              description: AppTexts.permissionsApiDescription,
              color: Colors.deepOrange,
              onTap: onOpenPermissions,
            ),
            const SizedBox(height: 12),
            FeatureNavigationCard(
              icon: AppIcons.readMore,
              title: AppTexts.recordsApi,
              description: AppTexts.recordsApiDescription,
              color: Colors.teal,
              onTap: onOpenRecords,
            ),
            const SizedBox(height: 12),
            FeatureNavigationCard(
              icon: AppIcons.add,
              title: AppTexts.writeApi,
              description: AppTexts.writeApiDescription,
              color: Colors.blue,
              onTap: onOpenWrite,
            ),
            const SizedBox(height: 12),
            FeatureNavigationCard(
              icon: AppIcons.calculate,
              title: AppTexts.aggregationApi,
              description: AppTexts.aggregationApiDescription,
              color: Colors.purple,
              onTap: onOpenAggregation,
            ),
            const SizedBox(height: 12),
            FeatureNavigationCard(
              icon: AppIcons.sync,
              title: AppTexts.syncApi,
              description: AppTexts.syncApiDescription,
              color: Colors.indigo,
              onTap: onOpenSync,
            ),
          ],
        ),
      ),
    );
  }
}
