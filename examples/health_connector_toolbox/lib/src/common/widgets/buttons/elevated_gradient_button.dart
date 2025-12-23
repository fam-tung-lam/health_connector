import 'package:flutter/material.dart';

/// A fixed bottom button with a gradient background container.
///
/// Typically used for primary actions at the bottom of a page, ensuring
/// visibility and a consistent prominent style.
class ElevatedGradientButton extends StatelessWidget {
  const ElevatedGradientButton({
    required this.onPressed,
    required this.label,
    super.key,
  });

  /// Callback when the button is pressed.
  ///
  /// Pass `null` to disable the button (e.g., during loading).
  final VoidCallback? onPressed;

  /// The label text to display in the button.
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.3),
            colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
