import 'package:flutter/material.dart';

/// Label on the left, value on the right; the value may wrap or ellipsize.
@immutable
final class StatusRow extends StatelessWidget {
  const StatusRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.maxLines = 2,
    super.key,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:', style: theme.textTheme.titleSmall),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(color: valueColor),
          ),
        ),
      ],
    );
  }
}
