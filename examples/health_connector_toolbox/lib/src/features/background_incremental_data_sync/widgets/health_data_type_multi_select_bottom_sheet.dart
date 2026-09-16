import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/display_name_extensions.dart';
import 'package:health_connector_toolbox/src/common/widgets/health_data_category_list_view.dart';
import 'package:health_connector_toolbox/src/common/widgets/search_text_field.dart';

/// Modal bottom sheet for picking any number of [HealthDataType]s.
///
/// Lists every data type the current platform supports, grouped by category,
/// with a search field pinned to the top. Returns the confirmed selection
/// sorted by display name, or null when dismissed.
@immutable
final class HealthDataTypeMultiSelectBottomSheet extends StatefulWidget {
  const HealthDataTypeMultiSelectBottomSheet({
    required this.healthPlatform,
    required this.initialSelection,
    super.key,
  });

  final HealthPlatform healthPlatform;
  final List<HealthDataType> initialSelection;

  /// Shows the sheet and resolves with the confirmed selection.
  static Future<List<HealthDataType>?> show(
    BuildContext context, {
    required HealthPlatform healthPlatform,
    required List<HealthDataType> initialSelection,
  }) {
    return showModalBottomSheet<List<HealthDataType>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => HealthDataTypeMultiSelectBottomSheet(
        healthPlatform: healthPlatform,
        initialSelection: initialSelection,
      ),
    );
  }

  /// Data types available on [healthPlatform].
  static List<HealthDataType> availableDataTypes(
    HealthPlatform healthPlatform,
  ) {
    return HealthDataType.values
        .where(
          (type) => type.healthPlatformRequirements.supportedHealthPlatforms
              .contains(healthPlatform),
        )
        .toList();
  }

  @override
  State<HealthDataTypeMultiSelectBottomSheet> createState() =>
      _HealthDataTypeMultiSelectBottomSheetState();
}

class _HealthDataTypeMultiSelectBottomSheetState
    extends State<HealthDataTypeMultiSelectBottomSheet> {
  late final List<HealthDataType> _available =
      HealthDataTypeMultiSelectBottomSheet.availableDataTypes(
        widget.healthPlatform,
      );
  late final Set<HealthDataType> _selected = {...widget.initialSelection};
  String _query = '';

  Map<HealthDataTypeCategory, List<HealthDataType>> _grouped() {
    final query = _query.trim().toLowerCase();
    final grouped = <HealthDataTypeCategory, List<HealthDataType>>{};
    for (final type in _available) {
      if (query.isNotEmpty &&
          !type.displayName.toLowerCase().contains(query) &&
          !type.id.toLowerCase().contains(query)) {
        continue;
      }
      grouped.putIfAbsent(type.category, () => []).add(type);
    }
    return grouped;
  }

  void _toggle(HealthDataType type, {required bool selected}) {
    setState(() {
      if (selected) {
        _selected.add(type);
      } else {
        _selected.remove(type);
      }
    });
  }

  void _confirm() {
    final selection = _selected.toList()
      ..sort((a, b) => a.displayName.compareTo(b.displayName));
    Navigator.pop(context, selection);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final grouped = _grouped();
    final height = MediaQuery.sizeOf(context).height * 0.85;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${AppTexts.selectDataTypes} (${_selected.length})',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                TextButton(
                  onPressed: _selected.isEmpty
                      ? null
                      : () => setState(_selected.clear),
                  child: const Text(AppTexts.clearSelection),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SearchTextField(
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: grouped.isEmpty
                  ? Center(
                      child: Text(
                        AppTexts.noDataTypesFound,
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                  : HealthDataCategoryListView<HealthDataType>(
                      groupedItems: grouped,
                      itemSorter: (a, b) =>
                          a.displayName.compareTo(b.displayName),
                      itemBuilder: (context, type) {
                        return CheckboxListTile(
                          key: ValueKey(type.id),
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          secondary: Icon(type.icon),
                          title: Text(type.displayName),
                          subtitle: Text(type.id),
                          value: _selected.contains(type),
                          onChanged: (checked) =>
                              _toggle(type, selected: checked ?? false),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(AppTexts.cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _confirm,
                    child: Text('${AppTexts.done} (${_selected.length})'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
