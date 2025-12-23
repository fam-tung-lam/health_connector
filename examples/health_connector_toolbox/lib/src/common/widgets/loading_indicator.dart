import 'package:flutter/material.dart';

/// A widget that displays a loading indicator in the center of a page.
/// Typically used to indicate that a page is initializing or loading data.
@immutable
final class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.message});

  /// Optional message to display below the loading indicator.
  final String? message;

  @override
  Widget build(BuildContext context) {
    final color =
        Theme.of(context).progressIndicatorTheme.color ??
        Theme.of(context).colorScheme.primary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: color),
          if (message != null) ...[
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: Text(
                message!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: color),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
