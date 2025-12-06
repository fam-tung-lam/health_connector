import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart'
    show Permission, PermissionStatus;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart';
import 'package:health_connector_toolbox/src/common/utils/health_connector_model_ui_extensions.dart';

/// A tile widget for displaying and selecting a single permission.
///
/// Shows the permission name, current status (granted/denied/unknown), and
/// allows selection via checkbox for batch permission requests.
@immutable
final class PermissionTile extends StatelessWidget {
  const PermissionTile({
    required this.permission,
    required this.displayName,
    required this.isSelected,
    required this.permissionStatus,
    required this.onChanged,
    super.key,
  });

  final Permission permission;
  final String displayName;
  final bool isSelected;
  final PermissionStatus? permissionStatus;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final isGranted = permissionStatus == PermissionStatus.granted;
    final isDenied = permissionStatus == PermissionStatus.denied;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: isGranted
          ? AppColors.successLight
          : isDenied
          ? AppColors.errorLightBackground
          : null,
      child: ListTile(
        leading: isGranted
            ? null
            : Checkbox(
                value: isSelected,
                onChanged: (value) => onChanged(value ?? false),
              ),
        title: Text(displayName),
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
            : const Text(AppTexts.notRequested),
      ),
    );
  }
}
