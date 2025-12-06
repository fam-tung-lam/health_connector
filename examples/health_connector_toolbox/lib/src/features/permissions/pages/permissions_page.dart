import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show
        HealthConnectorErrorCode,
        HealthConnectorException,
        HealthDataPermission,
        HealthDataType,
        HealthPlatform,
        HealthPlatformFeature,
        PermissionStatus,
        HealthConnector;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart';
import 'package:health_connector_toolbox/src/common/utils/health_connector_model_ui_extensions.dart';
import 'package:health_connector_toolbox/src/common/utils/show_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_indicator.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/permissions/permissions_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/permissions/widgets/expandable_nutrition_permission_tile.dart';
import 'package:health_connector_toolbox/src/features/permissions/widgets/feature_tile.dart';
import 'package:health_connector_toolbox/src/features/permissions/widgets/permission_tile.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, Provider, Selector;

/// Page for managing health data permissions.
///
/// Dynamically displays all available data type permissions (read/write for
/// all health data types) and feature permissions (all platform features).
/// Allows users to select and request multiple permissions at once.
@immutable
final class PermissionsPage extends StatelessWidget {
  const PermissionsPage({required this.healthPlatform, super.key});

  final HealthPlatform healthPlatform;

  /// Checks if a health data type is a nutrient type (excluding nutrition).
  static bool _isNutrientDataType(HealthDataType dataType) {
    return dataType == HealthDataType.energyNutrient ||
        dataType == HealthDataType.caffeine ||
        dataType == HealthDataType.protein ||
        dataType == HealthDataType.totalCarbohydrate ||
        dataType == HealthDataType.totalFat ||
        dataType == HealthDataType.saturatedFat ||
        dataType == HealthDataType.monounsaturatedFat ||
        dataType == HealthDataType.polyunsaturatedFat ||
        dataType == HealthDataType.cholesterol ||
        dataType == HealthDataType.dietaryFiber ||
        dataType == HealthDataType.sugar ||
        dataType == HealthDataType.calcium ||
        dataType == HealthDataType.iron ||
        dataType == HealthDataType.magnesium ||
        dataType == HealthDataType.manganese ||
        dataType == HealthDataType.phosphorus ||
        dataType == HealthDataType.potassium ||
        dataType == HealthDataType.selenium ||
        dataType == HealthDataType.sodium ||
        dataType == HealthDataType.zinc ||
        dataType == HealthDataType.vitaminA ||
        dataType == HealthDataType.vitaminB6 ||
        dataType == HealthDataType.vitaminB12 ||
        dataType == HealthDataType.vitaminC ||
        dataType == HealthDataType.vitaminD ||
        dataType == HealthDataType.vitaminE ||
        dataType == HealthDataType.vitaminK ||
        dataType == HealthDataType.thiamin ||
        dataType == HealthDataType.riboflavin ||
        dataType == HealthDataType.niacin ||
        dataType == HealthDataType.folate ||
        dataType == HealthDataType.biotin ||
        dataType == HealthDataType.pantothenicAcid;
  }

  /// Checks if a health data type is the nutrition type.
  static bool _isNutritionDataType(HealthDataType dataType) {
    return dataType == HealthDataType.nutrition;
  }

