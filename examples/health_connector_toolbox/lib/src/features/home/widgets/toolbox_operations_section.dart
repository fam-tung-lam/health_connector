import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/feature_navigation_card.dart';

/// Navigation for privacy information, Health Connector SDK operations, and
/// diagnostics.
@immutable
final class ToolboxOperationsSection extends StatelessWidget {
  const ToolboxOperationsSection({
    required this.onOpenPrivacy,
    required this.onOpenPermissions,
    required this.onOpenRecords,
    required this.onOpenWrite,
    required this.onOpenAggregation,
    required this.onOpenSync,
    required this.onOpenConsoleLogs,
    super.key,
  });

  final VoidCallback onOpenPrivacy;
  final VoidCallback onOpenPermissions;
  final VoidCallback onOpenRecords;
  final VoidCallback onOpenWrite;
  final VoidCallback onOpenAggregation;
  final VoidCallback onOpenSync;
  final VoidCallback onOpenConsoleLogs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FeatureNavigationCard(
          icon: AppIcons.privacyTip,
          title: AppTexts.privacyAndData,
          description: AppTexts.privacyAndDataDescription,
          color: Colors.blueGrey,
          onTap: onOpenPrivacy,
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            AppTexts.sdkOperations,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FeatureNavigationCard(
          icon: AppIcons.lockOutline,
          title: AppTexts.requestPermissions,
          description: AppTexts.permissionsApiDescription,
          color: Colors.deepOrange,
          onTap: onOpenPermissions,
        ),
        const SizedBox(height: 12),
        FeatureNavigationCard(
          icon: AppIcons.readMore,
          title: AppTexts.readHealthRecords,
          description: AppTexts.recordsApiDescription,
          color: Colors.teal,
          onTap: onOpenRecords,
        ),
        const SizedBox(height: 12),
        FeatureNavigationCard(
          icon: AppIcons.add,
          title: AppTexts.insertHealthRecord,
          description: AppTexts.writeApiDescription,
          color: Colors.blue,
          onTap: onOpenWrite,
        ),
        const SizedBox(height: 12),
        FeatureNavigationCard(
          icon: AppIcons.calculate,
          title: AppTexts.readAggregateData,
          description: AppTexts.aggregationApiDescription,
          color: Colors.purple,
          onTap: onOpenAggregation,
        ),
        const SizedBox(height: 12),
        FeatureNavigationCard(
          icon: AppIcons.sync,
          title: AppTexts.incrementalDataSync,
          description: AppTexts.syncApiDescription,
          color: Colors.indigo,
          onTap: onOpenSync,
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            AppTexts.diagnostics,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FeatureNavigationCard(
          icon: AppIcons.terminal,
          title: AppTexts.sdkConsoleLogs,
          description: AppTexts.consoleLogsApiDescription,
          color: Colors.green,
          onTap: onOpenConsoleLogs,
        ),
      ],
    );
  }
}
