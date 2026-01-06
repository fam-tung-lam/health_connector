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

  // Console logs
  final List<String> _logs = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeConnector();
  }

  void _log(String message) {
    setState(() {
      _logs.add(
        '[${DateTime.now().toIso8601String().split(
          'T',
        ).last.split('.').first}] $message',
      );
    });
    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearLogs() {
    setState(_logs.clear);
  }

  /// Initializes the HealthConnector instance.
  Future<void> _initializeConnector() async {
    setState(() {
      _isPageLoading = true;
    });

    try {
      // Check platform status first
      final status = await HealthConnector.getHealthPlatformStatus();
      if (status == HealthPlatformStatus.unavailable) {
        _log('Health platform unavailable on this device.');
        return;
      }
      if (status == HealthPlatformStatus.installationOrUpdateRequired) {
        _log('Health platform installation or update required.');
        // You could call HealthConnector.launchHealthAppPageInAppStore() here
        return;
      }

      // Create connector with logging enabled
      final connector = await HealthConnector.create();

      if (!mounted) {
        return;
      }

      setState(() {
        _connector = connector;
        _healthPlatform = connector.healthPlatform;
      });

      _log('${_healthPlatform!.name} is ready.');
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }
      _log('Failed to initialize: ${e.message}');
    } finally {
      if (mounted) {
        setState(() {
          _isPageLoading = false;
        });
      }
    }
  }

  /// Demonstrates [HealthConnector.requestPermissions] method.
  Future<void> _requestPermissions() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final permissions = [
        // Request health data read and write permissions
        HealthDataType.steps.readPermission,
        HealthDataType.steps.writePermission,
        HealthDataType.weight.readPermission,
        HealthDataType.weight.writePermission,

        // Request feature permissions (only supported on Health Connect)
        if (_healthPlatform == HealthPlatform.healthConnect) ...[
          HealthPlatformFeature.readHealthDataInBackground.permission,
          HealthPlatformFeature.readHealthDataHistory.permission,
        ],
      ];

      final results = await _connector!.requestPermissions(permissions);

      final grantedCount = results
          .where((r) => r.status == PermissionStatus.granted)
          .length;
      final deniedCount = results
          .where((r) => r.status == PermissionStatus.denied)
          .length;
      final unknownCount = results
          .where((r) => r.status == PermissionStatus.unknown)
          .length;

      _log(
        'Permission request completed: $grantedCount granted, '
        '$deniedCount denied, $unknownCount unknown',
      );
    } on HealthConnectorException catch (e) {
      _log('Failed to request permissions: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.getGrantedPermissions] method.
  Future<void> _getGrantedPermissions() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final grantedPermissions = await _connector!.getGrantedPermissions();
      _log('Found ${grantedPermissions.length} granted permissions.');
      for (final p in grantedPermissions) {
        if (p is HealthDataPermission) {
          _log(' - ${p.dataType} (${p.accessType.name})');
        } else if (p is HealthPlatformFeaturePermission) {
          _log(' - Feature: ${p.feature.toString().split('.').last}');
        }
      }
    } on HealthConnectorException catch (e) {
      if (e.code == HealthConnectorErrorCode.unsupportedOperation) {
        _log('getGrantedPermissions is only available on Health Connect.');
      } else {
        _log('Failed to get granted permissions: ${e.message}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.revokeAllPermissions] method.
  Future<void> _revokeAllPermissions() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _connector!.revokeAllPermissions();
      _log('All permissions have been revoked.');
    } on HealthConnectorException catch (e) {
      if (e.code == HealthConnectorErrorCode.unsupportedOperation) {
        _log('revokeAllPermissions is only available on Health Connect.');
      } else {
        _log('Failed to revoke permissions: ${e.message}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.getFeatureStatus] method.
  Future<void> _getFeatureStatus() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      _log('Checking feature status:');
      for (final feature in HealthPlatformFeature.values) {
        final status = await _connector!.getFeatureStatus(feature);
        _log(
          ' - ${feature.toString().split('.').last}: ${status.name}',
        );
      }
    } on HealthConnectorException catch (e) {
      _log('Failed to get feature status: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.readRecord] method.
  Future<void> _readRecord() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

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
        _log('No records found. Please write some records first.');
        return;
      }

      // Read the first record by ID
      final recordId = recordsResponse.records.first.id;
      final readRecordRequest = HealthDataType.steps.readById(recordId);
      final record = await _connector!.readRecord(readRecordRequest);

      if (record != null) {
        _log(
          'Read single record: ${record.count.value} steps from '
          '${record.startTime}',
        );
      } else {
        _log('Record not found');
      }
    } on HealthConnectorException catch (e) {
      _log('Failed to read record: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.readRecords] method.
  Future<void> _readRecords() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
      final request = HealthDataType.steps.readInTimeRange(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
        pageSize: 10,
      );

      final response = await _connector!.readRecords(request);

      _log('Read records (last 7 days):');
      if (response.records.isEmpty) {
        _log(' - No records found');
      } else {
        for (final record in response.records) {
          _log(' - ${record.count.value} steps at ${record.startTime}');
        }
      }
      if (response.hasMorePages) {
        _log(' (More pages available)');
      }
    } on HealthConnectorException catch (e) {
      _log('Failed to read records: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.writeRecord] method.
  Future<void> _writeRecord() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
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
      _log('Successfully wrote record ID: ${recordId.value}');
    } on HealthConnectorException catch (e) {
      _log('Failed to write record: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.writeRecords] method.
  Future<void> _writeRecords() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
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
      ];

      final recordIds = await _connector!.writeRecords(records);
      _log('Successfully wrote ${recordIds.length} records.');
    } on HealthConnectorException catch (e) {
      _log('Failed to write records: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.updateRecord] method.
  Future<void> _updateRecord() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // First, read a record to update
      final now = DateTime.now();
      final readRecordsRequest = HealthDataType.steps.readInTimeRange(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
        pageSize: 1,
      );

      final recordsResponse = await _connector!.readRecords(readRecordsRequest);

      if (recordsResponse.records.isEmpty) {
        _log('No records found to update.');
        return;
      }

      final existingRecord = recordsResponse.records.first;
      _log(
        'Updating record ${existingRecord.id.value} '
        '(old count: ${existingRecord.count.value})',
      );

      final updatedRecord = StepsRecord(
        id: existingRecord.id,
        startTime: existingRecord.startTime,
        endTime: existingRecord.endTime,
        count: Number(existingRecord.count.value + 100),
        metadata: existingRecord.metadata,
      );

      await _connector!.updateRecord(updatedRecord);
      _log('Record updated successfully.');
    } on HealthConnectorException catch (e) {
      _log('Failed to update record: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.aggregate] method.
  Future<void> _aggregate() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
      final request = HealthDataType.steps.aggregateSum(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
      );

      final result = await _connector!.aggregate(request);
      _log('Total steps (last 7 days): ${result.value}');
    } on HealthConnectorException catch (e) {
      _log('Failed to aggregate data: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.deleteRecords] method.
  Future<void> _deleteRecords() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
      final request = HealthDataType.steps.deleteInTimeRange(
        startTime: now.subtract(const Duration(hours: 1)),
        endTime: now,
      );

      await _connector!.deleteRecords(request);
      _log('Deleted step records from the last hour.');
    } on HealthConnectorException catch (e) {
      _log('Failed to delete records: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Demonstrates [HealthConnector.deleteRecords] via IDs.
  Future<void> _deleteRecordsByIds() async {
    if (_connector == null) {
      _log('Connector not initialized');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
      final readRequest = HealthDataType.steps.readInTimeRange(
        startTime: now.subtract(const Duration(days: 7)),
        endTime: now,
        pageSize: 5,
      );

      final response = await _connector!.readRecords(readRequest);
      if (response.records.isEmpty) {
        _log('No records found to delete.');
        return;
      }

      final ids = response.records.map((r) => r.id).toList();
      final request = HealthDataType.steps.deleteByIds(ids);

      await _connector!.deleteRecords(request);
      _log('Deleted ${ids.length} records by ID.');
    } on HealthConnectorException catch (e) {
      _log('Failed to delete records: ${e.message}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
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
        title: Text('Health Connector ($platformName)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _clearLogs,
            tooltip: 'Clear Logs',
          ),
        ],
      ),
      body: _LoadingOverlay(
        isLoading: _isPageLoading,
        message: 'Initializing...',
        child: Column(
          children: [
            // Controls Area (Top Half)
            Expanded(
              flex: 3,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const _SectionHeader(title: 'Permissions'),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _requestPermissions,
                        child: const Text('Request Permissions'),
                      ),
                      if (_healthPlatform == HealthPlatform.healthConnect) ...[
                        ElevatedButton(
                          onPressed: _isLoading || _connector == null
                              ? null
                              : _getGrantedPermissions,
                          child: const Text('Get Granted'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading || _connector == null
                              ? null
                              : _revokeAllPermissions,
                          child: const Text('Revoke All'),
                        ),
                      ],
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _getFeatureStatus,
                        child: const Text('Feature Status'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const _SectionHeader(title: 'Read / Write'),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _readRecords,
                        child: const Text('Read Records'),
                      ),
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _readRecord,
                        child: const Text('Read Single'),
                      ),
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _writeRecord,
                        child: const Text('Write Single'),
                      ),
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _writeRecords,
                        child: const Text('Write Batch'),
                      ),
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _updateRecord,
                        child: const Text('Update'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const _SectionHeader(title: 'Analyze / Clean'),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _aggregate,
                        child: const Text('Aggregate'),
                      ),
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _deleteRecords,
                        child: const Text('Delete (Time)'),
                      ),
                      ElevatedButton(
                        onPressed: _isLoading || _connector == null
                            ? null
                            : _deleteRecordsByIds,
                        child: const Text('Delete (IDs)'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1),

            // Logs Area (Bottom Half)
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.black87,
                width: double.infinity,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          _logs[index],
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontFamily: 'Courier',
                            fontSize: 12.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay({
    required this.isLoading,
    required this.child,
    this.message,
  });

  final bool isLoading;
  final Widget child;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      message!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
