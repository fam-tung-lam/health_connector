import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show HealthDataPermission, HealthDataType, PermissionStatus;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/theme/app_colors.dart';
import 'package:health_connector_toolbox/src/common/utils/health_connector_model_ui_extensions.dart';

/// An expandable tile widget for displaying nutrition permission with
/// a list of all nutrient data types.
///
/// Shows the nutrition permission as the main tile, and when expanded,
/// displays all nutrient data type permissions as nested items.
@immutable
final class ExpandableNutritionPermissionTile extends StatefulWidget {
  const ExpandableNutritionPermissionTile({
    required this.nutritionPermissions,
    required this.nutrientDataTypes,
    required this.isSelected,
    required this.permissionStatus,
    required this.onChanged,
    super.key,
  });

  final List<HealthDataPermission> nutritionPermissions;
  final List<HealthDataType> nutrientDataTypes;
  final bool isSelected;
  final PermissionStatus? permissionStatus;
  final ValueChanged<bool> onChanged;

  @override
  State<ExpandableNutritionPermissionTile> createState() =>
      _ExpandableNutritionPermissionTileState();
}

final class _ExpandableNutritionPermissionTileState
    extends State<ExpandableNutritionPermissionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isGranted = widget.permissionStatus == PermissionStatus.granted;
    final isDenied = widget.permissionStatus == PermissionStatus.denied;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: isGranted
          ? AppColors.successLight
          : isDenied
          ? AppColors.errorLightBackground
          : null,
      child: ExpansionTile(
        leading: isGranted
            ? null
            : Checkbox(
                value: widget.isSelected,
                onChanged: (value) => widget.onChanged(value ?? false),
              ),
        title: Text(
          widget.nutritionPermissions.first.displayName,
        ),
        subtitle: widget.permissionStatus != null
            ? Text(
                '${AppTexts.status} ${widget.permissionStatus!.displayName}',
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
        trailing: Icon(
          _isExpanded ? Icons.expand_less : AppIcons.expandMore,
          color: AppColors.grey,
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.nutrientDataTypes.map(
                  (dataType) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Row(
                      children: [
                        const Icon(
                          AppIcons.ring,
                          size: 6,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            dataType.displayName,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.grey700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
