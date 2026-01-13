import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/incremental_data_sync_change_notifier.dart';
import 'package:provider/provider.dart';

/// Card widget displaying sync results with color-coded sections.
///
/// Shows upserted records (green) and deleted record IDs (red) with
/// pagination support.
class SyncResultsViewerCard extends StatelessWidget {
  const SyncResultsViewerCard({
    required this.onLoadMore,
    super.key,
  });

  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return Selector<IncrementalDataSyncChangeNotifier, _ResultsState>(
      selector: (_, notifier) => _ResultsState(
        notifier.upsertedRecords.toList(),
        notifier.deletedRecordIds.toList(),
        hasMore: notifier.hasMore,
      ),
      builder: (context, state, _) {
        if (state.upsertedRecords.isEmpty && state.deletedRecordIds.isEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTexts.syncResults,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.upsertedRecords.length} ${AppTexts.upserted}, '
                  '${state.deletedRecordIds.length} ${AppTexts.deleted}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),

                // Upserted records (green)
                if (state.upsertedRecords.isNotEmpty) ...[
                  _SectionHeader(
                    title: AppTexts.upsertedRecords,
                    count: state.upsertedRecords.length,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 8),
                  ...state.upsertedRecords.map((record) {
                    return _RecordListItem(
                      record: record,
                      color: Colors.green.shade50,
                      borderColor: Colors.green.shade200,
                    );
                  }),
                ],

                // Deleted record IDs (red)
                if (state.deletedRecordIds.isNotEmpty) ...[
                  if (state.upsertedRecords.isNotEmpty)
                    const SizedBox(height: 16),
                  _SectionHeader(
                    title: AppTexts.deletedRecordIds,
                    count: state.deletedRecordIds.length,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 8),
                  ...state.deletedRecordIds.map((id) {
                    return _DeletedRecordItem(
                      id: id,
                      color: Colors.red.shade50,
                      borderColor: Colors.red.shade200,
                    );
                  }),
                ],

                // Load more button
                if (state.hasMore) ...[
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: onLoadMore,
                    icon: const Icon(Icons.expand_more),
                    label: const Text(AppTexts.loadMore),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Internal state class for results.
@immutable
class _ResultsState {
  const _ResultsState(
    this.upsertedRecords,
    this.deletedRecordIds, {
    required this.hasMore,
  });

  final List<HealthRecord> upsertedRecords;
  final List<HealthRecordId> deletedRecordIds;
  final bool hasMore;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ResultsState &&
          runtimeType == other.runtimeType &&
          _listEquals(upsertedRecords, other.upsertedRecords) &&
          _listEquals(deletedRecordIds, other.deletedRecordIds) &&
          hasMore == other.hasMore;

  @override
  int get hashCode => Object.hash(
    Object.hashAll(upsertedRecords),
    Object.hashAll(deletedRecordIds),
    hasMore,
  );

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}

/// Section header widget with icon and count.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.count,
    required this.color,
  });

  final String title;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.label, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          '$title ($count)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// List item for displaying a health record with expansion.
class _RecordListItem extends StatelessWidget {
  const _RecordListItem({
    required this.record,
    required this.color,
    required this.borderColor,
  });

  final HealthRecord record;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final details = _extractRecordDetails(record);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: ExpansionTile(
        title: Text(
          details.typeName,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (details.primaryValue != null)
              Text(
                details.primaryValue!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            Text(
              details.timeInfo,
              style: const TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(label: 'ID', value: record.id.value),
                ...details.additionalInfo.entries.map(
                  (e) => _DetailRow(label: e.key, value: e.value),
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 4),
                Text(
                  'Raw Data',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  record.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _RecordDetails _extractRecordDetails(HealthRecord record) {
    switch (record) {
      case final StepsRecord r:
        return _RecordDetails(
          typeName: 'Steps',
          primaryValue: '${r.count.value} steps',
          timeInfo: _formatInterval(r.startTime, r.endTime),
          additionalInfo: {
            'Recording Method': r.metadata.recordingMethod.name,
          },
        );

      case final WeightRecord r:
        return _RecordDetails(
          typeName: 'Weight',
          primaryValue: '${r.weight.inKilograms.toStringAsFixed(1)} kg',
          timeInfo: _formatInstant(r.time),
          additionalInfo: {
            'Recording Method': r.metadata.recordingMethod.name,
          },
        );

      case final HeightRecord r:
        return _RecordDetails(
          typeName: 'Height',
          primaryValue: '${r.height.inMeters.toStringAsFixed(2)} m',
          timeInfo: _formatInstant(r.time),
          additionalInfo: {
            'Recording Method': r.metadata.recordingMethod.name,
          },
        );

      case final HeartRateSeriesRecord r:
        return _RecordDetails(
          typeName: 'Heart Rate Series',
          primaryValue: '${r.samples.length} samples',
          timeInfo: _formatInterval(r.startTime, r.endTime),
          additionalInfo: {
            'Avg BPM': r.avgRate.inPerMinute.toStringAsFixed(0),
            'Recording Method': r.metadata.recordingMethod.name,
          },
        );

      case final HeartRateRecord r:
        return _RecordDetails(
          typeName: 'Heart Rate',
          primaryValue: '${r.rate.inPerMinute.toStringAsFixed(0)} bpm',
          timeInfo: _formatInstant(r.time),
          additionalInfo: {
            'Recording Method': r.metadata.recordingMethod.name,
          },
        );

      case final ActiveEnergyBurnedRecord r:
        return _RecordDetails(
          typeName: 'Active Energy',
          primaryValue: '${r.energy.inKilocalories.toStringAsFixed(0)} kcal',
          timeInfo: _formatInterval(r.startTime, r.endTime),
          additionalInfo: {
            'Recording Method': r.metadata.recordingMethod.name,
          },
        );

      case final DistanceRecord r:
        return _RecordDetails(
          typeName: 'Distance',
          primaryValue: '${r.distance.inMeters.toStringAsFixed(0)} m',
          timeInfo: _formatInterval(r.startTime, r.endTime),
          additionalInfo: {
            'Recording Method': r.metadata.recordingMethod.name,
          },
        );

      case final ExerciseSessionRecord r:
        return _RecordDetails(
          typeName: 'Exercise Session',
          primaryValue: r.exerciseType.name,
          timeInfo: _formatInterval(r.startTime, r.endTime),
          additionalInfo: {
            'Duration': '${r.endTime.difference(r.startTime).inMinutes} min',
            'Title': r.title ?? 'N/A',
            'Recording Method': r.metadata.recordingMethod.name,
          },
        );

      default:
        return _RecordDetails(
          typeName: record.runtimeType.toString(),
          primaryValue: null,
          timeInfo: _extractTimeInfo(record),
          additionalInfo: {},
        );
    }
  }

  String _formatInstant(DateTime time) {
    return '${time.year}-${time.month.toString().padLeft(2, '0')}-'
        '${time.day.toString().padLeft(2, '0')} '
        '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  String _formatInterval(DateTime start, DateTime end) {
    return '${_formatInstant(start)} → '
        '${end.hour.toString().padLeft(2, '0')}:'
        '${end.minute.toString().padLeft(2, '0')}';
  }

  String _extractTimeInfo(HealthRecord record) {
    if (record is InstantHealthRecord) {
      return _formatInstant(record.time);
    } else if (record is IntervalHealthRecord) {
      return _formatInterval(record.startTime, record.endTime);
    }
    return 'N/A';
  }
}

class _RecordDetails {
  const _RecordDetails({
    required this.typeName,
    required this.primaryValue,
    required this.timeInfo,
    required this.additionalInfo,
  });

  final String typeName;
  final String? primaryValue;
  final String timeInfo;
  final Map<String, String> additionalInfo;
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// List item for displaying a deleted record ID.
class _DeletedRecordItem extends StatelessWidget {
  const _DeletedRecordItem({
    required this.id,
    required this.color,
    required this.borderColor,
  });

  final HealthRecordId id;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          const Icon(Icons.delete, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              id.value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
