import 'dart:collection';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector.dart'
    show
        HealthConnectorException,
        HealthPlatformFeature,
        HealthPlatformFeatureStatus,
        Permission,
        PermissionStatus,
        HealthConnector;

/// Manages permission-related state and operations for the permissions page.
///
/// Handles requesting permissions, checking granted permissions, revoking
/// permissions, and tracking feature statuses. Also manages the selection
/// state of permissions for batch requests.
final class PermissionsChangeNotifier extends ChangeNotifier {
  final HealthConnector _healthConnector;

  PermissionsChangeNotifier(this._healthConnector) {
    loadFeatureStatuses();
  }

  bool _isLoading = false;
  bool _isPageLoading = false;
  UnmodifiableListView<Permission> _grantedPermissions = UnmodifiableListView(
    [],
  );
  final Set<Permission> _selectedPermissions = {};
  Map<Permission, PermissionStatus> _permissionResults = {};
  Map<HealthPlatformFeature, HealthPlatformFeatureStatus> _featureStatuses = {};
  Exception? _error;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  bool get isPageLoading => _isPageLoading;

  List<Permission> get grantedPermissions => _grantedPermissions;

  Set<Permission> get selectedPermissions => _selectedPermissions;

  Map<Permission, PermissionStatus> get permissionResults => _permissionResults;

  Map<HealthPlatformFeature, HealthPlatformFeatureStatus> get featureStatuses =>
      _featureStatuses;

  Exception? get error => _error;

  String? get errorMessage => _errorMessage;

  /// Checks if a permission is in the selected set.
  bool isPermissionSelected(Permission permission) {
    return _selectedPermissions.contains(permission);
  }

  /// Adds or removes a permission from the selected set.
  void togglePermissionSelection(
    Permission permission, {
    required bool isSelected,
  }) {
    notify(() {
      if (isSelected) {
        _selectedPermissions.add(permission);
      } else {
        _selectedPermissions.remove(permission);
      }
    });
  }

  /// Gets the permission result for a permission.
  PermissionStatus? getPermissionStatus(Permission permission) {
    return _permissionResults[permission];
  }

  /// Loads the availability status of health platform features.
  ///
  /// Updates [featureStatuses] with the current status of all available
  /// health platform features.
  Future<void> loadFeatureStatuses() async {
    notify(() {
      _isPageLoading = true;
      _errorMessage = null;
    });

    try {
      final statuses = <HealthPlatformFeature, HealthPlatformFeatureStatus>{};
      for (final feature in HealthPlatformFeature.values) {
        statuses[feature] = await _healthConnector.getFeatureStatus(feature);
      }

      notify(() {
        _featureStatuses = statuses;
        _isPageLoading = false;
      });
    } on HealthConnectorException catch (e) {
      notify(() {
        _errorMessage = 'Failed to load feature statuses: ${e.message}';
        _isPageLoading = false;
      });
    } on Exception catch (e) {
      notify(() {
        _errorMessage = 'Error: $e';
        _isPageLoading = false;
      });
    }
  }

  /// Requests the specified permissions from the health platform.
  ///
  /// Updates [permissionResults] with the status of each requested permission
  /// and clears [selectedPermissions] on completion.
  Future<void> requestPermissions(List<Permission> permissions) async {
    if (permissions.isEmpty) {
      return;
    }

    notify(() {
      _isLoading = true;
    });

    try {
      final results = await _healthConnector.requestPermissions(permissions);

      final resultsMap = <Permission, PermissionStatus>{};
      for (final result in results) {
        resultsMap[result.permission] = result.status;
      }

      notify(() {
        _permissionResults = {..._permissionResults, ...resultsMap};
        _selectedPermissions.clear();
      });
    } on HealthConnectorException catch (e) {
      _error = e;
    } on Exception catch (e) {
      _error = Exception('Error: $e');
    } finally {
      notify(() {
        _isLoading = false;
      });
    }
  }

  /// Retrieves all currently granted permissions from the health platform.
  ///
  /// Updates [grantedPermissions] with the list of granted permissions.
  Future<void> getGrantedPermissions() async {
    notify(() {
      _isLoading = true;
    });

    try {
      final grantedPermissions = await _healthConnector.getGrantedPermissions();
      notify(() {
        _grantedPermissions = UnmodifiableListView(grantedPermissions);
      });
    } on HealthConnectorException catch (e) {
      _error = e;
    } on Exception catch (e) {
      _error = Exception('Error: $e');
    } finally {
      notify(() {
        _isLoading = false;
      });
    }
  }

  /// Revokes all permissions granted to this app.
  ///
  /// Clears [grantedPermissions] on success.
  Future<void> revokeAllPermissions() async {
    notify(() {
      _isLoading = true;
    });

    try {
      await _healthConnector.revokeAllPermissions();
      notify(() {
        _grantedPermissions = UnmodifiableListView([]);
      });
    } on HealthConnectorException catch (e) {
      _error = e;
    } on Exception catch (e) {
      _error = Exception('Error: $e');
    } finally {
      notify(() {
        _isLoading = false;
      });
    }
  }

  void notify(void Function() fn) {
    fn();
    notifyListeners();
  }
}
