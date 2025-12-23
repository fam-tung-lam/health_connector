import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A reusable widget for displaying a single health record detail field row.
///
/// Shows a label on the left and value on the right with appropriate styling.
@immutable
final class HealthRecordDetailRow extends StatelessWidget {
  const HealthRecordDetailRow({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final Object? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? AppTexts.notAvailable,
              style: TextStyle(
                fontSize: 12,
                color: value == null
                    ? Theme.of(context).colorScheme.outline
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontStyle: value == null ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
