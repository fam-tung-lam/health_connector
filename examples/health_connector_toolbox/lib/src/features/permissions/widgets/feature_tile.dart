import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show HealthPlatformFeature, HealthPlatformFeatureStatus, PermissionStatus;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart';
import 'package:health_connector_toolbox/src/common/utils/health_connector_model_ui_extensions.dart';

/// A tile widget for displaying and selecting a health platform feature
/// permission.
///
/// Shows the feature name, availability status, permission status, and allows
/// selection via checkbox if the feature is available.
@immutable
final class FeatureTile extends StatelessWidget {
  const FeatureTile({
    required this.feature,
    required this.isSelected,
    required this.permissionStatus,
    required this.featureStatus,
    required this.onChanged,
    super.key,
  });

  final HealthPlatformFeature feature;
  final bool isSelected;
  final PermissionStatus? permissionStatus;
  final HealthPlatformFeatureStatus? featureStatus;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final isAvailable = featureStatus == HealthPlatformFeatureStatus.available;
    final isGranted = permissionStatus == PermissionStatus.granted;
    final isDenied = permissionStatus == PermissionStatus.denied;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: isGranted
          ? AppColors.successLight
          : isDenied
          ? AppColors.errorLightBackground
          : isAvailable
          ? AppColors.infoLight
          : AppColors.greyLight,
      child: ListTile(
        leading: isGranted
            ? null
            : Checkbox(
                value: isSelected,
                onChanged: isAvailable ? onChanged : null,
              ),
        title: Text(feature.displayName),
        subtitle: permissionStatus != null
            ? Text(
                '${AppTexts.status} ${permissionStatus!.displayName}',
                style: TextStyle(
                  color: isGranted
                      ? AppColors.successDark
                      : isDenied
                      ? AppColors.errorDark
                      : AppColors.grey700,
                  fontWeight: FontWeight.bold,
                ),
              )
            : featureStatus != null
            ? Text(
                '${AppTexts.feature}: ${featureStatus!.displayName}',
                style: TextStyle(
                  color: isAvailable ? AppColors.infoDark : AppColors.grey700,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