  /// Gets all nutrient data types (excluding nutrition).
  static List<HealthDataType> _getNutrientDataTypes() {
    return [
      HealthDataType.energyNutrient,
      HealthDataType.caffeine,
      HealthDataType.protein,
      HealthDataType.totalCarbohydrate,
      HealthDataType.totalFat,
      HealthDataType.saturatedFat,
      HealthDataType.monounsaturatedFat,
      HealthDataType.polyunsaturatedFat,
      HealthDataType.cholesterol,
      HealthDataType.dietaryFiber,
      HealthDataType.sugar,
      HealthDataType.calcium,
      HealthDataType.iron,
      HealthDataType.magnesium,
      HealthDataType.manganese,
      HealthDataType.phosphorus,
      HealthDataType.potassium,
      HealthDataType.selenium,
      HealthDataType.sodium,
      HealthDataType.zinc,
      HealthDataType.vitaminA,
      HealthDataType.vitaminB6,
      HealthDataType.vitaminB12,
      HealthDataType.vitaminC,
      HealthDataType.vitaminD,
      HealthDataType.vitaminE,
      HealthDataType.vitaminK,
      HealthDataType.thiamin,
      HealthDataType.riboflavin,
      HealthDataType.niacin,
      HealthDataType.folate,
      HealthDataType.biotin,
      HealthDataType.pantothenicAcid,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PermissionsChangeNotifier(
        Provider.of<HealthConnector>(context),
      ),
      child: Selector<PermissionsChangeNotifier, bool>(
        selector: (_, notifier) => notifier.isPageLoading,
        builder: (context, isPageLoading, _) {
          final notifier = Provider.of<PermissionsChangeNotifier>(context);
          return LoadingOverlay(
            isLoading: notifier.isLoading,
            message: AppTexts.requestSelectedPermissions,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(AppTexts.requestPermissionsTitle),
              ),
              body: isPageLoading
                  ? const LoadingIndicator()
                  : notifier.errorMessage != null
                  ? _buildErrorView(context, notifier)
                  : _buildPermissionsView(context, notifier),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorView(
    BuildContext context,
    PermissionsChangeNotifier notifier,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              AppIcons.errorOutline,
              size: 64,
              color: AppColors.errorLight,
            ),
            const SizedBox(height: 16),
            Text(
              notifier.errorMessage ?? AppTexts.failedToLoadFeatureStatuses,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.errorDark),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => notifier.loadFeatureStatuses(),
              icon: const Icon(AppIcons.refresh),
              label: const Text(AppTexts.retry),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDataTypePermissions(
    BuildContext context,
    PermissionsChangeNotifier notifier,
  ) {
    switch (healthPlatform) {
      case HealthPlatform.healthConnect:
        // For HealthConnect: show only nutrition with expandable nutrient list
        final nutritionPermissions = HealthDataType.nutrition.permissions
            .whereType<HealthDataPermission>()
            .where(
              (permission) => permission.supportedHealthPlatforms.contains(
                healthPlatform,
              ),
            )
            .toList();

        if (nutritionPermissions.isEmpty) {
          return [];
        }

        final nutrientDataTypes = _getNutrientDataTypes();

        return [
          // Create an expandable tile for each nutrition permission (read/write)
          ...nutritionPermissions.map(
            (nutritionPermission) => ExpandableNutritionPermissionTile(
              nutritionPermissions: [nutritionPermission],
              nutrientDataTypes: nutrientDataTypes,
              isSelected: notifier.isPermissionSelected(nutritionPermission),
              permissionStatus: notifier.getPermissionStatus(
                nutritionPermission,
              ),
              onChanged: (value) => notifier.togglePermissionSelection(
                nutritionPermission,
                isSelected: value,
              ),
            ),
          ),
          // Show all other data types (excluding nutrients and nutrition)
          ...HealthDataType.values
              .where(
                (dataType) =>
                    !_isNutrientDataType(dataType) &&
                    !_isNutritionDataType(dataType),
              )
              .expand(
                (dataType) =>
                    dataType.permissions.whereType<HealthDataPermission>().map(
                      (permission) => PermissionTile(
                        permission: permission,
                        displayName: permission.displayName,
                        isSelected: notifier.isPermissionSelected(permission),
                        permissionStatus: notifier.getPermissionStatus(
                          permission,
                        ),
                        onChanged: (value) =>
                            notifier.togglePermissionSelection(
                              permission,
                              isSelected: value,
                            ),
                      ),
                    ),
              )
              .where(
                (p) => p.permission.supportedHealthPlatforms.contains(
                  healthPlatform,
                ),
              ),
        ];
      case HealthPlatform.appleHealth:
        // For Apple Health: show all
        return HealthDataType.values
            .expand(
              (dataType) =>
                  dataType.permissions.whereType<HealthDataPermission>().map(
                    (permission) => PermissionTile(
                      permission: permission,
                      displayName: permission.displayName,
                      isSelected: notifier.isPermissionSelected(permission),
                      permissionStatus: notifier.getPermissionStatus(
                        permission,
                      ),
                      onChanged: (value) => notifier.togglePermissionSelection(
                        permission,
                        isSelected: value,
                      ),
                    ),
                  ),
            )
            .where(
              (p) => p.permission.supportedHealthPlatforms.contains(
                healthPlatform,
              ),
            )
            .toList();
    }
  }

  Widget _buildPermissionsView(
    BuildContext context,
    PermissionsChangeNotifier notifier,
  ) {
    final healthConnector = Provider.of<HealthConnector>(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (healthConnector.healthPlatform ==
                    HealthPlatform.appleHealth)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.amberLight,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.amberBorder),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          AppIcons.infoOutline,
                          color: AppColors.amber700,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            AppTexts.iosReadPermissionUnknownStatusNote,
                            style: TextStyle(
                              color: AppColors.amber900,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Text(
                  AppTexts.dataTypePermissions,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._buildDataTypePermissions(context, notifier),
                const SizedBox(height: 24),
                Text(
                  AppTexts.featurePermissions,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...HealthPlatformFeature.values.map(
                  (feature) => FeatureTile(
                    feature: feature,
                    isSelected: notifier.isPermissionSelected(
                      feature.permission,
                    ),
                    permissionStatus: notifier.getPermissionStatus(
                      feature.permission,
                    ),
                    featureStatus: notifier.featureStatuses[feature],
                    onChanged: (value) => notifier.togglePermissionSelection(
                      feature.permission,
                      isSelected: value ?? false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Selector<PermissionsChangeNotifier, int>(
              selector: (_, notifier) => notifier.selectedPermissions.length,
              builder: (context, selectedCount, _) {
                final notifier = Provider.of<PermissionsChangeNotifier>(
                  context,
                );
                return ElevatedButton(
                  onPressed: notifier.isLoading || selectedCount == 0
                      ? null
                      : () => _requestPermissions(context, notifier),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(
                    '${AppTexts.requestSelectedPermissions} ($selectedCount)',
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _requestPermissions(
    BuildContext context,
    PermissionsChangeNotifier notifier,
  ) async {
    if (notifier.selectedPermissions.isEmpty) {
      showAppSnackBar(
        context,
        SnackBarType.warning,
        AppTexts.pleaseSelectAtLeastOnePermission,
      );
      return;
    }

    try {
      await notifier.requestPermissions(notifier.selectedPermissions.toList());

      if (!context.mounted) {
        return;
      }

      final grantedCount = notifier.permissionResults.values
          .where((status) => status == PermissionStatus.granted)
          .length;
      final deniedCount = notifier.permissionResults.values
          .where((status) => status == PermissionStatus.denied)
          .length;

      showAppSnackBar(
        context,
        grantedCount > 0 ? SnackBarType.success : SnackBarType.warning,
        '${AppTexts.requestCompleted} $grantedCount '
        '${AppTexts.granted}, $deniedCount ${AppTexts.denied}',
      );
    } on HealthConnectorException catch (e) {
      if (!context.mounted) {
        return;
      }
      final message =
          e.code == HealthConnectorErrorCode.unsupportedHealthPlatformApi
          ? '${AppTexts.failedToRequestPermissions} ${e.message}'
          : e.message;
      showAppSnackBar(context, SnackBarType.error, message);
    } on Exception catch (e) {
      if (!context.mounted) {
        return;
      }
      showAppSnackBar(
        context,
        SnackBarType.error,
        '${AppTexts.errorPrefixColon} $e',
      );
    }
  }
}
