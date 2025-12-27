import 'dart:collection';
import 'dart:developer' show log;

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector_internal.dart'
    show
        HealthConnectorException,
        HealthPlatformFeature,
        HealthPlatformFeatureStatus,
        Permission,
        PermissionStatus,
        HealthConnector;

/// Loading state for permission operations.
sealed class PermissionLoadingState {
  const PermissionLoadingState();
}

/// No operations in progress.
final class Idle extends PermissionLoadingState {
  const Idle();
}

/// Loading feature statuses on page initialization.
final class LoadingPage extends PermissionLoadingState {
  const LoadingPage();
}

/// Loading during permission request operation.
final class LoadingRequest extends PermissionLoadingState {
  const LoadingRequest();
}

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

  PermissionLoadingState _loadingState = const Idle();
  UnmodifiableListView<Permission> _grantedPermissions = UnmodifiableListView(
    [],
  );
  final Set<Permission> _selectedPermissions = {};
  Map<Permission, PermissionStatus> _permissionResults = {};
  Map<HealthPlatformFeature, HealthPlatformFeatureStatus> _featureStatuses = {};
  String? _errorMessage;

  /// Current loading state.
  PermissionLoadingState get loadingState => _loadingState;

  /// Whether any operation is currently loading.
  bool get isLoading =>
      _loadingState is LoadingRequest || _loadingState is LoadingPage;

  /// Whether the page is loading (feature statuses).
  bool get isPageLoading => _loadingState is LoadingPage;

  /// List of currently granted permissions.
  List<Permission> get grantedPermissions => _grantedPermissions;

  /// Set of permissions selected for batch request.
  Set<Permission> get selectedPermissions => _selectedPermissions;

  /// Unmodifiable view of permission results.
  UnmodifiableMapView<Permission, PermissionStatus> get permissionResults =>
      UnmodifiableMapView(_permissionResults);

  /// Unmodifiable view of feature statuses.
  UnmodifiableMapView<HealthPlatformFeature, HealthPlatformFeatureStatus>
  get featureStatuses => UnmodifiableMapView(_featureStatuses);

  /// Current error message, if any.
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
    _executeAndNotify(() {
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
  /// health platform features. Uses parallel loading for improved performance.
  Future<void> loadFeatureStatuses() async {
    log('Loading feature statuses');
    _executeAndNotify(() {
      _loadingState = const LoadingPage();
      _errorMessage = null;
    });

    try {
      // Load all feature statuses in parallel for better performance
      final featureStatusFutures = HealthPlatformFeature.values.map(
        (feature) async => MapEntry(
          feature,
          await _healthConnector.getFeatureStatus(feature),
        ),
      );

      final statuses = Map.fromEntries(await Future.wait(featureStatusFutures));

      _executeAndNotify(() {
        _featureStatuses = statuses;
        _loadingState = const Idle();
      });

      log('Loaded ${statuses.length} feature statuses');
    } on HealthConnectorException catch (e, stackTrace) {
      log('Failed to load feature statuses', error: e, stackTrace: stackTrace);
      _executeAndNotify(() {
        _errorMessage = 'Failed to load feature statuses: ${e.message}';
        _loadingState = const Idle();
      });
    } on Exception catch (e, stackTrace) {
      log('Error loading feature statuses', error: e, stackTrace: stackTrace);
      _executeAndNotify(() {
        _errorMessage = 'Error: $e';
        _loadingState = const Idle();
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

    log('Requesting ${permissions.length} permissions');
    _executeAndNotify(() {
      _loadingState = const LoadingRequest();
      _errorMessage = null;
    });

    try {
      final results = await _healthConnector.requestPermissions(permissions);
      log('Received ${results.length} permission results');

      final resultsMap = <Permission, PermissionStatus>{};
      for (final result in results) {
        resultsMap[result.permission] = result.status;
      }

      _executeAndNotify(() {
        _permissionResults = {..._permissionResults, ...resultsMap};
        _selectedPermissions.clear();
        _loadingState = const Idle();
      });
    } on HealthConnectorException catch (e, stackTrace) {
      log('Failed to request permissions', error: e, stackTrace: stackTrace);
      _executeAndNotify(() {
        _errorMessage = 'Failed to request permissions: ${e.message}';
        _loadingState = const Idle();
      });
    } on Exception catch (e, stackTrace) {
      log('Error requesting permissions', error: e, stackTrace: stackTrace);
      _executeAndNotify(() {
        _errorMessage = 'Error: $e';
        _loadingState = const Idle();
      });
    }
  }

  /// Retrieves all currently granted permissions from the health platform.
  ///
  /// Updates [grantedPermissions] with the list of granted permissions.
  Future<void> getGrantedPermissions() async {
    log('Getting granted permissions');
    _executeAndNotify(() {
      _loadingState = const LoadingRequest();
      _errorMessage = null;
    });

    try {
      final grantedPermissions = await _healthConnector.getGrantedPermissions();
      log('Retrieved ${grantedPermissions.length} granted permissions');

      _executeAndNotify(() {
        _grantedPermissions = UnmodifiableListView(grantedPermissions);
        _loadingState = const Idle();
      });
    } on HealthConnectorException catch (e, stackTrace) {
      log(
        'Failed to get granted permissions',
        error: e,
        stackTrace: stackTrace,
      );
      _executeAndNotify(() {
        _errorMessage = 'Failed to get granted permissions: ${e.message}';
        _loadingState = const Idle();
      });
    } on Exception catch (e, stackTrace) {
      log(
        'Error getting granted permissions',
        error: e,
        stackTrace: stackTrace,
      );
      _executeAndNotify(() {
        _errorMessage = 'Error: $e';
        _loadingState = const Idle();
      });
    }
  }

  /// Revokes all permissions granted to this app.
  ///
  /// Clears [grantedPermissions] on success.
  Future<void> revokeAllPermissions() async {
    log('Revoking all permissions');
    _executeAndNotify(() {
      _loadingState = const LoadingRequest();
      _errorMessage = null;
    });

    try {
      await _healthConnector.revokeAllPermissions();
      log('Successfully revoked all permissions');

      _executeAndNotify(() {
        _grantedPermissions = UnmodifiableListView([]);
        _loadingState = const Idle();
      });
    } on HealthConnectorException catch (e, stackTrace) {
      log('Failed to revoke permissions', error: e, stackTrace: stackTrace);
      _executeAndNotify(() {
        _errorMessage = 'Failed to revoke permissions: ${e.message}';
        _loadingState = const Idle();
      });
    } on Exception catch (e, stackTrace) {
      log('Error revoking permissions', error: e, stackTrace: stackTrace);
      _executeAndNotify(() {
        _errorMessage = 'Error: $e';
        _loadingState = const Idle();
      });
    }
  }

  /// Executes an action and notifies listeners.
  ///
  /// This helper ensures state updates are always followed by listener
  /// notification, maintaining consistency across the notifier.
  void _executeAndNotify(void Function() action) {
    action();
    notifyListeners();
  }
}
