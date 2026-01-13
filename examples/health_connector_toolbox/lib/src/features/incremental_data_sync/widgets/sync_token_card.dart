import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/date_formatter.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/widgets/data_type_multi_selector.dart';
import 'package:provider/provider.dart';

/// Card widget displaying sync token status and metadata.
///
/// Shows token existence, creation timestamp, data types count,
/// and last sync timestamp with a clear button.
class SyncTokenCard extends StatelessWidget {
  const SyncTokenCard({
    required this.healthPlatform,
    required this.onDataTypesChanged,
    required this.onClearToken,
    super.key,
  });

  final HealthPlatform healthPlatform;
  final void Function(List<HealthDataType>) onDataTypesChanged;
  final VoidCallback onClearToken;

  @override
  Widget build(BuildContext context) {
    final dataTypesToTestSync =
    <HealthDataType>[
      HealthDataType.activeEnergyBurned,
      HealthDataType.distance,
      HealthDataType.height,
      HealthDataType.heartRateSeries,
      HealthDataType.heartRate,
      HealthDataType.steps,
      HealthDataType.weight,
    ].where((dt) {
      return dt.supportedHealthPlatforms.contains(healthPlatform);
    }).toList();

    return Selector<IncrementalDataSyncChangeNotifier, HealthDataSyncToken?>(
      selector: (_, notifier) => notifier.syncToken,
      builder: (context, token, _) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppTexts.syncToken,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,
                    ),
                    const Spacer(),
                    if (token != null)
                      IconButton(
                        icon: const Icon(AppIcons.delete),
                        onPressed: onClearToken,
                        tooltip: AppTexts.clearToken,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (token != null) ...[
                  _buildStatusRow(
                    context,
                    AppTexts.token,
                    token.token,
                    null,
                  ),
                  const SizedBox(height: 8),
                  _buildStatusRow(
                    context,
                    AppTexts.createdAt,
                    DateFormatter.formatDateTime(token.createdAt),
                    null,
                  ),
                  const SizedBox(height: 8),
                  _buildStatusRow(
                    context,
                    AppTexts.dataTypes,
                    token.dataTypes.map((dt) => dt.id).join('\n'),
                    null,
                  ),
                ] else
                  ...[
                    const Text(AppTexts.noneInitialSync),
                  ],
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                DataTypeMultiSelector(
                  availableDataTypes: dataTypesToTestSync,
                  onSelectionChanged: onDataTypesChanged,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusRow(BuildContext context,
      String label,
      String value,
      Color? valueColor,) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$label:',
          style: Theme
              .of(context)
              .textTheme
              .titleSmall,
        ),
        const Spacer(),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
