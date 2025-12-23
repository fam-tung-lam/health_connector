import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show
        HealthConnector,
        HealthDataPermission,
        HealthDataType,
        HealthPlatformFeature,
        HealthPlatformFeatureStatus;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/common/widgets/buttons/elevated_gradient_button.dart';
import 'package:health_connector_toolbox/src/common/widgets/search_text_field.dart';
import 'package:health_connector_toolbox/src/features/permissions/permissions_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/permissions/widgets/permission_list.dart';
import 'package:health_connector_toolbox/src/features/permissions/widgets/permission_list_tile.dart';
import 'package:provider/provider.dart' show Provider, Selector;

/// The main content view for the permissions page.
///
/// Displays iOS warning banner (if applicable), search field, data type
/// permissions list, feature permissions list, and an action bar for
/// requesting selected permissions.
@immutable
final class PermissionsContentView extends StatelessWidget {
  const PermissionsContentView({
    required this.notifier,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onRequestPermissions,
    super.key,
  });

  final PermissionsChangeNotifier notifier;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onRequestPermissions;

  @override
  Widget build(BuildContext context) {
    final healthConnector = Provider.of<HealthConnector>(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search field
                SearchTextField(
                  onChanged: onSearchChanged,
                ),
                const SizedBox(height: 24),

                // Data Type Permissions Section
                _buildSectionHeader(
                  context,
                  AppTexts.dataTypePermissions,
                ),
                const SizedBox(height: 16),
                _buildDataTypePermissions(context, healthConnector),
                const SizedBox(height: 32),

                // Feature Permissions Section
                _buildSectionHeader(
                  context,
                  AppTexts.featurePermissions,
                ),
                const SizedBox(height: 16),
                ...HealthPlatformFeature.values.map(
                  (feature) => PermissionListTile(
                    title: Text(feature.displayName),
                    isSelected: notifier.isPermissionSelected(
                      feature.permission,
                    ),
                    permissionStatus: notifier.getPermissionStatus(
                      feature.permission,
                    ),
                    isEnabled:
                        notifier.featureStatuses[feature] ==
                        HealthPlatformFeatureStatus.available,
                    onChanged: (bool value) =>
                        notifier.togglePermissionSelection(
                          feature.permission,
                          isSelected: value,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Enhanced Action Bar
        _PermissionActionBar(
          notifier: notifier,
          onRequestPermissions: onRequestPermissions,
        ),
      ],
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

  /// Builds the data type permissions list based on the platform.
  Widget _buildDataTypePermissions(
    BuildContext context,
    HealthConnector healthConnector,
  ) {
    // Get all permissions for the current platform
    final allPermissions = HealthDataType.values
        .expand(
          (dataType) => dataType.permissions.whereType<HealthDataPermission>(),
        )
        .where(
          (permission) => permission.supportedHealthPlatforms.contains(
            healthConnector.healthPlatform,
          ),
        )
        .toList();

    // Filter permissions based on search query
    final filteredPermissions = _getFilteredPermissions(allPermissions);

    return PermissionList(
      notifier: notifier,
      permissions: filteredPermissions,
    );
  }

  /// Filters permissions based on the search query.
  List<HealthDataPermission> _getFilteredPermissions(
    List<HealthDataPermission> allPermissions,
  ) {
    if (searchQuery.isEmpty) {
      return allPermissions;
    }

    final query = searchQuery.toLowerCase();
    return allPermissions.where((permission) {
      final displayName = permission.displayName.toLowerCase();
      return displayName.contains(query);
    }).toList();
  }
}

/// Permission action bar widget.
///
/// Displays a gradient action bar with a button to request
/// selected permissions.
final class _PermissionActionBar extends StatelessWidget {
  const _PermissionActionBar({
    required this.notifier,
    required this.onRequestPermissions,
  });

  final PermissionsChangeNotifier notifier;
  final VoidCallback onRequestPermissions;

  @override
  Widget build(BuildContext context) {
    return Selector<PermissionsChangeNotifier, int>(
      selector: (_, notifier) => notifier.selectedPermissions.length,
      builder: (context, selectedCount, _) {
        return ElevatedGradientButton(
          onPressed: notifier.isLoading || selectedCount == 0
              ? null
              : onRequestPermissions,
          label: _getButtonText(selectedCount),
        );
      },
    );
  }

  String _getButtonText(int selectedCount) {
    return selectedCount > 0
        ? '${AppTexts.requestPermissions.toUpperCase()} ($selectedCount)'
        : AppTexts.requestPermissions.toUpperCase();
  }
}
