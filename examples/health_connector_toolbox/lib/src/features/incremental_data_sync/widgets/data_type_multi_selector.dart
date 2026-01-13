import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/incremental_data_sync_change_notifier.dart';
import 'package:provider/provider.dart';

/// Widget for selecting multiple [HealthDataType]s for synchronization.
///
/// Displays checkboxes for each available data type filtered by platform.
class DataTypeMultiSelector extends StatelessWidget {
  const DataTypeMultiSelector({
    required this.availableDataTypes,
    required this.onSelectionChanged,
    super.key,
  });

  final List<HealthDataType> availableDataTypes;
  final void Function(List<HealthDataType>) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return Selector<IncrementalDataSyncChangeNotifier, List<HealthDataType>>(
      selector: (_, notifier) => notifier.selectedDataTypes,
      builder: (context, selectedTypes, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.selectDataTypes,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...availableDataTypes.map((dataType) {
              final isSelected = selectedTypes.contains(dataType);
              return CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(AppTexts.getLabel(dataType)),
                value: isSelected,
                onChanged: (checked) {
                  final newSelection = List<HealthDataType>.from(
                    selectedTypes,
                  );
                  if (checked ?? false) {
                    newSelection.add(dataType);
                  } else {
                    newSelection.remove(dataType);
                  }
                  onSelectionChanged(newSelection);
                },
              );
            }),
          ],
        );
      },
    );
  }
}
