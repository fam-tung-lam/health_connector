import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Bottom action bar for permissions page with selected count and
/// request button.
///
/// Displays the number of selected permissions and a button to request them.
/// The button is disabled when no permissions are selected or when loading.
@immutable
final class PermissionActionBar extends StatelessWidget {
  const PermissionActionBar({
    required this.selectedCount,
    required this.isLoading,
    required this.onRequestPressed,
    super.key,
  });

  final int selectedCount;
  final bool isLoading;
  final VoidCallback onRequestPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${AppTexts.selected}: $selectedCount',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: selectedCount > 0 && !isLoading
                    ? onRequestPressed
                    : null,
                child: const Text(AppTexts.requestPermissions),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
