import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/read_health_records_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/empty_health_records_placeholder.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/health_record_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/read_health_records_summary_card.dart';
import 'package:provider/provider.dart';

/// A widget that displays the results of a health records query.
///
/// Use this widget to show the list of fetched records, a summary card,
/// or an empty state placeholder if no records are found. It also handles
/// pagination with a "Load More" button.
class ReadHealthRecordResultsSection extends StatelessWidget {
  const ReadHealthRecordResultsSection({
    required this.healthPlatform,
    required this.onCheckPermissions,
    required this.onDeleteRecord,
    required this.onLoadNextPage,
    required this.isLoading,
    super.key,
  });

  final HealthPlatform healthPlatform;
  final VoidCallback onCheckPermissions;
  final void Function(HealthRecord) onDeleteRecord;
  final VoidCallback onLoadNextPage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Selector<ReadHealthRecordsChangeNotifier, bool>(
      selector: (_, notifier) => notifier.hasQueriedRecords,
      builder: (context, hasQueriedRecords, _) {
        if (!hasQueriedRecords) {
          return const SizedBox.shrink();
        }

        final notifier = Provider.of<ReadHealthRecordsChangeNotifier>(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 2),
            ReadHealthRecordsSummaryCard(
              recordCount: notifier.healthRecords.length,
              hasMore: notifier.nextPageRequest != null,
            ),
            const SizedBox(height: 16),
            if (notifier.healthRecords.isEmpty)
              EmptyHealthRecordsPlaceholder(
                healthPlatform: healthPlatform,
                onCheckPermissions: onCheckPermissions,
              )
            else
              ...notifier.healthRecords.map(
                (record) => HealthRecordListTile(
                  notifier: notifier,
                  record: record,
                  onDelete: () => onDeleteRecord(record),
                ),
              ),

            // Load more button
            if (notifier.nextPageRequest != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: isLoading ? null : onLoadNextPage,
                icon: const Icon(Icons.expand_more),
                label: const Text(AppTexts.loadMore),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
