import 'package:flutter/material.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/health_connector_hk_ios.dart'
    show HealthConnectorHKClient;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Connector HK iOS Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExampleAppHomePage(),
    );
  }
}

/// Example app demonstrating all public API methods of HealthConnectorHKClient.
///
/// This page provides buttons to test each method with clear explanations
/// and error handling.
class ExampleAppHomePage extends StatefulWidget {
  const ExampleAppHomePage({super.key});

  @override
  State<ExampleAppHomePage> createState() => _ExampleAppHomePageState();
}

class _ExampleAppHomePageState extends State<ExampleAppHomePage> {
  // Instance of HealthConnectorHCClient to use for all API calls
  late final HealthConnectorHKClient _client;

  // Loading state to show overlay during async operations
  bool _isPageLoading = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initClient();
  }

  Future<void> _initClient() async {
    setState(() {
      _isPageLoading = true;
    });

    try {
      _client = await HealthConnectorHKClient.create();
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

  /// Demonstrates [HealthConnectorHKClient.requestPermissions] method.
  ///
  /// Requests only health data permissions (read/write for steps).
  ///
  /// **Note**: HealthKit does not support feature permissions.
  Future<void> _requestPermissions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Build a list of permissions to request
      final permissions = <Permission>[
        // Request health data read and write permissions
        HealthDataType.steps.readPermission,
        HealthDataType.steps.writePermission,
        HealthDataType.weight.readPermission,
        HealthDataType.weight.writePermission,
        // ...

        // HealthKit does not support feature permissions
        // HealthPlatformFeature.readHealthDataInBackground.permission,
        // HealthPlatformFeature.readHealthDataHistory.permission,
        // ...
      ];

      final results = await _client.requestPermissions(permissions);

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

  /// Demonstrates [HealthConnectorHKClient.readRecord] method.
  ///
  /// Reads a single health record by its ID. First, we read some records
  /// to get an actual record ID, then read that specific record.
  Future<void> _readRecord() async {
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

      final recordsResponse = await _client.readRecords(readRecordsRequest);

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
      final record = await _client.readRecord(readRecordRequest);

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

  /// Demonstrates [HealthConnectorHKClient.readRecords] method.
  ///
  /// Reads multiple health records within a time range with pagination support.
  /// This is useful for querying historical data.
  Future<void> _readRecords() async {
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

      final response = await _client.readRecords(request);

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

  /// Demonstrates [HealthConnectorHKClient.writeRecord] method.
  ///
  /// Writes a single health record to HealthKit. The platform will
  /// assign a unique ID to the record.
  Future<void> _writeRecord() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();

      // Create a step record with sample data
      final record = StepsRecord(
        startTime: now.subtract(const Duration(hours: 1)),
        endTime: now,
        count: const Numeric(1000),
        metadata: Metadata.automaticallyRecorded(
          dataOrigin: const DataOrigin('com.example.health_connector'),
          device: const Device.fromType(DeviceType.phone),
        ),
      );

      final recordId = await _client.writeRecord(record);

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

  /// Demonstrates [HealthConnectorHKClient.writeRecords] method.
  ///
  /// Writes multiple health records in a single operation. This is more
  /// efficient than writing records one by one.
  Future<void> _writeRecords() async {
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
          count: const Numeric(1500),
          metadata: Metadata.automaticallyRecorded(
            dataOrigin: const DataOrigin('com.example.health_connector'),
            device: const Device.fromType(DeviceType.watch),
          ),
        ),
        StepsRecord(
          startTime: now.subtract(const Duration(hours: 2)),
          endTime: now.subtract(const Duration(hours: 1)),
          count: const Numeric(2000),
          metadata: Metadata.automaticallyRecorded(
            dataOrigin: const DataOrigin('com.example.health_connector'),
            device: const Device.fromType(DeviceType.watch),
          ),
        ),
        StepsRecord(
          startTime: now.subtract(const Duration(hours: 1)),
          endTime: now,
          count: const Numeric(1800),
          metadata: Metadata.automaticallyRecorded(
            dataOrigin: const DataOrigin('com.example.health_connector'),
            device: const Device.fromType(DeviceType.phone),
          ),
        ),
      ];

      final recordIds = await _client.writeRecords(records);

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

  /// Demonstrates [HealthConnectorHKClient.updateRecord] method.
  ///
  /// Updates an existing health record. First, we read a record, then
  /// update it with new values.
  Future<void> _updateRecord() async {
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

      final recordsResponse = await _client.readRecords(readRecordsRequest);

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
        count: Numeric(existingRecord.count.value + 100),
        // Add 100 steps
        metadata: existingRecord.metadata,
      );

      final updatedRecordId = await _client.updateRecord(updatedRecord);

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Successfully updated record with ID: ${updatedRecordId.value}',
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

  /// Demonstrates [HealthConnectorHKClient.aggregate] method.
  ///
  /// Aggregates health data over a time range. For steps, we can calculate
  /// the sum of all steps in the specified time period.
  Future<void> _aggregate() async {
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

      final response = await _client.aggregate(request);

      if (!mounted) {
        return;
      }
      _showSuccess(
        'Total steps in last 7 days: ${response.value}',
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

  /// Demonstrates [HealthConnectorHKClient.deleteRecords] method.
  ///
  /// Deletes all health records of a specific type within a time range.
  /// Use with caution as this operation cannot be undone.
  Future<void> _deleteRecords() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();
      final request = HealthDataType.steps.deleteInTimeRange(
        startTime: now.subtract(const Duration(hours: 1)),
        endTime: now,
      );

      await _client.deleteRecords(request);

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

  /// Demonstrates `deleteRecordsByIds` method.
  ///
  /// Deletes specific health records by their IDs. First, we read some
  /// records to get their IDs, then delete those specific records.
  Future<void> _deleteRecordsByIds() async {
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

      final response = await _client.readRecords(readRequest);

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

      await _client.deleteRecords(request);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Connector HK iOS Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _LoadingOverlay(
        isLoading: _isPageLoading,
        message: 'Loading...',
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
                    onPressed: _isLoading ? null : _requestPermissions,
                    icon: const Icon(Icons.lock_open),
                    label: const Text('Request Permissions'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Reading Records
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _readRecord,
                    icon: const Icon(Icons.read_more),
                    label: const Text('Read Record'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _readRecords,
                    icon: const Icon(Icons.list),
                    label: const Text('Read Records'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Writing Records
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _writeRecord,
                    icon: const Icon(Icons.edit),
                    label: const Text('Write Record'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _writeRecords,
                    icon: const Icon(Icons.add),
                    label: const Text('Write Records'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _updateRecord,
                    icon: const Icon(Icons.update),
                    label: const Text('Update Record'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Aggregation
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _aggregate,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Aggregate Data'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Deleting Records
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _deleteRecords,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete Records (Time Range)'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _deleteRecordsByIds,
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
