import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Connector Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExampleAppHomePage(),
    );
  }
}

/// Example app demonstrating all public API methods of HealthConnector.
///
/// This page provides buttons to test each method with clear explanations
/// and error handling.
class ExampleAppHomePage extends StatefulWidget {
  const ExampleAppHomePage({super.key});

  @override
  State<ExampleAppHomePage> createState() => _ExampleAppHomePageState();
}

class _ExampleAppHomePageState extends State<ExampleAppHomePage> {
  // Instance of HealthConnector to use for all API calls
  HealthConnector? _connector;

  // Loading state to show overlay during async operations
  bool _isPageLoading = false;
  bool _isLoading = false;

  // Track the current health platform
  HealthPlatform? _healthPlatform;

  @override
  void initState() {
    super.initState();
    _initializeConnector();
  }

  /// Initializes the HealthConnector instance.
  ///
  /// First checks platform status, then creates the connector instance.
  Future<void> _initializeConnector() async {
    setState(() {
      _isPageLoading = true;
    });

    try {
      final connector = await HealthConnector.create();

      if (!mounted) {
        return;
      }

      setState(() {
        _connector = connector;
        _healthPlatform = connector.healthPlatform;
      });

      _showSuccess(
        '${_healthPlatform!.name} is ready',
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to initialize: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isPageLoading = false;
        });
      }
    }
  }

  /// Shows a snack bar with the given message and color.
  void _showSnackBar(String message, Color backgroundColor) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Shows a success message.
  void _showSuccess(String message) {
    _showSnackBar(message, Colors.green);
  }

  /// Shows an error message.
  void _showError(String message) {
    _showSnackBar(message, Colors.red);
  }

  /// Shows an info message.
  void _showInfo(String message) {
    _showSnackBar(message, Colors.blue);
  }

  /// Demonstrates [HealthConnector.requestPermissions] method.
  ///
  /// Requests both health data permissions (read/write for steps) and
  /// feature permissions (background reading, history access).
  Future<void> _requestPermissions() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Build a list of permissions to request
      final permissions = [
        // Request health data read and write permissions
        HealthDataType.steps.readPermission,
        HealthDataType.steps.writePermission,
        HealthDataType.weight.readPermission,
        HealthDataType.weight.writePermission,
        // ...

        // Request feature permissions (only supported on Health Connect)
        if (_healthPlatform == HealthPlatform.healthConnect) ...[
          HealthPlatformFeature.readHealthDataInBackground.permission,
          HealthPlatformFeature.readHealthDataHistory.permission,
          // ...
        ],
      ];

      final results = await _connector!.requestPermissions(permissions);

      // Count permissions by status
      final grantedCount = results
          .where((r) => r.status == PermissionStatus.granted)
          .length;
      final deniedCount = results
          .where((r) => r.status == PermissionStatus.denied)
          .length;
      final unknownCount = results
          .where((r) => r.status == PermissionStatus.unknown)
          .length;

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Permission request completed: $grantedCount granted, '
        '$deniedCount denied, $unknownCount unknown',
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to request permissions: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.getGrantedPermissions] method.
  ///
  /// Retrieves all permissions that are currently granted to the app.
  /// This is useful for checking which data types the app has access to
  /// without prompting the user.
  ///
  /// **Note:** This method is only available on Health Connect.
  Future<void> _getGrantedPermissions() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final grantedPermissions = await _connector!.getGrantedPermissions();

      // Count permissions by type
      final dataTypePermissions = grantedPermissions
          .whereType<HealthDataPermission>()
          .length;
      final featurePermissions = grantedPermissions
          .whereType<HealthPlatformFeaturePermission>()
          .length;

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Found ${grantedPermissions.length} granted permissions: '
        '$dataTypePermissions data type(s), $featurePermissions feature(s)',
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      if (e.code == HealthConnectorErrorCode.unsupportedOperation) {
        _showError(
          'getGrantedPermissions is only available on Health Connect. '
          'HealthKit does not allow querying granted permissions.',
        );
      } else {
        _showError('Failed to get granted permissions: ${e.message}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.revokeAllPermissions] method.
  ///
  /// Revokes all health data permissions that were previously granted.
  /// After calling this, the app will need to request permissions again.
  ///
  /// **Note:** This method is only available on Health Connect.
  Future<void> _revokeAllPermissions() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _connector!.revokeAllPermissions();

      if (!mounted) {
        return;
      }
      _showSuccess('All permissions have been revoked');
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      if (e.code == HealthConnectorErrorCode.unsupportedOperation) {
        _showError(
          'revokeAllPermissions is only available on Health Connect. '
          'On iOS, users must revoke permissions manually in Settings.',
        );
      } else {
        _showError('Failed to revoke permissions: ${e.message}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.getFeatureStatus] method.
  ///
  /// Checks the status of all available platform features to see which
  /// ones are available, unavailable, or require an update.
  Future<void> _getFeatureStatus() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final results = <String>[];

      // Check status for each available feature
      for (final feature in HealthPlatformFeature.values) {
        final status = await _connector!.getFeatureStatus(feature);
        results.add('$feature: ${status.name}');
      }

      if (!mounted) {
        return;
      }
      _showInfo('Feature Status:\n${results.join('\n')}');
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to get feature status: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.readRecord] method.
  ///
  /// Reads a single health record by its ID. First, we read some records
  /// to get an actual record ID, then read that specific record.
  Future<void> _readRecord() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // First, read some records to get an actual record ID
      final now = DateTime.now();
      final readRecordsRequest = HealthDataType.steps.readInTimeRange(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
        pageSize: 1,
      );

      final recordsResponse = await _connector!.readRecords(readRecordsRequest);

      if (recordsResponse.records.isEmpty) {
        if (!mounted) {
          return;
        }
        _showInfo(
          'No records found. Please write some records first using '
          'the "Write Record" button.',
        );
        return;
      }

      // Read the first record by ID
      final recordId = recordsResponse.records.first.id;
      final readRecordRequest = HealthDataType.steps.readById(recordId);
      final record = await _connector!.readRecord(readRecordRequest);

      if (!mounted) {
        return;
      }
      if (record != null) {
        _showSuccess(
          'Read record: ${record.count.value} steps from '
          '${record.startTime} to ${record.endTime}',
        );
      } else {
        _showInfo('Record not found');
      }
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to read record: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.readRecords] method.
  ///
  /// Reads multiple health records within a time range with pagination support.
  /// This is useful for querying historical data.
  Future<void> _readRecords() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();
      final request = HealthDataType.steps.readInTimeRange(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
        pageSize: 10,
      );

      final response = await _connector!.readRecords(request);

      final message = response.records.isEmpty
          ? 'No records found in the last 7 days'
          : 'Found ${response.records.length} record(s)'
                '${response.hasMorePages ? ' (more available)' : ''}';

      if (!mounted) {
        return;
      }
      _showSuccess(message);
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to read records: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.writeRecord] method.
  ///
  /// Writes a single health record to the health platform. The platform will
  /// assign a unique ID to the record.
  Future<void> _writeRecord() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();

      // Create a step record with sample data
      final record = StepsRecord(
        startTime: now.subtract(const Duration(hours: 1)),
        endTime: now,
        count: const Number(1000),
        metadata: Metadata.automaticallyRecorded(
          dataOrigin: const DataOrigin('com.example.health_connector'),
          device: const Device.fromType(DeviceType.phone),
        ),
      );

      final recordId = await _connector!.writeRecord(record);

      if (!mounted) {
        return;
      }
      _showSuccess('Successfully wrote record with ID: ${recordId.value}');
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to write record: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.writeRecords] method.
  ///
  /// Writes multiple health records in a single operation. This is more
  /// efficient than writing records one by one.
  Future<void> _writeRecords() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();

      // Create multiple step records with sample data
      final records = [
        StepsRecord(
          startTime: now.subtract(const Duration(hours: 3)),
          endTime: now.subtract(const Duration(hours: 2)),
          count: const Number(1500),
          metadata: Metadata.automaticallyRecorded(
            dataOrigin: const DataOrigin('com.example.health_connector'),
            device: const Device.fromType(DeviceType.watch),
          ),
        ),
        StepsRecord(
          startTime: now.subtract(const Duration(hours: 2)),
          endTime: now.subtract(const Duration(hours: 1)),
          count: const Number(2000),
          metadata: Metadata.automaticallyRecorded(
            dataOrigin: const DataOrigin('com.example.health_connector'),
            device: const Device.fromType(DeviceType.watch),
          ),
        ),
        StepsRecord(
          startTime: now.subtract(const Duration(hours: 1)),
          endTime: now,
          count: const Number(1800),
          metadata: Metadata.automaticallyRecorded(
            dataOrigin: const DataOrigin('com.example.health_connector'),
            device: const Device.fromType(DeviceType.phone),
          ),
        ),
      ];

      final recordIds = await _connector!.writeRecords(records);

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Successfully wrote ${recordIds.length} record(s)',
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to write records: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.updateRecord] method.
  ///
  /// Updates an existing health record. First, we read a record, then
  /// update it with new values.
  Future<void> _updateRecord() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // First, read some records to get an actual record ID
      final now = DateTime.now();
      final readRecordsRequest = HealthDataType.steps.readInTimeRange(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
        pageSize: 1,
      );

      final recordsResponse = await _connector!.readRecords(readRecordsRequest);

      if (recordsResponse.records.isEmpty) {
        if (!mounted) {
          return;
        }
        _showInfo(
          'No records found to update. Please write some records first '
          'using the "Write Record" button.',
        );
        return;
      }

      // Get the first record and update it
      final existingRecord = recordsResponse.records.first;
      final updatedRecord = StepsRecord(
        id: existingRecord.id,
        startTime: existingRecord.startTime,
        endTime: existingRecord.endTime,
        count: Number(existingRecord.count.value + 100),
        // Add 100 steps
        metadata: existingRecord.metadata,
      );

      await _connector!.updateRecord(updatedRecord);

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Successfully updated record with ID: ${updatedRecord.id.value}',
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to update record: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.aggregate] method.
  ///
  /// Aggregates health data over a time range. For steps, we can calculate
  /// the sum of all steps in the specified time period.
  Future<void> _aggregate() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();

      // Create an aggregate request to sum all steps in the last 7 days
      final request = HealthDataType.steps.aggregateSum(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
      );

      final aggregationResult = await _connector!.aggregate(request);

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Total steps in last 7 days: ${aggregationResult.value}',
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to aggregate data: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.deleteRecords] method.
  ///
  /// Deletes all health records of a specific type within a time range.
  /// Use with caution as this operation cannot be undone.
  Future<void> _deleteRecords() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();
      final request = HealthDataType.steps.deleteInTimeRange(
        startTime: now.subtract(const Duration(hours: 1)),
        endTime: now,
      );

      await _connector!.deleteRecords(request);

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Successfully deleted step records from the last hour',
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to delete records: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.deleteRecords] method.
  ///
  /// Deletes specific health records by their IDs. First, we read some
  /// records to get their IDs, then delete those specific records.
  Future<void> _deleteRecordsByIds() async {
    if (_connector == null) {
      _showError('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // First, read some records to get IDs
      final now = DateTime.now();
      final readRequest = HealthDataType.steps.readInTimeRange(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
        pageSize: 5,
      );

      final response = await _connector!.readRecords(readRequest);

      if (response.records.isEmpty) {
        if (!mounted) {
          return;
        }
        _showInfo('No records found to delete');
        return;
      }

      // Get IDs of the records to delete
      final recordIds = response.records.map((r) => r.id).toList();
      final request = HealthDataType.steps.deleteByIds(recordIds);

      await _connector!.deleteRecords(request);

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Successfully deleted ${recordIds.length} record(s)',
      );
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _showError('Failed to delete records: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final platformName = _healthPlatform == HealthPlatform.appleHealth
        ? 'HealthKit'
        : _healthPlatform == HealthPlatform.healthConnect
        ? 'Health Connect'
        : 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('Health Connector Example ($platformName)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _LoadingOverlay(
        isLoading: _isPageLoading,
        message: 'Initializing...',
        child: Stack(
          children: [
            // Main content with scrollable list of buttons
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Permissions
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _requestPermissions,
                    icon: const Icon(Icons.lock_open),
                    label: const Text('Request Permissions'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Only show these buttons on Health Connect
                  if (_healthPlatform == HealthPlatform.healthConnect) ...[
                    ElevatedButton.icon(
                      onPressed: _isLoading || _connector == null
                          ? null
                          : _getGrantedPermissions,
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Get Granted Permissions'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _isLoading || _connector == null
                          ? null
                          : _revokeAllPermissions,
                      icon: const Icon(Icons.lock),
                      label: const Text('Revoke All Permissions'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Features
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _getFeatureStatus,
                    icon: const Icon(Icons.featured_play_list),
                    label: const Text('Get Feature Status'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Reading Records
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _readRecord,
                    icon: const Icon(Icons.read_more),
                    label: const Text('Read Record'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _readRecords,
                    icon: const Icon(Icons.list),
                    label: const Text('Read Records'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Writing Records
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _writeRecord,
                    icon: const Icon(Icons.edit),
                    label: const Text('Write Record'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _writeRecords,
                    icon: const Icon(Icons.add),
                    label: const Text('Write Records'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _updateRecord,
                    icon: const Icon(Icons.update),
                    label: const Text('Update Record'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Aggregation
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _aggregate,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Aggregate Data'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Deleting Records
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _deleteRecords,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete Records (Time Range)'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading || _connector == null
                        ? null
                        : _deleteRecordsByIds,
                    icon: const Icon(Icons.delete_sweep),
                    label: const Text('Delete Records (By IDs)'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                ],
              ),
            ),

            // Loading overlay
            if (_isLoading) const _LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}

/// A widget that displays a loading indicator in the center of a page.
/// Typically used to indicate that a page is initializing or loading data.
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({this.message});

  /// Optional message to display below the loading indicator.
  final String? message;

  @override
  Widget build(BuildContext context) {
    final color =
        Theme.of(context).progressIndicatorTheme.color ??
        Theme.of(context).colorScheme.primary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: color),
          if (message != null) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                message!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: color),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A widget that displays a gray transparent overlay with a loading indicator
/// in the center. Typically used during button operations like form submission
/// to prevent user interaction while an operation is in progress.
class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay({
    required this.isLoading,
    required this.child,
    this.message,
  });

  /// Whether the overlay should be displayed.
  final bool isLoading;

  /// The child widget to display behind the overlay.
  final Widget child;

  /// Optional message to display below the loading indicator.
  final String? message;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Stack(
        children: [
          child,
          if (isLoading)
            Positioned.fill(
              child: AbsorbPointer(
                child: ColoredBox(
                  color: Colors.grey.withValues(alpha: 0.5),
                  child: _LoadingIndicator(message: message),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
