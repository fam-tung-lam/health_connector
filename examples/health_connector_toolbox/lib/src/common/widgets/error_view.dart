import 'package:flutter/material.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A reusable widget for displaying error states with recovery options.
///
/// Shows an error icon, user-friendly message, and a retry button to help
/// users recover from errors gracefully.
@immutable
final class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.message,
    super.key,
    this.title,
    this.icon = AppIcons.error,
    this.onRetry,
  });

  /// The error title to display. If null, defaults to a generic error title.
  final String? title;

  /// The error message to display to the user.
  final String message;

  /// The icon to display at the top of the error view.
  final IconData icon;

  /// Callback function to execute when the retry button is pressed.
  /// If null, the retry button will not be shown.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.errorContainer,
            ),
            const SizedBox(height: 24),
            Text(
              title ?? AppTexts.errorOccurred,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(AppIcons.refresh),
                label: const Text(AppTexts.tryAgain),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
