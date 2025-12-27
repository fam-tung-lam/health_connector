import 'package:flutter/widgets.dart';
import 'package:health_connector/health_connector_internal.dart'
    show HealthDataPermission;
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/features/permissions/permissions_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/permissions/widgets/permission_list_tile.dart';

/// Widget that displays Apple Health permissions as a flat list.
///
/// For Apple Health (iOS), all permissions are displayed as individual
/// tiles in a flat list structure.
@immutable
final class PermissionList extends StatelessWidget {
  const PermissionList({
    required this.notifier,
    required this.permissions,
    super.key,
  });

  /// The notifier that manages permission state.
  final PermissionsChangeNotifier notifier;

  /// The filtered list of permissions to display.
  final List<HealthDataPermission> permissions;

  @override
  Widget build(BuildContext context) {
    // Sort permissions alphabetically by display name
    final sortedPermissions = permissions.toList()
      ..sort((a, b) => a.displayName.compareTo(b.displayName));

    return Column(
      children: sortedPermissions.map((permission) {
        return PermissionListTile(
          title: Text(permission.displayName),
          isSelected: notifier.isPermissionSelected(permission),
          permissionStatus: notifier.getPermissionStatus(permission),
          onChanged: (bool value) => notifier.togglePermissionSelection(
            permission,
            isSelected: value,
          ),
        );
      }).toList(),
    );
  }
}
