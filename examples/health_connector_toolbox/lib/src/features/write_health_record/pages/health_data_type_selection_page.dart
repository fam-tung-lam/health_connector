import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/common/widgets/health_data_category_list_view.dart';
import 'package:health_connector_toolbox/src/common/widgets/search_text_field.dart';
import 'package:health_connector_toolbox/src/features/home/widgets/feature_navigation_card.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/pages/health_record_write_page.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart';

/// A page that displays all available health data types for writing.
///
/// Shows a searchable list of health data types as cards. Tapping a card
/// navigates to the corresponding form page for writing that data type.
@immutable
final class HealthDataTypeSelectionPage extends StatefulWidget {
  const HealthDataTypeSelectionPage({
    required this.healthPlatform,
    super.key,
  });

  final HealthPlatform healthPlatform;

  @override
  State<HealthDataTypeSelectionPage> createState() =>
      _HealthDataTypeSelectionPageState();
}

class _HealthDataTypeSelectionPageState
    extends State<HealthDataTypeSelectionPage> {
  String _searchQuery = '';

  Map<HealthDataTypeCategory, List<HealthDataType>>
  _getFilteredDataTypesByCategory() {
    final allDataTypes = HealthDataType.values
        .where(
          (type) =>
              type.supportedHealthPlatforms.contains(widget.healthPlatform),
        )
        .toList();

    final grouped = <HealthDataTypeCategory, List<HealthDataType>>{};

    for (final type in allDataTypes) {
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final displayName = type.displayName.toLowerCase();
        final description = type.description.toLowerCase();
        if (!displayName.contains(query) && !description.contains(query)) {
          continue;
        }
      }

      final category = type.category;
      grouped.putIfAbsent(category, () => []).add(type);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedDataTypes = _getFilteredDataTypesByCategory();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.insertHealthRecord),
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchTextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: groupedDataTypes.isEmpty
                ? Center(
                    child: Text(
                      AppTexts.noDataTypesFound,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : HealthDataCategoryListView<HealthDataType>(
                    groupedItems: groupedDataTypes,
                    padding: const EdgeInsets.all(16.0),
                    itemSorter: (a, b) =>
                        a.displayName.compareTo(b.displayName),
                    itemBuilder: (context, dataType) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: FeatureNavigationCard(
                          icon: dataType.icon,
                          title: dataType.displayName,
                          description: dataType.description,
                          onTap: () => _onDataTypeListTileTap(dataType),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _onDataTypeListTileTap(HealthDataType dataType) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) =>
            ChangeNotifierProvider<WriteHealthRecordChangeNotifier>.value(
              value: context.read<WriteHealthRecordChangeNotifier>(),
              child: HealthRecordWritePage(
                dataType: dataType,
              ),
            ),
      ),
    );
  }
}
